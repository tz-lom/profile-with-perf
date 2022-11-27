perf ?= perf
hotspot ?= hotspot


all: e0 e1 e1.1 e2 e3 e4
	echo Examples: $<
.PHONY: all

clean:
	rm e* t* 2>/dev/null || true

t0: main.cpp
	g++ -std=c++11 main.cpp -o $@ -O2 -DA=300 -DB=200 -DC=100 -DN=2 -DM=2
	
t1: main.cpp
	g++ -std=c++11 main.cpp -o $@ -g -DA=300 -DB=200 -DC=100 -DN=2 -DM=2
	
t2: main.cpp
	g++ -std=c++11 main.cpp -o $@ -g -DA=300 -DB=200 -DC=100 -DN=2 -DM=2 -DSLEEP
	
t3: main.cpp
	g++ -std=c++11 main.cpp -o $@ -g -DA=300 -DB=200 -DC=1000 -DN=2 -DM=2
		
	
e%: t%
	$(perf) record --call-graph dwarf --aio -z -o $@ ./$<
	$(hotspot) $@

e1.1: t1
	$(perf) record --aio -z -o $@ ./$<
	$(hotspot) $@

# perf-e1.data: e1
# 	$(perf) record --call-graph dwarf --aio -z -o e1.perf.data ./e1
#      
# perf-e2.data: e2
# 	$(perf) record --call-graph dwarf --aio -z -o e2.perf.data ./e2
#      
# perf-e3.data: e3
# 	$(perf) record --call-graph dwarf --aio -z -o e3.perf.data ./e3
#      
# 
# hotspot-%: e%.perf.data
# 	$(hotspot) $<

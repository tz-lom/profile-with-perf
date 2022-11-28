perf ?= perf
hotspot ?= hotspot


all: h0 h1 h1.1 h2 h3 h4
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

e1.1: t1
	$(perf) record --aio -z -o $@ ./$<

h%: e%
	$(hotspot) $<
	
r%: e%
	$(perf) report -i $<


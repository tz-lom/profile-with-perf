#include <chrono>
#include <thread>

void sleep(int ms)
{
#ifdef SLEEP
	 std::this_thread::sleep_for(std::chrono::milliseconds(ms));
#else
	volatile int v=ms*1e5;
	for(;v>0;--v){}
#endif
}

void bar()
{
	sleep(C);
}

void foo()
{
	for(int j=0; j<N; ++j)
	{
		sleep(B);
		bar();
	}
}

int main()
{
    for(int i=0; i<M; ++i)
	{
		sleep(A);
		foo();
		bar();
	}
	return 0;
}


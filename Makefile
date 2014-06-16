all:
	coffee -o . -c coffee/*

clean:
	rm -rf *.js

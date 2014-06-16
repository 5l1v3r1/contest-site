all: main.js mobile.js flip-animation.js

main.js:
	coffee -o . -c coffee/main.coffee

mobile.js:
	coffee -o . -c coffee/mobile.coffee

flip-animation.js:
	coffee -o . -c coffee/flip-animation.coffee

clean:
	rm -rf main.js
	rm -rf mobile.js
	rm -rf flip-animation.js

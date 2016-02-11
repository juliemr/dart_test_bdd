# Guinness2 [![Build Status](https://travis-ci.org/juliemr/guinness2.svg?branch=master)](https://travis-ci.org/juliemr/guinness2)

Guinness2 is a port of the Jasmine library to Dart. It is based on the AngularDart implementation of Jasmine, and similar to [Guinness](https://github.com/vsavkin/guinness) but for dart:test instead of dart:unittest.

## Difference from Guinness

Backed by `dart:test` instead of `dart:unittest`. Run via `pub run test` instead of a Karma setup.

Removed bits referring to 'runner' programatically - just use `pub run test`. Removed deprecated
showStats option. Remove all context-keeping, as this is now handles by package:test directly.

## Installation

You can find the Guinness installation instructions [here](http://pub.dartlang.org/packages/guinness2#installing).

## Importing the Library

```dart
import 'package:guinness2/guinness2.dart';

main() {
  // your specs
}
```

If you are testing a client-side application, and you want to use html matchers, import the `guinness_html` library.

```dart
import 'package:guinness2/guinness2_html.dart';

main() {
  guinnessEnableHtmlMatchers();
  // your specs
}
```

## Syntax

Guinness specs are comprised of `describe`, `it`, `beforeEach`, and `afterEach` blocks.

```dart
import 'package:guinness2/guinness2.dart';

main() {
  describe("syntax", () {
    beforeEach(() {
      print("outer before");
    });

    afterEach(() {
      print("outer after");
    });

    it("runs first", () {
      print("first");
    });

    describe("nested describe", () {
      beforeEach(() {
        print("inner before");
      });

      afterEach(() {
        print("inner after");
      });

      it("runs second", () {
        print("second");
      });
    });
  });
}
```

This will print:

    outer before, first, outer after
    outer before, inner before, second, inner after, outer after

* To exclude a `describe`, change it to `xdescribe`.
* To exclude an `it`, change it to `xit`.
* To make a `describe` exclusive, change it to `ddescribe`.
* To make an `it` exclusive, change it to `iit`.
* *Important:* to run exclusive tests, add `--tags solo` to your command line invocation.


### Pending Specs

Guinness supports pending describe and it blocks (blocks without a callback).

```dart
describe("pending describe");
xdescribe("pending xdescribe");

it("pending it");
xit("pending xit");
```

## Async

Since Dart has built-in futures, the Guinness framework makes a good use out of them. If you return a future from
`beforeEach`, `afterEach`, or `it`, the framework will wait for that future to be resolved.

For instance:

```dart
beforeEach(connectToTheDatabase);
```

where `connectToTheDatabase` returns a future.

Similarly, you can write:

```dart
afterEach(releaseConnection);
```

You can also write async specs using the following technique:

```dart
it("should return an empty list when the database is empty", () {
  return queryDatabase().then((results){
    expect(results).toEqual([]);
  });
});
```

If a returned future gets rejected, the test fails.

## Expect

They way you write assertions in Guinness is by using the `expect` function, as follows:

```dart
expect(2).toEqual(2);
```

These are a few examples:

```dart
expect(2).toEqual(2);
expect([1,2]).toContain(2);
expect(2).toBe(2);
expect(()=> throw "BOOM").toThrow();
expect(()=> throw "BOOM").toThrow("BOOM");
expect(()=> throw "Invalid Argument").toThrowWith(message: "Invalid");
expect(()=> throw new InvalidArgument()).toThrowWith(anInstanceOf: InvalidArgument);
expect(()=> throw new InvalidArgument()).toThrowWith(type: ArgumentException);
expect(false).toBeFalsy();
expect(null).toBeFalsy();
expect(true).toBeTruthy();
expect("any object").toBeTruthy();
expect("any object").toBeDefined();
expect(null).toBeNull();
expect("not null").toBeNotNull();

expect(2).not.toEqual(1);
expect([1,2]).not.toContain(3);
expect([1,2]).not.toBe([1,2]);
expect((){}).not.toThrow();
expect(null).not.toBeDefined();

expect(new DocumentFragment.html("<div>some html</div>"))
    .toHaveHtml("<div>some html</div>");

expect(new DocumentFragment.html("<div>some text</div>"))
    .toHaveText("some text");

expect(new DivElement()..classes.add('abc'))
    .toHaveClass("abc");

expect(new DivElement()..attributes['attr'] = 'value')
    .toHaveAttribute("attr");

expect(new DocumentFragment.html("<div>some html</div>"))
    .not.toHaveHtml("<div>some other html</div>");

expect(new DocumentFragment.html("<div>some text</div>"))
    .not.toHaveText("some other text");

expect(new DivElement()..classes.add('abc'))
    .not.toHaveClass("def");

expect(new DivElement()..attributes['attr'] = 'value')
    .not.toHaveAttribute("other-attr");

final select = new SelectElement();
select.children
  ..add(new OptionElement(value: "1"))
  ..add(new OptionElement(value: "2", selected: true))
  ..add(new OptionElement(value: "3"));
expect(select).toEqualSelect(["1", ["2"], "3"]);
```

You can also use unittest matchers, like this:

```dart
expect(myObject).to(beValid); // where beValid is a unittest matcher
```

## Migrating from Unittest/Test

To make migration from the unittest library to Guinness easier, `expect` supports an optional second argument.

```dart
expect(myObject, beValid); // same as expect(myObject).to(beValid);
```

This keeps your unittest assertions working, so you can change them one by one.

## Spy

Guinness supports Jasmine-like spy functions:

```dart
final s = guinness.createSpy("my spy");
expect(s).not.toHaveBeenCalled();

s(1);
expect(s).toHaveBeenCalled();
expect(s).toHaveBeenCalledOnce();
expect(s).toHaveBeenCalledWith(1);
expect(s).toHaveBeenCalledOnceWith(1);
expect(s).not.toHaveBeenCalledWith(2);

s(2);
expect((){
  expect(s).toHaveBeenCalledOnce();
}).toThrow();

expect((){
  expect(s).toHaveBeenCalledOnceWith(1);
}).toThrow();
```

In addition, Guinness support spy objects:

```dart
class SomeSpy extends SpyObject implements SomeInterface {}

...

final s = new SomeSpy();
s.invoke(1,2);
s.name;
s.name = 'some name';

expect(s.spy("invoke")).toHaveBeenCalled();
expect(s.spy("get:name")).toHaveBeenCalled();
expect(s.spy("set:name")).toHaveBeenCalled();
```

And:

```dart
final s = new SomeSpy();
s.spy("invoke").andCallFake((a,b) => a + b);

expect(s.invoke(1,2)).toEqual(3);
```

You can also use the `mock` and `dart_mocks` libraries with it.


## Implementation Details

### Key Ideas

Dart's `package:test` supports most of the original Guinness test organization natively,
so we simply forward to the appropriate `package:test` function. 

The large exception is expectations, matchers, and spies, which are unchanged
from original Guinness.

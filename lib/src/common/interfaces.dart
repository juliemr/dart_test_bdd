part of guinness2;

abstract class Matchers {
  dynamic get config;

  void expect(actual, matcher, {String reason});
  void toEqual(actual, expected);
  void toContain(actual, expected);
  void toBe(actual, expected);
  void toBeLessThan(num actual, num expected);
  void toBeGreaterThan(num actual, num expected);
  void toBeCloseTo(num actual, num expected, num precision);
  void toBeA(actual, expected);
  void toBeAnInstanceOf(actual, expected);
  @Deprecated("toThrow() API is going to change to conform with toThrowWith()")
  void toThrow(actual, message);
  void toThrowWith(actual,
      {Type anInstanceOf, Type type, Pattern message, Function where});
  void toBeFalsy(actual);
  void toBeTruthy(actual);
  void toBeFalse(actual);
  void toBeTrue(actual);
  void toBeDefined(actual);
  void toBeNull(actual);
  void toBeNotNull(actual);
  void toHaveBeenCalled(actual);
  void toHaveBeenCalledOnce(actual);
  void toHaveBeenCalledWith(actual, [a, b, c, d, e, f]);
  void toHaveBeenCalledOnceWith(actual, [a, b, c, d, e, f]);
  void toHaveSameProps(actual, expected);
  void notToEqual(actual, expected);
  void notToContain(actual, expected);
  void notToBe(actual, expected);
  void notToBeLessThan(num actual, num expected);
  void notToBeGreaterThan(num actual, num expected);
  void notToBeCloseTo(num actual, num expected, num precision);
  void notToBeA(actual, expected);
  void notToBeAnInstanceOf(actual, expected);
  void toReturnNormally(actual);
  void toBeUndefined(actual);
  void notToHaveBeenCalled(actual);
  void notToHaveBeenCalledWith(actual, [a, b, c, d, e, f]);
  void notToHaveSameProps(actual, expected);
}

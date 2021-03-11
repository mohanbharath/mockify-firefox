// Generated by ReScript, PLEASE EDIT WITH CARE


function swap(c, threshold) {
  if (Math.random() < threshold) {
    return [
            c.toLocaleLowerCase(),
            -1
          ];
  } else {
    return [
            c.toLocaleUpperCase(),
            1
          ];
  }
}

function mockify_helper(_done, _remaining, _consecutiveUppers) {
  while(true) {
    var consecutiveUppers = _consecutiveUppers;
    var remaining = _remaining;
    var done = _done;
    if (remaining === "") {
      return done;
    }
    var threshold = 0.5 + consecutiveUppers * 0.15;
    var match = swap(remaining[0], threshold);
    var upper = match[1];
    var nextConsecutive = consecutiveUppers === 0 ? upper : (
        Math.sign(consecutiveUppers) === upper ? Math.imul(Math.abs(consecutiveUppers) + 1 | 0, upper) : 0
      );
    _consecutiveUppers = nextConsecutive;
    _remaining = remaining.slice(1);
    _done = done + match[0];
    continue ;
  };
}

function mockify(inputString) {
  return mockify_helper("", inputString, 0);
}
/* No side effect */

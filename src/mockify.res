let swap = (c: string, threshold: float) =>
{
  switch c
  {
    | " " => (c, 0)
    | _ when Js.Math.random() < threshold => (Js.String.toLocaleLowerCase(c), -1)
    | _ => (Js.String.toLocaleUpperCase(c), 1)
  }
}

let rec mockify_helper = (completed, remaining, consecutiveUppers) =>
{
  switch remaining
  {
    | "" => completed
    | _ =>
      {
        let threshold = (0.5 +. Belt.Int.toFloat(consecutiveUppers) *. 0.17)
        let (nextChar, upper) = swap(Js.String.get(remaining, 0), threshold)
        switch upper
        {
          | 1 => mockify_helper(
              completed ++ nextChar,
              Js.String.sliceToEnd(~from=1, remaining),
              Js.Math.max_int(consecutiveUppers + 1, 1)
            )
          | -1 => mockify_helper(
              completed ++ nextChar,
              Js.String.sliceToEnd(~from=1, remaining),
              Js.Math.min_int(consecutiveUppers - 1, -1)
            )
          | _ => mockify_helper(
              completed ++ nextChar,
              Js.String.sliceToEnd(~from=1, remaining),
              consecutiveUppers
            )
        }
      }
  }
}

let mockify = inputString =>
{
  mockify_helper("", inputString, 0)
}

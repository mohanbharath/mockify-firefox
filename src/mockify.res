let swap = (c: string, threshold: float) =>
{
  if Js.Math.random() < threshold
  {
    (Js.String.toLocaleLowerCase(c), -1)
  }
  else
  {
    (Js.String.toLocaleUpperCase(c), 1)
  }
}

let rec mockify_helper = (done, remaining, consecutiveUppers) =>
{
  switch remaining
  {
    | "" => done
    | _ =>
      {
        let threshold = (0.5 +. Belt.Int.toFloat(consecutiveUppers) *. 0.15)
        let (nextChar, upper) = swap(Js.String.get(remaining, 0), threshold)
        let nextConsecutive = if (consecutiveUppers == 0) {
          upper
        }
        else
        {
          if (Js.Math.sign_int(consecutiveUppers) == upper)
          {
            (Js.Math.abs_int(consecutiveUppers) + 1) * upper
          }
          else
          {
            0
          }
        }
        mockify_helper(
          done ++ nextChar,
          Js.String.sliceToEnd(~from=1, remaining),
          nextConsecutive
        )
      }
  }
}

let mockify = inputString =>
{
  mockify_helper("", inputString, 0)
}

let swap = c =>
{
  if Js.Math.random() < 0.5
  {
    Js.String.toLocaleLowerCase(c)
  }
  else
  {
    Js.String.toLocaleUpperCase(c)
  }
}

let mockify = inputString =>
{
  inputString
  |> Js.String.split("")
  |> Js.Array.map(swap)
  |> Js.Array.reduce((acc, element) => acc ++ element, "")
}

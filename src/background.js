function onCreated()
{
  if (browser.runtime.lastError)
  {
    console.log(`Error: ${browser.runtime.lastError}`);
  }
  else
  {
    console.log("Item created successfully!");
  }
}

/*
 * Create context menu items
 */
browser.menus.create({
  id: "mockify",
  title: "Mockify",
  contexts: ["editable"]
}, onCreated);

/*
 * Register click event listener
 */
browser.menus.onClicked.addListener((info, tab) =>
  {
    switch (info.menuItemId)
    {
      case "mockify":
        if (!info.selectionText)
        {
          console.log("No selected text; early termination");
        }
        else
        {
          console.log("Selected text: " + info.selectionText);
          var mockifiedText = mockify(info.selectionText);
          console.log("Mockified text: " + mockifiedText);

          var replaceValueCode = `var elem = browser.menus.getTargetElement(${info.targetElementId}); console.log("Full element text: " + elem.value); elem.value = elem.value.substring(0, elem.selectionStart) + "${mockifiedText}" + elem.value.substring(elem.selectionEnd); console.log("Post-mockification value: " + elem.value);`;
          exec = browser.tabs.executeScript(tab.id, {
            frameId: info.frameId,
            code: replaceValueCode,
          });
          exec.then(
            (result) => console.log(mockify("Mockification successful!")),
            (error) => console.log(`Exec error: ${error}`)
          );
        }
        break
    }
  }
);

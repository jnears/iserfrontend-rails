$(function() {

  // prevent widows in heading elements
  $("h1,h2,h3,h4,h5,h6").each(function() {
    var obj;
      if ($('a', this).length) {
        obj = $('a', this);
      }
      else {
        obj = $(this);
      }

      var wordArray = obj.text().split(" ");
      if (wordArray.length > 2) {
        wordArray[wordArray.length-2] += "&nbsp;" + wordArray.pop();
        obj.html(wordArray.join(" "));
      }
  });

  $("a#show-grid").click(function () {
    $('html').toggleClass("grid");
    return false;
  });
});
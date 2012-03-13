head.js("jquery-1.5.1.min.js", function() {
  $("#go1-go").click(function() {
    $(".if-go1").removeAttr("disabled");
  });
  $("#go1-dontgo").click(function() {
    $(".if-go1").attr("disabled", "disabled");
  });
});
head.js("varmath.js");

/* head.js("jquery-1.5.1.min.js", "jquery.selection-min.js", function() {
  $("pre").click(function() {
    console.log("clicked");
    var len = $(this).text().length;

    $(this).setCaretPos({start:0, end:len});
    $(this).select();
    $(this).focus();
    console.log(len);
    console.log($(this).getCaretPos());
  });
}); */

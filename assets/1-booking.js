function book () {
  // (A) PREVENT MULTIPLE SUBMIT
  document.getElementById("bookGo").disabled = true;

  // (B) COLLECT FORM DATA
  let data = new FormData(document.getElementById("bookForm"));

  // (C) SEND!
  fetch("/book", { method:"POST", body:data })
  .then(res => {
    if (res.status==200) { location.href = "/thankyou"; }
    else { alert("Opps an error has occured."); }
  })
  .catch(err => {
    console.error(err);
    alert("Opps an error has occured.");
  });
  return false;
}

// (D) INIT
window.onload = () => {
  // (D1) MIN SELECTABLE DATE IS TODAY
  let datepick = document.getElementsByName("date")[0];
  datepick.min = new Date().toISOString().split("T")[0];

  // (D2) ENABLE FORM
  document.getElementById("bookGo").disabled = false;
};
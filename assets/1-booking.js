// (A) Handle booking submission
function book() {
  const bookBtn = document.getElementById("bookGo");
  const errorMsg = document.getElementById("errorMsg");
  errorMsg.textContent = ""; // clear old error
  bookBtn.disabled = false;

  // Collect form data
  let data = new FormData(document.getElementById("bookForm"));
  console.log("Submitting booking data:", Object.fromEntries(data.entries()));

  // Validate date range before sending
  const checkin = data.get("checkin_date");
  const checkout = data.get("checkout_date");
  if (new Date(checkout) <= new Date(checkin)) {
    errorMsg.textContent = "Checkout date must be after check-in date.";
    bookBtn.disabled = false;
    return false;
  }

  // Send booking request
  fetch("/book", { method: "POST", body: data })
    .then(async res => {
      console.log("Booking response status:", res.status);

      if (res.ok) {
        console.log("Booking successful. Redirecting to /thankyou");
        location.href = "/thankyou";
      } else {
        const responseData = await res.json().catch(() => ({}));
        errorMsg.textContent = responseData.error || "Booking failed: Unknown error.";
        bookBtn.disabled = false;
      }
    })
    .catch(err => {
      console.error("Booking error:", err);
      errorMsg.textContent = "Booking failed: Server error.";
      bookBtn.disabled = false;
    });

  return false; // prevent default form submit
}

// (B) Load hotels into dropdown
async function loadHotels() {
  const hotelSelect = document.getElementById("hotelSelect");
  hotelSelect.innerHTML = '<option value="">Loading hotels...</option>';

  try {
    const res = await fetch("/hotels");
    if (!res.ok) throw new Error(`HTTP ${res.status}`);

    const hotels = await res.json();
    hotelSelect.innerHTML = hotels.length
      ? '<option value="">Select a hotel...</option>'
      : '<option value="">No hotels available</option>';

    hotels.forEach(h => {
      const opt = document.createElement("option");
      opt.value = h.hotel_id;
      opt.textContent = `${h.name} (${h.location}) - ¥${h.min_price}~¥${h.max_price}`;
      hotelSelect.appendChild(opt);
    });
  } catch (err) {
    console.error("Error loading hotels:", err);
    hotelSelect.innerHTML = '<option value="">Error loading hotels</option>';
  }
}

// (C) Load rooms for selected hotel and dates
async function loadRooms() {
  const hotelId = document.getElementById("hotelSelect").value;
  const checkin = document.getElementById("checkin_date").value;
  const checkout = document.getElementById("checkout_date").value;
  const roomSelect = document.getElementById("roomSelect");
  roomSelect.innerHTML = '<option value="">Loading rooms...</option>';

  if (!hotelId || !checkin || !checkout) {
    roomSelect.innerHTML = '<option value="">Select hotel and dates first</option>';
    return;
  }

  try {
    const res = await fetch(`/hotels/${hotelId}/rooms?checkin=${checkin}&checkout=${checkout}`);
    if (!res.ok) throw new Error(`HTTP ${res.status}`);

    const rooms = await res.json();
    roomSelect.innerHTML = rooms.length
      ? '<option value="">Select a room...</option>'
      : '<option value="">No rooms available</option>';

    rooms.forEach(r => {
      const opt = document.createElement("option");
      opt.value = r.room_type; // we send room_type to server
      opt.textContent = `${r.room_type} - ¥${r.price} (Available: ${r.total_available})`;
      roomSelect.appendChild(opt);
    });
  } catch (err) {
    console.error("Error loading rooms:", err);
    roomSelect.innerHTML = '<option value="">Error loading rooms</option>';
  }
}

// (D) INIT
window.onload = () => {
  // Disable button initially
  document.getElementById("bookGo").disabled = false;

  // Set min selectable date to today
  const today = new Date().toISOString().split("T")[0];
  document.getElementById("checkin_date").min = today;
  document.getElementById("checkout_date").min = today;

  // Enable submit button only when form is valid
  const inputs = document.querySelectorAll("#bookForm input, #bookForm select");
  inputs.forEach(input => input.addEventListener("input", () => {
    const allFilled = Array.from(inputs).every(i => i.value.trim() !== "");
    document.getElementById("bookGo").disabled = !allFilled;
  }));

  // Load hotels on page load
  loadHotels();

  // Bind events: reload rooms when hotel or dates change
  document.getElementById("hotelSelect").addEventListener("change", loadRooms);
  document.getElementById("checkin_date").addEventListener("change", loadRooms);
  document.getElementById("checkout_date").addEventListener("change", loadRooms);
};

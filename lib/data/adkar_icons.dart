/// Baraem Adkar icon mapping.
///
/// Keep all Adkar artwork in assets/images/adkar/ and use the same
/// 1:1 Baraem visual identity for the complete icon family.
const Map<String, String> adkarIcons = {
  'morning': 'assets/images/adkar/dhikr_morning.png',
  'evening': 'assets/images/adkar/dhikr_evening.png',
  'waking': 'assets/images/adkar/dhikr_waking.png',
  'sleep': 'assets/images/adkar/dhikr_sleep.png',
  'before_food': 'assets/images/adkar/dhikr_before_food.png',
  'after_food': 'assets/images/adkar/dhikr_after_food.png',
  'enter_mosque': 'assets/images/adkar/dhikr_enter_mosque.png',
  'leave_mosque': 'assets/images/adkar/dhikr_leave_mosque.png',
  'enter_home': 'assets/images/adkar/dhikr_enter_home.png',
  'leave_home': 'assets/images/adkar/dhikr_leave_home.png',
  'travel': 'assets/images/adkar/dhikr_travel.png',
  'riding': 'assets/images/adkar/dhikr_riding.png',
  'rain': 'assets/images/adkar/dhikr_rain.png',
  'new_moon': 'assets/images/adkar/dhikr_new_moon.png',
  'forgiveness': 'assets/images/adkar/dhikr_forgiveness.png',
  'tasbih': 'assets/images/adkar/dhikr_tasbih.png',
  'protection': 'assets/images/adkar/dhikr_protection.png',
  'fear': 'assets/images/adkar/dhikr_fear.png',
  'sneezing': 'assets/images/adkar/dhikr_sneezing.png',
  'wudu_before': 'assets/images/adkar/dhikr_wudu_before.png',
  'wudu_after': 'assets/images/adkar/dhikr_wudu_after.png',
  'bathroom_enter': 'assets/images/adkar/dhikr_bathroom_enter.png',
  'bathroom_leave': 'assets/images/adkar/dhikr_bathroom_leave.png',
  'beauty': 'assets/images/adkar/dhikr_beauty.png',
};

String? adkarIconFor(String id) {
  if (id.startsWith('morning_')) return adkarIcons['morning'];
  if (id.startsWith('evening_')) return adkarIcons['evening'];
  return adkarIcons[id];
}

source ../library/generate_site.sh
source assert_expectations.sh

function create_page_test_cases () {
  local description="should create a page"
  local webpage_template=`cat webpage_template.html`
  local card_template=`cat card_template.html`
  local records="1|bulbasaur|grass,poison|45|45|64|49|49|69"
  local types="happy joyfull"
  local selected_type="happy"
  local expected=`cat expected/create_page`

  local actual=$( create_page "$webpage_template" "$card_template" "${records[*]}" "${types[*]}" "$selected_type" )

  assert_expectation "webpage_template card_template types records" "$actual" "$expected" "$description"
}

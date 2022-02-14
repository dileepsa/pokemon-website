source ../library/generate_site.sh
source assert_expectations.sh


function test_generate_one_type_html () {
  local description="should generate one type"
  local types="grass"
  local expected="<p class=\"grass\">Grass</p>"

  local actual=$( generate_types_html ${types[*]} )
  assert_expectation "${types[*]}" "${actual}" "${expected}" "${description}"
}

function test_generate_multiple_types_html () {
  local description="should generate multiple types"
  local types="grass poison"
  local expected="<p class=\"grass\">Grass</p><p class=\"poison\">Poison</p>"

  local actual=$( generate_types_html "${types[*]}" )
  assert_expectation "${types[*]}" "${actual}" "${expected}" "${description}"
}

function generate_types_html_test_cases () {
  test_generate_one_type_html
  test_generate_multiple_types_html
}

# generate_types_html_test_cases
# generate_report
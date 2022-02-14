source ../library/generate_site.sh
source assert_expectations.sh

function test_generate_cards_with_one_record () {
  local description="should generate single card"
  local records="1|bulbasaur|grass,poison|45|45|64|49|49|69"
  local card_template="`cat card_template.html`"
  local expected=`cat expected/generate_cards_single_record`
  
  local actual=`generate_cards "${records[@]}" "${card_template}"`

  assert_expectation "records card_template" "${actual}" "${expected}" "${description}"
}

function test_generate_cards_with_multiple_records () {
  local description="should generate multiple cards"
  local records=("1|bulbasaur|grass,poison|45|45|64|49|49|69 
  3|venusaur|bug|45|45|64|49|49|69")
  local card_template="`cat card_template.html`"
  local expected=`cat expected/generate_cards_multiple_records`
  
  local actual=`generate_cards "${records[@]}" "${card_template}"`
  assert_expectation "records card_template" "${actual}" "${expected}" "${description}"
}

function generate_cards_test_cases () {
  test_generate_cards_with_one_record
  test_generate_cards_with_multiple_records
}
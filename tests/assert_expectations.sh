#-----colors---------------
NOCOLOR='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
#------colors--------------

PASSED_TESTS_COUNT=0

function assert_expectation () {
  local inputs=$1
  local actual="$2"
  local expected="$3"
	local description=$4
	local function_name=$5
  local result="actual : ${actual} | expected : ${expected}"
  local test_result="${GREEN}✔${NOCOLOR}"

  if [[ "$actual" != "$expected" ]]
  then
    test_result="${RED}✗${NOCOLOR}"
	  echo -e "\t$test_result $description"
	  FAILED_TESTS+=("${function_name}\n\tinputs:$inputs | $result\n")
	return
  fi

  echo -e "\t$test_result  $description "
	((PASSED_TESTS_COUNT ++))
}

function generate_report () {
	if [[ ${#FAILED_TESTS[@]} > 0 ]]
	then
		echo -e "\n${RED}Failing tests ${NOCOLOR}"
		echo -e "\n${FAILED_TESTS[@]}"
	fi
	total_tests=$(( ${#FAILED_TESTS[@]} + ${PASSED_TESTS_COUNT} ))
	echo -e "\n\n\t\tTests: ${RED}${#FAILED_TESTS[@]}${NOCOLOR} / ${GREEN}$total_tests ${NOCOLOR} \n"
}

# generate_report

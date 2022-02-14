source ../library/generate_site.sh
source assert_expectations.sh


function filter_records_of_type () {
    local description="should give the records of specific type"
    local records="1|21|bug|2
        1|21|poison|2"
    local type="bug"
    local expected="1|21|bug|2"

    local actual=$(filter_records "${records}" "${type}")
    assert_expectation "records type" "$actual" "$expected" "$description"
}

function filter_records_of_all () {
    local description="should give all the records"
    local records="1|21|bug|2
            2|24|poison|3"
    local type="all"
    local expected="1|21|bug|2
            2|24|poison|3"

    local actual=$(filter_records "${records}" "${type}")
    assert_expectation "records type" "$actual" "$expected" "$description"
}

function filter_records_test_cases () {
    filter_records_of_type
    filter_records_of_all
}

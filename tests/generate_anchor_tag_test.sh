source ../library/generate_site.sh
source assert_expectations.sh

function generate_anchor_tag_test_cases () {
    local description="should generate anchor tag"
    local reference="hello"    
    local class="some"
    local expected="<a href=\"hello.html\" class=\"some\">hello</a>"

    local actual=$(generate_anchor_tag $reference $class)

    assert_expectation "$reference $class" "$actual" "$expected" "$description"
}

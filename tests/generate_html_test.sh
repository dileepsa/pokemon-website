source ../library/generate_site.sh
source assert_expectations.sh

function test_with_inputs () {
    local description="should create given html tag"
    local tag="p"
    local class="design"
    local content="hello"

    local expected="<p class=\"design\">hello</p>"
    local actual=$(generate_html $tag $class $content)

    assert_expectation "$tag $class $content" "$actual" "$expected" "$description"
}

function test_with_empty_inputs () {
    local description="should not create any tag"
    local tag=""
    local class=""
    local content=""

    local expected="< class=\"\"></>"
    local actual=$(generate_html "$tag" "$class" "$content")

    assert_expectation "$tag $class $content" "$actual" "$expected" "$description"
}

function generate_html_test_cases () {
    test_with_inputs
    test_with_empty_inputs
}

# generate_html_test_cases
# generate_report
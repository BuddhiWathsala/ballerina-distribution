import ballerina/test;
import ballerina/http;

@test:Config {}
function testFunc() returns @tainted error? {
    http:Client httpEndpoint = checkpanic new("http://localhost:9095");
    string expectedResponse = "Successful";

    // Send a GET request to the specified endpoint.
    http:Response|error response = httpEndpoint->get("/hello");
    if (response is http:Response) {
        var res = check response.getTextPayload();
        test:assertEquals(res, expectedResponse);
    } else {
        test:assertFail(msg = "Failed to call the endpoint:");
    }
    return;
}

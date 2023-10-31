package handler

import (
	"net/http"
	"net/http/httptest"
	"testing"
)

func TestHello(t *testing.T) {
	req, err := http.NewRequest("GET", "/", nil)
	if err != nil {
		t.Fatal(err)
	}

	rr := httptest.NewRecorder()
	handler := http.HandlerFunc(Hello)

	handler.ServeHTTP(rr, req)

	if rr.Code != http.StatusOK {
		t.Errorf("Expected status %d, but got %d", http.StatusOK, rr.Code)
	}

	expected := "Hello, World!"
	if rr.Body.String() != expected {
		t.Errorf("Expected response body %s, but got %s", expected, rr.Body.String())
	}
}

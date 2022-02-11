package com.example.demo;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class DemoApplicationTests {

    @Autowired
    private DemoComponent dc;

    @Test
    void checkHello() {
        assertEquals(dc.hello, "world");
        assertEquals(dc.hello2, "321");
    }

}

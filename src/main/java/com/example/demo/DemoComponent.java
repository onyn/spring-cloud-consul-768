package com.example.demo;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
class DemoComponent {

    @Value("${hello}")
    public String hello;

    @Value("${hello2}")
    public String hello2;

}

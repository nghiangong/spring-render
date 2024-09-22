package com.nghiangong.demo;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class Controller {
    @GetMapping
    public String hello(){
        return "Hello";
    }
    @GetMapping("/test")
    public String success(){
        return "success";
    }
}

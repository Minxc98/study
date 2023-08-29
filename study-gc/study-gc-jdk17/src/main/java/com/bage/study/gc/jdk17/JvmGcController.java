package com.bage.study.gc.jdk17;

import com.bage.study.gc.biz.GcSafePointService;
import com.bage.study.gc.biz.JvmGcService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RequestMapping("/jvm")
@RestController
@Slf4j
public class JvmGcController {
    @Autowired
    private JvmGcService service;

    @RequestMapping("/gc/{step}")
    public Object gc(@PathVariable(value = "step", required = false) Integer step) {
        return service.gc(step);
    }

    @RequestMapping("/add/{step}")
    public Object add(@PathVariable(value = "step", required = false) Integer step) {
        return service.add(step);
    }


    @RequestMapping("/info")
    public Object info() {
        return service.info();
    }

}
package com.bage.study.best.practice.biz.flow.impl;

import com.bage.study.best.practice.biz.flow.OrderFlowStrategy;
import com.bage.study.best.practice.biz.steps.order.comfirm.OrderStepOrderConfirmHandler;
import com.bage.study.best.practice.biz.steps.order.place.OrderStepOrderAddHandler;
import com.bage.study.best.practice.biz.steps.order.place.OrderStepProductAddHandler;
import com.bage.study.best.practice.biz.steps.order.place.OrderStepSupplierPlaceHandler;
import com.bage.study.best.practice.biz.steps.order.place.OrderStepValidCheckHandler;

public class OrderPlaceProductFirstFlowStrategy implements OrderFlowStrategy {
    public static void main(String[] args) {
        OrderStepValidCheckHandler start = new OrderStepValidCheckHandler();
        start.setNext(new OrderStepProductAddHandler())
                .setNext(new OrderStepOrderConfirmHandler())
                .setNext(new OrderStepSupplierPlaceHandler())
                .setNext(new OrderStepOrderAddHandler())
        ;
        start.execute("mock");
    }
}

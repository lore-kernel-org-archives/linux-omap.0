From: Milo Kim <woogyom.kim@gmail.com>
Subject: [PATCH 1/7] ARM: dts: tps65217: Specify the interrupt controller
Date: Fri, 21 Oct 2016 23:01:00 +0900
Message-ID: <20161021140106.21531-2-woogyom.kim@gmail.com>
References: <20161021140106.21531-1-woogyom.kim@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161021140106.21531-1-woogyom.kim@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Milo Kim <woogyom.kim@gmail.com>
List-Id: linux-omap@vger.kernel.org

TPS65217 MFD driver supports the IRQ domain to handle the charger input
interrupts and push button status event. The interrupt controller enables
corresponding IRQ handling in the charger[*] and power button driver[**].

[*]  drivers/power/supply/tps65217_charger.c
[**] drivers/input/misc/tps65218-pwrbutton.c

Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
---
 arch/arm/boot/dts/tps65217.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/tps65217.dtsi b/arch/arm/boot/dts/tps65217.dtsi
index a632724..27935f8 100644
--- a/arch/arm/boot/dts/tps65217.dtsi
+++ b/arch/arm/boot/dts/tps65217.dtsi
@@ -13,6 +13,8 @@
 
 &tps {
 	compatible = "ti,tps65217";
+	interrupt-controller;
+	#interrupt-cells = <1>;
 
 	regulators {
 		#address-cells = <1>;
-- 
2.9.3

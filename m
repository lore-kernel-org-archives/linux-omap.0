From: Milo Kim <woogyom.kim@gmail.com>
Subject: [PATCH v2 6/8] ARM: dts: am335x: Add the charger interrupt
Date: Fri, 28 Oct 2016 21:37:00 +0900
Message-ID: <20161028123702.21849-7-woogyom.kim@gmail.com>
References: <20161028123702.21849-1-woogyom.kim@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161028123702.21849-1-woogyom.kim@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Robert Nelson <robertcnelson@gmail.com>, Milo Kim <woogyom.kim@gmail.com>
List-Id: linux-omap@vger.kernel.org

This enables the charger driver gets corresponding IRQ number by using
platform_get_irq_byname() helper.

Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
---
 arch/arm/boot/dts/am335x-bone-common.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index 25303d9..cec9d91 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -6,6 +6,8 @@
  * published by the Free Software Foundation.
  */
 
+#include <dt-bindings/mfd/tps65217.h>
+
 / {
 	cpus {
 		cpu@0 {
@@ -316,6 +318,12 @@
 
 	ti,pmic-shutdown-controller;
 
+	charger {
+		interrupts = <TPS65217_IRQ_AC>, <TPS65217_IRQ_USB>;
+		interrupts-names = "AC", "USB";
+		status = "okay";
+	};
+
 	regulators {
 		dcdc1_reg: regulator@0 {
 			regulator-name = "vdds_dpr";
-- 
2.9.3

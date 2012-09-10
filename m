From: Matt Porter <mporter@ti.com>
Subject: [PATCH] ARM: dts: AM33XX: fix gpio node numbering to match hardware
Date: Mon, 10 Sep 2012 12:20:20 -0400
Message-ID: <1347294020-22661-1-git-send-email-mporter@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux OMAP List <linux-omap@vger.kernel.org>
Cc: Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Benoit Cousson <b-cousson@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>
List-Id: linux-omap@vger.kernel.org

On AM33xx, the datasheet and TRM refer to four GPIO instances that
are 0-based, GPIO0-3.

Signed-off-by: Matt Porter <mporter@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index bb31bff..1369bfc 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -62,7 +62,7 @@
 			reg = <0x48200000 0x1000>;
 		};
 
-		gpio1: gpio@44e07000 {
+		gpio0: gpio@44e07000 {
 			compatible = "ti,omap4-gpio";
 			ti,hwmods = "gpio1";
 			gpio-controller;
@@ -74,7 +74,7 @@
 			interrupts = <96>;
 		};
 
-		gpio2: gpio@4804c000 {
+		gpio1: gpio@4804c000 {
 			compatible = "ti,omap4-gpio";
 			ti,hwmods = "gpio2";
 			gpio-controller;
@@ -86,7 +86,7 @@
 			interrupts = <98>;
 		};
 
-		gpio3: gpio@481ac000 {
+		gpio2: gpio@481ac000 {
 			compatible = "ti,omap4-gpio";
 			ti,hwmods = "gpio3";
 			gpio-controller;
@@ -98,7 +98,7 @@
 			interrupts = <32>;
 		};
 
-		gpio4: gpio@481ae000 {
+		gpio3: gpio@481ae000 {
 			compatible = "ti,omap4-gpio";
 			ti,hwmods = "gpio4";
 			gpio-controller;
-- 
1.7.9.5

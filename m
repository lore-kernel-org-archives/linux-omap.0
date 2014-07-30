From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] ARM: dts: DRA7: fix interrupt-cells for GPIO
Date: Wed, 30 Jul 2014 14:20:32 -0500
Message-ID: <1406748032-19417-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41486 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753369AbaG3TUq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Jul 2014 15:20:46 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: devicetree@vger.kernel.org, inux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>

GPIO modules are also interrupt sources. However, they require both the
GPIO number and IRQ type to function properly.

By declaring that GPIO uses interrupt-cells=<1>, we essentially do not
allow users of the nodes to use the interrupt property appropritely.

With this change, the following now works:

interrupt-parent = <&gpio6>;
interrupts = <5 IRQ_TYPE_LEVEL_LOW>;

Fixes: 6e58b8f1daaf ('ARM: dts: DRA7: Add the dts files for dra7 SoC and dra7-evm board')
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Based on v3.16-rc7

 arch/arm/boot/dts/dra7.dtsi |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 8012763..f21ef39 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -172,7 +172,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		gpio2: gpio@48055000 {
@@ -183,7 +183,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		gpio3: gpio@48057000 {
@@ -194,7 +194,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		gpio4: gpio@48059000 {
@@ -205,7 +205,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		gpio5: gpio@4805b000 {
@@ -216,7 +216,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		gpio6: gpio@4805d000 {
@@ -227,7 +227,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		gpio7: gpio@48051000 {
@@ -238,7 +238,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		gpio8: gpio@48053000 {
@@ -249,7 +249,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		uart1: serial@4806a000 {
-- 
1.7.9.5


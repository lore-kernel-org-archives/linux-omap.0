From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 8/9] ARM: dts: OMAP3+: Correct gpio #interrupts-cells property
Date: Fri, 8 Mar 2013 11:27:32 -0600
Message-ID: <1362763654-9660-9-git-send-email-jon-hunter@ti.com>
References: <1362763654-9660-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44920 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933093Ab3CHR2G (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Mar 2013 12:28:06 -0500
In-Reply-To: <1362763654-9660-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

The OMAP gpio binding documention [1] states that the #interrupts-cells
property for gpio controllers should be 2. Currently, for OMAP3+ devices
the #interrupt-cells is set to 1. By setting this property to 2, it
allows clients to pass a 2nd parameter indicating the sensitivity (level
or edge) and polarity (high or low) of the interrupt. The OMAP gpio
controllers support these options and so update the #interrupt-cells
property for OMAP3+ devices to 2.

[1] Documentation/devicetree/bindings/gpio/gpio-omap.txt

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/boot/dts/omap3.dtsi |   12 ++++++------
 arch/arm/boot/dts/omap4.dtsi |   12 ++++++------
 arch/arm/boot/dts/omap5.dtsi |   16 ++++++++--------
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 5b36de5..c9bedf7 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -117,7 +117,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		gpio2: gpio@49050000 {
@@ -126,7 +126,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		gpio3: gpio@49052000 {
@@ -135,7 +135,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		gpio4: gpio@49054000 {
@@ -144,7 +144,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		gpio5: gpio@49056000 {
@@ -153,7 +153,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		gpio6: gpio@49058000 {
@@ -162,7 +162,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		uart1: serial@4806a000 {
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 726ef11..544be06 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -138,7 +138,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		gpio2: gpio@48055000 {
@@ -149,7 +149,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		gpio3: gpio@48057000 {
@@ -160,7 +160,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		gpio4: gpio@48059000 {
@@ -171,7 +171,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		gpio5: gpio@4805b000 {
@@ -182,7 +182,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		gpio6: gpio@4805d000 {
@@ -193,7 +193,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		gpmc: gpmc@50000000 {
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 34f41ad..93feb50 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -128,7 +128,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		gpio2: gpio@48055000 {
@@ -139,7 +139,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		gpio3: gpio@48057000 {
@@ -150,7 +150,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		gpio4: gpio@48059000 {
@@ -161,7 +161,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		gpio5: gpio@4805b000 {
@@ -172,7 +172,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		gpio6: gpio@4805d000 {
@@ -183,7 +183,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		gpio7: gpio@48051000 {
@@ -194,7 +194,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		gpio8: gpio@48053000 {
@@ -205,7 +205,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		gpmc: gpmc@50000000 {
-- 
1.7.10.4


From: Felipe Balbi <balbi@ti.com>
Subject: [RFC/NOT FOR MERGING 3/3] arm: boot: dts: omap: remove ti_hwmods from UART ports
Date: Thu, 14 Feb 2013 13:15:54 +0200
Message-ID: <1360840554-26901-3-git-send-email-balbi@ti.com>
References: <1360840554-26901-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33418 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758506Ab3BNLQK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Feb 2013 06:16:10 -0500
In-Reply-To: <1360840554-26901-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

now that driver doesn't depend on HWMOD for
configuring SYSCONFIG register, we can remove
ti,hwmods attributes from UART ports.

NYET-Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi   | 6 ------
 arch/arm/boot/dts/omap2.dtsi    | 3 ---
 arch/arm/boot/dts/omap3.dtsi    | 3 ---
 arch/arm/boot/dts/omap36xx.dtsi | 1 -
 arch/arm/boot/dts/omap4.dtsi    | 4 ----
 arch/arm/boot/dts/omap5.dtsi    | 6 ------
 6 files changed, 23 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index c2f14e8..20832a9 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -133,7 +133,6 @@
 
 		uart1: serial@44e09000 {
 			compatible = "ti,omap3-uart";
-			ti,hwmods = "uart1";
 			clock-frequency = <48000000>;
 			reg = <0x44e09000 0x2000>;
 			interrupts = <72>;
@@ -142,7 +141,6 @@
 
 		uart2: serial@48022000 {
 			compatible = "ti,omap3-uart";
-			ti,hwmods = "uart2";
 			clock-frequency = <48000000>;
 			reg = <0x48022000 0x2000>;
 			interrupts = <73>;
@@ -151,7 +149,6 @@
 
 		uart3: serial@48024000 {
 			compatible = "ti,omap3-uart";
-			ti,hwmods = "uart3";
 			clock-frequency = <48000000>;
 			reg = <0x48024000 0x2000>;
 			interrupts = <74>;
@@ -160,7 +157,6 @@
 
 		uart4: serial@481a6000 {
 			compatible = "ti,omap3-uart";
-			ti,hwmods = "uart4";
 			clock-frequency = <48000000>;
 			reg = <0x481a6000 0x2000>;
 			interrupts = <44>;
@@ -169,7 +165,6 @@
 
 		uart5: serial@481a8000 {
 			compatible = "ti,omap3-uart";
-			ti,hwmods = "uart5";
 			clock-frequency = <48000000>;
 			reg = <0x481a8000 0x2000>;
 			interrupts = <45>;
@@ -178,7 +173,6 @@
 
 		uart6: serial@481aa000 {
 			compatible = "ti,omap3-uart";
-			ti,hwmods = "uart6";
 			clock-frequency = <48000000>;
 			reg = <0x481aa000 0x2000>;
 			interrupts = <46>;
diff --git a/arch/arm/boot/dts/omap2.dtsi b/arch/arm/boot/dts/omap2.dtsi
index 761c4b6..fa66e10 100644
--- a/arch/arm/boot/dts/omap2.dtsi
+++ b/arch/arm/boot/dts/omap2.dtsi
@@ -51,19 +51,16 @@
 
 		uart1: serial@4806a000 {
 			compatible = "ti,omap2-uart";
-			ti,hwmods = "uart1";
 			clock-frequency = <48000000>;
 		};
 
 		uart2: serial@4806c000 {
 			compatible = "ti,omap2-uart";
-			ti,hwmods = "uart2";
 			clock-frequency = <48000000>;
 		};
 
 		uart3: serial@4806e000 {
 			compatible = "ti,omap2-uart";
-			ti,hwmods = "uart3";
 			clock-frequency = <48000000>;
 		};
 
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 1acc261..2ef28ea 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -149,19 +149,16 @@
 
 		uart1: serial@4806a000 {
 			compatible = "ti,omap3-uart";
-			ti,hwmods = "uart1";
 			clock-frequency = <48000000>;
 		};
 
 		uart2: serial@4806c000 {
 			compatible = "ti,omap3-uart";
-			ti,hwmods = "uart2";
 			clock-frequency = <48000000>;
 		};
 
 		uart3: serial@49020000 {
 			compatible = "ti,omap3-uart";
-			ti,hwmods = "uart3";
 			clock-frequency = <48000000>;
 		};
 
diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap36xx.dtsi
index 96bf028..b837eb7 100644
--- a/arch/arm/boot/dts/omap36xx.dtsi
+++ b/arch/arm/boot/dts/omap36xx.dtsi
@@ -18,7 +18,6 @@
 	ocp {
 		uart4: serial@49042000 {
 			compatible = "ti,omap3-uart";
-			ti,hwmods = "uart4";
 			clock-frequency = <48000000>;
 		};
 	};
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 739bb79..83bc261 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -188,7 +188,6 @@
 			compatible = "ti,omap4-uart";
 			reg = <0x4806a000 0x100>;
 			interrupts = <0 72 0x4>;
-			ti,hwmods = "uart1";
 			clock-frequency = <48000000>;
 		};
 
@@ -196,7 +195,6 @@
 			compatible = "ti,omap4-uart";
 			reg = <0x4806c000 0x100>;
 			interrupts = <0 73 0x4>;
-			ti,hwmods = "uart2";
 			clock-frequency = <48000000>;
 		};
 
@@ -204,7 +202,6 @@
 			compatible = "ti,omap4-uart";
 			reg = <0x48020000 0x100>;
 			interrupts = <0 74 0x4>;
-			ti,hwmods = "uart3";
 			clock-frequency = <48000000>;
 		};
 
@@ -212,7 +209,6 @@
 			compatible = "ti,omap4-uart";
 			reg = <0x4806e000 0x100>;
 			interrupts = <0 70 0x4>;
-			ti,hwmods = "uart4";
 			clock-frequency = <48000000>;
 		};
 
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 790bb2a..c1e6ceb 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -245,7 +245,6 @@
 			compatible = "ti,omap4-uart";
 			reg = <0x4806a000 0x100>;
 			interrupts = <0 72 0x4>;
-			ti,hwmods = "uart1";
 			clock-frequency = <48000000>;
 		};
 
@@ -253,7 +252,6 @@
 			compatible = "ti,omap4-uart";
 			reg = <0x4806c000 0x100>;
 			interrupts = <0 73 0x4>;
-			ti,hwmods = "uart2";
 			clock-frequency = <48000000>;
 		};
 
@@ -261,7 +259,6 @@
 			compatible = "ti,omap4-uart";
 			reg = <0x48020000 0x100>;
 			interrupts = <0 74 0x4>;
-			ti,hwmods = "uart3";
 			clock-frequency = <48000000>;
 		};
 
@@ -269,7 +266,6 @@
 			compatible = "ti,omap4-uart";
 			reg = <0x4806e000 0x100>;
 			interrupts = <0 70 0x4>;
-			ti,hwmods = "uart4";
 			clock-frequency = <48000000>;
 		};
 
@@ -277,7 +273,6 @@
 			compatible = "ti,omap4-uart";
 			reg = <0x48066000 0x100>;
 			interrupts = <0 105 0x4>;
-			ti,hwmods = "uart5";
 			clock-frequency = <48000000>;
 		};
 
@@ -285,7 +280,6 @@
 			compatible = "ti,omap4-uart";
 			reg = <0x48068000 0x100>;
 			interrupts = <0 106 0x4>;
-			ti,hwmods = "uart6";
 			clock-frequency = <48000000>;
 		};
 
-- 
1.8.1.rc1.5.g7e0651a


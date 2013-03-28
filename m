From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH-V2 5/6] ARM: dts: AM33XX: Fix uart numbering to match hardware/TRM
Date: Thu, 28 Mar 2013 12:12:42 +0530
Message-ID: <1364452963-22083-6-git-send-email-hvaibhav@ti.com>
References: <1364452963-22083-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51567 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755829Ab3C1GoP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Mar 2013 02:44:15 -0400
In-Reply-To: <1364452963-22083-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, mporter@ti.com, b-cousson@ti.com, jacmet@sunsite.dk, Vaibhav Hiremath <hvaibhav@ti.com>

With DT support, where naming convention is based on base-addr
and not id, so we should follow TRM/Spec numbering label.

This patch changes UART numbering as per TRM, as uart0-5.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Acked-by: Matt Porter <mporter@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Peter Korsgaard <jacmet@sunsite.dk>
---
 arch/arm/boot/dts/am335x-bone.dts  |    2 +-
 arch/arm/boot/dts/am335x-evm.dts   |    2 +-
 arch/arm/boot/dts/am335x-evmsk.dts |    2 +-
 arch/arm/boot/dts/am33xx.dtsi      |   24 ++++++++++++------------
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index 1d623e4..be2c501 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -46,7 +46,7 @@
 	};

 	ocp {
-		uart1: serial@44e09000 {
+		uart0: serial@44e09000 {
 			status = "okay";
 		};

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 79b3cc8..2f3f5be 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -61,7 +61,7 @@
 	};

 	ocp {
-		uart1: serial@44e09000 {
+		uart0: serial@44e09000 {
 			status = "okay";
 		};

diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index 21d5a08..bcd7028 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -61,7 +61,7 @@
 	};

 	ocp {
-		uart1: serial@44e09000 {
+		uart0: serial@44e09000 {
 			status = "okay";
 		};

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index dd237de..565e05e 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -15,12 +15,12 @@
 	interrupt-parent = <&intc>;

 	aliases {
-		serial0 = &uart1;
-		serial1 = &uart2;
-		serial2 = &uart3;
-		serial3 = &uart4;
-		serial4 = &uart5;
-		serial5 = &uart6;
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+		serial4 = &uart4;
+		serial5 = &uart5;
 	};

 	cpus {
@@ -131,7 +131,7 @@
 			interrupts = <62>;
 		};

-		uart1: serial@44e09000 {
+		uart0: serial@44e09000 {
 			compatible = "ti,omap3-uart";
 			ti,hwmods = "uart1";
 			clock-frequency = <48000000>;
@@ -140,7 +140,7 @@
 			status = "disabled";
 		};

-		uart2: serial@48022000 {
+		uart1: serial@48022000 {
 			compatible = "ti,omap3-uart";
 			ti,hwmods = "uart2";
 			clock-frequency = <48000000>;
@@ -149,7 +149,7 @@
 			status = "disabled";
 		};

-		uart3: serial@48024000 {
+		uart2: serial@48024000 {
 			compatible = "ti,omap3-uart";
 			ti,hwmods = "uart3";
 			clock-frequency = <48000000>;
@@ -158,7 +158,7 @@
 			status = "disabled";
 		};

-		uart4: serial@481a6000 {
+		uart3: serial@481a6000 {
 			compatible = "ti,omap3-uart";
 			ti,hwmods = "uart4";
 			clock-frequency = <48000000>;
@@ -167,7 +167,7 @@
 			status = "disabled";
 		};

-		uart5: serial@481a8000 {
+		uart4: serial@481a8000 {
 			compatible = "ti,omap3-uart";
 			ti,hwmods = "uart5";
 			clock-frequency = <48000000>;
@@ -176,7 +176,7 @@
 			status = "disabled";
 		};

-		uart6: serial@481aa000 {
+		uart5: serial@481aa000 {
 			compatible = "ti,omap3-uart";
 			ti,hwmods = "uart6";
 			clock-frequency = <48000000>;
--
1.7.0.4


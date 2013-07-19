From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCH 1/4] arm: dts: dra7: Add initial status for the devices.
Date: Fri, 19 Jul 2013 21:54:07 +0530
Message-ID: <1374251050-10033-2-git-send-email-sourav.poddar@ti.com>
References: <1374251050-10033-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60717 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760794Ab3GSQYY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Jul 2013 12:24:24 -0400
In-Reply-To: <1374251050-10033-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, benoit.cousson@linaro.org
Cc: balbi@ti.com, rnayak@ti.com, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Sourav Poddar <sourav.poddar@ti.com>

This patch disabled I2C/SPI/UART device initially(status = "disabled").
This devices will only be probed, if the devices are 
present in the dts file(status = "okay").

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index a5d9350..40e450b 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -206,6 +206,7 @@
 			interrupts = <0 72 0x4>;
 			ti,hwmods = "uart1";
 			clock-frequency = <48000000>;
+                        status = "disabled";
 		};
 
 		uart2: serial@4806c000 {
@@ -214,6 +215,7 @@
 			interrupts = <0 73 0x4>;
 			ti,hwmods = "uart2";
 			clock-frequency = <48000000>;
+                        status = "disabled";
 		};
 
 		uart3: serial@48020000 {
@@ -222,6 +224,7 @@
 			interrupts = <0 74 0x4>;
 			ti,hwmods = "uart3";
 			clock-frequency = <48000000>;
+                        status = "disabled";
 		};
 
 		uart4: serial@4806e000 {
@@ -230,6 +233,7 @@
 			interrupts = <0 70 0x4>;
 			ti,hwmods = "uart4";
 			clock-frequency = <48000000>;
+                        status = "disabled";
 		};
 
 		uart5: serial@48066000 {
@@ -238,6 +242,7 @@
 			interrupts = <0 105 0x4>;
 			ti,hwmods = "uart5";
 			clock-frequency = <48000000>;
+                        status = "disabled";
 		};
 
 		uart6: serial@48068000 {
@@ -246,6 +251,7 @@
 			interrupts = <0 106 0x4>;
 			ti,hwmods = "uart6";
 			clock-frequency = <48000000>;
+                        status = "disabled";
 		};
 
 		timer1: timer@4ae18000 {
@@ -354,6 +360,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c1";
+                        status = "disabled";
 		};
 
 		i2c2: i2c@48072000 {
@@ -363,6 +370,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c2";
+                        status = "disabled";
 		};
 
 		i2c3: i2c@48060000 {
@@ -372,6 +380,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c3";
+                        status = "disabled";
 		};
 
 		i2c4: i2c@4807a000 {
@@ -381,6 +390,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c4";
+                        status = "disabled";
 		};
 
 		i2c5: i2c@4807c000 {
@@ -390,6 +400,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c5";
+                        status = "disabled";
 		};
 
 		mmc1: mmc@4809c000 {
@@ -451,6 +462,7 @@
 			       <&sdma 42>;
 			dma-names = "tx0", "rx0", "tx1", "rx1",
 				    "tx2", "rx2", "tx3", "rx3";
+                        status = "disabled";
 		};
 
 		mcspi2: spi@4809a000 {
@@ -466,6 +478,7 @@
 			       <&sdma 45>,
 			       <&sdma 46>;
 			dma-names = "tx0", "rx0", "tx1", "rx1";
+                        status = "disabled";
 		};
 
 		mcspi3: spi@480b8000 {
@@ -478,6 +491,7 @@
 			ti,spi-num-cs = <2>;
 			dmas = <&sdma 15>, <&sdma 16>;
 			dma-names = "tx0", "rx0";
+                        status = "disabled";
 		};
 
 		mcspi4: spi@480ba000 {
@@ -490,6 +504,7 @@
 			ti,spi-num-cs = <1>;
 			dmas = <&sdma 70>, <&sdma 71>;
 			dma-names = "tx0", "rx0";
+                        status = "disabled";
 		};
 	};
 };
-- 
1.7.1


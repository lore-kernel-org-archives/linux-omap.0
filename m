From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 17/18] arm: dts: dra7: add DMA properties for UART
Date: Fri,  5 Sep 2014 21:02:52 +0200
Message-ID: <1409943773-7874-18-git-send-email-bigeasy@linutronix.de>
References: <1409943773-7874-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1409943773-7874-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, balbi@ti.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Cc: devicetree@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/boot/dts/dra7.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index d678152db4cb..f273e3811f75 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -332,6 +332,8 @@
 			ti,hwmods = "uart1";
 			clock-frequency = <48000000>;
 			status = "disabled";
+			dmas = <&sdma 49>, <&sdma 50>;
+			dma-names = "tx", "rx";
 		};
 
 		uart2: serial@4806c000 {
@@ -341,6 +343,8 @@
 			ti,hwmods = "uart2";
 			clock-frequency = <48000000>;
 			status = "disabled";
+			dmas = <&sdma 51>, <&sdma 52>;
+			dma-names = "tx", "rx";
 		};
 
 		uart3: serial@48020000 {
@@ -350,6 +354,8 @@
 			ti,hwmods = "uart3";
 			clock-frequency = <48000000>;
 			status = "disabled";
+			dmas = <&sdma 53>, <&sdma 54>;
+			dma-names = "tx", "rx";
 		};
 
 		uart4: serial@4806e000 {
@@ -359,6 +365,8 @@
 			ti,hwmods = "uart4";
 			clock-frequency = <48000000>;
                         status = "disabled";
+			dmas = <&sdma 55>, <&sdma 56>;
+			dma-names = "tx", "rx";
 		};
 
 		uart5: serial@48066000 {
@@ -368,6 +376,8 @@
 			ti,hwmods = "uart5";
 			clock-frequency = <48000000>;
 			status = "disabled";
+			dmas = <&sdma 63>, <&sdma 64>;
+			dma-names = "tx", "rx";
 		};
 
 		uart6: serial@48068000 {
@@ -377,6 +387,8 @@
 			ti,hwmods = "uart6";
 			clock-frequency = <48000000>;
 			status = "disabled";
+			dmas = <&sdma 79>, <&sdma 80>;
+			dma-names = "tx", "rx";
 		};
 
 		uart7: serial@48420000 {
-- 
2.1.0

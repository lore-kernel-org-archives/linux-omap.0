From: Sebastien Guiriec <s-guiriec@ti.com>
Subject: [PATCH 5/5] ARM: dts: OMAP2+: Add SDMA Audio IPs bindings
Date: Thu, 7 Mar 2013 13:43:24 +0100
Message-ID: <1362660204-27074-6-git-send-email-s-guiriec@ti.com>
References: <1362660204-27074-1-git-send-email-s-guiriec@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59379 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754827Ab3CGMoU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Mar 2013 07:44:20 -0500
In-Reply-To: <1362660204-27074-1-git-send-email-s-guiriec@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastien Guiriec <s-guiriec@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org

Populate DMA client information for McBSP DMIC and McPDM periperhal on
OMAP2+ devices.

Signed-off-by: Sebastien Guiriec <s-guiriec@ti.com>
---
 arch/arm/boot/dts/omap2420.dtsi |    6 ++++++
 arch/arm/boot/dts/omap2430.dtsi |   15 +++++++++++++++
 arch/arm/boot/dts/omap3.dtsi    |   15 +++++++++++++++
 arch/arm/boot/dts/omap4.dtsi    |   17 +++++++++++++++++
 arch/arm/boot/dts/omap5.dtsi    |   14 ++++++++++++++
 5 files changed, 67 insertions(+)

diff --git a/arch/arm/boot/dts/omap2420.dtsi b/arch/arm/boot/dts/omap2420.dtsi
index af65609..45930f2 100644
--- a/arch/arm/boot/dts/omap2420.dtsi
+++ b/arch/arm/boot/dts/omap2420.dtsi
@@ -37,6 +37,9 @@
 				     <60>; /* RX interrupt */
 			interrupt-names = "tx", "rx";
 			ti,hwmods = "mcbsp1";
+			dmas = <&sdma 31>,
+			       <&sdma 32>;
+			dma-names = "tx", "rx";
 		};
 
 		mcbsp2: mcbsp@48076000 {
@@ -47,6 +50,9 @@
 				     <63>; /* RX interrupt */
 			interrupt-names = "tx", "rx";
 			ti,hwmods = "mcbsp2";
+			dmas = <&sdma 33>,
+			       <&sdma 34>;
+			dma-names = "tx", "rx";
 		};
 
 		timer1: timer@48028000 {
diff --git a/arch/arm/boot/dts/omap2430.dtsi b/arch/arm/boot/dts/omap2430.dtsi
index c392445..cfe7ed9 100644
--- a/arch/arm/boot/dts/omap2430.dtsi
+++ b/arch/arm/boot/dts/omap2430.dtsi
@@ -40,6 +40,9 @@
 			interrupt-names = "common", "tx", "rx", "rx_overflow";
 			ti,buffer-size = <128>;
 			ti,hwmods = "mcbsp1";
+			dmas = <&sdma 31>,
+			       <&sdma 32>;
+			dma-names = "tx", "rx";
 		};
 
 		mcbsp2: mcbsp@48076000 {
@@ -52,6 +55,9 @@
 			interrupt-names = "common", "tx", "rx";
 			ti,buffer-size = <128>;
 			ti,hwmods = "mcbsp2";
+			dmas = <&sdma 33>,
+			       <&sdma 34>;
+			dma-names = "tx", "rx";
 		};
 
 		mcbsp3: mcbsp@4808c000 {
@@ -64,6 +70,9 @@
 			interrupt-names = "common", "tx", "rx";
 			ti,buffer-size = <128>;
 			ti,hwmods = "mcbsp3";
+			dmas = <&sdma 17>,
+			       <&sdma 18>;
+			dma-names = "tx", "rx";
 		};
 
 		mcbsp4: mcbsp@4808e000 {
@@ -76,6 +85,9 @@
 			interrupt-names = "common", "tx", "rx";
 			ti,buffer-size = <128>;
 			ti,hwmods = "mcbsp4";
+			dmas = <&sdma 19>,
+			       <&sdma 20>;
+			dma-names = "tx", "rx";
 		};
 
 		mcbsp5: mcbsp@48096000 {
@@ -88,6 +100,9 @@
 			interrupt-names = "common", "tx", "rx";
 			ti,buffer-size = <128>;
 			ti,hwmods = "mcbsp5";
+			dmas = <&sdma 21>,
+			       <&sdma 22>;
+			dma-names = "tx", "rx";
 		};
 
 		timer1: timer@49018000 {
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 4e7acb6..f901404 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -289,6 +289,9 @@
 			interrupt-names = "common", "tx", "rx";
 			ti,buffer-size = <128>;
 			ti,hwmods = "mcbsp1";
+			dmas = <&sdma 31>,
+			       <&sdma 32>;
+			dma-names = "tx", "rx";
 		};
 
 		mcbsp2: mcbsp@49022000 {
@@ -303,6 +306,9 @@
 			interrupt-names = "common", "tx", "rx", "sidetone";
 			ti,buffer-size = <1280>;
 			ti,hwmods = "mcbsp2", "mcbsp2_sidetone";
+			dmas = <&sdma 33>,
+			       <&sdma 34>;
+			dma-names = "tx", "rx";
 		};
 
 		mcbsp3: mcbsp@49024000 {
@@ -317,6 +323,9 @@
 			interrupt-names = "common", "tx", "rx", "sidetone";
 			ti,buffer-size = <128>;
 			ti,hwmods = "mcbsp3", "mcbsp3_sidetone";
+			dmas = <&sdma 17>,
+			       <&sdma 18>;
+			dma-names = "tx", "rx";
 		};
 
 		mcbsp4: mcbsp@49026000 {
@@ -329,6 +338,9 @@
 			interrupt-names = "common", "tx", "rx";
 			ti,buffer-size = <128>;
 			ti,hwmods = "mcbsp4";
+			dmas = <&sdma 19>,
+			       <&sdma 20>;
+			dma-names = "tx", "rx";
 		};
 
 		mcbsp5: mcbsp@48096000 {
@@ -341,6 +353,9 @@
 			interrupt-names = "common", "tx", "rx";
 			ti,buffer-size = <128>;
 			ti,hwmods = "mcbsp5";
+			dmas = <&sdma 21>,
+			       <&sdma 22>;
+			dma-names = "tx", "rx";
 		};
 
 		timer1: timer@48318000 {
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 827f6f3..413c683 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -388,6 +388,9 @@
 			reg-names = "mpu", "dma";
 			interrupts = <0 112 0x4>;
 			ti,hwmods = "mcpdm";
+			dmas = <&sdma 65>,
+			       <&sdma 66>;
+			dma-names = "up_link", "dn_link";
 		};
 
 		dmic: dmic@4012e000 {
@@ -397,6 +400,8 @@
 			reg-names = "mpu", "dma";
 			interrupts = <0 114 0x4>;
 			ti,hwmods = "dmic";
+			dmas = <&sdma 67>;
+			dma-names = "up_link";
 		};
 
 		mcbsp1: mcbsp@40122000 {
@@ -408,6 +413,9 @@
 			interrupt-names = "common";
 			ti,buffer-size = <128>;
 			ti,hwmods = "mcbsp1";
+			dmas = <&sdma 33>,
+			       <&sdma 34>;
+			dma-names = "tx", "rx";
 		};
 
 		mcbsp2: mcbsp@40124000 {
@@ -419,6 +427,9 @@
 			interrupt-names = "common";
 			ti,buffer-size = <128>;
 			ti,hwmods = "mcbsp2";
+			dmas = <&sdma 17>,
+			       <&sdma 18>;
+			dma-names = "tx", "rx";
 		};
 
 		mcbsp3: mcbsp@40126000 {
@@ -430,6 +441,9 @@
 			interrupt-names = "common";
 			ti,buffer-size = <128>;
 			ti,hwmods = "mcbsp3";
+			dmas = <&sdma 19>,
+			       <&sdma 20>;
+			dma-names = "tx", "rx";
 		};
 
 		mcbsp4: mcbsp@48096000 {
@@ -440,6 +454,9 @@
 			interrupt-names = "common";
 			ti,buffer-size = <128>;
 			ti,hwmods = "mcbsp4";
+			dmas = <&sdma 31>,
+			       <&sdma 32>;
+			dma-names = "tx", "rx";
 		};
 
 		keypad: keypad@4a31c000 {
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 39b8d76..5aa6086 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -364,6 +364,9 @@
 			reg-names = "mpu", "dma";
 			interrupts = <0 112 0x4>;
 			ti,hwmods = "mcpdm";
+			dmas = <&sdma 65>,
+			       <&sdma 66>;
+			dma-names = "up_link", "dn_link";
 		};
 
 		dmic: dmic@4012e000 {
@@ -373,6 +376,8 @@
 			reg-names = "mpu", "dma";
 			interrupts = <0 114 0x4>;
 			ti,hwmods = "dmic";
+			dmas = <&sdma 67>;
+			dma-names = "up_link";
 		};
 
 		mcbsp1: mcbsp@40122000 {
@@ -384,6 +389,9 @@
 			interrupt-names = "common";
 			ti,buffer-size = <128>;
 			ti,hwmods = "mcbsp1";
+			dmas = <&sdma 33>,
+			       <&sdma 34>;
+			dma-names = "tx", "rx";
 		};
 
 		mcbsp2: mcbsp@40124000 {
@@ -395,6 +403,9 @@
 			interrupt-names = "common";
 			ti,buffer-size = <128>;
 			ti,hwmods = "mcbsp2";
+			dmas = <&sdma 17>,
+			       <&sdma 18>;
+			dma-names = "tx", "rx";
 		};
 
 		mcbsp3: mcbsp@40126000 {
@@ -406,6 +417,9 @@
 			interrupt-names = "common";
 			ti,buffer-size = <128>;
 			ti,hwmods = "mcbsp3";
+			dmas = <&sdma 19>,
+			       <&sdma 20>;
+			dma-names = "tx", "rx";
 		};
 
 		timer1: timer@4ae18000 {
-- 
1.7.10.4


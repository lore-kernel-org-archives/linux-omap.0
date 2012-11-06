From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH RESEND 08/10] ARM: dts: AM33XX: Add user-leds device tree data to am335x-evmsk
Date: Tue, 6 Nov 2012 19:18:36 +0530
Message-ID: <1352209718-5586-9-git-send-email-anilkumar@ti.com>
References: <1352209718-5586-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52685 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752143Ab2KFNuE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Nov 2012 08:50:04 -0500
In-Reply-To: <1352209718-5586-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, AnilKumar Ch <anilkumar@ti.com>

Add gpio-leds device tree data to am335x-evmsk device to enable gpio
based user-leds (USR0, USR1, USR2 and USR3) present on am335x starter
kit.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/am335x-evmsk.dts |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index 659ec5b..7262fa8 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -100,6 +100,36 @@
 		regulator-name = "lis3_reg";
 		regulator-boot-on;
 	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led@1 {
+			label = "evmsk:green:usr0";
+			gpios = <&gpio2 4 0>;
+			default-state = "off";
+		};
+
+		led@2 {
+			label = "evmsk:green:usr1";
+			gpios = <&gpio2 5 0>;
+			default-state = "off";
+		};
+
+		led@3 {
+			label = "evmsk:green:mmc0";
+			gpios = <&gpio2 6 0>;
+			linux,default-trigger = "mmc0";
+			default-state = "off";
+		};
+
+		led@4 {
+			label = "evmsk:green:heartbeat";
+			gpios = <&gpio2 7 0>;
+			linux,default-trigger = "heartbeat";
+			default-state = "off";
+		};
+	};
 };
 
 /include/ "tps65910.dtsi"
-- 
1.7.9.5


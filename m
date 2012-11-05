From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH 06/10] ARM: dts: AM33XX: Add user-leds device tree data to am335x-bone
Date: Mon, 5 Nov 2012 16:15:46 +0530
Message-ID: <1352112350-13398-7-git-send-email-anilkumar@ti.com>
References: <1352112350-13398-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57528 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753909Ab2KEKqK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Nov 2012 05:46:10 -0500
In-Reply-To: <1352112350-13398-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, AnilKumar Ch <anilkumar@ti.com>

Add gpio-leds device tree data to am335x-bone device to enable gpio
based user-leds (USR0, USR1, USR2 and USR3) present on BeagleBone.

[koen@dominion.thruhere.net: led0, led1 suggested by koen]
Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/am335x-bone.dts |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index 0bd0355..206c3eb 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -57,6 +57,36 @@
 			ti,system-power-controller;
 		};
 	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led@2 {
+			label = "beaglebone:green:heartbeat";
+			gpios = <&gpio2 21 0>;
+			linux,default-trigger = "heartbeat";
+			default-state = "off";
+		};
+
+		led@3 {
+			label = "beaglebone:green:mmc0";
+			gpios = <&gpio2 22 0>;
+			linux,default-trigger = "mmc0";
+			default-state = "off";
+		};
+
+		led@4 {
+			label = "beaglebone:green:usr2";
+			gpios = <&gpio2 23 0>;
+			default-state = "off";
+		};
+
+		led@5 {
+			label = "beaglebone:green:usr3";
+			gpios = <&gpio2 24 0>;
+			default-state = "off";
+		};
+	};
 };
 
 /include/ "tps65217.dtsi"
-- 
1.7.9.5


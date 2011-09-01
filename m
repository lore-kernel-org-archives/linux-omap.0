From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 5/7] arm/dts: omap3-beagle: Add twl4030 and EEPROM i2c devices
Date: Thu, 1 Sep 2011 19:25:10 +0200
Message-ID: <1314897912-18178-6-git-send-email-b-cousson@ti.com>
References: <1314897912-18178-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40465 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756466Ab1IARZm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Sep 2011 13:25:42 -0400
In-Reply-To: <1314897912-18178-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grant.likely@secretlab.ca, tony@atomide.com
Cc: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, manjugk@ti.com, Benoit Cousson <b-cousson@ti.com>

Add the twl4030 basic description with only the twl_rtc module.
Add the EEPROM node.
Add required clock frequencies for the i2c client devices existing
on beagle board.

Based on original patch from Manju:
http://www.spinics.net/lists/linux-omap/msg55831.html

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: G, Manjunath Kondaiah <manjugk@ti.com>
---
 arch/arm/boot/dts/omap3-beagle.dts |   42 ++++++++++++++++++++++++++++++++++++
 1 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index da13ec7..5d0a558 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -27,3 +27,45 @@
 		reg = <0x80000000 0x20000000>; /* 512 MB */
 	};
 };
+
+&i2c1 {
+	clock-frequency = <2600000>;
+
+	/*
+	 * Integrated Power Management Chip
+	 */
+	twl@48 {
+		compatible = "ti,twl4030";
+		reg = <0x48>;
+		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		interrupt-parent = <&intc>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		ranges = <0 0x48>;
+
+		twl_rtc {
+			compatible = "ti,twl_rtc";
+			interrupts = <11>;
+			reg = <0>;
+		};
+	};
+};
+
+&i2c2 {
+	clock-frequency = <400000>;
+};
+
+&i2c3 {
+	clock-frequency = <100000>;
+
+	/*
+	 * Display monitor features are burnt in the EEPROM
+	 * as EDID data.
+	 */
+	eeprom@50 {
+		compatible = "ti,eeprom";
+		reg = <0x50>;
+	};
+};
-- 
1.7.0.4


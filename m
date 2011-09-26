From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 12/13] arm/dts: omap3-beagle: Add twl4030 and i2c EEPROM
Date: Mon, 26 Sep 2011 18:50:20 +0200
Message-ID: <1317055821-20652-13-git-send-email-b-cousson@ti.com>
References: <1317055821-20652-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43349 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751853Ab1IZQvX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Sep 2011 12:51:23 -0400
In-Reply-To: <1317055821-20652-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, grant.likely@secretlab.ca
Cc: paul@pwsan.com, khilman@ti.com, rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>

Add required clock frequencies for the i2c client devices existing
on beagle board.

Add the twl4030 basic description with only the twl_rtc module.

Add the EEPROM node.

Based on original patch from Manju:
http://www.spinics.net/lists/linux-omap/msg55831.html

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: G, Manjunath Kondaiah <manjugk@ti.com>
---
 arch/arm/boot/dts/omap3-beagle.dts |   38 ++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index 9486be6..a65f39d 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -27,3 +27,41 @@
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
+
+		twl_rtc {
+			compatible = "ti,twl4030-rtc";
+			interrupts = <11>;
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


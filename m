From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 10/13] arm/dts: omap4-panda: Add twl6030 and i2c EEPROM
Date: Mon, 26 Sep 2011 18:50:18 +0200
Message-ID: <1317055821-20652-11-git-send-email-b-cousson@ti.com>
References: <1317055821-20652-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43345 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751788Ab1IZQvV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Sep 2011 12:51:21 -0400
In-Reply-To: <1317055821-20652-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, grant.likely@secretlab.ca
Cc: paul@pwsan.com, khilman@ti.com, rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>

Update pandaboard dts file with required clock frequencies
for the i2c client devices existing on pandaboard.

Add the twl6030 node in i2c1 controller.

This is the minimal support needed to boot OMAP4 boards
without any crash.
The support for all the features included in this MFD will be
added later.

Add a generic i2c EEPROM entry.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 arch/arm/boot/dts/omap4-panda.dts |   44 +++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
index c702657..2c6ce2b 100644
--- a/arch/arm/boot/dts/omap4-panda.dts
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -27,3 +27,47 @@
 		reg = <0x80000000 0x40000000>; /* 1 GB */
 	};
 };
+
+&i2c1 {
+	clock-frequency = <400000>;
+
+	/*
+	 * Integrated Power Management Chip
+	 * http://www.ti.com/lit/ds/symlink/twl6030.pdf
+	 */
+	twl@48 {
+		compatible = "ti,twl6030";
+		reg = <0x48>;
+		interrupts = <39>; /* IRQ_SYS_1N cascaded to gic */
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		interrupt-parent = <&gic>;
+
+		/* twl is a MFD, so it will contain a bunch of sub-ips */
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
+	 * Display monitor features are burnt in their EEPROM as EDID data.
+	 * The EEPROM is connected as I2C slave device.
+	 */
+	eeprom@50 {
+		compatible = "ti,eeprom";
+		reg = <0x50>;
+	};
+};
+
+&i2c4 {
+	clock-frequency = <400000>;
+};
-- 
1.7.0.4


From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 11/13] arm/dts: omap4-sdp: Add twl6030, i2c3 and i2c4 devices
Date: Mon, 26 Sep 2011 18:50:19 +0200
Message-ID: <1317055821-20652-12-git-send-email-b-cousson@ti.com>
References: <1317055821-20652-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49899 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794Ab1IZQvX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Sep 2011 12:51:23 -0400
In-Reply-To: <1317055821-20652-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, grant.likely@secretlab.ca
Cc: paul@pwsan.com, khilman@ti.com, rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>

Update DTS file with required clock frequencies
for the i2c client devices existing on sdp4430.

Add the twl6030 node inside the i2c1 controller node.
This is the minimal support needed to boot OMAP4 boards
without any crash.
The support for all the features included in this MFD will be
added later.

Add the RTC submodule inside the twl node.

Add tmp105 temperature sensor in i2c3
Add bh1780 Ambient Light Sensor in i2c3
Add hmc5843 3-Axis Digital Compass in i2c4

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 arch/arm/boot/dts/omap4-sdp.dts |   62 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 62 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 066e28c..2990841 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -27,3 +27,65 @@
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
+	clock-frequency = <400000>;
+
+	/*
+	 * Temperature Sensor
+	 * http://www.ti.com/lit/ds/symlink/tmp105.pdf
+	 */
+	tmp105@48 {
+		compatible = "ti,tmp105";
+		reg = <0x48>;
+	};
+
+	/*
+	 * Ambient Light Sensor
+	 * http://www.rohm.com/products/databook/sensor/pdf/bh1780gli-e.pdf
+	 */
+	bh1780@29 {
+		compatible = "rohm,bh1780";
+		reg = <0x29>;
+	};
+};
+
+&i2c4 {
+	clock-frequency = <400000>;
+
+	/*
+	 * 3-Axis Digital Compass
+	 * http://www.sparkfun.com/datasheets/Sensors/Magneto/HMC5843.pdf
+	 */
+	hmc5843@1e {
+		compatible = "honeywell,hmc5843";
+		reg = <0x1e>;
+	};
+};
-- 
1.7.0.4


From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v3 10/11] arm/dts: omap3-beagle: Add twl4030 and i2c EEPROM
Date: Tue, 20 Dec 2011 17:27:23 +0100
Message-ID: <1324398444-23296-11-git-send-email-b-cousson@ti.com>
References: <1324398444-23296-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48156 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751629Ab1LTQ2M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Dec 2011 11:28:12 -0500
In-Reply-To: <1324398444-23296-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rob.herring@calxeda.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, Benoit Cousson <b-cousson@ti.com>

Add required clock frequencies for the i2c client devices existing
on beagle board.

Add the twl4030 basic description with only the twl_rtc module.

Add the EEPROM node.

Based on original patch from Manju:
http://www.spinics.net/lists/linux-omap/msg55831.html

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/boot/dts/omap3-beagle.dts |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index 9f72cd4..714ba5d 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -18,3 +18,32 @@
 		reg = <0x80000000 0x20000000>; /* 512 MB */
 	};
 };
+
+&i2c1 {
+	clock-frequency = <2600000>;
+
+	twl: twl@48 {
+		reg = <0x48>;
+		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
+		interrupt-parent = <&intc>;
+	};
+};
+
+/include/ "twl4030.dtsi"
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


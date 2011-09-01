From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 09/13] arm/dts: omap4-sdp: Add twl6030 node
Date: Thu, 1 Sep 2011 19:21:25 +0200
Message-ID: <1314897689-17791-10-git-send-email-b-cousson@ti.com>
References: <1314897689-17791-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35323 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756043Ab1IARWn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Sep 2011 13:22:43 -0400
In-Reply-To: <1314897689-17791-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grant.likely@secretlab.ca, tony@atomide.com
Cc: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, manjugk@ti.com, Benoit Cousson <b-cousson@ti.com>

Add the twl6030 node inside the i2c1 controller node.
Add the RTC submodule inside the twl node.

This is just the minimal support needed to boot OMAP4 boards
without any crash.
The support for all the features included in this MFD will be added
later.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 arch/arm/boot/dts/omap4-sdp.dts |   25 +++++++++++++++++++++++--
 1 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index ed85b35..d03f2e7 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -26,12 +26,33 @@
 		device_type = "memory";
 		reg = <0x80000000 0x40000000>; /* 1 GB */
 	};
-
-
 };
 
 &i2c1 {
 	clock-frequency = <400000>;
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
+		/* twl is a MFD, so it will contain a bunch of sub-ips */
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
 };
 
 &i2c2 {
-- 
1.7.0.4


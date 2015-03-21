From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCHv2 4/4] DTS: ARM: OMAP3-N900: Add lis3lv02d support
Date: Sat, 21 Mar 2015 21:19:05 +0100
Message-ID: <1426969145-4478-5-git-send-email-sre@kernel.org>
References: <1426969145-4478-1-git-send-email-sre@kernel.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([5.45.105.125]:59489 "EHLO ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751742AbbCUUUR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 21 Mar 2015 16:20:17 -0400
In-Reply-To: <1426969145-4478-1-git-send-email-sre@kernel.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Eric Piel <eric.piel@tremplin-utc.net>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, Sebastian Reichel <sre@kernel.or>

From: Sebastian Reichel <sre@kernel.or>

This adds support for the N900's accelerometer to
the Nokia N900 DTS file.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 arch/arm/boot/dts/omap3-n900.dts | 52 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 6040327..b02a717 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -602,6 +602,58 @@
 	pinctrl-0 = <&i2c3_pins>;
 
 	clock-frequency = <400000>;
+
+	lis302dl: lis3lv02d@1d {
+		compatible = "st,lis3lv02d";
+		reg = <0x1d>;
+
+		Vdd-supply = <&vaux1>;
+		Vdd_IO-supply = <&vio>;
+
+		interrupt-parent = <&gpio6>;
+		interrupts = <21 20>; /* 181 and 180 */
+
+		/* click flags */
+		st,click-single-x;
+		st,click-single-y;
+		st,click-single-z;
+
+		/* Limits are 0.5g * value */
+		st,click-threshold-x = <8>;
+		st,click-threshold-y = <8>;
+		st,click-threshold-z = <10>;
+
+		/* Click must be longer than time limit */
+		st,click-time-limit = <9>;
+
+		/* Kind of debounce filter */
+		st,click-latency = <50>;
+
+		/* Interrupt line 2 for click detection */
+		st,irq2-click;
+
+		st,wakeup-x-hi;
+		st,wakeup-y-hi;
+		st,wakeup-threshold = <(800/18)>; /* millig-value / 18 to get HW values */
+
+		st,wakeup2-z-hi;
+		st,wakeup2-threshold = <(900/18)>; /* millig-value / 18 to get HW values */
+
+		st,hipass1-disable;
+		st,hipass2-disable;
+
+		st,axis-x = <1>;    /* LIS3_DEV_X */
+		st,axis-y = <(-2)>; /* LIS3_INV_DEV_Y */
+		st,axis-z = <(-3)>; /* LIS3_INV_DEV_Z */
+
+		st,min-limit-x = <(-32)>;
+		st,min-limit-y = <3>;
+		st,min-limit-z = <3>;
+
+		st,max-limit-x = <(-3)>;
+		st,max-limit-y = <32>;
+		st,max-limit-z = <32>;
+	};
 };
 
 &mmc1 {
-- 
2.1.4


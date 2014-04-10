From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 05/11] ARM: dts: Configure omap3 twl4030 I2C4 pins by default
Date: Thu, 10 Apr 2014 16:47:13 -0700
Message-ID: <1397173639-29587-6-git-send-email-tony@atomide.com>
References: <1397173639-29587-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49000 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754205AbaDJXr1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Apr 2014 19:47:27 -0400
In-Reply-To: <1397173639-29587-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@linaro.org>, Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>

Almost certainly any sane board has the twl4030 has the I2C4
pins connected as those are needed for voltage control during
idle. If the I2C4 lines are not properly muxed, any voltage
scaling over I2C4 will fail.

Let's mux those pins by default, the boards that are not using
them can still configure things separately.

Cc: Kevin Hilman <khilman@linaro.org>
Cc: Nishanth Menon <nm@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/twl4030_omap3.dtsi | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/twl4030_omap3.dtsi b/arch/arm/boot/dts/twl4030_omap3.dtsi
index c353ef0..3537ae5 100644
--- a/arch/arm/boot/dts/twl4030_omap3.dtsi
+++ b/arch/arm/boot/dts/twl4030_omap3.dtsi
@@ -8,7 +8,7 @@
 
 &twl {
 	pinctrl-names = "default";
-	pinctrl-0 = <&twl4030_pins>;
+	pinctrl-0 = <&twl4030_pins &twl4030_vpins>;
 };
 
 &omap3_pmx_core {
@@ -23,3 +23,20 @@
 		>;
 	};
 };
+
+/*
+ * If your board is not using the I2C4 pins with twl4030, then don't include
+ * this file. For proper idle mode signaling with sys_clkreq and sys_off_mode
+ * pins we need to configure I2C4, or else use the legacy sys_nvmode1 and
+ * sys_nvmode2 signaling.
+ */
+&omap3_pmx_wkup {
+	twl4030_vpins: pinmux_twl4030_vpins {
+		pinctrl-single,pins = <
+			OMAP3_WKUP_IOPAD(0x2a00, PIN_INPUT | MUX_MODE0)		/* i2c4_scl.i2c4_scl */
+			OMAP3_WKUP_IOPAD(0x2a02, PIN_INPUT | MUX_MODE0)		/* i2c4_sda.i2c4_sda */
+			OMAP3_WKUP_IOPAD(0x2a06, PIN_OUTPUT | MUX_MODE0)	/* sys_clkreq.sys_clkreq */
+			OMAP3_WKUP_IOPAD(0x2a18, PIN_OUTPUT | MUX_MODE0)	/* sys_off_mode.sys_off_mode */
+		>;
+	};
+};
-- 
1.8.1.1


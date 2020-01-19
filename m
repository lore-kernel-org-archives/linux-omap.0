From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: dts: omap4-droid4: Enable hdq for droid4 ds250x 1-wire battery nvmem
Date: Sun, 19 Jan 2020 11:56:59 -0800
Message-ID: <20200119195659.18273-1-tony@atomide.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:51770 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727138AbgAST5L (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Sun, 19 Jan 2020 14:57:11 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, devicetree@vger.kernel.org, Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>

With "[PATCHv3] w1: omap-hdq: Simplify driver with PM runtime autosuspend"
we can read the droid4 battery information over 1-wire with this patch
with something like:

# modprobe omap_hdq
# hd /sys/bus/w1/devices/89-*/89-*/nvmem
...

Unfortunately the format of the battery data seems to be Motorola specific
and is currently unusable for battery charger unless somebody figures out
what it means.

Note that currently keeping omap_hdq module loaded will cause extra power
consumption as it seems to scan devices periodically.

Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/motorola-mapphone-common.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/motorola-mapphone-common.dtsi b/arch/arm/boot/dts/motorola-mapphone-common.dtsi
--- a/arch/arm/boot/dts/motorola-mapphone-common.dtsi
+++ b/arch/arm/boot/dts/motorola-mapphone-common.dtsi
@@ -259,6 +259,13 @@
 	};
 };
 
+/* Battery NVRAM on 1-wire handled by w1_ds250x driver */
+&hdqw1w {
+	pinctrl-0 = <&hdq_pins>;
+	pinctrl-names = "default";
+	ti,mode = "1w";
+};
+
 &i2c1 {
 	tmp105@48 {
 		compatible = "ti,tmp105";
@@ -449,6 +456,13 @@
 		>;
 	};
 
+	hdq_pins: pinmux_hdq_pins {
+		pinctrl-single,pins = <
+		/* 0x4a100120 hdq_sio.hdq_sio aa27 */
+		OMAP4_IOPAD(0x120, PIN_INPUT | MUX_MODE0)
+		>;
+	};
+
 	/* hdmi_cec.hdmi_cec, hdmi_scl.hdmi_scl, hdmi_sda.hdmi_sda */
 	dss_hdmi_pins: pinmux_dss_hdmi_pins {
 		pinctrl-single,pins = <
-- 
2.24.1

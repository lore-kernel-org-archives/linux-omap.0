From: Kevin Hilman <khilman@linaro.org>
Subject: [PATCH v2] ARM: DTS: OMAP4: Panda/SDP: twl6030: fix mux for IRQ pin and msecure line
Date: Fri, 24 May 2013 17:24:21 -0700
Message-ID: <1369441461-18888-1-git-send-email-khilman@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:51497 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757Ab3EYAYZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 May 2013 20:24:25 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz11so2147255pad.16
        for <linux-omap@vger.kernel.org>; Fri, 24 May 2013 17:24:25 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>

Earlier commits ensured proper muxing of pins related to proper
TWL6030 behavior: see commit 265a2bc8 (ARM: OMAP3: TWL4030: ensure
sys_nirq1 is mux'd and wakeup enabled) and commit 1ef43369 (ARM:
OMAP4: TWL: mux sys_drm_msecure as output for PMIC).

However these only fixed legacy boot and not DT boot.  For DT boot,
the default mux values need to be set properly in DT.

Special thanks to Nishanth Menon for the review and catching some
major flaws in earlier versions.

Tested on OMAP4430/Panda and OMAP4460/Panda-ES.

Cc: Nishanth Menon <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Kevin Hilman <khilman@linaro.org>
---
Applies to v3.10-rc2

 arch/arm/boot/dts/omap4-panda-common.dtsi | 20 ++++++++++++++++++++
 arch/arm/boot/dts/omap4-sdp.dts           | 20 ++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
index 03bd60d..eeb734e 100644
--- a/arch/arm/boot/dts/omap4-panda-common.dtsi
+++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
@@ -56,9 +56,23 @@
 	};
 };
 
+&omap4_pmx_wkup {
+	pinctrl-names = "default";
+	pinctrl-0 = <
+			&twl6030_wkup_pins
+	>;
+
+	twl6030_wkup_pins: pinmux_twl6030_wkup_pins {
+		pinctrl-single,pins = <
+			0x14 0x2        /* fref_clk0_out.sys_drm_msecure OUTPUT | MODE2 */
+		>;
+	};
+};
+
 &omap4_pmx_core {
 	pinctrl-names = "default";
 	pinctrl-0 = <
+			&twl6030_pins
 			&twl6040_pins
 			&mcpdm_pins
 			&mcbsp1_pins
@@ -66,6 +80,12 @@
 			&tpd12s015_pins
 	>;
 
+	twl6030_pins: pinmux_twl6030_pins {
+		pinctrl-single,pins = <
+			0x15e 0x4118	/* sys_nirq1.sys_nirq1 OMAP_WAKEUP_EN | INPUT_PULLUP | MODE0 */
+		>;
+	};
+
 	twl6040_pins: pinmux_twl6040_pins {
 		pinctrl-single,pins = <
 			0xe0 0x3	/* hdq_sio.gpio_127 OUTPUT | MODE3 */
diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index a35d9cd..98505a2 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -142,9 +142,23 @@
 	};
 };
 
+&omap4_pmx_wkup {
+	pinctrl-names = "default";
+	pinctrl-0 = <
+			&twl6030_wkup_pins
+	>;
+
+	twl6030_wkup_pins: pinmux_twl6030_wkup_pins {
+		pinctrl-single,pins = <
+			0x14 0x2        /* fref_clk0_out.sys_drm_msecure OUTPUT | MODE2 */
+		>;
+	};
+};
+
 &omap4_pmx_core {
 	pinctrl-names = "default";
 	pinctrl-0 = <
+			&twl6030_pins
 			&twl6040_pins
 			&mcpdm_pins
 			&dmic_pins
@@ -179,6 +193,12 @@
 		>;
 	};
 
+	twl6030_pins: pinmux_twl6030_pins {
+		pinctrl-single,pins = <
+			0x15e 0x4118	/* sys_nirq1.sys_nirq1 OMAP_WAKEUP_EN | INPUT_PULLUP | MODE0 */
+		>;
+	};
+
 	twl6040_pins: pinmux_twl6040_pins {
 		pinctrl-single,pins = <
 			0xe0 0x3	/* hdq_sio.gpio_127 OUTPUT | MODE3 */
-- 
1.8.2


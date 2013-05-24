From: Kevin Hilman <khilman@linaro.org>
Subject: [PATCH] ARM: DTS: OMAP4: Panda/SDP: twl6030: fix mux for IRQ pin and msecure line
Date: Fri, 24 May 2013 12:28:22 -0700
Message-ID: <1369423702-31501-1-git-send-email-khilman@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:40422 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755041Ab3EXT20 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 May 2013 15:28:26 -0400
Received: by mail-pb0-f50.google.com with SMTP id wy17so4541129pbc.23
        for <linux-omap@vger.kernel.org>; Fri, 24 May 2013 12:28:25 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Earlier commits ensured proper muxing of pins related to proper
TWL6030 behavior: see commit 265a2bc8 (ARM: OMAP3: TWL4030: ensure
sys_nirq1 is mux'd and wakeup enabled) and commit 1ef43369 (ARM:
OMAP4: TWL: mux sys_drm_msecure as output for PMIC).

However these only fixed legacy boot and not DT boot.  For DT boot,
the default mux values need to be set properly in DT.

Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Kevin Hilman <khilman@linaro.org>
---
Applies on v3.10-rc2

 arch/arm/boot/dts/omap4-panda-common.dtsi | 8 ++++++++
 arch/arm/boot/dts/omap4-sdp.dts           | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
index 03bd60d..a7a9bc0 100644
--- a/arch/arm/boot/dts/omap4-panda-common.dtsi
+++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
@@ -59,6 +59,7 @@
 &omap4_pmx_core {
 	pinctrl-names = "default";
 	pinctrl-0 = <
+			&twl6030_pins
 			&twl6040_pins
 			&mcpdm_pins
 			&mcbsp1_pins
@@ -66,6 +67,13 @@
 			&tpd12s015_pins
 	>;
 
+	twl6030_pins: pinmux_twl6030_pins {
+		pinctrl-single,pins = <
+			0x15e 0x4118	/* sys_nirq1.sys_nirq1 OMAP_WAKEUP_EN | INPUT_PULLUP | MODE0 */
+			0x14 0x0	/* fref_clk0_out.sys_drm_msecure OUTPUT */
+		>;
+	};
+
 	twl6040_pins: pinmux_twl6040_pins {
 		pinctrl-single,pins = <
 			0xe0 0x3	/* hdq_sio.gpio_127 OUTPUT | MODE3 */
diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index a35d9cd..5ad0c10 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -145,6 +145,7 @@
 &omap4_pmx_core {
 	pinctrl-names = "default";
 	pinctrl-0 = <
+			&twl6030_pins
 			&twl6040_pins
 			&mcpdm_pins
 			&dmic_pins
@@ -179,6 +180,13 @@
 		>;
 	};
 
+	twl6030_pins: pinmux_twl6030_pins {
+		pinctrl-single,pins = <
+			0x15e 0x4118	/* sys_nirq1.sys_nirq1 OMAP_WAKEUP_EN | INPUT_PULLUP | MODE0 */
+			0x14 0x0	/* fref_clk0_out.sys_drm_msecure OUTPUT */
+		>;
+	};
+
 	twl6040_pins: pinmux_twl6040_pins {
 		pinctrl-single,pins = <
 			0xe0 0x3	/* hdq_sio.gpio_127 OUTPUT | MODE3 */
-- 
1.8.2


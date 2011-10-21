From: <mythripk@ti.com>
Subject: [PATCH 2/2] OMAPDSS: HDMI: Disable HDMI DDC internal pull up
Date: Fri, 21 Oct 2011 14:57:06 +0530
Message-ID: <1319189226-11019-1-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41882 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753596Ab1JUJfD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 Oct 2011 05:35:03 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org
Cc: Mythri P K <mythripk@ti.com>, Ricardo Salveti de Araujo <ricardo.salveti@linaro.org>

From: Mythri P K <mythripk@ti.com>

Disables the internal pull resistor for SDA and SCL enabled by
default as there are expernal pull up's to avoid the EDID read failure.

Signed-off-by: Ricardo Salveti de Araujo <ricardo.salveti@linaro.org>
Signed-off-by: Mythri P K <mythripk@ti.com>
---
 arch/arm/mach-omap2/display.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index f6590b9..3e70ef8 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -106,6 +106,9 @@ static const struct omap_dss_hwmod_data omap4_dss_hwmod_data[] __initdata = {
 
 static void omap4_hdmi_mux_pads(void)
 {
+	u32 reg;
+	u16 control_i2c_1;
+
 	/* PAD0_HDMI_HPD_PAD1_HDMI_CEC */
 	omap_mux_init_signal("hdmi_hpd",
 			OMAP_PIN_INPUT_PULLUP);
@@ -116,6 +119,21 @@ static void omap4_hdmi_mux_pads(void)
 			OMAP_PIN_INPUT_PULLUP);
 	omap_mux_init_signal("hdmi_ddc_sda",
 			OMAP_PIN_INPUT_PULLUP);
+
+	/*
+	 * CONTROL_I2C_1: HDMI_DDC_SDA_PULLUPRESX (bit 28) and
+	 * HDMI_DDC_SCL_PULLUPRESX (bit 24) are set to disable
+	 * internal pull up resistor - This is a change needed in
+	 * OMAP4460 and OMAP4430 ES2.3 as the external pull up
+	 * are present. This is needed to avoid EDID read failure.
+	 */
+	if (cpu_is_omap446x() || (omap_rev() > OMAP4430_REV_ES2_2)) {
+		control_i2c_1 = OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_I2C_1;
+		reg = omap4_ctrl_pad_readl(control_i2c_1);
+		reg |= (OMAP4_HDMI_DDC_SDA_PULLUPRESX_MASK |
+		OMAP4_HDMI_DDC_SCL_PULLUPRESX_MASK);
+		omap4_ctrl_pad_writel(reg, control_i2c_1);
+	}
 }
 
 static int omap4_dsi_mux_pads(int dsi_id, unsigned lanes)
-- 
1.7.5.4


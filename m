From: <mythripk@ti.com>
Subject: [PATCH 2/2] OMAPDSS: HDMI: SDP: Disable HDMI DDC internal pull up
Date: Thu, 20 Oct 2011 16:14:06 +0530
Message-ID: <1319107446-15600-1-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34023 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932262Ab1JTKwB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Oct 2011 06:52:01 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org
Cc: Mythri P K <mythripk@ti.com>, Ricardo Salveti de Araujo <ricardo.salveti@linaro.org>

From: Mythri P K <mythripk@ti.com>

Disables the internal pull resistor for SDA and SCL enabled by
default as there are expernal pull up's to avoid the EDID read failure.

Signed-off-by: Ricardo Salveti de Araujo <ricardo.salveti@linaro.org>
---
 arch/arm/mach-omap2/board-4430sdp.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 6d16306..75f7cd0 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -603,6 +603,9 @@ static void __init omap_sfh7741prox_init(void)
 
 static void sdp4430_hdmi_mux_init(void)
 {
+	u32 reg;
+	u16 control_i2c_1;
+
 	/* PAD0_HDMI_HPD_PAD1_HDMI_CEC */
 	omap_mux_init_signal("hdmi_hpd",
 			OMAP_PIN_INPUT_PULLUP);
@@ -613,6 +616,21 @@ static void sdp4430_hdmi_mux_init(void)
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
 
 static struct gpio sdp4430_hdmi_gpios[] = {
-- 
1.7.5.4


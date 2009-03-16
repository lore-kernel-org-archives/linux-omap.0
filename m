From: Dominic Curran <dcurran@ti.com>
Subject: [OMAPZOOM][PATCH] CSI2: Fix to csi2 reset.
Date: Sun, 15 Mar 2009 19:12:42 -0500
Message-ID: <200903151912.42156.dcurran@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53747 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752287AbZCPAMv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 15 Mar 2009 20:12:51 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2G0CgHL017714
	for <linux-omap@vger.kernel.org>; Sun, 15 Mar 2009 19:12:47 -0500
Received: from gromit.am.dhcp.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id n2G0CgVf002156
	for <linux-omap@vger.kernel.org>; Sun, 15 Mar 2009 19:12:42 -0500 (CDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

From: Dominic Curran <dcurran@ti.com>
Subject: [OMAPZOOM][PATCH] CSI2: Fix to csi2 reset.

This patch fixes an issue where CSI2 setup is incorrect for the
following scenario:
 QBUF
 STREAMON
 DQBUF
 STREAMOFF
 QBUF
 STREAMON   <- csi2 setup incorrect at power_on
 DQBUF      <- forever wait here

When STREAMOFF occurs then csi2 register setup ends up in an unknown
state.
This patch performs a csi2 reset everytime a PowerOn occurs to get it back into 
know state.

SUMMARY:
board-*.c - Remove the 'if' condition so that csi2 reset is called everytime.

isp.c     - Configuration in isp_csi2_ctx_config_format() depends on
            changes that happen in isp_csi2_ctrl_config_vp_only_enable().
            Thus change order so that isp_csi2_ctrl_config_vp_only_enable()
            is called first.

ispcsi2.c - Clear internal structures at beginning of every reset.


Signed-off-by: Dominic Curran <dcurran@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c |    6 ++----
 arch/arm/mach-omap2/board-ldp.c     |    4 ++--
 arch/arm/mach-omap2/board-zoom2.c   |    3 +--
 drivers/media/video/isp/isp.c       |    6 +++---
 drivers/media/video/isp/ispcsi2.c   |    4 ++++
 5 files changed, 12 insertions(+), 11 deletions(-)

Index: omapzoom04/arch/arm/mach-omap2/board-3430sdp.c
===================================================================
--- omapzoom04.orig/arch/arm/mach-omap2/board-3430sdp.c
+++ omapzoom04/arch/arm/mach-omap2/board-3430sdp.c
@@ -835,8 +835,7 @@ static int ov3640_sensor_power_set(enum 
 	switch (power) {
 	case V4L2_POWER_ON:
 		printk(KERN_DEBUG "ov3640_sensor_power_set(ON)\n");
-		if (previous_power == V4L2_POWER_OFF)
-			isp_csi2_reset();
+		isp_csi2_reset();
 
 		lanecfg.clk.pol = OV3640_CSI2_CLOCK_POLARITY;
 		lanecfg.clk.pos = OV3640_CSI2_CLOCK_LANE;
@@ -1019,8 +1018,7 @@ static int imx046_sensor_power_set(enum 
 	case V4L2_POWER_ON:
 		/* Power Up Sequence */
 		printk(KERN_DEBUG "imx046_sensor_power_set(ON)\n");
-		if (previous_power == V4L2_POWER_OFF)
-			isp_csi2_reset();
+		isp_csi2_reset();
 
 		lanecfg.clk.pol = IMX046_CSI2_CLOCK_POLARITY;
 		lanecfg.clk.pos = IMX046_CSI2_CLOCK_LANE;
Index: omapzoom04/arch/arm/mach-omap2/board-ldp.c
===================================================================
--- omapzoom04.orig/arch/arm/mach-omap2/board-ldp.c
+++ omapzoom04/arch/arm/mach-omap2/board-ldp.c
@@ -675,8 +675,8 @@ static int ov3640_sensor_power_set(enum 
 	switch (power) {
 	case V4L2_POWER_ON:
 		printk(KERN_DEBUG "ov3640_sensor_power_set(ON)\n");
-		if (previous_power == V4L2_POWER_OFF)
-			isp_csi2_reset();
+		isp_csi2_reset();
+
 		lanecfg.clk.pol = OV3640_CSI2_CLOCK_POLARITY;
 		lanecfg.clk.pos = OV3640_CSI2_CLOCK_LANE;
 		lanecfg.data[0].pol = OV3640_CSI2_DATA0_POLARITY;
Index: omapzoom04/arch/arm/mach-omap2/board-zoom2.c
===================================================================
--- omapzoom04.orig/arch/arm/mach-omap2/board-zoom2.c
+++ omapzoom04/arch/arm/mach-omap2/board-zoom2.c
@@ -397,8 +397,7 @@ static int imx046_sensor_power_set(enum 
 	case V4L2_POWER_ON:
 		/* Power Up Sequence */
 		printk(KERN_DEBUG "imx046_sensor_power_set(ON)\n");
-		if (previous_power == V4L2_POWER_OFF)
-			isp_csi2_reset();
+		isp_csi2_reset();
 
 		lanecfg.clk.pol = IMX046_CSI2_CLOCK_POLARITY;
 		lanecfg.clk.pos = IMX046_CSI2_CLOCK_LANE;
Index: omapzoom04/drivers/media/video/isp/isp.c
===================================================================
--- omapzoom04.orig/drivers/media/video/isp/isp.c
+++ omapzoom04/drivers/media/video/isp/isp.c
@@ -907,9 +907,6 @@ int isp_configure_interface(struct isp_i
 		ispctrl_val &= ~ISPCTRL_PAR_BRIDGE_BENDIAN;
 		ispctrl_val |= (0x03 << ISPCTRL_PAR_BRIDGE_SHIFT);
 
-		isp_csi2_ctx_config_format(0, config->u.csi.format);
-		isp_csi2_ctx_update(0, false);
-
 		if (config->u.csi.crc)
 			isp_csi2_ctrl_config_ecc_enable(true);
 
@@ -918,6 +915,9 @@ int isp_configure_interface(struct isp_i
 		isp_csi2_ctrl_config_vp_clk_enable(true);
 		isp_csi2_ctrl_update(false);
 
+		isp_csi2_ctx_config_format(0, config->u.csi.format);
+		isp_csi2_ctx_update(0, false);
+
 		isp_csi2_irq_complexio1_set(1);
 		isp_csi2_irq_status_set(1);
 		isp_csi2_irq_set(1);
Index: omapzoom04/drivers/media/video/isp/ispcsi2.c
===================================================================
--- omapzoom04.orig/drivers/media/video/isp/ispcsi2.c
+++ omapzoom04/drivers/media/video/isp/ispcsi2.c
@@ -1966,6 +1966,10 @@ int isp_csi2_reset(void)
 	u8 soft_reset_retries = 0;
 	int i;
 
+	memset(&current_csi2_cfg, 0x00, sizeof(struct isp_csi2_cfg));
+	memset(&current_csi2_cfg_update, 0x00,
+			sizeof(struct isp_csi2_cfg_update));
+
 	reg = omap_readl(ISPCSI2_SYSCONFIG);
 	reg |= ISPCSI2_SYSCONFIG_SOFT_RESET_RESET;
 	omap_writel(reg, ISPCSI2_SYSCONFIG);

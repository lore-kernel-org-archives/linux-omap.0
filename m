From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCHv2] arm: omap2+: hwmod: Add qspi data for am437x.
Date: Tue, 15 Oct 2013 11:07:27 +0530
Message-ID: <1381815447-10401-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35084 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752589Ab3JOFiC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Oct 2013 01:38:02 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, paul@pwsan.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk, balbi@ti.com, nsekhar@ti.com, afzal@ti.com, Sourav Poddar <sourav.poddar@ti.com>

Add hwmod data for qspi for AM437x.

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
This was tested on AM437x EPOS EVM with Afzal's v6 of AM43x PRCM
basic support and tero's DT clock series.

v1->v2:
Rebase on George Cherian USB hwmod patches.
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c |   34 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prcm43xx.h             |    1 +
 2 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
index a58024d..9002fca 100644
--- a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
@@ -389,6 +389,32 @@ static struct omap_hwmod am43xx_usb_otg_ss1_hwmod = {
 	},
 };
 
+static struct omap_hwmod_class_sysconfig am43xx_qspi_sysc = {
+	.sysc_offs      = 0x0010,
+	.sysc_flags     = SYSC_HAS_SIDLEMODE,
+	.idlemodes      = (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+				SIDLE_SMART_WKUP),
+	.sysc_fields    = &omap_hwmod_sysc_type2,
+};
+
+static struct omap_hwmod_class am43xx_qspi_hwmod_class = {
+	.name   = "qspi",
+	.sysc   = &am43xx_qspi_sysc,
+};
+
+static struct omap_hwmod am43xx_qspi_hwmod = {
+	.name           = "qspi",
+	.class          = &am43xx_qspi_hwmod_class,
+	.clkdm_name     = "l3s_clkdm",
+	.main_clk       = "l3s_gclk",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = AM43XX_CM_PER_QSPI_CLKCTRL_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
+		},
+	},
+};
+
 /* Interfaces */
 static struct omap_hwmod_ocp_if am43xx_l3_main__l4_hs = {
 	.master		= &am33xx_l3_main_hwmod,
@@ -621,6 +647,13 @@ static struct omap_hwmod_ocp_if am43xx_l3_s__usbotgss1 = {
 	.user           = OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+static struct omap_hwmod_ocp_if am43xx_l3_s__qspi = {
+	.master         = &am33xx_l3_s_hwmod,
+	.slave          = &am43xx_qspi_hwmod,
+	.clk            = "l3s_gclk",
+	.user           = OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 static struct omap_hwmod_ocp_if *am43xx_hwmod_ocp_ifs[] __initdata = {
 	&am33xx_l4_wkup__synctimer,
 	&am43xx_l4_ls__timer8,
@@ -660,6 +693,7 @@ static struct omap_hwmod_ocp_if *am43xx_hwmod_ocp_ifs[] __initdata = {
 	&am43xx_l4_wkup__i2c1,
 	&am43xx_l4_wkup__gpio0,
 	&am43xx_l4_wkup__wd_timer1,
+	&am43xx_l3_s__qspi,
 	&am33xx_l4_per__dcan0,
 	&am33xx_l4_per__dcan1,
 	&am33xx_l4_per__gpio1,
diff --git a/arch/arm/mach-omap2/prcm43xx.h b/arch/arm/mach-omap2/prcm43xx.h
index 0d66a6e..7785be9 100644
--- a/arch/arm/mach-omap2/prcm43xx.h
+++ b/arch/arm/mach-omap2/prcm43xx.h
@@ -106,6 +106,7 @@
 #define AM43XX_CM_WKUP_L4WKUP_CLKCTRL_OFFSET		0x0220
 #define AM43XX_CM_RTC_RTC_CLKCTRL_OFFSET		0x0020
 #define AM43XX_CM_PER_MMC2_CLKCTRL_OFFSET		0x0248
+#define AM43XX_CM_PER_QSPI_CLKCTRL_OFFSET               0x0258
 #define AM43XX_CM_PER_GPMC_CLKCTRL_OFFSET		0x0220
 #define AM43XX_CM_PER_MCASP0_CLKCTRL_OFFSET		0x0238
 #define AM43XX_CM_PER_MCASP1_CLKCTRL_OFFSET		0x0240
-- 
1.7.1


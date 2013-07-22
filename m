From: Sathya Prakash M R <sathyap@ti.com>
Subject: [PATCH 1/2] ARM: OMAP2+: AM43x - Add DSS hwmod
Date: Mon, 22 Jul 2013 11:33:16 +0530
Message-ID: <1374472997-9653-2-git-send-email-sathyap@ti.com>
References: <1374472997-9653-1-git-send-email-sathyap@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34990 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752984Ab3GVGEQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Jul 2013 02:04:16 -0400
In-Reply-To: <1374472997-9653-1-git-send-email-sathyap@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, benoit.cousson@linaro.org, a-kishore@ti.com, devicetree-discuss@lists.ozlabs.org
Cc: afzal@ti.com, Sathya Prakash M R <sathyap@ti.com>

Add DSS hwmod struct for AM43x SOC.

Signed-off-by: Sathya Prakash M R <sathyap@ti.com>
---
This is based on below patch series which is yet to be merged
http://permalink.gmane.org/gmane.linux.ports.arm.omap/100892

 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |   85 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prcm43xx.h             |    1 +
 2 files changed, 86 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index 319780e..a1884ce 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -1937,6 +1937,55 @@ static struct omap_hwmod am43xx_spi4_hwmod = {
 	.dev_attr	= &mcspi_attrib,
 };
 
+/* Display sub system - DSS */
+
+static struct omap_hwmod_dma_info am43xx_dss_sdma_chs[] = {
+	{ .name = "dispc", .dma_req = 5 },
+	{ .dma_req = -1 }
+
+static struct omap_hwmod am43xx_dss_core_hwmod = {
+	.name		= "dss_core",
+	.class		= &omap2_dss_hwmod_class,
+	.clkdm_name	= "dss_clkdm",
+	.main_clk	= "disp_clk",
+	.sdma_reqs	= am43xx_dss_sdma_chs,
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = AM43XX_CM_PER_DSS_CLKCTRL_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+/* display controller -dispc*/
+
+static struct omap_hwmod am43xx_dss_dispc_hwmod = {
+	.name		= "dss_dispc",
+	.class		= &omap3_dispc_hwmod_class,
+	.clkdm_name	= "dss_clkdm",
+	.main_clk	= "disp_clk",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = AM43XX_CM_PER_DSS_CLKCTRL_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
+		},
+};
+
+/*RFBI*/
+
+static struct omap_hwmod am43xx_dss_rfbi_hwmod = {
+	.name		= "dss_rfbi",
+	.class		= &omap2_rfbi_hwmod_class,
+	.clkdm_name	= "dss_clkdm",
+	.main_clk	= "disp_clk",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = AM43XX_CM_PER_DSS_CLKCTRL_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
+		},
+};
+
+
 /*
  * Interfaces
  */
@@ -2874,6 +2923,38 @@ static struct omap_hwmod_ocp_if am43xx_l3_main__pruss = {
 	.user		= OCP_USER_MPU,
 };
 
+/* DSS -> L3 Main */
+static struct omap_hwmod_ocp_if am43xx_dss__l3_main = {
+	.master		= &am43xx_dss_core_hwmod,
+	.slave		= &am33xx_l3_main_hwmod,
+	.clk		= "disp_clk"
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* L4-ls -> DSS */
+static struct omap_hwmod_ocp_if am43xx_l4_ls__dss = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am43xx_dss_core_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* L4_ls -> dss_dispc */
+static struct omap_hwmod_ocp_if am43xx_l4_ls__dss_dispc = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am43xx_dss_dispc_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* L4_ls -> dss_rfbi */
+static struct omap_hwmod_ocp_if am43xx_l4_ls__dss_rfbi = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am43xx_dss_rfbi_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 #define CLKCTRL(oh, clkctrl) ((oh).prcm.omap4.clkctrl_offs = (clkctrl))
 
 static void am43xx_hwmod_clkctrl(void)
@@ -3109,6 +3190,10 @@ static struct omap_hwmod_ocp_if *am43xx_hwmod_ocp_ifs[] __initdata = {
 	&am43xx_l4_ls__mcspi3,
 	&am43xx_l4_ls__mcspi4,
 	&am43xx_l3_main__pruss,
+	&am43xx_dss__l3_main,
+	&am43xx_l4_ls__dss,
+	&am43xx_l4_ls__dss_dispc,
+	&am43xx_l4_ls__dss_rfbi,
 	NULL,
 };
 
diff --git a/arch/arm/mach-omap2/prcm43xx.h b/arch/arm/mach-omap2/prcm43xx.h
index 0d05278..4dfd9be 100644
--- a/arch/arm/mach-omap2/prcm43xx.h
+++ b/arch/arm/mach-omap2/prcm43xx.h
@@ -144,5 +144,6 @@
 #define	AM43XX_CM_PER_SPI2_CLKCTRL_OFFSET		0x0510
 #define	AM43XX_CM_PER_SPI3_CLKCTRL_OFFSET		0x0518
 #define	AM43XX_CM_PER_SPI4_CLKCTRL_OFFSET		0x0520
+#define	AM43XX_CM_PER_DSS_CLKCTRL_OFFSET		0x0a00
 
 #endif
-- 
1.7.9.5


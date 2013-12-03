From: Sathya Prakash M R <sathyap@ti.com>
Subject: [PATCH 3/4] ARM: OMAP2+: AM43xx DSS Hwmod
Date: Tue, 3 Dec 2013 14:03:47 +0530
Message-ID: <1386059629-1234-4-git-send-email-sathyap@ti.com>
References: <1386059629-1234-1-git-send-email-sathyap@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39713 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752253Ab3LCIeQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Dec 2013 03:34:16 -0500
In-Reply-To: <1386059629-1234-1-git-send-email-sathyap@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, tomi.valkeinen@ti.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, paul@pwsan.com
Cc: Sathya Prakash M R <sathyap@ti.com>

Add DSS hwmod structs for AM43xx.

Signed-off-by: Sathya Prakash M R <sathyap@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c |  104 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prcm43xx.h             |    1 +
 2 files changed, 105 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
index 9002fca..6a121db 100644
--- a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
@@ -19,6 +19,8 @@
 #include "omap_hwmod.h"
 #include "omap_hwmod_33xx_43xx_common_data.h"
 #include "prcm43xx.h"
+#include "omap_hwmod_common_data.h"
+
 
 /* IP blocks */
 static struct omap_hwmod am43xx_l4_hs_hwmod = {
@@ -415,6 +417,76 @@ static struct omap_hwmod am43xx_qspi_hwmod = {
 	},
 };
 
+/* Display sub system - DSS */
+
+static struct omap_hwmod_dma_info am43xx_dss_sdma_chs[] = {
+	{ .name = "dispc", .dma_req = 5 },
+	{ .dma_req = -1 },
+};
+
+struct omap_dss_dispc_dev_attr am43xx_dss_dispc_dev_attr = {
+	.manager_count		= 1,
+	.has_framedonetv_irq	= 0
+};
+
+
+static struct omap_hwmod_class_sysconfig am43xx_dispc_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0014,
+	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_MIDLEMODE),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class am43xx_dispc_hwmod_class = {
+	.name	= "dispc",
+	.sysc	= &am43xx_dispc_sysc,
+};
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
+	.class		= &am43xx_dispc_hwmod_class,
+	.clkdm_name	= "dss_clkdm",
+	.main_clk	= "disp_clk",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = AM43XX_CM_PER_DSS_CLKCTRL_OFFSET,
+		},
+	},
+	.dev_attr	= &am43xx_dss_dispc_dev_attr,
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
+		},
+	},
+};
+
 /* Interfaces */
 static struct omap_hwmod_ocp_if am43xx_l3_main__l4_hs = {
 	.master		= &am33xx_l3_main_hwmod,
@@ -654,6 +726,34 @@ static struct omap_hwmod_ocp_if am43xx_l3_s__qspi = {
 	.user           = OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+static struct omap_hwmod_ocp_if am43xx_dss__l3_main = {
+	.master		= &am43xx_dss_core_hwmod,
+	.slave		= &am33xx_l3_main_hwmod,
+	.clk		= "disp_clk",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_ocp_if am43xx_l4_ls__dss = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am43xx_dss_core_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_ocp_if am43xx_l4_ls__dss_dispc = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am43xx_dss_dispc_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_ocp_if am43xx_l4_ls__dss_rfbi = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am43xx_dss_rfbi_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 static struct omap_hwmod_ocp_if *am43xx_hwmod_ocp_ifs[] __initdata = {
 	&am33xx_l4_wkup__synctimer,
 	&am43xx_l4_ls__timer8,
@@ -747,6 +847,10 @@ static struct omap_hwmod_ocp_if *am43xx_hwmod_ocp_ifs[] __initdata = {
 	&am43xx_l4_ls__ocp2scp1,
 	&am43xx_l3_s__usbotgss0,
 	&am43xx_l3_s__usbotgss1,
+	&am43xx_dss__l3_main,
+	&am43xx_l4_ls__dss,
+	&am43xx_l4_ls__dss_dispc,
+	&am43xx_l4_ls__dss_rfbi,
 	NULL,
 };
 
diff --git a/arch/arm/mach-omap2/prcm43xx.h b/arch/arm/mach-omap2/prcm43xx.h
index 7785be9..ad7b3e9 100644
--- a/arch/arm/mach-omap2/prcm43xx.h
+++ b/arch/arm/mach-omap2/prcm43xx.h
@@ -142,5 +142,6 @@
 #define AM43XX_CM_PER_USBPHYOCP2SCP0_CLKCTRL_OFFSET	0x05B8
 #define AM43XX_CM_PER_USB_OTG_SS1_CLKCTRL_OFFSET        0x0268
 #define AM43XX_CM_PER_USBPHYOCP2SCP1_CLKCTRL_OFFSET	0x05C0
+#define AM43XX_CM_PER_DSS_CLKCTRL_OFFSET		0x0a20
 
 #endif
-- 
1.7.9.5


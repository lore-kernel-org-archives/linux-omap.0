From: Satish Patel <satish.patel@ti.com>
Subject: [RFC PATCH v1 2/2] ARM: OMAP: AM43xx: HWMOD changes added for ti-usim
Date: Mon, 6 Jan 2014 17:42:31 +0530
Message-ID: <1389010351-17320-3-git-send-email-satish.patel@ti.com>
References: <1389010351-17320-1-git-send-email-satish.patel@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39747 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753660AbaAFMNA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Jan 2014 07:13:00 -0500
In-Reply-To: <1389010351-17320-1-git-send-email-satish.patel@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

HWMOD entries support for TI's USIM - Smart card controller of AM43xx platform

Signed-off-by: Satish Patel <satish.patel@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |   39 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prcm43xx.h             |    1 +
 2 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index 5a629f2..f9bfdec 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -1689,6 +1689,35 @@ static struct omap_hwmod am33xx_usbss_hwmod = {
 	},
 };
 
+/* usim0 */
+static struct omap_hwmod_class_sysconfig am43xx_usim0_sysc = {
+	.rev_offs	= 0x0,
+	.sysc_offs	= 0x10,
+	.sysc_flags	= (SYSC_HAS_SIDLEMODE),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+				SIDLE_SMART_WKUP),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class am43xx_usim0_hwmod_class = {
+	.name		= "usim",
+	.sysc		= &am43xx_usim0_sysc,
+};
+
+static struct omap_hwmod am43xx_usim0_hwmod = {
+	.name		= "usim0",
+	.class		= &am43xx_usim0_hwmod_class,
+	.clkdm_name	= "l4ls_clkdm",
+	.main_clk	= "l4ls_gclk",
+	.prcm		= {
+		.omap4	= {
+				.clkctrl_offs	= AM43XX_CM_PER_USIM0_CLKCTRL_OFFSET,
+				.modulemode	= MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+
 static struct omap_hwmod_class_sysconfig am43xx_synctimer_sysc = {
 	.rev_offs	= 0x0,
 	.sysc_offs	= 0x4,
@@ -2901,6 +2930,14 @@ static struct omap_hwmod_ocp_if am43xx_l4_ls__mcspi4 = {
 	.user		= OCP_USER_MPU,
 };
 
+static struct omap_hwmod_ocp_if am43xx_l4_ls__usim0 = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am43xx_usim0_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU,
+};
+
+
 static struct omap_hwmod_ocp_if am43xx_l4_ls__gpio4 = {
 	.master		= &am33xx_l4_ls_hwmod,
 	.slave		= &am43xx_gpio4_hwmod,
@@ -3083,6 +3120,7 @@ static void am43xx_hwmod_clkctrl(void)
 	CLKCTRL(am33xx_sha0_hwmod , AM43XX_CM_PER_SHA0_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_aes0_hwmod , AM43XX_CM_PER_AES0_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_rng_hwmod , AM43XX_CM_PER_RNG_CLKCTRL_OFFSET);
+	CLKCTRL(am43xx_usim0_hwmod , AM43XX_CM_PER_USIM0_CLKCTRL_OFFSET);
 }
 
 static void am33xx_hwmod_clkctrl(void)
@@ -3256,6 +3294,7 @@ static struct omap_hwmod_ocp_if *am43xx_hwmod_ocp_ifs[] __initdata = {
 	&am43xx_l4_ls__dss,
 	&am43xx_l4_ls__dss_dispc,
 	&am43xx_l4_ls__dss_rfbi,
+	&am43xx_l4_ls__usim0,
 	NULL,
 };
 
diff --git a/arch/arm/mach-omap2/prcm43xx.h b/arch/arm/mach-omap2/prcm43xx.h
index 93a1953..d8aa310 100644
--- a/arch/arm/mach-omap2/prcm43xx.h
+++ b/arch/arm/mach-omap2/prcm43xx.h
@@ -146,5 +146,6 @@
 #define AM43XX_CM_PER_GPIO5_CLKCTRL_OFFSET		0x0498
 #define AM43XX_CM_PER_DSS_CLKCTRL_OFFSET		0x0a20
 #define AM43XX_CM_PER_MAGADC_CLKCTRL_OFFSET		0x0230
+#define AM43XX_CM_PER_USIM0_CLKCTRL_OFFSET              0x05A8
 
 #endif
-- 
1.7.1


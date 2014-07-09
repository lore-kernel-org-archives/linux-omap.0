From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH V2 1/2] ARM: DRA7: hwmod: Add data for RTC
Date: Wed, 9 Jul 2014 14:05:31 +0530
Message-ID: <1404894932-26677-2-git-send-email-lokeshvutla@ti.com>
References: <alpine.DEB.2.02.1407060031120.23762@utopia.booyaka.com>
 <1404894932-26677-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58464 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751871AbaGIIgP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Jul 2014 04:36:15 -0400
In-Reply-To: <1404894932-26677-1-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, rnayak@ti.com, tony@atomide.com, devicetree@vger.kernel.org, nm@ti.com, j-keerthy@ti.com, nsekhar@ti.com, lokeshvutla@ti.com

Add hwmod data for RTC

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Reviewed-by: Rajendra Nayak <rnayak@ti.com>
---
Changes since V1:
Rebased on top of linux-next 20140708.

 arch/arm/mach-omap2/omap_hwmod_7xx_data.c |   41 +++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index 20b4398..d8032b9 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -1249,6 +1249,38 @@ static struct omap_hwmod dra7xx_qspi_hwmod = {
 };
 
 /*
+ * 'rtcss' class
+ *
+ */
+static struct omap_hwmod_class_sysconfig dra7xx_rtcss_sysc = {
+	.sysc_offs	= 0x0078,
+	.sysc_flags	= SYSC_HAS_SIDLEMODE,
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+			   SIDLE_SMART_WKUP),
+	.sysc_fields	= &omap_hwmod_sysc_type3,
+};
+
+static struct omap_hwmod_class dra7xx_rtcss_hwmod_class = {
+	.name	= "rtcss",
+	.sysc	= &dra7xx_rtcss_sysc,
+};
+
+/* rtcss */
+static struct omap_hwmod dra7xx_rtcss_hwmod = {
+	.name		= "rtcss",
+	.class		= &dra7xx_rtcss_hwmod_class,
+	.clkdm_name	= "rtc_clkdm",
+	.main_clk	= "sys_32k_ck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = DRA7XX_CM_RTC_RTCSS_CLKCTRL_OFFSET,
+			.context_offs = DRA7XX_RM_RTC_RTCSS_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+/*
  * 'sata' class
  *
  */
@@ -2344,6 +2376,14 @@ static struct omap_hwmod_ocp_if dra7xx_l3_main_1__qspi = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* l4_per3 -> rtcss */
+static struct omap_hwmod_ocp_if dra7xx_l4_per3__rtcss = {
+	.master		= &dra7xx_l4_per3_hwmod,
+	.slave		= &dra7xx_rtcss_hwmod,
+	.clk		= "l4_root_clk_div",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 static struct omap_hwmod_addr_space dra7xx_sata_addrs[] = {
 	{
 		.name		= "sysc",
@@ -2673,6 +2713,7 @@ static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp_ifs[] __initdata = {
 	&dra7xx_l4_cfg__mpu,
 	&dra7xx_l4_cfg__ocp2scp1,
 	&dra7xx_l3_main_1__qspi,
+	&dra7xx_l4_per3__rtcss,
 	&dra7xx_l4_cfg__sata,
 	&dra7xx_l4_cfg__smartreflex_core,
 	&dra7xx_l4_cfg__smartreflex_mpu,
-- 
1.7.9.5


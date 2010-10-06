From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH v1 04/16] OMAP3: hwmod data: change dss_hwmod to dss_dss_hwmod
Date: Wed,  6 Oct 2010 16:44:47 +0530
Message-ID: <1286363699-9614-5-git-send-email-svadivu@ti.com>
References: <1286363699-9614-1-git-send-email-svadivu@ti.com>
 <1286363699-9614-2-git-send-email-svadivu@ti.com>
 <1286363699-9614-3-git-send-email-svadivu@ti.com>
 <1286363699-9614-4-git-send-email-svadivu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60260 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758876Ab0JFLPP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Oct 2010 07:15:15 -0400
In-Reply-To: <1286363699-9614-4-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com, tomi.valkeinen@nokia.com, paul@pwsan.com, hvaibhav@ti.com, linux-omap@vger.kernel.org
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

dss is also considered as a HW IP inside DSS.
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 7df341f..21fb9eb 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -32,7 +32,7 @@
  * elsewhere.
  */
 
-static struct omap_hwmod omap3xxx_dss_hwmod;
+static struct omap_hwmod omap3xxx_dss_dss_hwmod;
 static struct omap_hwmod omap3xxx_dss_dispc_hwmod;
 static struct omap_hwmod omap3xxx_dss_dsi1_hwmod;
 static struct omap_hwmod omap3xxx_dss_rfbi_hwmod;
@@ -66,7 +66,7 @@ static struct omap_hwmod_ocp_if omap3xxx_mpu__l3_main = {
 
 /* DSS -> l3 */
 static struct omap_hwmod_ocp_if omap3xxx_dss__l3 = {
-	.master		= &omap3xxx_dss_hwmod,
+	.master		= &omap3xxx_dss_dss_hwmod,
 	.slave		= &omap3xxx_l3_main_hwmod,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
@@ -255,7 +255,7 @@ static struct omap_hwmod_addr_space omap3xxx_dss_addrs[] = {
 /* l4_core -> dss */
 static struct omap_hwmod_ocp_if omap3xxx_l4_core__dss = {
 	.master		= &omap3xxx_l4_core_hwmod,
-	.slave		= &omap3xxx_dss_hwmod,
+	.slave		= &omap3xxx_dss_dss_hwmod,
 	.clk		= "dss_ick",
 	.addr		= omap3xxx_dss_addrs,
 	.addr_cnt	= ARRAY_SIZE(omap3xxx_dss_addrs),
@@ -273,8 +273,8 @@ static struct omap_hwmod_opt_clk dss_opt_clks[] = {
 	{ .role = "sys_clk", .clk = "dss2_alwon_fck" },
 };
 
-static struct omap_hwmod omap3xxx_dss_hwmod = {
-	.name		= "dss",
+static struct omap_hwmod omap3xxx_dss_dss_hwmod = {
+	.name		= "dss_dss",
 	.class		= &omap3xxx_dss_hwmod_class,
 	.main_clk	= "dss1_alwon_fck", /* instead of dss_fck */
 	.mpu_irqs	= omap3xxx_dss_irqs,
@@ -532,7 +532,7 @@ static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_l4_wkup_hwmod,
 	&omap3xxx_mpu_hwmod,
 	&omap3xxx_iva_hwmod,
-	&omap3xxx_dss_hwmod,
+	&omap3xxx_dss_dss_hwmod,
 	&omap3xxx_dss_dispc_hwmod,
 	&omap3xxx_dss_dsi1_hwmod,
 	&omap3xxx_dss_rfbi_hwmod,
-- 
1.6.3.3


From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 1/3] ARM: OMAP: HWMOD: split omap2/3 dispc hwmod class
Date: Mon, 23 Jan 2012 14:15:28 +0200
Message-ID: <1327320930-14550-2-git-send-email-tomi.valkeinen@ti.com>
References: <1327320930-14550-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:52599 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750852Ab2AWMPs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Jan 2012 07:15:48 -0500
In-Reply-To: <1327320930-14550-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, paul@pwsan.com
Cc: archit@ti.com, neilb@suse.de, jean.pihet@newoldbits.com, khilman@ti.com, jw@terrafix.co.uk, Tomi Valkeinen <tomi.valkeinen@ti.com>

Currently OMAP2 and 3 share the same omap_hwmod_class and
omap_hwmod_class_sysconfig for dispc. However, OMAP3 has sysconfig
bits that OMAP2 doesn't have, so we need to split those structs into
OMAP2 and OMAP3 specific versions.

This patch only splits the structs, without changing the contents.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |   21 ------------------
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |   22 +++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   23 +++++++++++++++++++-
 3 files changed, 44 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
index c11273d..f08e442 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
@@ -56,27 +56,6 @@ struct omap_hwmod_class omap2_dss_hwmod_class = {
 };
 
 /*
- * 'dispc' class
- * display controller
- */
-
-static struct omap_hwmod_class_sysconfig omap2_dispc_sysc = {
-	.rev_offs	= 0x0000,
-	.sysc_offs	= 0x0010,
-	.syss_offs	= 0x0014,
-	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_MIDLEMODE |
-			   SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE),
-	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
-			   MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMART),
-	.sysc_fields	= &omap_hwmod_sysc_type1,
-};
-
-struct omap_hwmod_class omap2_dispc_hwmod_class = {
-	.name	= "dispc",
-	.sysc	= &omap2_dispc_sysc,
-};
-
-/*
  * 'rfbi' class
  * remote frame buffer interface
  */
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
index 177dee2..2a67297 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
@@ -28,6 +28,28 @@ struct omap_hwmod_dma_info omap2xxx_dss_sdma_chs[] = {
 	{ .name = "dispc", .dma_req = 5 },
 	{ .dma_req = -1 }
 };
+
+/*
+ * 'dispc' class
+ * display controller
+ */
+
+static struct omap_hwmod_class_sysconfig omap2_dispc_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0014,
+	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_MIDLEMODE |
+			   SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+			   MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+struct omap_hwmod_class omap2_dispc_hwmod_class = {
+	.name	= "dispc",
+	.sysc	= &omap2_dispc_sysc,
+};
+
 /* OMAP2xxx Timer Common */
 static struct omap_hwmod_class_sysconfig omap2xxx_timer_sysc = {
 	.rev_offs	= 0x0000,
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 5324e8d..c965309 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1480,6 +1480,27 @@ static struct omap_hwmod omap3xxx_dss_core_hwmod = {
 	.masters_cnt	= ARRAY_SIZE(omap3xxx_dss_masters),
 };
 
+/*
+ * 'dispc' class
+ * display controller
+ */
+
+static struct omap_hwmod_class_sysconfig omap3_dispc_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0014,
+	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_MIDLEMODE |
+			   SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+			   MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap3_dispc_hwmod_class = {
+	.name	= "dispc",
+	.sysc	= &omap3_dispc_sysc,
+};
+
 /* l4_core -> dss_dispc */
 static struct omap_hwmod_ocp_if omap3xxx_l4_core__dss_dispc = {
 	.master		= &omap3xxx_l4_core_hwmod,
@@ -1503,7 +1524,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_dss_dispc_slaves[] = {
 
 static struct omap_hwmod omap3xxx_dss_dispc_hwmod = {
 	.name		= "dss_dispc",
-	.class		= &omap2_dispc_hwmod_class,
+	.class		= &omap3_dispc_hwmod_class,
 	.mpu_irqs	= omap2_dispc_irqs,
 	.main_clk	= "dss1_alwon_fck",
 	.prcm		= {
-- 
1.7.4.1


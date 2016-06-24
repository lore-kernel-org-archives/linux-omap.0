From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH] ARM: OMAP3: hwmod data: Add sysc information for DSI
Date: Fri, 24 Jun 2016 03:59:33 +0200
Message-ID: <1466733573-19177-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

Add missing sysconfig/sysstatus information
to OMAP3 hwmod. The information has been
checked against OMAP34xx and OMAP36xx TRM.

Without this change DSI block is not reset
during boot, which is required for working
Nokia N950 display.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
Hi,

This is an updated version of this patch [0]. Instead
of the workaround implemented in [0], this patch fixes
the root problem - missing hwmod data. I think it should
be added to -rc.

[0] http://article.gmane.org/gmane.comp.video.dri.devel/153665

-- Sebastian
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 9869a75c5d96..caf15c8e0c47 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -722,8 +722,20 @@ static struct omap_hwmod omap3xxx_dss_dispc_hwmod = {
  * display serial interface controller
  */
 
+static struct omap_hwmod_class_sysconfig omap3xxx_dsi_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0014,
+	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_CLOCKACTIVITY |
+			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SIDLEMODE |
+			   SYSC_HAS_SOFTRESET | SYSS_HAS_RESET_STATUS),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
 static struct omap_hwmod_class omap3xxx_dsi_hwmod_class = {
 	.name = "dsi",
+	.sysc	= &omap3xxx_dsi_sysc,
 };
 
 static struct omap_hwmod_irq_info omap3xxx_dsi1_irqs[] = {
-- 
2.8.1

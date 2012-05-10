From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 3/3] ARM: OMAP3: HWMOD: Add omap_hwmod_class_sysconfig for dsi
Date: Thu, 10 May 2012 13:21:04 +0300
Message-ID: <1336645264-909-4-git-send-email-tomi.valkeinen@ti.com>
References: <1336645264-909-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:41515 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758781Ab2EJKVZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 May 2012 06:21:25 -0400
Received: by lahm15 with SMTP id m15so1163044lah.23
        for <linux-omap@vger.kernel.org>; Thu, 10 May 2012 03:21:16 -0700 (PDT)
In-Reply-To: <1336645264-909-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

hwmod data for OMAP3 does not define sysconfig for DSI. This patch adds
it.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 489c374..1c55295 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1558,8 +1558,20 @@ static struct omap_hwmod omap3xxx_dss_dispc_hwmod = {
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
+	.sysc = &omap3xxx_dsi_sysc,
 };
 
 static struct omap_hwmod_irq_info omap3xxx_dsi1_irqs[] = {
-- 
1.7.9.5


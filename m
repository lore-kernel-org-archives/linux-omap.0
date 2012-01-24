From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 3/3] ARM: OMAP3: HWMOD: Add omap_hwmod_class_sysconfig for dsi
Date: Tue, 24 Jan 2012 12:45:20 +0200
Message-ID: <1327401920-5617-4-git-send-email-tomi.valkeinen@ti.com>
References: <1327401920-5617-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:44923 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755886Ab2AXKpl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jan 2012 05:45:41 -0500
In-Reply-To: <1327401920-5617-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, paul@pwsan.com
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

hwmod data for OMAP3 does not define sysconfig for DSI. This patch adds
it.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 76e6498..c3ab5e4 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1547,8 +1547,20 @@ static struct omap_hwmod omap3xxx_dss_dispc_hwmod = {
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
1.7.4.1


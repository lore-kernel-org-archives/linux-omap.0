From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH]omap:dmtimer:no null check for kzalloc
Date: Mon, 12 Jul 2010 03:39:45 +0530
Message-ID: <1278886185-12502-1-git-send-email-tarun.kanti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40923 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753784Ab0GKLMX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 11 Jul 2010 07:12:23 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o6BBCKu7010225
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Sun, 11 Jul 2010 06:12:22 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: olbpdev@list.ti.com
Cc: linux-omap@vger.kernel.org, Tarun Kanti Debbarma <tarun.kanti@ti.com>

This patch incorporates null pointer check associated with memory allocation
for omap_dm_timer_plat_info using kzalloc()

Tested on OMAP4430 SDP.

Signed-off-by: Tarun Kanti Debbarma <tarun.kanti@ti.com>
--- 
 arch/arm/mach-omap2/dmtimers.c |   20 ++++++++++++++++++--
 1 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/dmtimers.c b/arch/arm/mach-omap2/dmtimers.c
index 772be63..a7e9ac5 100644
--- a/arch/arm/mach-omap2/dmtimers.c
+++ b/arch/arm/mach-omap2/dmtimers.c
@@ -248,7 +248,12 @@ void __init omap2_dm_timer_early_init(void)
 
 			pdata = kzalloc(sizeof(struct omap_dm_timer_plat_info),
 					GFP_KERNEL);
-
+			if (!pdata) {
+				pr_err("%s: \
+				No memory for omap_dm_timer_plat_info\n",
+				__func__);
+				return -ENOMEM;
+			}
 			pdata->omap_dm_clk_enable = omap2_dm_timer_enable;
 			pdata->omap_dm_clk_disable = omap2_dm_timer_disable;
 			pdata->omap_dm_set_source_clk = omap2_dm_timer_set_clk;
@@ -346,6 +351,12 @@ int __init omap2_dm_timer_init(void)
 
 			pdata = kzalloc(sizeof(struct omap_dm_timer_plat_info),
 					GFP_KERNEL);
+			if (!pdata) {
+				pr_err("%s: \
+				No memory for omap_dm_timer_plat_info\n",
+				__func__);
+				return -ENOMEM;
+			}
 			pdata->omap_dm_clk_enable = omap2_dm_timer_enable;
 			pdata->omap_dm_clk_disable = omap2_dm_timer_disable;
 			pdata->omap_dm_set_source_clk = omap2_dm_timer_set_clk;
@@ -397,7 +408,12 @@ fail:
 				break;
 			pdata = kzalloc(sizeof(struct omap_dm_timer_plat_info),
 					GFP_KERNEL);
-
+			if (!pdata) {
+				pr_err("%s: \
+				No memory for omap_dm_timer_plat_info\n",
+				__func__);
+				return -ENOMEM;
+			}
 			pdata->omap_dm_clk_enable = omap2_dm_timer_enable;
 			pdata->omap_dm_clk_disable = omap2_dm_timer_disable;
 			pdata->omap_dm_set_source_clk = omap2_dm_timer_set_clk;

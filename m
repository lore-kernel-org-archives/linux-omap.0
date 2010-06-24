From: Nishanth Menon <nm@ti.com>
Subject: [PM-SR][PATCH 3/4] omap3: voltage: make required variables static
Date: Thu, 24 Jun 2010 16:29:25 -0500
Message-ID: <1277414966-31806-4-git-send-email-nm@ti.com>
References: <1277414966-31806-1-git-send-email-nm@ti.com>
 <1277414966-31806-2-git-send-email-nm@ti.com>
 <1277414966-31806-3-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49140 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755697Ab0FXV3b (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Jun 2010 17:29:31 -0400
In-Reply-To: <1277414966-31806-3-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Thara Gopinath <thara@ti.com>

debugfs voltage_dir - used only by voltage layer and no reason for
others to add data to it, so make it static.  omap3_vp_offs,
volt_mod have no business being exposed as global. make them static

This fixes sparse warnings:
arch/arm/mach-omap2/voltage.c:42:15: warning: symbol 'voltage_dir' was not declared. Should it be static?
arch/arm/mach-omap2/voltage.c:49:5: warning: symbol 'volt_mod' was not declared. Should it be static?
arch/arm/mach-omap2/voltage.c:130:27: warning: symbol 'omap3_vp_offs' was not declared. Should it be static?

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Thara Gopinath <thara@ti.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/voltage.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index d289691..6927d6a 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -39,14 +39,14 @@
 #define VP_TRANXDONE_TIMEOUT	300
 
 #ifdef CONFIG_PM_DEBUG
-struct dentry *voltage_dir;
+static struct dentry *voltage_dir;
 #endif
 
 /* VP SR debug support */
 u32 enable_sr_vp_debug;
 
 /* PRM voltage module */
-u32 volt_mod;
+static u32 volt_mod;
 
 /* Voltage processor register offsets */
 struct vp_reg_offs {
@@ -127,7 +127,7 @@ static struct omap_vdd_info *vdd_info;
 static int no_scalable_vdd;
 
 /* OMAP3 VP register offsets and other definitions */
-struct __init vp_reg_offs omap3_vp_offs[] = {
+static struct __init vp_reg_offs omap3_vp_offs[] = {
 	/* VP1 */
 	{
 		.vpconfig_reg = OMAP3_PRM_VP1_CONFIG_OFFSET,
-- 
1.6.3.3


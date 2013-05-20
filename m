From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH-V2] ARM: OMAP2+: AM33xx: Fix missing reset status data to GFX hwmod
Date: Mon, 20 May 2013 19:08:36 +0530
Message-ID: <1369057116-31423-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51564 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756421Ab3ETNjK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 May 2013 09:39:10 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>

GFX has a reset status register (PRM_GFX.RM_GFX_RSTST),
so update the GFX hwmod data with .rstst_off and .st_shift
information.

Although it doesn't have impact on kernel boot, but this is
regression fix from original hwmod commit.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
---
Changes from V1 (No code change):
	- Updated commit description to mention its regression
	  from original commit.

 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index d1cf3ab..38c7b04 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -329,7 +329,7 @@ static struct omap_hwmod_class am33xx_gfx_hwmod_class = {
 };

 static struct omap_hwmod_rst_info am33xx_gfx_resets[] = {
-	{ .name = "gfx", .rst_shift = 0 },
+	{ .name = "gfx", .rst_shift = 0, .st_shift = 0},
 };

 static struct omap_hwmod_irq_info am33xx_gfx_irqs[] = {
@@ -347,6 +347,7 @@ static struct omap_hwmod am33xx_gfx_hwmod = {
 		.omap4	= {
 			.clkctrl_offs	= AM33XX_CM_GFX_GFX_CLKCTRL_OFFSET,
 			.rstctrl_offs	= AM33XX_RM_GFX_RSTCTRL_OFFSET,
+			.rstst_offs	= AM33XX_RM_GFX_RSTST_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
--
1.7.0.4


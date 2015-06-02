From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 1/2] ARM: DRA7: hwmod: fix gpmc hwmod
Date: Tue, 2 Jun 2015 13:02:52 +0300
Message-ID: <1433239373-14653-2-git-send-email-rogerq@ti.com>
References: <1433239373-14653-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55278 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbbFBKDO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Jun 2015 06:03:14 -0400
In-Reply-To: <1433239373-14653-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, tony@atomide.com
Cc: nm@ti.com, j-keerthy@ti.com, t-kristo@ti.com, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>

GPMC smart idle is not really broken but it does not support
smart idle with wakeup.

Fixes: 556708fe8718 ("ARM: OMAP: DRA7: hwmod: Make gpmc software supervised as the smart idle is broken")

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index 0e64c2f..8c2fad5 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -819,8 +819,7 @@ static struct omap_hwmod dra7xx_gpmc_hwmod = {
 	.name		= "gpmc",
 	.class		= &dra7xx_gpmc_hwmod_class,
 	.clkdm_name	= "l3main1_clkdm",
-	.flags		= (HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET |
-			   HWMOD_SWSUP_SIDLE),
+	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
 	.main_clk	= "l3_iclk_div",
 	.prcm = {
 		.omap4 = {
@@ -1421,8 +1420,7 @@ static struct omap_hwmod_class_sysconfig dra7xx_ocp2scp_sysc = {
 	.syss_offs	= 0x0014,
 	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_SIDLEMODE |
 			   SYSC_HAS_SOFTRESET | SYSS_HAS_RESET_STATUS),
-	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
-			   SIDLE_SMART_WKUP),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
 
-- 
2.1.4


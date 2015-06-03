From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 1/1] ARM: DRA7: hwmod: fix gpmc hwmod
Date: Wed, 3 Jun 2015 15:38:32 +0300
Message-ID: <556EF548.5040104@ti.com>
References: <1433239373-14653-1-git-send-email-rogerq@ti.com> <1433239373-14653-2-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55867 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932997AbbFCMiu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 3 Jun 2015 08:38:50 -0400
In-Reply-To: <1433239373-14653-2-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, tony@atomide.com
Cc: nm@ti.com, j-keerthy@ti.com, t-kristo@ti.com, linux-omap@vger.kernel.org, rogerq@ti.com

GPMC smart idle is not really broken but it does not support
smart idle with wakeup.

Fixes: 556708fe8718 ("ARM: OMAP: DRA7: hwmod: Make gpmc software supervised as the smart idle is broken")

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
v2 - Rebased on top of for-v4.2/omap-hwmod-a
Patch 2/2 is no longer needed

  arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 5 ++---
  1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index a0411f3..152526a 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -820,7 +820,7 @@ static struct omap_hwmod dra7xx_gpmc_hwmod = {
  	.class		= &dra7xx_gpmc_hwmod_class,
  	.clkdm_name	= "l3main1_clkdm",
  	/* Skip reset for CONFIG_OMAP_GPMC_DEBUG for bootloader timings */
-	.flags		= HWMOD_SWSUP_SIDLE | DEBUG_OMAP_GPMC_HWMOD_FLAGS,
+	.flags		= DEBUG_OMAP_GPMC_HWMOD_FLAGS,
  	.main_clk	= "l3_iclk_div",
  	.prcm = {
  		.omap4 = {
@@ -1421,8 +1421,7 @@ static struct omap_hwmod_class_sysconfig dra7xx_ocp2scp_sysc = {
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


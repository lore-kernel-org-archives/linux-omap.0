From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 2/2] ARM: DRA7: hwmod: Fix GPMC from preventing core suspend
Date: Tue, 2 Jun 2015 13:02:53 +0300
Message-ID: <1433239373-14653-3-git-send-email-rogerq@ti.com>
References: <1433239373-14653-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55281 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755639AbbFBKDP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Jun 2015 06:03:15 -0400
In-Reply-To: <1433239373-14653-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, tony@atomide.com
Cc: nm@ti.com, j-keerthy@ti.com, t-kristo@ti.com, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>

GPMC hwmod is flagged as HWMOD_INIT_NO_IDLE so it is kept
enabled at boot. If the GPMC driver is not loaded then
GPMC will not be idled thus preventing CORE from going idle
during suspend.

Disable HWMOD_INIT_NO_IDLE and HWMOD_INIT_NO_RESET.

The only reason HWMOD_INIT_NO_RESET was there was to retain
GPMC timings/settings configured by bootloader. We no longer
need that as we're configuring the timins in the kernel.

There is no reasoning as to why HWMOD_INIT_NO_IDLE was there.
Seems to have beein blindly copied from omap3/4 hwmod code.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index 8c2fad5..52c6565 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -819,7 +819,6 @@ static struct omap_hwmod dra7xx_gpmc_hwmod = {
 	.name		= "gpmc",
 	.class		= &dra7xx_gpmc_hwmod_class,
 	.clkdm_name	= "l3main1_clkdm",
-	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
 	.main_clk	= "l3_iclk_div",
 	.prcm = {
 		.omap4 = {
-- 
2.1.4


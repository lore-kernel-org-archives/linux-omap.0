From: "kishore kadiyala" <kishore.kadiyala@ti.com>
Subject: [PATCH 02/10] [PM-WIP-MMC] OMAP3 HWMOD: Updating MMC controller
     data
Date: Sat, 21 Aug 2010 01:40:31 +0530 (IST)
Message-ID: <16081.10.24.255.18.1282335031.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34485 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016Ab0HTUKe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Aug 2010 16:10:34 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, tony@atomide.com, b-cousson@ti.com

Updating OMAP3 hwmod data file with correct register offsets for
MMC controllers.

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 6536afe..6412cc4 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -527,8 +527,9 @@ static struct omap_hwmod omap3xxx_uart4_hwmod = {
 /* MMC/SD/SDIO common */

 static struct omap_hwmod_class_sysconfig mmc_sysc = {
-	.rev_offs	= 0x10,
-	.sysc_offs	= 0x14,
+	.rev_offs	= 0x1FC,
+	.sysc_offs	= 0x10,
+	.syss_offs	= 0x14,
 	.sysc_flags	= (SYSC_HAS_CLOCKACTIVITY | SYSC_HAS_SIDLEMODE |
 			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
 			   SYSC_HAS_AUTOIDLE),
-- 
1.7.0.4



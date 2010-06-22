From: Charulatha V <charu@ti.com>
Subject: [PATCH] OMAP3: HWMOD: Fix compilation error due to sr hwmod usage
Date: Tue, 22 Jun 2010 20:30:23 +0530
Message-ID: <1277218823-15133-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40832 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756022Ab0FVO76 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jun 2010 10:59:58 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, Charulatha V <charu@ti.com>

On 'origin/pm-wip/hwmods-omap4' branch, fix the following
compilation error:

arch/arm/mach-omap2/omap_hwmod_3xxx_data.c:218:
	error: 'omap34xx_sr1_hwmod' undeclared here (not in a function)
arch/arm/mach-omap2/omap_hwmod_3xxx_data.c:219:
	error: 'omap34xx_sr2_hwmod' undeclared here (not in a function)
arch/arm/mach-omap2/omap_hwmod_3xxx_data.c:220: error:
	'omap36xx_sr1_hwmod' undeclared here (not in a function)
arch/arm/mach-omap2/omap_hwmod_3xxx_data.c:221:
	error: 'omap36xx_sr2_hwmod' undeclared here (not in a function)
make[1]: *** [arch/arm/mach-omap2/omap_hwmod_3xxx_data.o] Error 1

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index f7e1ace..fe92b5d 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -215,10 +215,6 @@ static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_l4_wkup_hwmod,
 	&omap3xxx_mpu_hwmod,
 	&omap3xxx_iva2_hwmod,
-	&omap34xx_sr1_hwmod,
-	&omap34xx_sr2_hwmod,
-	&omap36xx_sr1_hwmod,
-	&omap36xx_sr2_hwmod,
 	NULL,
 };
 
-- 
1.6.3.3


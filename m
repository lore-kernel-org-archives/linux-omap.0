From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 02/19] omap3630: hwmod: sr: enable for higher ES
Date: Sat, 19 Feb 2011 17:31:41 +0530
Message-ID: <1298116918-30744-3-git-send-email-nm@ti.com>
References: <1298116918-30744-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:44479 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751556Ab1BSMCZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 19 Feb 2011 07:02:25 -0500
Received: by gyh3 with SMTP id 3so609500gyh.37
        for <linux-omap@vger.kernel.org>; Sat, 19 Feb 2011 04:02:23 -0800 (PST)
In-Reply-To: <1298116918-30744-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Nishanth Menon <nm@ti.com>

Enable hwmod entries for OMAP3630 for higher ES revisions as
well. This is to ensure that SR can be used in all revisions of
OMAP3630 as of this posting.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index ea1f49a..bbcbea6 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1318,7 +1318,9 @@ static struct omap_hwmod omap36xx_sr1_hwmod = {
 	},
 	.slaves		= omap3_sr1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3_sr1_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3630ES1),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3630ES1	|
+					CHIP_IS_OMAP3630ES1_1	|
+					CHIP_IS_OMAP3630ES1_2),
 	.mpu_irqs	= omap3_smartreflex_mpu_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap3_smartreflex_mpu_irqs),
 };
@@ -1368,7 +1370,9 @@ static struct omap_hwmod omap36xx_sr2_hwmod = {
 	},
 	.slaves		= omap3_sr2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3_sr2_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3630ES1),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3630ES1	|
+					CHIP_IS_OMAP3630ES1_1	|
+					CHIP_IS_OMAP3630ES1_2),
 	.mpu_irqs	= omap3_smartreflex_core_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap3_smartreflex_core_irqs),
 };
-- 
1.7.1


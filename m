From: Sanjeev Premi <premi@ti.com>
Subject: [RFC] AM35x: Workaround to use generic OMAP3 hwmods
Date: Fri, 25 Feb 2011 19:18:09 +0530
Message-ID: <1298641689-7417-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53526 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754695Ab1BYNsQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Feb 2011 08:48:16 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1PDmDMS020207
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 25 Feb 2011 07:48:15 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

This patch implements workaround to reuse the hwmods
defined for OMAP3. Else, the master-slave dependency
cascades into duplicating all of the hwmods.

Without this workaround, the AM3517 EVM fails to boot
due to kernel panic while initializing the SR hwmods.

Until real solution is implemented, this workaround
can be considered.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   66 +++++++++++++++++++++++++++-
 1 files changed, 65 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 800eda4..c8854eb 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1670,7 +1670,71 @@ static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	NULL,
 };
 
+/**
+ * HWMODs specific to AM35x processors
+ * Though they are quite similar to OMAP34xx definitions,
+ * having separate array makes customization easy.
+ */
+static __initdata struct omap_hwmod *am35xx_hwmods[] = {
+	&omap3xxx_l3_main_hwmod,
+	&omap3xxx_l4_core_hwmod,
+	&omap3xxx_l4_per_hwmod,
+	&omap3xxx_l4_wkup_hwmod,
+	&omap3xxx_mpu_hwmod,
+	&omap3xxx_wd_timer2_hwmod,
+	&omap3xxx_uart1_hwmod,
+	&omap3xxx_uart2_hwmod,
+	&omap3xxx_uart3_hwmod,
+	&omap3xxx_uart4_hwmod,
+	&omap3xxx_i2c1_hwmod,
+	&omap3xxx_i2c2_hwmod,
+	&omap3xxx_i2c3_hwmod,
+
+	/* gpio class */
+	&omap3xxx_gpio1_hwmod,
+	&omap3xxx_gpio2_hwmod,
+	&omap3xxx_gpio3_hwmod,
+	&omap3xxx_gpio4_hwmod,
+	&omap3xxx_gpio5_hwmod,
+	&omap3xxx_gpio6_hwmod,
+
+	/* dma_system class*/
+	&omap3xxx_dma_system_hwmod,
+
+	/* mcspi class */
+	&omap34xx_mcspi1,
+	&omap34xx_mcspi2,
+	&omap34xx_mcspi3,
+	&omap34xx_mcspi4,
+	NULL,
+};
+
 int __init omap3xxx_hwmod_init(void)
 {
-	return omap_hwmod_init(omap3xxx_hwmods);
+	if (cpu_is_omap3505() || cpu_is_omap3517()) {
+
+		/* TODO: Find better way to get this done.
+		 *
+		 * AM35xx doesn't support smartreflex. This requires:
+		 * 1) Removing related hwmods from the initialization list.
+		 *    (done).
+		 * 2) Removing omap3_l4_core__sr1 and omap3_l4_core__sr2
+		 *    from omap3xxx_l4_core_slaves.
+		 *    This, however, has cascading effect on all hwmods,
+		 *    due to master-slave relations between these hwmods.
+		 *
+		 * Instead of duplicating contents of this file, updating
+		 * the structure to restrict slave count to 1; and setting
+		 * address of omap3_l4_core__sr1 & omap3_l4_core__sr2 to
+		 * NULL should be a reasonable workaround.
+		 */
+		omap3xxx_l4_core_slaves[1] = NULL;
+		omap3xxx_l4_core_slaves[2] = NULL;
+
+		omap3xxx_l4_core_hwmod.slaves_cnt = 1;
+
+		return omap_hwmod_init(am35xx_hwmods);
+	} else {
+		return omap_hwmod_init(omap3xxx_hwmods);
+	}
 }
-- 
1.7.2.2


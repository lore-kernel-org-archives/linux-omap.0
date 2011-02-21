From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 1/6] omap3: hwmod_data: Add l3 error log data to hwmod database.
Date: Mon, 21 Feb 2011 19:16:25 +0530
Message-ID: <1298295990-1070-2-git-send-email-santosh.shilimkar@ti.com>
References: <1298295990-1070-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37906 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756035Ab1BUNqg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Feb 2011 08:46:36 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1LDkXxJ017270
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 21 Feb 2011 07:46:35 -0600
In-Reply-To: <1298295990-1070-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: balbi@ti.com, b-cousson@ti.com, r.sricharan@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: sricharan <r.sricharan@ti.com>

Add the error log registers, irqs of the l3 interconnect to the
hwmod data. The hwmod changes are aligned with Benoit Cousson.

Signed-off-by: sricharan <r.sricharan@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Tested-by: sricharan <r.sricharan@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   22 ++++++++++++++++++++--
 arch/arm/plat-omap/include/plat/irqs.h     |    2 ++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 8d81813..9a8f799 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -72,10 +72,26 @@ static struct omap_hwmod_ocp_if omap3xxx_l3_main__l4_per = {
 	.user	= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* L3 taret configuration and error log registers */
+static struct omap_hwmod_irq_info omap3xxx_l3_targ_irqs[] = {
+	{ .irq = INT_34XX_L3_DBG_IRQ },
+	{ .irq = INT_34XX_L3_APP_IRQ },
+};
+
+static struct omap_hwmod_addr_space omap3xxx_l3_targ_addrs[] = {
+	{
+		.pa_start       = 0x68000000,
+		.pa_end         = 0x68100000,
+		.flags          = ADDR_TYPE_RT,
+	},
+};
+
 /* MPU -> L3 interface */
 static struct omap_hwmod_ocp_if omap3xxx_mpu__l3_main = {
-	.master = &omap3xxx_mpu_hwmod,
-	.slave	= &omap3xxx_l3_main_hwmod,
+	.master   = &omap3xxx_mpu_hwmod,
+	.slave    = &omap3xxx_l3_main_hwmod,
+	.addr     = omap3xxx_l3_targ_addrs,
+	.addr_cnt = ARRAY_SIZE(omap3xxx_l3_targ_addrs),
 	.user	= OCP_USER_MPU,
 };
 
@@ -94,6 +110,8 @@ static struct omap_hwmod_ocp_if *omap3xxx_l3_main_masters[] = {
 static struct omap_hwmod omap3xxx_l3_main_hwmod = {
 	.name		= "l3_main",
 	.class		= &l3_hwmod_class,
+	.mpu_irqs       = omap3xxx_l3_targ_irqs,
+	.mpu_irqs_cnt   = ARRAY_SIZE(omap3xxx_l3_targ_irqs),
 	.masters	= omap3xxx_l3_main_masters,
 	.masters_cnt	= ARRAY_SIZE(omap3xxx_l3_main_masters),
 	.slaves		= omap3xxx_l3_main_slaves,
diff --git a/arch/arm/plat-omap/include/plat/irqs.h b/arch/arm/plat-omap/include/plat/irqs.h
index 2910de9..e614de1 100644
--- a/arch/arm/plat-omap/include/plat/irqs.h
+++ b/arch/arm/plat-omap/include/plat/irqs.h
@@ -315,6 +315,8 @@
 #define INT_34XX_SSM_ABORT_IRQ	6
 #define INT_34XX_SYS_NIRQ	7
 #define INT_34XX_D2D_FW_IRQ	8
+#define INT_34XX_L3_DBG_IRQ     9
+#define INT_34XX_L3_APP_IRQ     10
 #define INT_34XX_PRCM_MPU_IRQ	11
 #define INT_34XX_MCBSP1_IRQ	16
 #define INT_34XX_MCBSP2_IRQ	17
-- 
1.7.0.4


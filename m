From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 4/6] omap4: hwmod_data: Add l3 errorlog data to hwmod database.
Date: Mon, 21 Feb 2011 19:16:28 +0530
Message-ID: <1298295990-1070-5-git-send-email-santosh.shilimkar@ti.com>
References: <1298295990-1070-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42582 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756036Ab1BUNqg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Feb 2011 08:46:36 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1LDkXj1012011
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 21 Feb 2011 07:46:35 -0600
In-Reply-To: <1298295990-1070-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: balbi@ti.com, b-cousson@ti.com, r.sricharan@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: sricharan <r.sricharan@ti.com>

Add the error log registers, irqs of the l3 interconnect to the
hwmod data. The hwmod change is aligned with Benoit Cousson.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: sricharan <r.sricharan@ti.com>
Tested-by: sricharan <r.sricharan@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index c2806bd..95001d4 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -229,11 +229,37 @@ static struct omap_hwmod_ocp_if omap44xx_l4_cfg__l3_main_1 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* L3 target configuration and error log registers */
+static struct omap_hwmod_irq_info omap44xx_l3_targ_irqs[] = {
+	{ .irq = 9  + OMAP44XX_IRQ_GIC_START },
+	{ .irq = 10 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_l3_targ_addrs[] = {
+	{
+		.pa_start	= 0x44000000,
+		.pa_end		= 0x44100000,
+		.flags		= ADDR_TYPE_RT,
+	},
+	{
+		.pa_start	= 0x44800000,
+		.pa_end		= 0x44900000,
+		.flags		= ADDR_TYPE_RT,
+	},
+	{
+		.pa_start	= 0x45000000,
+		.pa_end		= 0x45100000,
+		.flags		= ADDR_TYPE_RT,
+	},
+};
+
 /* mpu -> l3_main_1 */
 static struct omap_hwmod_ocp_if omap44xx_mpu__l3_main_1 = {
 	.master		= &omap44xx_mpu_hwmod,
 	.slave		= &omap44xx_l3_main_1_hwmod,
 	.clk		= "l3_div_ck",
+	.addr		= omap44xx_l3_targ_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_l3_targ_addrs),
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -248,6 +274,8 @@ static struct omap_hwmod_ocp_if *omap44xx_l3_main_1_slaves[] = {
 static struct omap_hwmod omap44xx_l3_main_1_hwmod = {
 	.name		= "l3_main_1",
 	.class		= &omap44xx_l3_hwmod_class,
+	.mpu_irqs	= omap44xx_l3_targ_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_l3_targ_irqs),
 	.slaves		= omap44xx_l3_main_1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_l3_main_1_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
-- 
1.7.0.4


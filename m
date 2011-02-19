From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 01/19] omap3: hwmod: add smartreflex irqs
Date: Sat, 19 Feb 2011 17:31:40 +0530
Message-ID: <1298116918-30744-2-git-send-email-nm@ti.com>
References: <1298116918-30744-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:41114 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750788Ab1BSMCQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 19 Feb 2011 07:02:16 -0500
Received: by gye5 with SMTP id 5so2303433gye.18
        for <linux-omap@vger.kernel.org>; Sat, 19 Feb 2011 04:02:15 -0800 (PST)
In-Reply-To: <1298116918-30744-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Nishanth Menon <nm@ti.com>

OMAP3 smartreflex irqs in hwmod structures with the same naming as
present in OMAP4. Without these IRQs being registered, SmartReflex
driver will be unable to get the irq numbers to handle notifications

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 8d81813..ea1f49a 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -265,6 +265,15 @@ static struct omap_hwmod_ocp_if omap3_l4_core__i2c3 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+
+static struct omap_hwmod_irq_info omap3_smartreflex_mpu_irqs[] = {
+	{.name = "sr1_irq", .irq = 18},
+};
+
+static struct omap_hwmod_irq_info omap3_smartreflex_core_irqs[] = {
+	{.name = "sr2_irq", .irq = 19},
+};
+
 /* L4 CORE -> SR1 interface */
 static struct omap_hwmod_addr_space omap3_sr1_addr_space[] = {
 	{
@@ -1289,6 +1298,8 @@ static struct omap_hwmod omap34xx_sr1_hwmod = {
 					CHIP_IS_OMAP3430ES3_0 |
 					CHIP_IS_OMAP3430ES3_1),
 	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
+	.mpu_irqs	= omap3_smartreflex_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap3_smartreflex_mpu_irqs),
 };
 
 static struct omap_hwmod omap36xx_sr1_hwmod = {
@@ -1308,6 +1319,8 @@ static struct omap_hwmod omap36xx_sr1_hwmod = {
 	.slaves		= omap3_sr1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3_sr1_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3630ES1),
+	.mpu_irqs	= omap3_smartreflex_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap3_smartreflex_mpu_irqs),
 };
 
 /* SR2 */
@@ -1335,6 +1348,8 @@ static struct omap_hwmod omap34xx_sr2_hwmod = {
 					CHIP_IS_OMAP3430ES3_0 |
 					CHIP_IS_OMAP3430ES3_1),
 	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
+	.mpu_irqs	= omap3_smartreflex_core_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap3_smartreflex_core_irqs),
 };
 
 static struct omap_hwmod omap36xx_sr2_hwmod = {
@@ -1354,6 +1369,8 @@ static struct omap_hwmod omap36xx_sr2_hwmod = {
 	.slaves		= omap3_sr2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3_sr2_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3630ES1),
+	.mpu_irqs	= omap3_smartreflex_core_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap3_smartreflex_core_irqs),
 };
 
 static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
-- 
1.7.1


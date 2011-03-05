From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V3 01/19] OMAP3: hwmod: add SmartReflex IRQs
Date: Sat,  5 Mar 2011 20:59:04 +0530
Message-ID: <1299338962-5602-2-git-send-email-nm@ti.com>
References: <1299338962-5602-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:41202 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751962Ab1CEP3p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 5 Mar 2011 10:29:45 -0500
Received: by gyd10 with SMTP id 10so1318552gyd.12
        for <linux-omap@vger.kernel.org>; Sat, 05 Mar 2011 07:29:44 -0800 (PST)
In-Reply-To: <1299338962-5602-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, Kevin Hilman <khilman@ti.com>, Tony <tony@atomide.com>, Paul <paul@pwsan.com>, Nishanth Menon <nm@ti.com>

OMAP3 SmartReflex IRQs in hwmod structures with the same naming as
present in OMAP4. Without these IRQs being registered, SmartReflex
driver will be unable to get the IRQ numbers to handle notifications

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 196a834..2d464bc 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -378,6 +378,15 @@ static struct omap_hwmod_ocp_if omap3_l4_core__i2c3 = {
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
@@ -2925,6 +2934,8 @@ static struct omap_hwmod omap34xx_sr1_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES2 |
 					CHIP_IS_OMAP3430ES3_0 |
 					CHIP_IS_OMAP3430ES3_1),
+	.mpu_irqs	= omap3_smartreflex_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap3_smartreflex_mpu_irqs),
 	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
@@ -2945,6 +2956,8 @@ static struct omap_hwmod omap36xx_sr1_hwmod = {
 	.slaves		= omap3_sr1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3_sr1_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3630ES1),
+	.mpu_irqs	= omap3_smartreflex_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap3_smartreflex_mpu_irqs),
 };
 
 /* SR2 */
@@ -2971,6 +2984,8 @@ static struct omap_hwmod omap34xx_sr2_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES2 |
 					CHIP_IS_OMAP3430ES3_0 |
 					CHIP_IS_OMAP3430ES3_1),
+	.mpu_irqs	= omap3_smartreflex_core_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap3_smartreflex_core_irqs),
 	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
@@ -2991,6 +3006,8 @@ static struct omap_hwmod omap36xx_sr2_hwmod = {
 	.slaves		= omap3_sr2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3_sr2_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3630ES1),
+	.mpu_irqs	= omap3_smartreflex_core_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap3_smartreflex_core_irqs),
 };
 
 /*
-- 
1.7.1


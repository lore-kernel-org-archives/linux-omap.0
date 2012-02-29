From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 07/13] ARM: OMAP3+: hwmod: add SmartReflex IRQs
Date: Wed, 29 Feb 2012 23:33:43 +0100
Message-ID: <1330554829-11347-8-git-send-email-j-pihet@ti.com>
References: <1330554829-11347-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48113 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964876Ab2B2We1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Feb 2012 17:34:27 -0500
Received: by mail-ww0-f44.google.com with SMTP id dr13so4173817wgb.1
        for <linux-omap@vger.kernel.org>; Wed, 29 Feb 2012 14:34:27 -0800 (PST)
In-Reply-To: <1330554829-11347-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>
Cc: balbi@ti.com, nm@ti.com, Jean Pihet <j-pihet@ti.com>

From: Nishanth Menon <nm@ti.com>

Add OMAP3 SmartReflex IRQs in hwmod structures. Without these IRQs
being registered the SmartReflex driver will be unable to get the
IRQ numbers to handle notifications.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 8688960..34b9766d 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -377,6 +377,16 @@ static struct omap_hwmod_ocp_if omap3_l4_core__i2c3 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+static struct omap_hwmod_irq_info omap3_smartreflex_mpu_irqs[] = {
+	{ .irq = 18},
+	{ .irq = -1 }
+};
+
+static struct omap_hwmod_irq_info omap3_smartreflex_core_irqs[] = {
+	{ .irq = 19},
+	{ .irq = -1 }
+};
+
 /* L4 CORE -> SR1 interface */
 static struct omap_hwmod_addr_space omap3_sr1_addr_space[] = {
 	{
@@ -2689,6 +2699,7 @@ static struct omap_hwmod omap34xx_sr1_hwmod = {
 	.slaves		= omap3_sr1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3_sr1_slaves),
 	.dev_attr	= &sr1_dev_attr,
+	.mpu_irqs	= omap3_smartreflex_mpu_irqs,
 	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
@@ -2708,6 +2719,7 @@ static struct omap_hwmod omap36xx_sr1_hwmod = {
 	.slaves		= omap3_sr1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3_sr1_slaves),
 	.dev_attr	= &sr1_dev_attr,
+	.mpu_irqs	= omap3_smartreflex_mpu_irqs,
 };
 
 /* SR2 */
@@ -2735,6 +2747,7 @@ static struct omap_hwmod omap34xx_sr2_hwmod = {
 	.slaves		= omap3_sr2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3_sr2_slaves),
 	.dev_attr	= &sr2_dev_attr,
+	.mpu_irqs	= omap3_smartreflex_core_irqs,
 	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
@@ -2754,6 +2767,7 @@ static struct omap_hwmod omap36xx_sr2_hwmod = {
 	.slaves		= omap3_sr2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3_sr2_slaves),
 	.dev_attr	= &sr2_dev_attr,
+	.mpu_irqs	= omap3_smartreflex_core_irqs,
 };
 
 /*
-- 
1.7.5.4


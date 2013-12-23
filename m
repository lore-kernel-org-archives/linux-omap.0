From: Suman Anna <s-anna@ti.com>
Subject: [PATCH] ARM: OMAP2+: hwmod_data: fix missing OMAP_INTC_START in irq data
Date: Mon, 23 Dec 2013 16:53:11 -0600
Message-ID: <1387839191-57886-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36779 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932309Ab3LWWxP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Dec 2013 17:53:15 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>
Cc: Afzal Mohammed <afzal@ti.com>, linux-omap@vger.kernel.org, Suman Anna <s-anna@ti.com>

Commit 7d7e1eb (ARM: OMAP2+: Prepare for irqs.h removal) and commit
ec2c082 (ARM: OMAP2+: Remove hardcoded IRQs and enable SPARSE_IRQ)
updated the way interrupts for OMAP2/3 devices are defined in the
HWMOD data structures to being an index plus a fixed offset (defined
by OMAP_INTC_START).

Couple of irqs in the OMAP2/3 hwmod data were misconfigured completely
as they were missing this OMAP_INTC_START relative offset. Add this
offset back to fix the incorrect irq data for the following modules:
	OMAP2 - GPMC, RNG
	OMAP3 - GPMC, ISP MMU & IVA MMU

Signed-off-by: Suman Anna <s-anna@ti.com>
---
This patch is applicable to only current 3.13 and past kernels (from
3.7 onwards), it is not needed for 3.14 as this IRQ data has already
been cleaned up in Tony's omap-for-v3.14/omap3-board-removal branch.

 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c | 4 ++--
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
index 56cebb0..d23c77f 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
@@ -796,7 +796,7 @@ struct omap_hwmod omap2xxx_counter_32k_hwmod = {
 
 /* gpmc */
 static struct omap_hwmod_irq_info omap2xxx_gpmc_irqs[] = {
-	{ .irq = 20 },
+	{ .irq = 20 + OMAP_INTC_START, },
 	{ .irq = -1 }
 };
 
@@ -841,7 +841,7 @@ static struct omap_hwmod_class omap2_rng_hwmod_class = {
 };
 
 static struct omap_hwmod_irq_info omap2_rng_mpu_irqs[] = {
-	{ .irq = 52 },
+	{ .irq = 52 + OMAP_INTC_START, },
 	{ .irq = -1 }
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 1d49a61..b1bf86e 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -2165,7 +2165,7 @@ static struct omap_hwmod_class omap3xxx_gpmc_hwmod_class = {
 };
 
 static struct omap_hwmod_irq_info omap3xxx_gpmc_irqs[] = {
-	{ .irq = 20 },
+	{ .irq = 20 + OMAP_INTC_START, },
 	{ .irq = -1 }
 };
 
@@ -2999,7 +2999,7 @@ static struct omap_mmu_dev_attr mmu_isp_dev_attr = {
 
 static struct omap_hwmod omap3xxx_mmu_isp_hwmod;
 static struct omap_hwmod_irq_info omap3xxx_mmu_isp_irqs[] = {
-	{ .irq = 24 },
+	{ .irq = 24 + OMAP_INTC_START, },
 	{ .irq = -1 }
 };
 
@@ -3041,7 +3041,7 @@ static struct omap_mmu_dev_attr mmu_iva_dev_attr = {
 
 static struct omap_hwmod omap3xxx_mmu_iva_hwmod;
 static struct omap_hwmod_irq_info omap3xxx_mmu_iva_irqs[] = {
-	{ .irq = 28 },
+	{ .irq = 28 + OMAP_INTC_START, },
 	{ .irq = -1 }
 };
 
-- 
1.8.4.3


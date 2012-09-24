From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH] ARM: OMAP2+: Fix PMU interrupt definitions
Date: Mon, 24 Sep 2012 16:32:41 -0500
Message-ID: <1348522362-912-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49206 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265Ab2IXVcu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Sep 2012 17:32:50 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
Cc: Jon Hunter <jon-hunter@ti.com>

Commit 7d7e1eb (ARM: OMAP2+: Prepare for irqs.h removal) and commit ec2c082
(ARM: OMAP2+: Remove hardcoded IRQs and enable SPARSE_IRQ) updated the way
interrupts for OMAP2/3 devices are defined in the HWMOD data structures to
being an index plus a fixed offset (defined by OMAP_INTC_START). The definition
of the PMU interrupts on OMAP2/3 devices is missing the OMAP_INTC_START offset
and so this is causing the allocation of PMU interrupts to fail on OMAP2/3
devices. So add the offset to fix this.

This is patch is based upon the Tony's master branch for OMAP.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |    2 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
index 35dcdb6..bd9220e 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
@@ -219,7 +219,7 @@ struct omap_hwmod omap2xxx_l4_wkup_hwmod = {
 
 /* MPU */
 static struct omap_hwmod_irq_info omap2xxx_mpu_irqs[] = {
-	{ .name = "pmu", .irq = 3 },
+	{ .name = "pmu", .irq = 3 + OMAP_INTC_START },
 	{ .irq = -1 }
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 2857772..b4028fa 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -94,7 +94,7 @@ static struct omap_hwmod omap3xxx_l4_sec_hwmod = {
 
 /* MPU */
 static struct omap_hwmod_irq_info omap3xxx_mpu_irqs[] = {
-	{ .name = "pmu", .irq = 3 },
+	{ .name = "pmu", .irq = 3 + OMAP_INTC_START },
 	{ .irq = -1 }
 };
 
-- 
1.7.9.5


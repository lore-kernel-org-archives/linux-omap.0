From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 5/9] ARM: OMAP4+: Remove un-necessary cacheflush in secondary CPU boot path
Date: Wed, 20 Feb 2013 20:48:43 +0530
Message-ID: <1361373527-21695-6-git-send-email-santosh.shilimkar@ti.com>
References: <1361373527-21695-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46972 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935440Ab3BTPSD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Feb 2013 10:18:03 -0500
In-Reply-To: <1361373527-21695-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

This was borrowed from ARM versatile code with pen_release mechanism but since
OMAP uses hardware register based synchronisation, pen_release stuff was
dropped. Unfortunately the cacheflush wasn't dropped along with it.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap-smp.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index cd42d92..81fd489 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -20,7 +20,6 @@
 #include <linux/smp.h>
 #include <linux/io.h>
 
-#include <asm/cacheflush.h>
 #include <asm/hardware/gic.h>
 #include <asm/smp_scu.h>
 
@@ -103,9 +102,6 @@ static int __cpuinit omap4_boot_secondary(unsigned int cpu, struct task_struct *
 	else
 		__raw_writel(0x20, base + OMAP_AUX_CORE_BOOT_0);
 
-	flush_cache_all();
-	smp_wmb();
-
 	if (!cpu1_clkdm)
 		cpu1_clkdm = clkdm_lookup("mpu1_clkdm");
 
-- 
1.7.9.5


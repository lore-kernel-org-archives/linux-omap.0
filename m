From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 2/4] OMAP4: Clean the secondary_data from L2
Date: Thu, 10 Dec 2009 00:13:51 +0530
Message-ID: <1260384233-2278-2-git-send-email-santosh.shilimkar@ti.com>
References: <1260384233-2278-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53925 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756925AbZLISoK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Dec 2009 13:44:10 -0500
In-Reply-To: <1260384233-2278-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, Santosh Shilimkar <santosh.shilimkar@ti.com>

The boot_secondary() needs to call outer_clean_range() because the
L2 cache is already enabled in the kernel boot with
early_initcall

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap-smp.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index 38153e5..2d0733a 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -73,6 +73,8 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * the AuxCoreBoot1 register is updated with cpu state
 	 * A barrier is added to ensure that write buffer is drained
 	 */
+	flush_cache_all();
+	outer_clean_range(__pa(&secondary_data), __pa(&secondary_data + 1));
 	omap_modify_auxcoreboot0(0x200, 0x0);
 	flush_cache_all();
 	smp_wmb();
-- 
1.6.0.4


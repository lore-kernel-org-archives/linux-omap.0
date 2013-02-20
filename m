From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 6/9] ARM: OMAP4+: Remove out of placed smp_wmb() in secondary wakeup code
Date: Wed, 20 Feb 2013 20:48:44 +0530
Message-ID: <1361373527-21695-7-git-send-email-santosh.shilimkar@ti.com>
References: <1361373527-21695-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53238 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934210Ab3BTPRt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Feb 2013 10:17:49 -0500
In-Reply-To: <1361373527-21695-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

The smp_wmb() here is out of placed and redundant. So remove it. It is
a left over of the pain_release cleanup mostly.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap-smp.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index 81fd489..7d29a74 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -186,8 +186,6 @@ static void __init wakeup_secondary(void)
 		__raw_writel(virt_to_phys(omap5_secondary_startup),
 						base + OMAP_AUX_CORE_BOOT_1);
 
-	smp_wmb();
-
 	/*
 	 * Send a 'sev' to wake the secondary core from WFE.
 	 * Drain the outstanding writes to memory
-- 
1.7.9.5


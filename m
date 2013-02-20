From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 4/9] ARM: OMAP4+: Remove the un-necessary cache flush from hotplug code
Date: Wed, 20 Feb 2013 20:48:42 +0530
Message-ID: <1361373527-21695-5-git-send-email-santosh.shilimkar@ti.com>
References: <1361373527-21695-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53239 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933491Ab3BTPRt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Feb 2013 10:17:49 -0500
In-Reply-To: <1361373527-21695-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

This was added with intial port where OMAP PM support wasn't existing
and only simple WFI based hooks were used.

This should have been cleaned up while adding the PM support but some
how fall through cracks.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap-hotplug.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-hotplug.c b/arch/arm/mach-omap2/omap-hotplug.c
index e712d17..458f72f 100644
--- a/arch/arm/mach-omap2/omap-hotplug.c
+++ b/arch/arm/mach-omap2/omap-hotplug.c
@@ -19,11 +19,8 @@
 #include <linux/smp.h>
 #include <linux/io.h>
 
-#include <asm/cacheflush.h>
 #include "omap-wakeupgen.h"
-
 #include "common.h"
-
 #include "powerdomain.h"
 
 /*
@@ -35,9 +32,6 @@ void __ref omap4_cpu_die(unsigned int cpu)
 	unsigned int boot_cpu = 0;
 	void __iomem *base = omap_get_wakeupgen_base();
 
-	flush_cache_all();
-	dsb();
-
 	/*
 	 * we're ready for shutdown now, so do it
 	 */
-- 
1.7.9.5


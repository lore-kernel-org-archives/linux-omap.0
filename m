From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 17/17] omap4: Remove un-used do_wfi() macro.
Date: Sat, 19 Feb 2011 16:12:38 +0530
Message-ID: <1298112158-28469-18-git-send-email-santosh.shilimkar@ti.com>
References: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50552 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754104Ab1BSKnA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 19 Feb 2011 05:43:00 -0500
In-Reply-To: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

With OMAP4 suspend, idle and hotplug series, we no longer need
do_wfi() macro.

Remove the same.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/include/mach/omap4-common.h |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/include/mach/omap4-common.h b/arch/arm/mach-omap2/include/mach/omap4-common.h
index 74c9aa7..ca20333 100644
--- a/arch/arm/mach-omap2/include/mach/omap4-common.h
+++ b/arch/arm/mach-omap2/include/mach/omap4-common.h
@@ -16,12 +16,6 @@
 #include <asm/proc-fns.h>
 
 #ifndef __ASSEMBLER__
-/*
- * wfi used in low power code. Directly opcode is used instead
- * of instruction to avoid mulit-omap build break
- */
-#define do_wfi()			\
-		__asm__ __volatile__ (".word	0xe320f003" : : : "memory")
 
 #ifdef CONFIG_CACHE_L2X0
 extern void __iomem *l2cache_base;
-- 
1.6.0.4


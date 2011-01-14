From: jean.pihet@newoldbits.com
Subject: [PATCH] OMAP: use fncpy to copy the PM code functions to SRAM
Date: Fri, 14 Jan 2011 16:21:10 +0100
Message-ID: <1295018470-18099-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63935 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752081Ab1ANPVY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Jan 2011 10:21:24 -0500
Received: by wwa36 with SMTP id 36so3092548wwa.1
        for <linux-omap@vger.kernel.org>; Fri, 14 Jan 2011 07:21:23 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

The new fncpy API is better suited for copying some
code to SRAM at runtime. This patch changes the ad-hoc
code to the more generic fncpy API.

Tested OK on OMAP3 in low power modes (RET/OFF)
with !CONFIG_THUMB2_KERNEL

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/plat-omap/sram.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index e26e504..e2982b0 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -23,7 +23,7 @@
 
 #include <asm/tlb.h>
 #include <asm/cacheflush.h>
-
+#include <asm/fncpy.h>
 #include <asm/mach/map.h>
 
 #include <plat/sram.h>
@@ -251,9 +251,8 @@ void * omap_sram_push(void * start, unsigned long size)
 
 	omap_sram_ceil -= size;
 	omap_sram_ceil = ROUND_DOWN(omap_sram_ceil, sizeof(void *));
-	memcpy((void *)omap_sram_ceil, start, size);
-	flush_icache_range((unsigned long)omap_sram_ceil,
-		(unsigned long)(omap_sram_ceil + size));
+
+	fncpy((void *)omap_sram_ceil, start, size);
 
 	return (void *)omap_sram_ceil;
 }
-- 
1.7.2.3


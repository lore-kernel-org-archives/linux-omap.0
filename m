From: R Sricharan <r.sricharan@ti.com>
Subject: [PATCH v2] ARM: OMAP2+: Fix omap2+ build error.
Date: Fri, 30 Mar 2012 14:27:43 +0530
Message-ID: <1333097863-7205-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33551 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760410Ab2C3I5w (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Mar 2012 04:57:52 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, tony@atomide.com, r.sricharan@ti.com

With CONFIG_OMAP4_ERRATA_I688 enabled, omap2+ build
was broken as below.

	arch/arm/kernel/io.c: In function '_memcpy_toio':
	arch/arm/kernel/io.c:29: error: implicit declaration of function 'outer_sync'
	make[1]: *** [arch/arm/kernel/io.o] Error 1

after the commit,

	commit 9f97da78bf018206fb623cd351d454af2f105fe0
	Author: David Howells <dhowells@redhat.com>
	Date:   Wed Mar 28 18:30:01 2012 +0100

	    Disintegrate asm/system.h for ARM
    
	    Disintegrate asm/system.h for ARM.

Fixing this here.

Signed-off-by: R Sricharan <r.sricharan@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/include/asm/barrier.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/barrier.h b/arch/arm/include/asm/barrier.h
index 44f4a09..0511238 100644
--- a/arch/arm/include/asm/barrier.h
+++ b/arch/arm/include/asm/barrier.h
@@ -2,6 +2,7 @@
 #define __ASM_BARRIER_H
 
 #ifndef __ASSEMBLY__
+#include <asm/outercache.h>
 
 #define nop() __asm__ __volatile__("mov\tr0,r0\t@ nop\n\t");
 
@@ -39,7 +40,6 @@
 #ifdef CONFIG_ARCH_HAS_BARRIERS
 #include <mach/barriers.h>
 #elif defined(CONFIG_ARM_DMA_MEM_BUFFERABLE) || defined(CONFIG_SMP)
-#include <asm/outercache.h>
 #define mb()		do { dsb(); outer_sync(); } while (0)
 #define rmb()		dsb()
 #define wmb()		mb()
-- 
1.7.1


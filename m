From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 1/2] ARM: mm: Add v7_flush_dcache_by_level() API.
Date: Thu, 12 Apr 2012 16:59:46 +0530
Message-ID: <1334230187-21553-2-git-send-email-santosh.shilimkar@ti.com>
References: <1334230187-21553-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49823 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761719Ab2DLLaN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Apr 2012 07:30:13 -0400
In-Reply-To: <1334230187-21553-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: catalin.marinas@arm.com, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, R Sricharan <r.sricharan@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King <rmk+kernel@arm.linux.org.uk>

From: R Sricharan <r.sricharan@ti.com>

On ARMv7 based SOC with an integrated L2 cache, there is a need
to have a flush API to operate on each cache level. In few low
power modes, L2 cache is retained where as L1 is lost. The current
v7_flush_dcache_all(), flushes all the levels and it would be quite
expensive.

So introduce v7_flush_dcache_by_level() API which takes a
parameter (cache level), and flush only on that level.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Sricharan R <r.sricharan@ti.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-v7.S |   56 ++++++++++++++++++++++++++++++++++++++---------
 1 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index a655d3d..cbeff42 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -43,12 +43,32 @@ ENDPROC(v7_flush_icache_all)
  */
 ENTRY(v7_flush_dcache_all)
 	dmb					@ ensure ordering with previous memory accesses
+	mov	r8, lr				@ store lr
 	mrc	p15, 1, r0, c0, c0, 1		@ read clidr
 	ands	r3, r0, #0x7000000		@ extract loc from clidr
 	mov	r3, r3, lsr #23			@ left align loc bit field
 	beq	finished			@ if loc is 0, then no need to clean
 	mov	r10, #0				@ start clean at cache level 0
 loop1:
+	bl	v7_flush_dcache_current_level
+skip:
+	add	r10, r10, #2			@ increment cache number
+	cmp	r3, r10						@
+	bgt	loop1
+finished:
+	mov	r10, #0				@ swith back to cache level 0
+	mcr	p15, 2, r10, c0, c0, 0		@ select current cache level in cssr
+	dsb
+	isb
+	mov	pc, r8				@ restore lr
+ENDPROC(v7_flush_dcache_all)
+/*
+ *	v7_flush_dcache_current_level()
+ *
+ *	Flush the D-cache by specifed level like l1, l2 etc.
+ *	Corrupted registers: r0-r7, r9-r11 (r6 only in Thumb mode)
+ */
+ENTRY(v7_flush_dcache_current_level)
 	add	r2, r10, r10, lsr #1		@ work out 3x current cache level
 	mov	r1, r0, lsr r2			@ extract cache type bits from clidr
 	and	r1, r1, #7			@ mask of the bits for current cache only
@@ -84,17 +104,31 @@ loop3:
 	bge	loop3
 	subs	r7, r7, #1			@ decrement the index
 	bge	loop2
-skip:
-	add	r10, r10, #2			@ increment cache number
-	cmp	r3, r10
-	bgt	loop1
-finished:
+	mov	pc, lr
+ENDPROC(v7_flush_dcache_current_level)
+
+/*
+ *	v7_flush_dcache_by_level()
+ *	r0	- cache level to be flushed
+ *
+ *	Flush the D-cache by specifed level like l1, l2 etc.
+ *	Corrupted registers: r0-r7, r9-r11 (r6 only in Thumb mode)
+ */
+ENTRY(v7_flush_dcache_by_level)
+	dmb					@ ensure ordering with previous memory accesses
+	mov	r8, lr				@ store the lr
+	mov	r10, r0				@ temp storage
+	sub	r10, r10, #1
+	mov	r10, r10, lsl #1
+	mrc	p15, 1, r0, c0, c0, 1		@ read clidr
+	bl	v7_flush_dcache_current_level
+finished1:
 	mov	r10, #0				@ swith back to cache level 0
 	mcr	p15, 2, r10, c0, c0, 0		@ select current cache level in cssr
 	dsb
 	isb
-	mov	pc, lr
-ENDPROC(v7_flush_dcache_all)
+	mov	pc, r8				@ restore lr
+ENDPROC(v7_flush_dcache_by_level)
 
 /*
  *	v7_flush_cache_all()
@@ -108,14 +142,14 @@ ENDPROC(v7_flush_dcache_all)
  *
  */
 ENTRY(v7_flush_kern_cache_all)
- ARM(	stmfd	sp!, {r4-r5, r7, r9-r11, lr}	)
- THUMB(	stmfd	sp!, {r4-r7, r9-r11, lr}	)
+ ARM(	stmfd	sp!, {r4-r5, r7-r11, lr}	)
+ THUMB(	stmfd	sp!, {r4-r11, lr}	)
 	bl	v7_flush_dcache_all
 	mov	r0, #0
 	ALT_SMP(mcr	p15, 0, r0, c7, c1, 0)	@ invalidate I-cache inner shareable
 	ALT_UP(mcr	p15, 0, r0, c7, c5, 0)	@ I+BTB cache invalidate
- ARM(	ldmfd	sp!, {r4-r5, r7, r9-r11, lr}	)
- THUMB(	ldmfd	sp!, {r4-r7, r9-r11, lr}	)
+ ARM(	ldmfd	sp!, {r4-r5, r7-r11, lr}	)
+ THUMB(	ldmfd	sp!, {r4-r11, lr}	)
 	mov	pc, lr
 ENDPROC(v7_flush_kern_cache_all)
 
-- 
1.7.5.4


From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH] ARM: Fix bad SP address after relocating kernel
Date: Tue, 26 Apr 2011 17:31:20 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1104261700270.24613@xanadu.home>
References: <20110420165514.GE10402@atomide.com> <alpine.LFD.2.00.1104201318040.24613@xanadu.home> <20110421055945.GB13688@atomide.com> <20110421104954.GH13688@atomide.com> <alpine.LFD.2.00.1104210919070.24613@xanadu.home> <alpine.LFD.2.00.1104211711240.24613@xanadu.home>
 <alpine.LFD.2.00.1104212233170.24613@xanadu.home> <20110422062843.GA841@atomide.com> <alpine.LFD.2.00.1104220959440.24613@xanadu.home> <20110426085700.GJ16892@atomide.com> <20110426123746.GC3755@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45018 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932253Ab1DZVbY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Apr 2011 17:31:24 -0400
Received: by vws1 with SMTP id 1so804101vws.19
        for <linux-omap@vger.kernel.org>; Tue, 26 Apr 2011 14:31:22 -0700 (PDT)
In-Reply-To: <20110426123746.GC3755@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Shawn Guo <shawn.guo@freescale.com>, linux-arm-kernel@lists.infradead.org, patches@linaro.org, Aaro Koskinen <aaro.koskinen@nokia.com>, linux-omap@vger.kernel.org

On Tue, 26 Apr 2011, Tony Lindgren wrote:

> Otherwise cache_clean_flush can overwrite some of the relocated
> area depending on where the kernel image gets loaded. This fixes
> booting on n900 after commit 6d7d0ae51574943bf571d269da3243257a2d15db
> (ARM: 6750/1: improvements to compressed/head.S).

Gaaaah.  Indeed.

> Thanks to Aaro Koskinen <aaro.koskinen@nokia.com> for debugging
> the address of the relocated area that gets corrupted, and to
> Nicolas Pitre <nicolas.pitre@linaro.org> for the other uncompress
> related fixes.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>

I think there could be a better fix yet.  Could you test this patch:

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index adf583c..8e3c54b 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -838,9 +838,11 @@ __armv3_mmu_cache_off:
  * Clean and flush the cache to maintain consistency.
  *
  * On exit,
- *  r1, r2, r3, r9, r10, r11, r12 corrupted
+ *  r0, r1, r2, r3, r5, r9, r10, r11, r12, sp corrupted
  * This routine must preserve:
  *  r4, r6, r7, r8
+ *
+ * Yes, sp is destroyed by this call in the armv7 hierarchical case.
  */
 		.align	5
 cache_clean_flush:
@@ -888,7 +890,6 @@ __armv7_mmu_cache_flush:
 		b	iflush
 hierarchical:
 		mcr	p15, 0, r10, c7, c10, 5	@ DMB
-		stmfd	sp!, {r0-r7, r9-r11}
 		mrc	p15, 1, r0, c0, c0, 1	@ read clidr
 		ands	r3, r0, #0x7000000	@ extract loc from clidr
 		mov	r3, r3, lsr #23		@ left align loc bit field
@@ -905,31 +906,31 @@ loop1:
 		mrc	p15, 1, r1, c0, c0, 0	@ read the new csidr
 		and	r2, r1, #7		@ extract the length of the cache lines
 		add	r2, r2, #4		@ add 4 (line length offset)
-		ldr	r4, =0x3ff
-		ands	r4, r4, r1, lsr #3	@ find maximum number on the way size
-		clz	r5, r4			@ find bit position of way size increment
-		ldr	r7, =0x7fff
-		ands	r7, r7, r1, lsr #13	@ extract max number of the index size
+		ldr	r9, =0x3ff
+		ands	r9, r9, r1, lsr #3	@ find maximum number on the way size
+		clz	r5, r9			@ find bit position of way size increment
+		mov	sp, r9
+		ldr	r9, =0x7fff
+		ands	r1, r9, r1, lsr #13	@ extract max number of the index size
 loop2:
-		mov	r9, r4			@ create working copy of max way size
+		mov	r9, sp			@ create working copy of max way size
 loop3:
  ARM(		orr	r11, r10, r9, lsl r5	) @ factor way and cache number into r11
- ARM(		orr	r11, r11, r7, lsl r2	) @ factor index number into r11
- THUMB(		lsl	r6, r9, r5		)
- THUMB(		orr	r11, r10, r6		) @ factor way and cache number into r11
- THUMB(		lsl	r6, r7, r2		)
- THUMB(		orr	r11, r11, r6		) @ factor index number into r11
+ ARM(		orr	r11, r11, r1, lsl r2	) @ factor index number into r11
+ THUMB(		lsl	r12, r9, r5		)
+ THUMB(		orr	r11, r10, r12		) @ factor way and cache number into r11
+ THUMB(		lsl	r12, r1, r2		)
+ THUMB(		orr	r11, r11, r12		) @ factor index number into r11
 		mcr	p15, 0, r11, c7, c14, 2	@ clean & invalidate by set/way
 		subs	r9, r9, #1		@ decrement the way
 		bge	loop3
-		subs	r7, r7, #1		@ decrement the index
+		subs	r1, r1, #1		@ decrement the index
 		bge	loop2
 skip:
 		add	r10, r10, #2		@ increment cache number
 		cmp	r3, r10
 		bgt	loop1
 finished:
-		ldmfd	sp!, {r0-r7, r9-r11}
 		mov	r10, #0			@ swith back to cache level 0
 		mcr	p15, 2, r10, c0, c0, 0	@ select current cache level in cssr
 iflush:

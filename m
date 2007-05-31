From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [PATCH 3/12] ARM V7 support in head.S - OMAP 3430 support
Date: Thu, 31 May 2007 12:57:41 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C4701063210@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Add ARM V7 support to head.S, derived from ARM's Cortex Patch

Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>

Files:
 head.S |   76
 1 files changed, 75 insertions(+), 1 deletion(-)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap/arch/arm/boot/compressed/head.S	2006-11-20 =
21:53:55.000000000 -0600
+++ val_3430_GIT/arch/arm/boot/compressed/head.S	2007-05-30 =
12:20:31.000000000 -0500
@@ -447,6 +447,20 @@ __arm6_mmu_cache_on:
 		mcr	p15, 0, r0, c5, c0, 0	@ invalidate whole TLB v3
 		mov	pc, r12
=20
+__armv7_mmu_cache_on:
+		mov	r12, lr			@ L1 only please
+		bl	__setup_mmu
+		mov	r0, #0
+		mcr	p15, 0, r0, c7, c5, 0	@ invalidate icache
+		mcr	p15, 0, r0, c8, c7, 0	@ invalidate TLBs
+		mrc	p15, 0, r0, c1, c0, 0	@ read control reg
+		orr	r0, r0, #0x1800		@ I-cache + BTB enable
+		bl	__common_mmu_cache_on
+		mov	r0, #0
+		mcr	p15, 0, r0, c8, c7, 0	@ invalidate TLBs
+		mov	pc, r12
+
+
 __common_mmu_cache_on:
 #ifndef DEBUG
 		orr	r0, r0, #0x000d		@ Write buffer, mmu
@@ -624,6 +638,12 @@ proc_types:
 		b	__armv4_mmu_cache_off
 		b	__armv6_mmu_cache_flush
=20
+		.word	0x000fc000		@ ARMv7
+		.word	0x000ff000
+		b	__armv7_mmu_cache_on
+		b	__armv7_mmu_cache_off
+		b	__armv7_mmu_cache_flush
+
 		.word	0			@ unrecognised type
 		.word	0
 		mov	pc, lr
@@ -717,7 +737,7 @@ __armv4_mpu_cache_flush:
 		mcrne	p15, 0, ip, c7, c5, 0	@ invalidate I cache
 		mcr	p15, 0, ip, c7, c10, 4	@ drain WB
 		mov	pc, lr
-	=09
+
=20
 __armv6_mmu_cache_flush:
 		mov	r1, #0
@@ -727,6 +747,51 @@ __armv6_mmu_cache_flush:
 		mcr	p15, 0, r1, c7, c10, 4	@ drain WB
 		mov	pc, lr
=20
+__armv7_mmu_cache_flush:
+		adr	sp, no_cache_id		@ hack, non-v7 code is temp stack
+		stmfd	sp!, {r0-r12}
+		mrc	p15, 1, r0, c0, c0, 1	@ read clidr
+		ands	r3, r0, #0x7000000	@ extract loc from clidr
+		mov	r3, r3, lsr #23		@ left align loc bit field
+		beq	finished		@ if loc is 0, then no need to clean
+		mov	r10, #0			@ start clean at cache level 0
+loop1:
+		add	r2, r10, r10, lsr #1	@ work out 3x current cache level
+		mov	r1, r0, lsr r2		@ extract cache type bits from clidr
+		and	r1, r1, #7		@ mask of the bits for current cache only
+		cmp	r1, #2			@ see what cache we have at this level
+		blt	skip			@ skip if no cache, or just i-cache
+		mcr	p15, 2, r10, c0, c0, 0	@ select current cache level in cssr
+		mov	r1, #0
+		mcr	p15, 0, r1, c7, c5, 4	@ prefetchflush to sych the new cssr&csidr
+		mrc	p15, 1, r1, c0, c0, 0	@ read the new csidr
+		and	r2, r1, #7		@ extract the length of the cache lines
+		add	r2, r2, #4		@ add 4 (line length offset)
+		ldr	r4, =3D0x3ff
+		ands	r4, r4, r1, lsr #3	@ find maximum number on the way size
+		clz	r5, r4			@ find bit position of way size increment
+		ldr	r7, =3D0x7fff
+		ands	r7, r7, r1, lsr #13	@ extract max number of the index size
+loop2:
+		mov	r9, r4			@ create working copy of max way size
+loop3:
+		orr	r11, r10, r9, lsl r5	@ factor way and cache number into r11
+		orr	r11, r11, r7, lsl r2	@ factor index number into r11
+		mcr	p15, 0, r11, c7, c14, 2	@ clean & invalidate by set/way
+		subs	r9, r9, #1		@ decrement the way
+		bge	loop3
+		subs	r7, r7, #1		@ decrement the index
+		bge	loop2
+skip:
+		add	r10, r10, #2		@ increment cache number
+		cmp	r3, r10
+		bgt	loop1
+finished:
+		mov	r0, #0
+		mcr	p15, 0, r0, c7, c5, 0	@ I+BTB cache invalidate
+		ldmfd	sp!, {r0-r12}
+		mov	pc, lr
+
 __armv4_mmu_cache_flush:
 		mov	r2, #64*1024		@ default: 32K dcache size (*2)
 		mov	r11, #32		@ default: 32 byte line size
@@ -761,6 +826,15 @@ __armv3_mpu_cache_flush:
 		mcr	p15, 0, r0, c7, c0, 0	@ invalidate whole cache v3
 		mov	pc, lr
=20
+__armv7_mmu_cache_off:
+		mrc	p15, 0, r0, c1, c0
+		bic	r0, r0, #0x000d	 @ dcache & mmu off (icache still on)
+		mcr	p15, 0, r0, c1, c0, 0	@ turn MMU and cache off
+		mov	r0, #0
+		mcr	p15, 0, r0, c7, c5, 0	@ invalidate icache
+		mcr	p15, 0, r10, c8, c7, 0	@ invalidate I + D TLBs
+		mov	pc, lr
+
 /*
  * Various debugging routines for printing hex characters and
  * memory, which again must be relocatable.

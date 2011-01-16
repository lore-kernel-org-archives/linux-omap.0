From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC+CFT] Use word operations in bitops
Date: Sun, 16 Jan 2011 18:15:51 +0000
Message-ID: <20110116181551.GB21795@n2100.arm.linux.org.uk>
References: <20110116121911.GB27542@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:48177 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752711Ab1APSQF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 Jan 2011 13:16:05 -0500
Content-Disposition: inline
In-Reply-To: <20110116121911.GB27542@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Sun, Jan 16, 2011 at 12:19:11PM +0000, Russell King - ARM Linux wrote:
> XXX WARNING: bitops are used heavily by filesystem code: there be dragons XXX
> I strongly suggest you ensure you have a copy of your filesystems before
> trying this patch.
> 
> The patch below switches the bitops to use word loads/stores rather than
> byte operations - so that we can avoid using the ldrexb/strexb instructions
> which are only supported from ARMv6k and up.
> 
> The current bitops prevent a single kernel covering ARMv6 and ARMv7
> architectures without the resulting kernel being unsafe on SMP.  As
> ldrex/strex is supported from ARMv6 upwards, but ldrexb/strexb is not,
> switch these functions to use the word-based loads/stores.
> 
> As our bitops functions have been tolerant of misaligned pointers, they
> now include a check which will do a NULL pointer store in the event that
> they're passed a non-aligned pointers: ldrex/strex can't cope with such
> things.
> 
> I've verified in userspace that these give the same results on LE setups
> as our existing implementation - that doesn't mean these aren't buggy, it
> just means they appear to behave the same for the testing I've done.  BE
> is completely untested (I don't have any ARM BE setups.)
> 
> Someone who uses BE setups needs to check that filesystem images (for
> minix and ext2/ext3) which worked prior to this patch continue to work
> after these patches.
> 
> This does need a fair amount of testing before it can be merged, so I'd
> like to see a number of Tested-by's against this patch.  Please also
> indicate whether you tested on LE or BE or both, which filesystems, and
> whether they were read-only mounted or read-write mounted.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Revised patch - the previous one was slightly buggered for BE.  We also
don't need to touch the findbit operations at all, so that part has been
dropped.

This includes a patch by Akinobu Mita ("arm: introduce little-endian
bitops", v4).

 arch/arm/include/asm/bitops.h |  114 +++++++++++++++++++++--------------------
 arch/arm/kernel/armksyms.c    |   18 ++----
 arch/arm/lib/bitops.h         |   46 ++++++++++-------
 arch/arm/lib/changebit.S      |   10 +---
 arch/arm/lib/clearbit.S       |   11 +---
 arch/arm/lib/findbit.S        |   16 ++++++
 arch/arm/lib/setbit.S         |   11 +---
 arch/arm/lib/testchangebit.S  |    9 +--
 arch/arm/lib/testclearbit.S   |    9 +--
 arch/arm/lib/testsetbit.S     |    9 +--
 10 files changed, 124 insertions(+), 129 deletions(-)

diff --git a/arch/arm/include/asm/bitops.h b/arch/arm/include/asm/bitops.h
index 338ff19..1e8c366 100644
--- a/arch/arm/include/asm/bitops.h
+++ b/arch/arm/include/asm/bitops.h
@@ -149,30 +149,28 @@ ____atomic_test_and_change_bit(unsigned int bit, volatile unsigned long *p)
  */
 
 /*
+ * Native endian assembly bitops.  nr = 0 -> word 0 bit 0.
+ */
+extern void _set_bit(int nr, volatile unsigned long * p);
+extern void _clear_bit(int nr, volatile unsigned long * p);
+extern void _change_bit(int nr, volatile unsigned long * p);
+extern int _test_and_set_bit(int nr, volatile unsigned long * p);
+extern int _test_and_clear_bit(int nr, volatile unsigned long * p);
+extern int _test_and_change_bit(int nr, volatile unsigned long * p);
+
+/*
  * Little endian assembly bitops.  nr = 0 -> byte 0 bit 0.
  */
-extern void _set_bit_le(int nr, volatile unsigned long * p);
-extern void _clear_bit_le(int nr, volatile unsigned long * p);
-extern void _change_bit_le(int nr, volatile unsigned long * p);
-extern int _test_and_set_bit_le(int nr, volatile unsigned long * p);
-extern int _test_and_clear_bit_le(int nr, volatile unsigned long * p);
-extern int _test_and_change_bit_le(int nr, volatile unsigned long * p);
-extern int _find_first_zero_bit_le(const void * p, unsigned size);
-extern int _find_next_zero_bit_le(const void * p, int size, int offset);
+extern int _find_first_zero_bit_le(const unsigned long *p, unsigned size);
+extern int _find_next_zero_bit_le(const unsigned long *p, int size, int offset);
 extern int _find_first_bit_le(const unsigned long *p, unsigned size);
 extern int _find_next_bit_le(const unsigned long *p, int size, int offset);
 
 /*
  * Big endian assembly bitops.  nr = 0 -> byte 3 bit 0.
  */
-extern void _set_bit_be(int nr, volatile unsigned long * p);
-extern void _clear_bit_be(int nr, volatile unsigned long * p);
-extern void _change_bit_be(int nr, volatile unsigned long * p);
-extern int _test_and_set_bit_be(int nr, volatile unsigned long * p);
-extern int _test_and_clear_bit_be(int nr, volatile unsigned long * p);
-extern int _test_and_change_bit_be(int nr, volatile unsigned long * p);
-extern int _find_first_zero_bit_be(const void * p, unsigned size);
-extern int _find_next_zero_bit_be(const void * p, int size, int offset);
+extern int _find_first_zero_bit_be(const unsigned long *p, unsigned size);
+extern int _find_next_zero_bit_be(const unsigned long *p, int size, int offset);
 extern int _find_first_bit_be(const unsigned long *p, unsigned size);
 extern int _find_next_bit_be(const unsigned long *p, int size, int offset);
 
@@ -180,33 +178,26 @@ extern int _find_next_bit_be(const unsigned long *p, int size, int offset);
 /*
  * The __* form of bitops are non-atomic and may be reordered.
  */
-#define	ATOMIC_BITOP_LE(name,nr,p)		\
-	(__builtin_constant_p(nr) ?		\
-	 ____atomic_##name(nr, p) :		\
-	 _##name##_le(nr,p))
-
-#define	ATOMIC_BITOP_BE(name,nr,p)		\
-	(__builtin_constant_p(nr) ?		\
-	 ____atomic_##name(nr, p) :		\
-	 _##name##_be(nr,p))
+#define ATOMIC_BITOP(name,nr,p)			\
+	(__builtin_constant_p(nr) ? ____atomic_##name(nr, p) : _##name(nr,p))
 #else
-#define ATOMIC_BITOP_LE(name,nr,p)	_##name##_le(nr,p)
-#define ATOMIC_BITOP_BE(name,nr,p)	_##name##_be(nr,p)
+#define ATOMIC_BITOP(name,nr,p)		_##name(nr,p)
 #endif
 
-#define NONATOMIC_BITOP(name,nr,p)		\
-	(____nonatomic_##name(nr, p))
+/*
+ * Native endian atomic definitions.
+ */
+#define set_bit(nr,p)			ATOMIC_BITOP(set_bit,nr,p)
+#define clear_bit(nr,p)			ATOMIC_BITOP(clear_bit,nr,p)
+#define change_bit(nr,p)		ATOMIC_BITOP(change_bit,nr,p)
+#define test_and_set_bit(nr,p)		ATOMIC_BITOP(test_and_set_bit,nr,p)
+#define test_and_clear_bit(nr,p)	ATOMIC_BITOP(test_and_clear_bit,nr,p)
+#define test_and_change_bit(nr,p)	ATOMIC_BITOP(test_and_change_bit,nr,p)
 
 #ifndef __ARMEB__
 /*
  * These are the little endian, atomic definitions.
  */
-#define set_bit(nr,p)			ATOMIC_BITOP_LE(set_bit,nr,p)
-#define clear_bit(nr,p)			ATOMIC_BITOP_LE(clear_bit,nr,p)
-#define change_bit(nr,p)		ATOMIC_BITOP_LE(change_bit,nr,p)
-#define test_and_set_bit(nr,p)		ATOMIC_BITOP_LE(test_and_set_bit,nr,p)
-#define test_and_clear_bit(nr,p)	ATOMIC_BITOP_LE(test_and_clear_bit,nr,p)
-#define test_and_change_bit(nr,p)	ATOMIC_BITOP_LE(test_and_change_bit,nr,p)
 #define find_first_zero_bit(p,sz)	_find_first_zero_bit_le(p,sz)
 #define find_next_zero_bit(p,sz,off)	_find_next_zero_bit_le(p,sz,off)
 #define find_first_bit(p,sz)		_find_first_bit_le(p,sz)
@@ -215,16 +206,9 @@ extern int _find_next_bit_be(const unsigned long *p, int size, int offset);
 #define WORD_BITOFF_TO_LE(x)		((x))
 
 #else
-
 /*
  * These are the big endian, atomic definitions.
  */
-#define set_bit(nr,p)			ATOMIC_BITOP_BE(set_bit,nr,p)
-#define clear_bit(nr,p)			ATOMIC_BITOP_BE(clear_bit,nr,p)
-#define change_bit(nr,p)		ATOMIC_BITOP_BE(change_bit,nr,p)
-#define test_and_set_bit(nr,p)		ATOMIC_BITOP_BE(test_and_set_bit,nr,p)
-#define test_and_clear_bit(nr,p)	ATOMIC_BITOP_BE(test_and_clear_bit,nr,p)
-#define test_and_change_bit(nr,p)	ATOMIC_BITOP_BE(test_and_change_bit,nr,p)
 #define find_first_zero_bit(p,sz)	_find_first_zero_bit_be(p,sz)
 #define find_next_zero_bit(p,sz,off)	_find_next_zero_bit_be(p,sz,off)
 #define find_first_bit(p,sz)		_find_first_bit_be(p,sz)
@@ -303,41 +287,61 @@ static inline int fls(int x)
 #include <asm-generic/bitops/hweight.h>
 #include <asm-generic/bitops/lock.h>
 
+#define __set_bit_le(nr, p)			\
+	__set_bit(WORD_BITOFF_TO_LE(nr), (p))
+#define __clear_bit_le(nr, p)			\
+	__clear_bit(WORD_BITOFF_TO_LE(nr), (p))
+#define __test_and_set_bit_le(nr, p)			\
+		__test_and_set_bit(WORD_BITOFF_TO_LE(nr), (p))
+#define test_and_set_bit_le(nr, p)          \
+		test_and_set_bit(WORD_BITOFF_TO_LE(nr), (p))
+#define __test_and_clear_bit_le(nr, p)			\
+		__test_and_clear_bit(WORD_BITOFF_TO_LE(nr), (p))
+#define test_and_clear_bit_le(nr, p)	\
+		test_and_clear_bit(WORD_BITOFF_TO_LE(nr), (p))
+#define test_bit_le(nr, p)			\
+		test_bit(WORD_BITOFF_TO_LE(nr), (p))
+#define find_first_zero_bit_le(p, sz)		\
+		_find_first_zero_bit_le(p, sz)
+#define find_next_zero_bit_le(p, sz, off)	\
+		_find_next_zero_bit_le(p, sz, off)
+#define find_next_bit_le(p, sz, off) \
+		_find_next_bit_le(p, sz, off)
 /*
  * Ext2 is defined to use little-endian byte ordering.
  * These do not need to be atomic.
  */
 #define ext2_set_bit(nr,p)			\
-		__test_and_set_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
+		__test_and_set_bit_le(nr, (unsigned long *)(p))
 #define ext2_set_bit_atomic(lock,nr,p)          \
-                test_and_set_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
+		test_and_set_bit_le(nr, (unsigned long *)(p))
 #define ext2_clear_bit(nr,p)			\
-		__test_and_clear_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
+		__test_and_clear_bit_le(nr, (unsigned long *)(p))
 #define ext2_clear_bit_atomic(lock,nr,p)        \
-                test_and_clear_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
+		test_and_clear_bit_le(nr, (unsigned long *)(p))
 #define ext2_test_bit(nr,p)			\
-		test_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
+		test_bit_le(nr, (unsigned long *)(p))
 #define ext2_find_first_zero_bit(p,sz)		\
-		_find_first_zero_bit_le(p,sz)
+		find_first_zero_bit_le((unsigned long *)(p), sz)
 #define ext2_find_next_zero_bit(p,sz,off)	\
-		_find_next_zero_bit_le(p,sz,off)
+		find_next_zero_bit_le((unsigned long *)(p), sz, off)
 #define ext2_find_next_bit(p, sz, off) \
-		_find_next_bit_le(p, sz, off)
+		find_next_bit_le((unsigned long *)(p), sz, off)
 
 /*
  * Minix is defined to use little-endian byte ordering.
  * These do not need to be atomic.
  */
 #define minix_set_bit(nr,p)			\
-		__set_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
+		__set_bit_le(nr, (unsigned long *)(p))
 #define minix_test_bit(nr,p)			\
-		test_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
+		test_bit_le(nr, (unsigned long *)(p))
 #define minix_test_and_set_bit(nr,p)		\
-		__test_and_set_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
+		__test_and_set_bit_le(nr, (unsigned long *)(p))
 #define minix_test_and_clear_bit(nr,p)		\
-		__test_and_clear_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
+		__test_and_clear_bit_le(nr, (unsigned long *)(p))
 #define minix_find_first_zero_bit(p,sz)		\
-		_find_first_zero_bit_le(p,sz)
+		find_first_zero_bit_le((unsigned long *)(p), sz)
 
 #endif /* __KERNEL__ */
 
diff --git a/arch/arm/kernel/armksyms.c b/arch/arm/kernel/armksyms.c
index e5e1e53..d5d4185 100644
--- a/arch/arm/kernel/armksyms.c
+++ b/arch/arm/kernel/armksyms.c
@@ -140,24 +140,18 @@ EXPORT_SYMBOL(__aeabi_ulcmp);
 #endif
 
 	/* bitops */
-EXPORT_SYMBOL(_set_bit_le);
-EXPORT_SYMBOL(_test_and_set_bit_le);
-EXPORT_SYMBOL(_clear_bit_le);
-EXPORT_SYMBOL(_test_and_clear_bit_le);
-EXPORT_SYMBOL(_change_bit_le);
-EXPORT_SYMBOL(_test_and_change_bit_le);
+EXPORT_SYMBOL(_set_bit);
+EXPORT_SYMBOL(_test_and_set_bit);
+EXPORT_SYMBOL(_clear_bit);
+EXPORT_SYMBOL(_test_and_clear_bit);
+EXPORT_SYMBOL(_change_bit);
+EXPORT_SYMBOL(_test_and_change_bit);
 EXPORT_SYMBOL(_find_first_zero_bit_le);
 EXPORT_SYMBOL(_find_next_zero_bit_le);
 EXPORT_SYMBOL(_find_first_bit_le);
 EXPORT_SYMBOL(_find_next_bit_le);
 
 #ifdef __ARMEB__
-EXPORT_SYMBOL(_set_bit_be);
-EXPORT_SYMBOL(_test_and_set_bit_be);
-EXPORT_SYMBOL(_clear_bit_be);
-EXPORT_SYMBOL(_test_and_clear_bit_be);
-EXPORT_SYMBOL(_change_bit_be);
-EXPORT_SYMBOL(_test_and_change_bit_be);
 EXPORT_SYMBOL(_find_first_zero_bit_be);
 EXPORT_SYMBOL(_find_next_zero_bit_be);
 EXPORT_SYMBOL(_find_first_bit_be);
diff --git a/arch/arm/lib/bitops.h b/arch/arm/lib/bitops.h
index d422529..f8a2bd3 100644
--- a/arch/arm/lib/bitops.h
+++ b/arch/arm/lib/bitops.h
@@ -1,28 +1,33 @@
-
-#if __LINUX_ARM_ARCH__ >= 6 && defined(CONFIG_CPU_32v6K)
+#if __LINUX_ARM_ARCH__ >= 6
 	.macro	bitop, instr
+	tst	r1, #3
+	strne	r1, [r1, -r1]		@ assert word-aligned
 	mov	r2, #1
-	and	r3, r0, #7		@ Get bit offset
-	add	r1, r1, r0, lsr #3	@ Get byte offset
+	and	r3, r0, #31		@ Get bit offset
+	mov	r0, r0, lsr #5
+	add	r1, r1, r0, lsl #2	@ Get word offset
 	mov	r3, r2, lsl r3
-1:	ldrexb	r2, [r1]
+1:	ldrex	r2, [r1]
 	\instr	r2, r2, r3
-	strexb	r0, r2, [r1]
+	strex	r0, r2, [r1]
 	cmp	r0, #0
 	bne	1b
 	mov	pc, lr
 	.endm
 
 	.macro	testop, instr, store
-	and	r3, r0, #7		@ Get bit offset
+	tst	r1, #3
+	strne	r1, [r1, -r1]		@ assert word-aligned
 	mov	r2, #1
-	add	r1, r1, r0, lsr #3	@ Get byte offset
+	and	r3, r0, #31		@ Get bit offset
+	mov	r0, r0, lsr #5
+	add	r1, r1, r0, lsl #2	@ Get word offset
 	mov	r3, r2, lsl r3		@ create mask
 	smp_dmb
-1:	ldrexb	r2, [r1]
+1:	ldrex	r2, [r1]
 	ands	r0, r2, r3		@ save old value of bit
-	\instr	r2, r2, r3			@ toggle bit
-	strexb	ip, r2, [r1]
+	\instr	r2, r2, r3		@ toggle bit
+	strex	ip, r2, [r1]
 	cmp	ip, #0
 	bne	1b
 	smp_dmb
@@ -32,13 +37,16 @@
 	.endm
 #else
 	.macro	bitop, instr
-	and	r2, r0, #7
+	tst	r1, #3
+	strne	r1, [r1, -r1]		@ assert word-aligned
+	and	r2, r0, #31
+	mov	r0, r0, lsr #5
 	mov	r3, #1
 	mov	r3, r3, lsl r2
 	save_and_disable_irqs ip
-	ldrb	r2, [r1, r0, lsr #3]
+	ldr	r2, [r1, r0, lsl #2]
 	\instr	r2, r2, r3
-	strb	r2, [r1, r0, lsr #3]
+	str	r2, [r1, r0, lsl #2]
 	restore_irqs ip
 	mov	pc, lr
 	.endm
@@ -52,11 +60,13 @@
  * to avoid dirtying the data cache.
  */
 	.macro	testop, instr, store
-	add	r1, r1, r0, lsr #3
-	and	r3, r0, #7
-	mov	r0, #1
+	tst	r1, #3
+	strne	r1, [r1, -r1]		@ assert word-aligned
+	and	r3, r0, #31
+	mov	r0, r0, lsr #5
 	save_and_disable_irqs ip
-	ldrb	r2, [r1]
+	ldr	r2, [r1, r0, lsl #2]!
+	mov	r0, #1
 	tst	r2, r0, lsl r3
 	\instr	r2, r2, r0, lsl r3
 	\store	r2, [r1]
diff --git a/arch/arm/lib/changebit.S b/arch/arm/lib/changebit.S
index 80f3115..68ed5b6 100644
--- a/arch/arm/lib/changebit.S
+++ b/arch/arm/lib/changebit.S
@@ -12,12 +12,6 @@
 #include "bitops.h"
                 .text
 
-/* Purpose  : Function to change a bit
- * Prototype: int change_bit(int bit, void *addr)
- */
-ENTRY(_change_bit_be)
-		eor	r0, r0, #0x18		@ big endian byte ordering
-ENTRY(_change_bit_le)
+ENTRY(_change_bit)
 	bitop	eor
-ENDPROC(_change_bit_be)
-ENDPROC(_change_bit_le)
+ENDPROC(_change_bit)
diff --git a/arch/arm/lib/clearbit.S b/arch/arm/lib/clearbit.S
index 1a63e43..4c04c3b 100644
--- a/arch/arm/lib/clearbit.S
+++ b/arch/arm/lib/clearbit.S
@@ -12,13 +12,6 @@
 #include "bitops.h"
                 .text
 
-/*
- * Purpose  : Function to clear a bit
- * Prototype: int clear_bit(int bit, void *addr)
- */
-ENTRY(_clear_bit_be)
-		eor	r0, r0, #0x18		@ big endian byte ordering
-ENTRY(_clear_bit_le)
+ENTRY(_clear_bit)
 	bitop	bic
-ENDPROC(_clear_bit_be)
-ENDPROC(_clear_bit_le)
+ENDPROC(_clear_bit)
diff --git a/arch/arm/lib/findbit.S b/arch/arm/lib/findbit.S
index 64f6bc1..7edd605 100644
--- a/arch/arm/lib/findbit.S
+++ b/arch/arm/lib/findbit.S
@@ -22,6 +22,8 @@
  * Prototype: int find_first_zero_bit(void *addr, unsigned int maxbit);
  */
 ENTRY(_find_first_zero_bit_le)
+		tst	r0, #3
+		strne	r0, [r0, -r0]		@ assert word-aligned
 		teq	r1, #0	
 		beq	3f
 		mov	r2, #0
@@ -43,6 +45,8 @@ ENDPROC(_find_first_zero_bit_le)
  * Prototype: int find_next_zero_bit(void *addr, unsigned int maxbit, int offset)
  */
 ENTRY(_find_next_zero_bit_le)
+		tst	r0, #3
+		strne	r0, [r0, -r0]		@ assert word-aligned
 		teq	r1, #0
 		beq	3b
 		ands	ip, r2, #7
@@ -63,6 +67,8 @@ ENDPROC(_find_next_zero_bit_le)
  * Prototype: int find_first_bit(const unsigned long *addr, unsigned int maxbit);
  */
 ENTRY(_find_first_bit_le)
+		tst	r0, #3
+		strne	r0, [r0, -r0]		@ assert word-aligned
 		teq	r1, #0	
 		beq	3f
 		mov	r2, #0
@@ -84,6 +90,8 @@ ENDPROC(_find_first_bit_le)
  * Prototype: int find_next_zero_bit(void *addr, unsigned int maxbit, int offset)
  */
 ENTRY(_find_next_bit_le)
+		tst	r0, #3
+		strne	r0, [r0, -r0]		@ assert word-aligned
 		teq	r1, #0
 		beq	3b
 		ands	ip, r2, #7
@@ -101,6 +109,8 @@ ENDPROC(_find_next_bit_le)
 #ifdef __ARMEB__
 
 ENTRY(_find_first_zero_bit_be)
+		tst	r0, #3
+		strne	r0, [r0, -r0]		@ assert word-aligned
 		teq	r1, #0
 		beq	3f
 		mov	r2, #0
@@ -118,6 +128,8 @@ ENTRY(_find_first_zero_bit_be)
 ENDPROC(_find_first_zero_bit_be)
 
 ENTRY(_find_next_zero_bit_be)
+		tst	r0, #3
+		strne	r0, [r0, -r0]		@ assert word-aligned
 		teq	r1, #0
 		beq	3b
 		ands	ip, r2, #7
@@ -135,6 +147,8 @@ ENTRY(_find_next_zero_bit_be)
 ENDPROC(_find_next_zero_bit_be)
 
 ENTRY(_find_first_bit_be)
+		tst	r0, #3
+		strne	r0, [r0, -r0]		@ assert word-aligned
 		teq	r1, #0
 		beq	3f
 		mov	r2, #0
@@ -152,6 +166,8 @@ ENTRY(_find_first_bit_be)
 ENDPROC(_find_first_bit_be)
 
 ENTRY(_find_next_bit_be)
+		tst	r0, #3
+		strne	r0, [r0, -r0]		@ assert word-aligned
 		teq	r1, #0
 		beq	3b
 		ands	ip, r2, #7
diff --git a/arch/arm/lib/setbit.S b/arch/arm/lib/setbit.S
index 1dd7176..bbee5c6 100644
--- a/arch/arm/lib/setbit.S
+++ b/arch/arm/lib/setbit.S
@@ -12,13 +12,6 @@
 #include "bitops.h"
 		.text
 
-/*
- * Purpose  : Function to set a bit
- * Prototype: int set_bit(int bit, void *addr)
- */
-ENTRY(_set_bit_be)
-		eor	r0, r0, #0x18		@ big endian byte ordering
-ENTRY(_set_bit_le)
+ENTRY(_set_bit)
 	bitop	orr
-ENDPROC(_set_bit_be)
-ENDPROC(_set_bit_le)
+ENDPROC(_set_bit)
diff --git a/arch/arm/lib/testchangebit.S b/arch/arm/lib/testchangebit.S
index 5c98dc5..15a4d43 100644
--- a/arch/arm/lib/testchangebit.S
+++ b/arch/arm/lib/testchangebit.S
@@ -12,9 +12,6 @@
 #include "bitops.h"
                 .text
 
-ENTRY(_test_and_change_bit_be)
-		eor	r0, r0, #0x18		@ big endian byte ordering
-ENTRY(_test_and_change_bit_le)
-	testop	eor, strb
-ENDPROC(_test_and_change_bit_be)
-ENDPROC(_test_and_change_bit_le)
+ENTRY(_test_and_change_bit)
+	testop	eor, str
+ENDPROC(_test_and_change_bit)
diff --git a/arch/arm/lib/testclearbit.S b/arch/arm/lib/testclearbit.S
index 543d709..521b66b 100644
--- a/arch/arm/lib/testclearbit.S
+++ b/arch/arm/lib/testclearbit.S
@@ -12,9 +12,6 @@
 #include "bitops.h"
                 .text
 
-ENTRY(_test_and_clear_bit_be)
-		eor	r0, r0, #0x18		@ big endian byte ordering
-ENTRY(_test_and_clear_bit_le)
-	testop	bicne, strneb
-ENDPROC(_test_and_clear_bit_be)
-ENDPROC(_test_and_clear_bit_le)
+ENTRY(_test_and_clear_bit)
+	testop	bicne, strne
+ENDPROC(_test_and_clear_bit)
diff --git a/arch/arm/lib/testsetbit.S b/arch/arm/lib/testsetbit.S
index 0b3f390..1c98cc2 100644
--- a/arch/arm/lib/testsetbit.S
+++ b/arch/arm/lib/testsetbit.S
@@ -12,9 +12,6 @@
 #include "bitops.h"
                 .text
 
-ENTRY(_test_and_set_bit_be)
-		eor	r0, r0, #0x18		@ big endian byte ordering
-ENTRY(_test_and_set_bit_le)
-	testop	orreq, streqb
-ENDPROC(_test_and_set_bit_be)
-ENDPROC(_test_and_set_bit_le)
+ENTRY(_test_and_set_bit)
+	testop	orreq, streq
+ENDPROC(_test_and_set_bit)

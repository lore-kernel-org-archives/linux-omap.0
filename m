From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 07/14] ARM: v6k: select clear exclusive code seqences according to V6 variants
Date: Mon, 17 Jan 2011 19:23:22 +0000
Message-ID: <E1Peufi-0003Sh-Ej@rmk-PC.arm.linux.org.uk>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59822 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752319Ab1AQT2t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jan 2011 14:28:49 -0500
In-Reply-To: <20110117192050.GE23331@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

If CONFIG_CPU_V6 is enabled, then the kernel must support ARMv6 CPUs
which don't have the V6K extensions implemented.  Always use the
dummy store-exclusive method to ensure that the exclusive monitors are
cleared.

If CONFIG_CPU_V6 is not set, but CONFIG_CPU_32v6K is enabled, then we
have the K extensions available on all CPUs we're building support for,
so we can use the new clear-exclusive instruction.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/entry-header.S |   14 +++++++-------
 arch/arm/mm/abort-ev6.S        |    6 +++---
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index ae94649..051166c 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -76,13 +76,13 @@
 #ifndef CONFIG_THUMB2_KERNEL
 	.macro	svc_exit, rpsr
 	msr	spsr_cxsf, \rpsr
-#if defined(CONFIG_CPU_32v6K)
-	clrex					@ clear the exclusive monitor
-	ldmia	sp, {r0 - pc}^			@ load r0 - pc, cpsr
-#elif defined (CONFIG_CPU_V6)
+#if defined(CONFIG_CPU_V6)
 	ldr	r0, [sp]
 	strex	r1, r2, [sp]			@ clear the exclusive monitor
 	ldmib	sp, {r1 - pc}^			@ load r1 - pc, cpsr
+#elif defined(CONFIG_CPU_32v6K)
+	clrex					@ clear the exclusive monitor
+	ldmia	sp, {r0 - pc}^			@ load r0 - pc, cpsr
 #else
 	ldmia	sp, {r0 - pc}^			@ load r0 - pc, cpsr
 #endif
@@ -92,10 +92,10 @@
 	ldr	r1, [sp, #\offset + S_PSR]	@ get calling cpsr
 	ldr	lr, [sp, #\offset + S_PC]!	@ get pc
 	msr	spsr_cxsf, r1			@ save in spsr_svc
-#if defined(CONFIG_CPU_32v6K)
-	clrex					@ clear the exclusive monitor
-#elif defined (CONFIG_CPU_V6)
+#if defined(CONFIG_CPU_V6)
 	strex	r1, r2, [sp]			@ clear the exclusive monitor
+#elif defined(CONFIG_CPU_32v6K)
+	clrex					@ clear the exclusive monitor
 #endif
 	.if	\fast
 	ldmdb	sp, {r1 - lr}^			@ get calling r1 - lr
diff --git a/arch/arm/mm/abort-ev6.S b/arch/arm/mm/abort-ev6.S
index f332df7..1478aa5 100644
--- a/arch/arm/mm/abort-ev6.S
+++ b/arch/arm/mm/abort-ev6.S
@@ -20,11 +20,11 @@
  */
 	.align	5
 ENTRY(v6_early_abort)
-#ifdef CONFIG_CPU_32v6K
-	clrex
-#else
+#ifdef CONFIG_CPU_V6
 	sub	r1, sp, #4			@ Get unused stack location
 	strex	r0, r1, [r1]			@ Clear the exclusive monitor
+#elif defined(CONFIG_CPU_32v6K)
+	clrex
 #endif
 	mrc	p15, 0, r1, c5, c0, 0		@ get FSR
 	mrc	p15, 0, r0, c6, c0, 0		@ get FAR
-- 
1.6.2.5


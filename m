From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/2] ARM: Add inituart macro to initialize DEBUG_LL serial
	port based on the machine ID
Date: Thu, 03 Feb 2011 17:22:07 -0800
Message-ID: <20110204012207.26298.16649.stgit@baageli.muru.com>
References: <20110204012008.26298.16341.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:13719 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753752Ab1BDBWV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Feb 2011 20:22:21 -0500
In-Reply-To: <20110204012008.26298.16341.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Allow machine specific init of the DEBUG_LL serial port. This is needed
to debug kernels built with support for multiple machines compiled in
without recompiling the kernel.

As some SoCs need to use variables to store the port address and LSR
register configuration, we must call inituart again after clearing
the BSS.

If variables are being used for for inituart and addruart, this setup
won't work properly for debugging the uncompress code without patching
arch/arm/boot/compressed/head.S for the machine in question.

For adding DEBUG_LL support for new machines, only two lines are needed
in debug-macro.S:

	.macro	inituart, id, a, v
	...
	ldr	\v, =MACH_TYPE_SOMETHING1
	cmp	\id, \v
	ldrne	\v, =MACH_TYPE_SOMETHING2
	cmpne	\id, \v
	ldrne	\v, =MACH_TYPE_SOMETHING3
	cmpne	\id, \v
	...
	.endm

Note that this patch depends on a patch to add empty inituart macro for
each debug-macro.S file.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/kernel/head-common.S |    7 +++++++
 arch/arm/kernel/head.S        |    5 +++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/head-common.S b/arch/arm/kernel/head-common.S
index c84b57d..0b66d6b 100644
--- a/arch/arm/kernel/head-common.S
+++ b/arch/arm/kernel/head-common.S
@@ -63,6 +63,9 @@ ENDPROC(__vet_atags)
  *  r1  = machine ID
  *  r2  = atags pointer
  *  r9  = processor ID
+ *
+ * Note that if the machine uses BSS to store the debug UART configuration,
+ * debug_ll code will not work after clear BSS until inituart is called again.
  */
 	__INIT
 __mmap_switched:
@@ -80,6 +83,10 @@ __mmap_switched:
 	strcc	fp, [r6],#4
 	bcc	1b
 
+#if defined(CONFIG_DEBUG_LL) && !defined(CONFIG_DEBUG_ICEDCC)
+	inituart r1, r4, r5
+#endif
+
  ARM(	ldmia	r3, {r4, r5, r6, r7, sp})
  THUMB(	ldmia	r3, {r4, r5, r6, r7}	)
  THUMB(	ldr	sp, [r3, #16]		)
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 591a2ea..be64264 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -75,6 +75,11 @@
 ENTRY(stext)
 	setmode	PSR_F_BIT | PSR_I_BIT | SVC_MODE, r9 @ ensure svc mode
 						@ and irqs disabled
+
+#if defined(CONFIG_DEBUG_LL) && !defined(CONFIG_DEBUG_ICEDCC)
+	inituart r1, r3, r4
+#endif
+
 	mrc	p15, 0, r9, c0, c0		@ get processor id
 	bl	__lookup_processor_type		@ r5=procinfo r9=cpuid
 	movs	r10, r5				@ invalid processor (r5=0)?


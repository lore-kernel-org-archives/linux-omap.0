From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 01/11] ARM: pm: CPU specific code should not overwrite r1
 (v:p offset)
Date: Thu, 01 Sep 2011 13:48:38 +0100
Message-ID: <E1Qz6hC-00078B-Pm@rmk-PC.arm.linux.org.uk>
References: <20110901124752.GE29729@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:58545 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757370Ab1IAMsw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Sep 2011 08:48:52 -0400
In-Reply-To: <20110901124752.GE29729@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.orglinux-arm-kernel@lists.infradead.orglinux-omap@vger.kernel.org

r1 stores the v:p offset from the CPU invariant resume code, and is
expected to be preserved by the CPU specific code.  Overwriting it is
not a good idea.

We've managed to get away with it on sa1100 platforms because most
happen to have PHYS_OFFSET == PAGE_OFFSET, but that may not be the
case depending on kernel configuration.  So fix this latent bug.

This fixes xsc3 as well which was saving and restoring this register
independently.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/proc-sa1100.S |   10 +++++-----
 arch/arm/mm/proc-xsc3.S   |    6 +++---
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mm/proc-sa1100.S b/arch/arm/mm/proc-sa1100.S
index 07219c2..69e7f2e 100644
--- a/arch/arm/mm/proc-sa1100.S
+++ b/arch/arm/mm/proc-sa1100.S
@@ -182,11 +182,11 @@ ENDPROC(cpu_sa1100_do_suspend)
 
 ENTRY(cpu_sa1100_do_resume)
 	ldmia	r0, {r4 - r7}			@ load cp regs
-	mov	r1, #0
-	mcr	p15, 0, r1, c8, c7, 0		@ flush I+D TLBs
-	mcr	p15, 0, r1, c7, c7, 0		@ flush I&D cache
-	mcr	p15, 0, r1, c9, c0, 0		@ invalidate RB
-	mcr	p15, 0, r1, c9, c0, 5		@ allow user space to use RB
+	mov	ip, #0
+	mcr	p15, 0, ip, c8, c7, 0		@ flush I+D TLBs
+	mcr	p15, 0, ip, c7, c7, 0		@ flush I&D cache
+	mcr	p15, 0, ip, c9, c0, 0		@ invalidate RB
+	mcr	p15, 0, ip, c9, c0, 5		@ allow user space to use RB
 
 	mcr	p15, 0, r4, c3, c0, 0		@ domain ID
 	mcr	p15, 0, r5, c2, c0, 0		@ translation table base addr
diff --git a/arch/arm/mm/proc-xsc3.S b/arch/arm/mm/proc-xsc3.S
index 28c72a2..755e1bf 100644
--- a/arch/arm/mm/proc-xsc3.S
+++ b/arch/arm/mm/proc-xsc3.S
@@ -406,7 +406,7 @@ ENTRY(cpu_xsc3_set_pte_ext)
 	.align
 
 .globl	cpu_xsc3_suspend_size
-.equ	cpu_xsc3_suspend_size, 4 * 8
+.equ	cpu_xsc3_suspend_size, 4 * 7
 #ifdef CONFIG_PM_SLEEP
 ENTRY(cpu_xsc3_do_suspend)
 	stmfd	sp!, {r4 - r10, lr}
@@ -418,12 +418,12 @@ ENTRY(cpu_xsc3_do_suspend)
 	mrc	p15, 0, r9, c1, c0, 1	@ auxiliary control reg
 	mrc 	p15, 0, r10, c1, c0, 0	@ control reg
 	bic	r4, r4, #2		@ clear frequency change bit
-	stmia	r0, {r1, r4 - r10}	@ store v:p offset + cp regs
+	stmia	r0, {r4 - r10}		@ store cp regs
 	ldmia	sp!, {r4 - r10, pc}
 ENDPROC(cpu_xsc3_do_suspend)
 
 ENTRY(cpu_xsc3_do_resume)
-	ldmia	r0, {r1, r4 - r10}	@ load v:p offset + cp regs
+	ldmia	r0, {r4 - r10}		@ load cp regs
 	mov	ip, #0
 	mcr	p15, 0, ip, c7, c7, 0	@ invalidate I & D caches, BTB
 	mcr	p15, 0, ip, c7, c10, 4	@ drain write (&fill) buffer
-- 
1.7.4.4


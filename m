From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 07/25] ARM: pm: preserve r4 - r11 across a suspend
Date: Thu, 23 Jun 2011 20:11:23 +0100
Message-ID: <E1QZpJD-0005m7-LO@rmk-PC.arm.linux.org.uk>
References: <20110623190900.GH9449@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20110623190900.GH9449@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Make cpu_suspend()..return function preserve r4 to r11 across a suspend
cycle.  This is in preparation of relieving platform support code from
this task.

Acked-by: Frank Hofmann <frank.hofmann@tomtom.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/sleep.S |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
index 0a778c3..8dbca93 100644
--- a/arch/arm/kernel/sleep.S
+++ b/arch/arm/kernel/sleep.S
@@ -12,10 +12,11 @@
  *  r1 = v:p offset
  *  r3 = virtual return function
  * Note: sp is decremented to allocate space for CPU state on stack
- * r0-r3,r9,r10,lr corrupted
+ * r0-r3,ip,lr corrupted
  */
 ENTRY(cpu_suspend)
 	stmfd	sp!, {r3}
+	stmfd	sp!, {r4 - r11}
 	mov	r9, lr
 #ifdef MULTI_CPU
 	ldr	r10, =processor
@@ -88,7 +89,7 @@ ENDPROC(cpu_resume_turn_mmu_on)
 cpu_resume_after_mmu:
 	str	r5, [r2, r4, lsl #2]	@ restore old mapping
 	mcr	p15, 0, r0, c1, c0, 0	@ turn on D-cache
-	ldmfd	sp!, {pc}
+	ldmfd	sp!, {r4 - r11, pc}
 ENDPROC(cpu_resume_after_mmu)
 
 /*
-- 
1.7.4.4

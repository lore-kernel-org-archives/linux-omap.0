From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 24/25] ARM: pm: ensure ARMv7 CPUs save and restore the TLS
 register
Date: Wed, 22 Jun 2011 16:16:38 +0100
Message-ID: <E1QZPAU-0002XK-54@rmk-PC.arm.linux.org.uk>
References: <20110622150816.GT23234@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20110622150816.GT23234@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Ensure that the TLS register is saved and restored over a suspend
cycle, so that userspace programs don't see a corrupted TLS value.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/proc-v7.S |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index b3b566e..426c946 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -208,19 +208,21 @@ cpu_v7_name:
 
 /* Suspend/resume support: derived from arch/arm/mach-s5pv210/sleep.S */
 .globl	cpu_v7_suspend_size
-.equ	cpu_v7_suspend_size, 4 * 8
+.equ	cpu_v7_suspend_size, 4 * 9
 #ifdef CONFIG_PM_SLEEP
 ENTRY(cpu_v7_do_suspend)
 	stmfd	sp!, {r4 - r11, lr}
 	mrc	p15, 0, r4, c13, c0, 0	@ FCSE/PID
 	mrc	p15, 0, r5, c13, c0, 1	@ Context ID
+	mrc	p15, 0, r6, c13, c0, 3	@ User r/o thread ID
+	stmia	r0!, {r4 - r6}
 	mrc	p15, 0, r6, c3, c0, 0	@ Domain ID
 	mrc	p15, 0, r7, c2, c0, 0	@ TTB 0
 	mrc	p15, 0, r8, c2, c0, 1	@ TTB 1
 	mrc	p15, 0, r9, c1, c0, 0	@ Control register
 	mrc	p15, 0, r10, c1, c0, 1	@ Auxiliary control register
 	mrc	p15, 0, r11, c1, c0, 2	@ Co-processor access control
-	stmia	r0, {r4 - r11}
+	stmia	r0, {r6 - r11}
 	ldmfd	sp!, {r4 - r11, pc}
 ENDPROC(cpu_v7_do_suspend)
 
@@ -228,9 +230,11 @@ ENTRY(cpu_v7_do_resume)
 	mov	ip, #0
 	mcr	p15, 0, ip, c8, c7, 0	@ invalidate TLBs
 	mcr	p15, 0, ip, c7, c5, 0	@ invalidate I cache
-	ldmia	r0, {r4 - r11}
+	ldmia	r0!, {r4 - r6}
 	mcr	p15, 0, r4, c13, c0, 0	@ FCSE/PID
 	mcr	p15, 0, r5, c13, c0, 1	@ Context ID
+	mcr	p15, 0, r6, c13, c0, 3	@ User r/o thread ID
+	ldmia	r0, {r6 - r11}
 	mcr	p15, 0, r6, c3, c0, 0	@ Domain ID
 	mcr	p15, 0, r7, c2, c0, 0	@ TTB 0
 	mcr	p15, 0, r8, c2, c0, 1	@ TTB 1
-- 
1.7.4.4

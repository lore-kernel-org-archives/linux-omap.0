From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 14/25] ARM: pm: pxa: cleanup PXA suspend code
Date: Wed, 22 Jun 2011 16:13:15 +0100
Message-ID: <E1QZP7D-0002Wf-As@rmk-PC.arm.linux.org.uk>
References: <20110622150816.GT23234@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110622150816.GT23234@n2100.arm.linux.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Remove now redundant stacking of registers.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-pxa/sleep.S |   33 +++++++++++++--------------------
 1 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-pxa/sleep.S b/arch/arm/mach-pxa/sleep.S
index 3a67887..cd39293 100644
--- a/arch/arm/mach-pxa/sleep.S
+++ b/arch/arm/mach-pxa/sleep.S
@@ -33,11 +33,15 @@ ENTRY(pxa3xx_cpu_suspend)
 #ifndef CONFIG_IWMMXT
 	mra	r2, r3, acc0
 #endif
-	stmfd	sp!, {r2 - r12, lr}	@ save registers on stack
+	stmfd	sp!, {r2, r3, lr}	@ save registers on stack
 	mov	r1, r0
 	adr	r3, BSYM(pxa3xx_finish_suspend)
 	bl	cpu_suspend
-	b	pxa_cpu_resume
+	ldmfd	sp!, {r2, r3, lr}
+#ifndef CONFIG_IWMMXT
+	mar	acc0, r2, r3
+#endif
+	mov	pc, lr
 
 pxa3xx_finish_suspend:
 	mov	r0, #0x06		@ S2D3C4 mode
@@ -60,11 +64,15 @@ ENTRY(pxa27x_cpu_suspend)
 #ifndef CONFIG_IWMMXT
 	mra	r2, r3, acc0
 #endif
-	stmfd	sp!, {r2 - r12, lr}		@ save registers on stack
+	stmfd	sp!, {r2, r3, lr}		@ save registers on stack
 	mov	r2, r0				@ save sleep mode
 	adr	r3, BSYM(pxa27x_finish_suspend)
 	bl	cpu_suspend
-	b	pxa_cpu_resume
+	ldmfd	sp!, {r2, r3, lr}
+#ifndef CONFIG_IWMMXT
+	mar	acc0, r2, r3
+#endif
+	mov	pc, lr
 
 pxa27x_finish_suspend:
 	@ Put the processor to sleep
@@ -112,11 +120,9 @@ pxa27x_finish_suspend:
  */
 
 ENTRY(pxa25x_cpu_suspend)
-	stmfd	sp!, {r2 - r12, lr}		@ save registers on stack
 	mov	r2, r0				@ save sleep mode
 	adr	r3, BSYM(pxa25x_finish_suspend)
-	bl	cpu_suspend
-	b	pxa_cpu_resume
+	b	cpu_suspend
 
 pxa25x_finish_suspend:
 	@ prepare value for sleep mode
@@ -202,16 +208,3 @@ pxa_cpu_do_suspend:
 	mcr	p14, 0, r1, c7, c0, 0		@ PWRMODE
 
 20:	b	20b				@ loop waiting for sleep
-
-/*
- * pxa_cpu_resume()
- *
- * entry point from bootloader into kernel during resume
- */
-	.align 5
-pxa_cpu_resume:
-	ldmfd	sp!, {r2, r3}
-#ifndef CONFIG_IWMMXT
-	mar	acc0, r2, r3
-#endif
-	ldmfd	sp!, {r4 - r12, pc}		@ return to caller
-- 
1.7.4.4

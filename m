From: Joel Fernandes <joelf@ti.com>
Subject: [RFC] ARM: kernel: irq: Simplify allocation of stack frame
Date: Sun, 6 Oct 2013 17:30:47 -0500
Message-ID: <1381098649-21417-1-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Hentschel?= <nerv@dawncrow.de>, Russell King <linux@arm.linux.org.uk>, Jonathan Austin <jonathan.austin@arm.com>, Nicolas Pitre <nico@linaro.org>, Joel Fernandes <joelf@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

On receiving IRQ exception in SVC mode, all the SVC mode registers are saved
onto the stack very early on.

The stack frame allocation code for IRQ entry during SVC mode (svc_entry) is
hard to read as 4-less is allocated initially only to be allocated later
implicity using the mov r3, [sp, #-4]! instruction. We make code easier to read
by allocating the 4 bytes on the stack frame in the beginning itself and remove
all instances where 4 bytes is adjusted.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Nicolas Pitre <nico@linaro.org>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 arch/arm/kernel/entry-armv.S | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 9cbe70c..fc5ac2a 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -149,7 +149,7 @@ ENDPROC(__und_invalid)
 	.macro	svc_entry, stack_hole=0
  UNWIND(.fnstart		)
  UNWIND(.save {r0 - pc}		)
-	sub	sp, sp, #(S_FRAME_SIZE + \stack_hole - 4)
+	sub	sp, sp, #(S_FRAME_SIZE + \stack_hole)
 #ifdef CONFIG_THUMB2_KERNEL
  SPFIX(	str	r0, [sp]	)	@ temporarily saved
  SPFIX(	mov	r0, sp		)
@@ -159,14 +159,14 @@ ENDPROC(__und_invalid)
  SPFIX(	tst	sp, #4		)
 #endif
  SPFIX(	subeq	sp, sp, #4	)
-	stmia	sp, {r1 - r12}
+	stmia	sp, {r0 - r12}
 
 	ldmia	r0, {r3 - r5}
-	add	r7, sp, #S_SP - 4	@ here for interlock avoidance
+	add	r7, sp, #S_SP		@ here for interlock avoidance
 	mov	r6, #-1			@  ""  ""      ""       ""
-	add	r2, sp, #(S_FRAME_SIZE + \stack_hole - 4)
+	add	r2, sp, #(S_FRAME_SIZE + \stack_hole)
  SPFIX(	addeq	r2, r2, #4	)
-	str	r3, [sp, #-4]!		@ save the "real" r0 copied
+	str	r3, [sp]		@ save the "real" r0 copied
 					@ from the exception stack
 
 	mov	r3, lr
-- 
1.8.1.2

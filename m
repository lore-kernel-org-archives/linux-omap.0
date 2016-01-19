From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/5] ARM: OMAP2+: Fix l2dis_3630 for rodata
Date: Tue, 19 Jan 2016 09:48:51 -0800
Message-ID: <1453225734-16993-3-git-send-email-tony@atomide.com>
References: <1453225734-16993-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1453225734-16993-1-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Richard Woodruff <r-woodruff2@ti.com>, Russell King <linux@arm.linux.org.uk>, Kees Cook <keescook@chromium.org>, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <menon.nishanth@gmail.com>, Laura Abbott <labbott@redhat.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We don't want to write to .text section. Let's move l2dis_3630
to .data and access it via a pointer.

Cc: Kees Cook <keescook@chromium.org>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Nishanth Menon <menon.nishanth@gmail.com>
Cc: Richard Woodruff <r-woodruff2@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/sleep34xx.S | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index 787cfda..f7c7bf8 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -86,7 +86,9 @@ ENTRY(enable_omap3630_toggle_l2_on_restore)
 	stmfd	sp!, {lr}	@ save registers on stack
 	/* Setup so that we will disable and enable l2 */
 	mov	r1, #0x1
-	adrl	r2, l2dis_3630	@ may be too distant for plain adr
+	adrl	r3, l2dis_3630_offset	@ may be too distant for plain adr
+	ldr	r2, [r3]
+	add	r2, r2, r3
 	str	r1, [r2]
 	ldmfd	sp!, {pc}	@ restore regs and return
 ENDPROC(enable_omap3630_toggle_l2_on_restore)
@@ -415,7 +417,9 @@ ENTRY(omap3_restore)
 	cmp	r2, #0x0	@ Check if target power state was OFF or RET
 	bne	logic_l1_restore
 
-	ldr	r0, l2dis_3630
+	adr	r1, l2dis_3630_offset
+	ldr	r0, [r1]
+	add	r0, r0, r1
 	cmp	r0, #0x1	@ should we disable L2 on 3630?
 	bne	skipl2dis
 	mrc	p15, 0, r0, c1, c0, 1
@@ -484,7 +488,9 @@ l2_inv_gp:
 	mov	r12, #0x2
 	smc	#0			@ Call SMI monitor (smieq)
 logic_l1_restore:
-	ldr	r1, l2dis_3630
+	adr	r0, l2dis_3630_offset
+	ldr	r1, [r0]
+	add	r1, r1, r0
 	cmp	r1, #0x1		@ Test if L2 re-enable needed on 3630
 	bne	skipl2reen
 	mrc	p15, 0, r1, c1, c0, 1
@@ -513,6 +519,10 @@ control_stat:
 	.word	CONTROL_STAT
 control_mem_rta:
 	.word	CONTROL_MEM_RTA_CTRL
+l2dis_3630_offset:
+	.long	l2dis_3630 - .
+
+	.data
 l2dis_3630:
 	.word	0
 
-- 
2.7.0.rc3

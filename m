From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/5] ARM: OMAP2+: Fix l2dis_3630 for rodata
Date: Thu, 21 Jan 2016 11:12:04 -0800
Message-ID: <1453403527-21308-3-git-send-email-tony@atomide.com>
References: <1453403527-21308-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1453403527-21308-1-git-send-email-tony@atomide.com>
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
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Nishanth Menon <nm@ti.com>, Richard Woodruff <r-woodruff2@ti.com>, Russell King <linux@arm.linux.org.uk>, Kees Cook <keescook@chromium.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Tero Kristo <t-kristo@ti.com>, Laura Abbott <labbott@redhat.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We don't want to write to .text section. Let's move l2dis_3630
to .data and access it via a pointer.

For calculating the offset, let's optimize out the add and do it
in ldr/str as suggested by Nicolas Pitre <nicolas.pitre@linaro.org>.

Cc: Kees Cook <keescook@chromium.org>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Nishanth Menon <nm@ti.com>
Cc: Richard Woodruff <r-woodruff2@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/sleep34xx.S | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index 787cfda..5659d96 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -86,8 +86,9 @@ ENTRY(enable_omap3630_toggle_l2_on_restore)
 	stmfd	sp!, {lr}	@ save registers on stack
 	/* Setup so that we will disable and enable l2 */
 	mov	r1, #0x1
-	adrl	r2, l2dis_3630	@ may be too distant for plain adr
-	str	r1, [r2]
+	adrl	r3, l2dis_3630_offset	@ may be too distant for plain adr
+	ldr	r2, [r3]		@ value for offset
+	str	r1, [r2, r3]		@ write to l2dis_3630
 	ldmfd	sp!, {pc}	@ restore regs and return
 ENDPROC(enable_omap3630_toggle_l2_on_restore)
 
@@ -415,7 +416,9 @@ ENTRY(omap3_restore)
 	cmp	r2, #0x0	@ Check if target power state was OFF or RET
 	bne	logic_l1_restore
 
-	ldr	r0, l2dis_3630
+	adr	r1, l2dis_3630_offset	@ address for offset
+	ldr	r0, [r1]		@ value for offset
+	ldr	r0, [r1, r0]		@ value at l2dis_3630
 	cmp	r0, #0x1	@ should we disable L2 on 3630?
 	bne	skipl2dis
 	mrc	p15, 0, r0, c1, c0, 1
@@ -484,7 +487,9 @@ l2_inv_gp:
 	mov	r12, #0x2
 	smc	#0			@ Call SMI monitor (smieq)
 logic_l1_restore:
-	ldr	r1, l2dis_3630
+	adr	r0, l2dis_3630_offset	@ adress for offset
+	ldr	r1, [r0]		@ value for offset
+	ldr	r1, [r0, r1]		@ value at l2dis_3630
 	cmp	r1, #0x1		@ Test if L2 re-enable needed on 3630
 	bne	skipl2reen
 	mrc	p15, 0, r1, c1, c0, 1
@@ -513,6 +518,10 @@ control_stat:
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

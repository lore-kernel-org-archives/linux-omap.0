From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/5] ARM: OMAP2+: Fix ppa_zero_params and ppa_por_params for
 rodata
Date: Tue, 19 Jan 2016 09:48:54 -0800
Message-ID: <1453225734-16993-6-git-send-email-tony@atomide.com>
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

We don't want to write to .text so let's move ppa_zero_params and
ppa_por_params to .data and access them via pointers.

Note that I have not been able to test as we I don't have a HS
omap4 to test with. The code has been changed in similar way as
for omap3 though.

Cc: Kees Cook <keescook@chromium.org>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Nishanth Menon <menon.nishanth@gmail.com>
Cc: Richard Woodruff <r-woodruff2@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/sleep44xx.S | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/sleep44xx.S b/arch/arm/mach-omap2/sleep44xx.S
index 9b09d85..74ab3d1 100644
--- a/arch/arm/mach-omap2/sleep44xx.S
+++ b/arch/arm/mach-omap2/sleep44xx.S
@@ -29,12 +29,6 @@
 	dsb
 .endm
 
-ppa_zero_params:
-	.word		0x0
-
-ppa_por_params:
-	.word		1, 0
-
 #ifdef CONFIG_ARCH_OMAP4
 
 /*
@@ -266,7 +260,9 @@ ENTRY(omap4_cpu_resume)
 	beq	skip_ns_smp_enable
 ppa_actrl_retry:
 	mov     r0, #OMAP4_PPA_CPU_ACTRL_SMP_INDEX
-	adr	r3, ppa_zero_params		@ Pointer to parameters
+	adr	r1, ppa_zero_params_offset	@ Pointer to parameters
+	ldr	r3, [r1]
+	add	r3, r3, r1
 	mov	r1, #0x0			@ Process ID
 	mov	r2, #0x4			@ Flag
 	mov	r6, #0xff
@@ -303,7 +299,9 @@ skip_ns_smp_enable:
 	ldr     r0, =OMAP4_PPA_L2_POR_INDEX
 	ldr     r1, =OMAP44XX_SAR_RAM_BASE
 	ldr     r4, [r1, #L2X0_PREFETCH_CTRL_OFFSET]
-	adr     r3, ppa_por_params
+	adr     r1, ppa_por_params_offset
+	ldr	r3, [r1]
+	add	r3, r3, r1
 	str     r4, [r3, #0x04]
 	mov	r1, #0x0			@ Process ID
 	mov	r2, #0x4			@ Flag
@@ -328,6 +326,8 @@ skip_l2en:
 #endif
 
 	b	cpu_resume			@ Jump to generic resume
+ppa_por_params_offset:
+	.long	ppa_por_params - .
 ENDPROC(omap4_cpu_resume)
 #endif	/* CONFIG_ARCH_OMAP4 */
 
@@ -380,4 +380,13 @@ ENTRY(omap_do_wfi)
 	nop
 
 	ldmfd	sp!, {pc}
+ppa_zero_params_offset:
+	.long	ppa_zero_params - .
 ENDPROC(omap_do_wfi)
+
+	.data
+ppa_zero_params:
+	.word		0
+
+ppa_por_params:
+	.word		1, 0
-- 
2.7.0.rc3

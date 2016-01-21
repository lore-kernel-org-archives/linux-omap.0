From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/5] ARM: OMAP2+: Fix l2_inv_api_params for rodata
Date: Thu, 21 Jan 2016 11:12:06 -0800
Message-ID: <1453403527-21308-5-git-send-email-tony@atomide.com>
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

We don't want to write to .text, so let's move l2_inv_api_params
to .data and access it via a pointer.

Cc: Kees Cook <keescook@chromium.org>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Nishanth Menon <nm@ti.com>
Cc: Richard Woodruff <r-woodruff2@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/sleep34xx.S | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index 8e2a7ac..1b9f052 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -436,12 +436,14 @@ skipl2dis:
 	and	r1, #0x700
 	cmp	r1, #0x300
 	beq	l2_inv_gp
+	adr	r0, l2_inv_api_params_offset
+	ldr	r3, [r0]
+	add	r3, r3, r0		@ r3 points to dummy parameters
 	mov	r0, #40			@ set service ID for PPA
 	mov	r12, r0			@ copy secure Service ID in r12
 	mov	r1, #0			@ set task id for ROM code in r1
 	mov	r2, #4			@ set some flags in r2, r6
 	mov	r6, #0xff
-	adr	r3, l2_inv_api_params	@ r3 points to dummy parameters
 	dsb				@ data write barrier
 	dmb				@ data memory barrier
 	smc	#1			@ call SMI monitor (smi #1)
@@ -475,8 +477,8 @@ skipl2dis:
 	b	logic_l1_restore
 
 	.align
-l2_inv_api_params:
-	.word	0x1, 0x00
+l2_inv_api_params_offset:
+	.long	l2_inv_api_params - .
 l2_inv_gp:
 	/* Execute smi to invalidate L2 cache */
 	mov r12, #0x1			@ set up to invalidate L2
@@ -531,6 +533,10 @@ l2dis_3630_offset:
 l2dis_3630:
 	.word	0
 
+	.data
+l2_inv_api_params:
+	.word	0x1, 0x00
+
 /*
  * Internal functions
  */
-- 
2.7.0.rc3

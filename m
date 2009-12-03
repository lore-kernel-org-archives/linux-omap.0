From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 7/9] OMAP3: SDRC: Place SDRC AC timing and MR changes in CORE
	DVFS SRAM code behind Kconfig
Date: Thu, 03 Dec 2009 06:45:43 -0700
Message-ID: <20091203134539.16229.20330.stgit@localhost.localdomain>
References: <20091203134321.16229.87539.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48966 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756109AbZLCNwX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 08:52:23 -0500
In-Reply-To: <20091203134321.16229.87539.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Christophe Sucur <c-sucur@ti.com>, Nishanth Menon <nm@ti.com>, Rajendra Nayak <rnayak@ti.com>, =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>, Richard Woodruff <r-woodruff2@ti.com>

The code that reprograms the SDRC memory controller during CORE DVFS,
mach-omap2/sram34xx.S:omap3_sram_configure_core_dpll(), does not
ensure that all L3 initiators are prevented from accessing the SDRAM
before modifying the SDRC AC timing and MR registers.  This can cause
memory to be corrupted or cause the SDRC to enter an unpredictable
state.  This patch places that code behind a Kconfig option,
CONFIG_OMAP3_SDRC_AC_TIMING for now, and adds a note explaining what
is going on.  Ideally the code can be added back in once supporting
code is present to ensure that other initiators aren't touching the
SDRAM.  At the very least, these registers should be reprogrammable
during kernel init to deal with buggy bootloaders.  Users who know
that all other system initiators will not be touching the SDRAM can
also re-enable this Kconfig option.

This is a modification of a patch originally written by Rajendra Nayak
<rnayak@ti.com> (the original is at http://patchwork.kernel.org/patch/5=
1927/).
Rather than removing the code completely, this patch just comments it o=
ut.

Thanks to Beno=C3=AEt Cousson <b-cousson@ti.com> and Christophe Sucur
<c-sucur@ti.com> for explaining the technical basis for this and for
explaining what can be done to make this path work in future code.
Thanks to Richard Woodruff <r-woodruff2@ti.com> and Nishanth Menon
<nm@ti.com> for their comments.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Christophe Sucur <c-sucur@ti.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
Cc: Richard Woodruff <r-woodruff2@ti.com>
Cc: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/Kconfig    |   13 +++++++++++++
 arch/arm/mach-omap2/sram34xx.S |   19 +++++++++++++++++--
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index aad194f..a8d2610 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -100,3 +100,16 @@ config MACH_OMAP_ZOOM2
 config MACH_OMAP_4430SDP
 	bool "OMAP 4430 SDP board"
 	depends on ARCH_OMAP4
+
+config OMAP3_SDRC_AC_TIMING
+	bool "Enable SDRC AC timing register changes"
+	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+	default n
+	help
+	  If you know that none of your system initiators will attempt to
+	  access SDRAM during CORE DVFS, select Y here.  This should boost
+	  SDRAM performance at lower CORE OPPs.  There are relatively few
+	  users who will wish to say yes at this point - almost everyone will
+	  wish to say no.  Selecting yes without understanding what is
+	  going on could result in system crashes;
+
diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sram3=
4xx.S
index 82aa4a3..de99ba2 100644
--- a/arch/arm/mach-omap2/sram34xx.S
+++ b/arch/arm/mach-omap2/sram34xx.S
@@ -91,8 +91,19 @@
  *  new SDRC_ACTIM_CTRL_B_1 register contents
  *  new SDRC_MR_1 register value
  *
- * If the param SDRC_RFR_CTRL_1 is 0, the parameters
- *  are not programmed into the SDRC CS1 registers
+ * If the param SDRC_RFR_CTRL_1 is 0, the parameters are not programme=
d into
+ * the SDRC CS1 registers
+ *
+ * NOTE: This code no longer attempts to program the SDRC AC timing an=
d MR
+ * registers.  This is because the code currently cannot ensure that a=
ll
+ * L3 initiators (e.g., sDMA, IVA, DSS DISPC, etc.) are not accessing =
the
+ * SDRAM when the registers are written.  If the registers are changed=
 while
+ * an initiator is accessing SDRAM, memory can be corrupted and/or the=
 SDRC
+ * may enter an unpredictable state.  In the future, the intent is to
+ * re-enable this code in cases where we can ensure that no initiators=
 are
+ * touching the SDRAM.  Until that time, users who know that their use=
 case
+ * can satisfy the above requirement can enable the CONFIG_OMAP3_SDRC_=
AC_TIMING
+ * option.
  */
 ENTRY(omap3_sram_configure_core_dpll)
 	stmfd	sp!, {r1-r12, lr}	@ store regs to stack
@@ -219,6 +230,7 @@ configure_sdrc:
 	ldr	r12, omap_sdrc_rfr_ctrl_0_val	@ fetch value from SRAM
 	ldr	r11, omap3_sdrc_rfr_ctrl_0	@ fetch addr from SRAM
 	str	r12, [r11]			@ store
+#ifdef CONFIG_OMAP3_SDRC_AC_TIMING
 	ldr	r12, omap_sdrc_actim_ctrl_a_0_val
 	ldr	r11, omap3_sdrc_actim_ctrl_a_0
 	str	r12, [r11]
@@ -228,11 +240,13 @@ configure_sdrc:
 	ldr	r12, omap_sdrc_mr_0_val
 	ldr	r11, omap3_sdrc_mr_0
 	str	r12, [r11]
+#endif
 	ldr	r12, omap_sdrc_rfr_ctrl_1_val
 	cmp	r12, #0			@ if SDRC_RFR_CTRL_1 is 0,
 	beq	skip_cs1_prog		@  do not program cs1 params
 	ldr	r11, omap3_sdrc_rfr_ctrl_1
 	str	r12, [r11]
+#ifdef CONFIG_OMAP3_SDRC_AC_TIMING
 	ldr	r12, omap_sdrc_actim_ctrl_a_1_val
 	ldr	r11, omap3_sdrc_actim_ctrl_a_1
 	str	r12, [r11]
@@ -242,6 +256,7 @@ configure_sdrc:
 	ldr	r12, omap_sdrc_mr_1_val
 	ldr	r11, omap3_sdrc_mr_1
 	str	r12, [r11]
+#endif
 skip_cs1_prog:
 	ldr	r12, [r11]		@ posted-write barrier for SDRC
 	bx	lr


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

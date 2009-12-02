From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP3: SDRC: Comment out SDRC AC timing and MR changes in
 CORE DVFS SRAM code
Date: Tue, 1 Dec 2009 18:33:32 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0912011832290.13408@utopia.booyaka.com>
References: <1254835224-19500-1-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.0910201918230.22645@utopia.booyaka.com> <13B9B4C6EF24D648824FF11BE8967162039B3CF012@dlee02.ent.ti.com> <74583B8642AB8841B30447520659FCA9DDD9D7E9@dnce01.ent.ti.com>
 <13B9B4C6EF24D648824FF11BE8967162039B459718@dlee02.ent.ti.com> <1F18D6510CF0474A8C9500565A7E41A2236DA1C1F3@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-556411796-1259717612=:13408"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36225 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbZLBBd0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Dec 2009 20:33:26 -0500
In-Reply-To: <1F18D6510CF0474A8C9500565A7E41A2236DA1C1F3@NOK-EUMSG-02.mgdnok.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tero.Kristo@nokia.com, r-woodruff2@ti.com, b-cousson@ti.com, rnayak@ti.com, c-sucur@ti.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-556411796-1259717612=:13408
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE


The code that reprograms the SDRC memory controller during CORE DVFS,
mach-omap2/sram34xx.S:omap3_sram_configure_core_dpll(), does not
ensure that all L3 initiators are prevented from accessing the SDRAM
before modifying the SDRC AC timing and MR registers.  This can cause
memory to be corrupted or cause the SDRC to enter an unpredictable
state.  This patch comments out that code for now and adds a note
explaining what is going on.  Ideally it can be added back in once
supporting code is present to ensure that other initiators aren't
touching the SDRAM.  At the very least, these registers should be
reprogrammable during kernel init to deal with buggy bootloaders.

This is a modification of a patch originally written by Rajendra Nayak
<rnayak@ti.com> (the original is at http://patchwork.kernel.org/patch/51927=
/).
Rather than removing the code completely, this patch just comments it out.

Thanks to Beno=EEt Cousson <b-cousson@ti.com> and Christophe Sucur
<c-sucur@ti.com> for explaining the technical basis for this and for
explaining what can be done to make this path work in future code.
Thanks to Richard Woodruff <r-woodruff2@ti.com> for his comments.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Christophe Sucur <c-sucur@ti.com>
Cc: Beno=EEt Cousson <b-cousson@ti.com>
Cc: Richard Woodruff <r-woodruff2@ti.com>
---
 arch/arm/mach-omap2/sram34xx.S |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sram34xx.=
S
index 82aa4a3..8fa8955 100644
--- a/arch/arm/mach-omap2/sram34xx.S
+++ b/arch/arm/mach-omap2/sram34xx.S
@@ -91,8 +91,18 @@
  *  new SDRC_ACTIM_CTRL_B_1 register contents
  *  new SDRC_MR_1 register value
  *
- * If the param SDRC_RFR_CTRL_1 is 0, the parameters
- *  are not programmed into the SDRC CS1 registers
+ * If the param SDRC_RFR_CTRL_1 is 0, the parameters are not programmed in=
to
+ * the SDRC CS1 registers
+ *
+ * NOTE: This code no longer attempts to program the SDRC AC timing and MR
+ * registers.  This is because the code currently cannot ensure that all
+ * L3 initiators (e.g., sDMA, IVA, DSS DISPC, etc.) are not accessing the
+ * SDRAM when the registers are written.  If the registers are changed whi=
le
+ * an initiator is accessing SDRAM, memory can be corrupted and/or the SDR=
C
+ * may enter an unpredictable state.  The code to reprogram the registers,
+ * however, has been left in -- commented out in "#if 0" .. "#endif" block=
s --
+ * since in the future, the intent is to re-enable this code in cases wher=
e we
+ * can ensure that no initiators are touching the SDRAM.
  */
 ENTRY(omap3_sram_configure_core_dpll)
 =09stmfd=09sp!, {r1-r12, lr}=09@ store regs to stack
@@ -219,6 +229,7 @@ configure_sdrc:
 =09ldr=09r12, omap_sdrc_rfr_ctrl_0_val=09@ fetch value from SRAM
 =09ldr=09r11, omap3_sdrc_rfr_ctrl_0=09@ fetch addr from SRAM
 =09str=09r12, [r11]=09=09=09@ store
+#if 0
 =09ldr=09r12, omap_sdrc_actim_ctrl_a_0_val
 =09ldr=09r11, omap3_sdrc_actim_ctrl_a_0
 =09str=09r12, [r11]
@@ -228,11 +239,13 @@ configure_sdrc:
 =09ldr=09r12, omap_sdrc_mr_0_val
 =09ldr=09r11, omap3_sdrc_mr_0
 =09str=09r12, [r11]
+#endif
 =09ldr=09r12, omap_sdrc_rfr_ctrl_1_val
 =09cmp=09r12, #0=09=09=09@ if SDRC_RFR_CTRL_1 is 0,
 =09beq=09skip_cs1_prog=09=09@  do not program cs1 params
 =09ldr=09r11, omap3_sdrc_rfr_ctrl_1
 =09str=09r12, [r11]
+#if 0
 =09ldr=09r12, omap_sdrc_actim_ctrl_a_1_val
 =09ldr=09r11, omap3_sdrc_actim_ctrl_a_1
 =09str=09r12, [r11]
@@ -242,6 +255,7 @@ configure_sdrc:
 =09ldr=09r12, omap_sdrc_mr_1_val
 =09ldr=09r11, omap3_sdrc_mr_1
 =09str=09r12, [r11]
+#endif
 skip_cs1_prog:
 =09ldr=09r12, [r11]=09=09@ posted-write barrier for SDRC
 =09bx=09lr
--=20
1.6.5.GIT

--155748971-556411796-1259717612=:13408--

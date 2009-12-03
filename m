From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2] OMAP3: SDRC: Comment out SDRC AC timing and MR changes
 in CORE DVFS SRAM code
Date: Thu, 3 Dec 2009 06:41:50 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0912030641150.13408@utopia.booyaka.com>
References: <1254835224-19500-1-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.0910201918230.22645@utopia.booyaka.com> <13B9B4C6EF24D648824FF11BE8967162039B3CF012@dlee02.ent.ti.com> <74583B8642AB8841B30447520659FCA9DDD9D7E9@dnce01.ent.ti.com>
 <13B9B4C6EF24D648824FF11BE8967162039B459718@dlee02.ent.ti.com> <1F18D6510CF0474A8C9500565A7E41A2236DA1C1F3@NOK-EUMSG-02.mgdnok.nokia.com> <alpine.DEB.2.00.0912011832290.13408@utopia.booyaka.com> <4B160552.6050108@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-511909081-1259847710=:13408"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45384 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754686AbZLCNlo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 08:41:44 -0500
In-Reply-To: <4B160552.6050108@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: linux-omap@vger.kernel.org, Tero.Kristo@nokia.com, r-woodruff2@ti.com, b-cousson@ti.com, rnayak@ti.com, c-sucur@ti.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-511909081-1259847710=:13408
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE


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
<rnayak@ti.com> (the original is at http://patchwork.kernel.org/patch/51927=
/).
Rather than removing the code completely, this patch just comments it out.

Thanks to Beno=EEt Cousson <b-cousson@ti.com> and Christophe Sucur
<c-sucur@ti.com> for explaining the technical basis for this and for
explaining what can be done to make this path work in future code.
Thanks to Richard Woodruff <r-woodruff2@ti.com> and Nishanth Menon
<nm@ti.com> for their comments.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Christophe Sucur <c-sucur@ti.com>
Cc: Beno=EEt Cousson <b-cousson@ti.com>
Cc: Richard Woodruff <r-woodruff2@ti.com>
Cc: Nishanth Menon <nm@ti.com>

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index aad194f..a8d2610 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -100,3 +100,16 @@ config MACH_OMAP_ZOOM2
 config MACH_OMAP_4430SDP
 =09bool "OMAP 4430 SDP board"
 =09depends on ARCH_OMAP4
+
+config OMAP3_SDRC_AC_TIMING
+=09bool "Enable SDRC AC timing register changes"
+=09depends on ARCH_OMAP3 && ARCH_OMAP34XX
+=09default n
+=09help
+=09  If you know that none of your system initiators will attempt to
+=09  access SDRAM during CORE DVFS, select Y here.  This should boost
+=09  SDRAM performance at lower CORE OPPs.  There are relatively few
+=09  users who will wish to say yes at this point - almost everyone will
+=09  wish to say no.  Selecting yes without understanding what is
+=09  going on could result in system crashes;
+
diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sram34xx.=
S
index 82aa4a3..de99ba2 100644
--- a/arch/arm/mach-omap2/sram34xx.S
+++ b/arch/arm/mach-omap2/sram34xx.S
@@ -91,8 +91,19 @@
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
+ * may enter an unpredictable state.  In the future, the intent is to
+ * re-enable this code in cases where we can ensure that no initiators are
+ * touching the SDRAM.  Until that time, users who know that their use cas=
e
+ * can satisfy the above requirement can enable the CONFIG_OMAP3_SDRC_AC_T=
IMING
+ * option.
  */
 ENTRY(omap3_sram_configure_core_dpll)
 =09stmfd=09sp!, {r1-r12, lr}=09@ store regs to stack
@@ -219,6 +230,7 @@ configure_sdrc:
 =09ldr=09r12, omap_sdrc_rfr_ctrl_0_val=09@ fetch value from SRAM
 =09ldr=09r11, omap3_sdrc_rfr_ctrl_0=09@ fetch addr from SRAM
 =09str=09r12, [r11]=09=09=09@ store
+#ifdef CONFIG_OMAP3_SDRC_AC_TIMING
 =09ldr=09r12, omap_sdrc_actim_ctrl_a_0_val
 =09ldr=09r11, omap3_sdrc_actim_ctrl_a_0
 =09str=09r12, [r11]
@@ -228,11 +240,13 @@ configure_sdrc:
 =09ldr=09r12, omap_sdrc_mr_0_val
 =09ldr=09r11, omap3_sdrc_mr_0
 =09str=09r12, [r11]
+#endif
 =09ldr=09r12, omap_sdrc_rfr_ctrl_1_val
 =09cmp=09r12, #0=09=09=09@ if SDRC_RFR_CTRL_1 is 0,
 =09beq=09skip_cs1_prog=09=09@  do not program cs1 params
 =09ldr=09r11, omap3_sdrc_rfr_ctrl_1
 =09str=09r12, [r11]
+#ifdef CONFIG_OMAP3_SDRC_AC_TIMING
 =09ldr=09r12, omap_sdrc_actim_ctrl_a_1_val
 =09ldr=09r11, omap3_sdrc_actim_ctrl_a_1
 =09str=09r12, [r11]
@@ -242,6 +256,7 @@ configure_sdrc:
 =09ldr=09r12, omap_sdrc_mr_1_val
 =09ldr=09r11, omap3_sdrc_mr_1
 =09str=09r12, [r11]
+#endif
 skip_cs1_prog:
 =09ldr=09r12, [r11]=09=09@ posted-write barrier for SDRC
 =09bx=09lr
--155748971-511909081-1259847710=:13408--

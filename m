From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/3] OMAP: control: add functions for DSP boot address/mode
	control
Date: Mon, 11 Oct 2010 14:37:12 -0600
Message-ID: <20101011203710.24425.94685.stgit@twilight.localdomain>
References: <20101011203659.24425.2381.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40278 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754619Ab0JKUj3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Oct 2010 16:39:29 -0400
In-Reply-To: <20101011203659.24425.2381.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: fernando.lugo@ti.com
Cc: linux-omap@vger.kernel.org

Add two functions for OMAP2430/OMAP3 IVA2 DSP boot control.  These
registers wound up in the System Control Module.  Other kernel code
that wishes to control the DSP's boot process should now use these
functions to do so; subsequent patches implement this in the two
in-tree users of these functions.

This patch is functionally untested; that is for the DSP/Bridge
programmers to do.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/control.c              |   51 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/control.h              |   16 +++++---
 arch/arm/plat-omap/include/plat/iva2_dsp.h |   56 ++++++++++++++++++++++++++++
 3 files changed, 116 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/iva2_dsp.h

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 1fa3294..90fae36 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -209,6 +209,57 @@ void omap4_ctrl_pad_writel(u32 val, u16 offset)
 	__raw_writel(val, OMAP4_CTRL_PAD_REGADDR(offset));
 }
 
+/*
+ * OMAP3 DSP control functions
+ */
+
+/**
+ * omap2430_ctrl_set_dsp_bootaddr - set the DSP's boot address
+ * @pa: DSP boot address (in physical memory)
+ *
+ * Set the DSP's boot address.  This is an address in physical memory.
+ * No return value.  XXX The TRM claims that this is an "index to a
+ * 4kByte page".  If so, why is the bitfield 21 bits wide, rather than
+ * 20?
+ */
+void omap2430_ctrl_set_dsp_bootaddr(u32 pa)
+{
+	if (!(cpu_is_omap2430() || cpu_is_omap34xx())) {
+		WARN(1, "control: %s: not supported on this SoC\n", __func__);
+		return;
+	}
+
+	WARN(pa & ~OMAP_CTRL_DSP_BOOTADDR_MASK,
+	     "control: %s: invalid DSP boot address %08x\n", __func__, pa);
+
+	omap_ctrl_writel(pa, OMAP243X_CONTROL_IVA2_BOOTADDR);
+}
+
+/**
+ * omap2430_ctrl_set_dsp_bootmode - set the DSP's boot mode
+ * @mode: DSP boot mode (described below)
+ *
+ * Sets the DSP boot mode - see OMAP3 TRM revision ZH section 7.4.7.4
+ * "IVA2.2 Boot Registers".  Known values of @mode include 0, to boot
+ * directly to the address supplied by omap2_ctrl_set_dsp_bootaddr();
+ * 1, to boot to the DSP's ROM code and idle, waiting for interrupts;
+ * 2, to boot to the DSP's ROM code and spin in an idle loop; 3, to
+ * copy the user's bootstrap code from the DSP's internal memory and
+ * execute it (XXX how does the DSP know where to copy from?); and 4,
+ * to execute the DSP ROM code's context restore code.  No return
+ * value.
+ */
+void omap2430_ctrl_set_dsp_bootmode(u8 mode)
+{
+	if (!(cpu_is_omap2430() || cpu_is_omap34xx())) {
+		WARN(1, "control: %s: not supported on this SoC\n", __func__);
+		return;
+	}
+
+	omap_ctrl_writel(mode, OMAP243X_CONTROL_IVA2_BOOTMOD);
+}
+
+
 #if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_PM)
 /*
  * Clears the scratchpad contents in case of cold boot-
diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index b6c6b7c..ac14e0a 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -258,11 +258,6 @@
 /* CONTROL_PROG_IO1 bits */
 #define OMAP3630_PRG_SDMMC1_SPEEDCTRL	(1 << 20)
 
-/* CONTROL_IVA2_BOOTMOD bits */
-#define OMAP3_IVA2_BOOTMOD_SHIFT	0
-#define OMAP3_IVA2_BOOTMOD_MASK		(0xf << 0)
-#define OMAP3_IVA2_BOOTMOD_IDLE		(0x1 << 0)
-
 /* CONTROL_PADCONF_X bits */
 #define OMAP3_PADCONF_WAKEUPEVENT0	(1 << 15)
 #define OMAP3_PADCONF_WAKEUPENABLE0	(1 << 14)
@@ -280,7 +275,7 @@
 #define AM35XX_CPGMAC_FCLK_SHIFT        9
 #define AM35XX_VPFE_FCLK_SHIFT          10
 
-/*AM35XX CONTROL_LVL_INTR_CLEAR bits*/
+/* AM35XX CONTROL_LVL_INTR_CLEAR bits */
 #define AM35XX_CPGMAC_C0_MISC_PULSE_CLR	BIT(0)
 #define AM35XX_CPGMAC_C0_RX_PULSE_CLR	BIT(1)
 #define AM35XX_CPGMAC_C0_RX_THRESH_CLR	BIT(2)
@@ -290,7 +285,7 @@
 #define AM35XX_VPFE_CCDC_VD1_INT_CLR	BIT(6)
 #define AM35XX_VPFE_CCDC_VD2_INT_CLR	BIT(7)
 
-/*AM35XX CONTROL_IP_SW_RESET bits*/
+/* AM35XX CONTROL_IP_SW_RESET bits */
 #define AM35XX_USBOTGSS_SW_RST		BIT(0)
 #define AM35XX_CPGMACSS_SW_RST		BIT(1)
 #define AM35XX_VPFE_VBUSP_SW_RST	BIT(2)
@@ -330,6 +325,10 @@
 #define		FEAT_NEON		0
 #define		FEAT_NEON_NONE		1
 
+/*
+ * DSP booting-related constants
+ */
+#define OMAP_CTRL_DSP_BOOTADDR_MASK	0xfffffc00
 
 #ifndef __ASSEMBLY__
 #ifdef CONFIG_ARCH_OMAP2PLUS
@@ -351,6 +350,9 @@ extern u32 omap3_arm_context[128];
 extern void omap3_control_save_context(void);
 extern void omap3_control_restore_context(void);
 
+extern void omap2430_ctrl_set_dsp_bootaddr(u32 pa);
+extern void omap2430_ctrl_set_dsp_bootmode(u8 mode);
+
 #else
 #define omap_ctrl_base_get()		0
 #define omap_ctrl_readb(x)		0
diff --git a/arch/arm/plat-omap/include/plat/iva2_dsp.h b/arch/arm/plat-omap/include/plat/iva2_dsp.h
new file mode 100644
index 0000000..495c6a9
--- /dev/null
+++ b/arch/arm/plat-omap/include/plat/iva2_dsp.h
@@ -0,0 +1,56 @@
+/*
+ * OMAP2430/OMAP3 IVA2 DSP control headers
+ *
+ * Copyright (C) 2010 Nokia Corporation
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
+ * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write  to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef __ARCH_ARM_PLAT_OMAP_IVA2_DSP_H
+#define __ARCH_ARM_PLAT_OMAP_IVA2_DSP_H
+
+/*
+ * OMAP2430_IVA2_DSP_BOOTMODE_* values:
+ *
+ * Parameters for omap2430_ctrl_set_dsp_bootmode()
+ * (see e.g. OMAP34XX TRM revision ZH section 7.4.7.4
+ * "IVA2.2 Boot Registers"; OMAP2430 TRM revision Z table 7-181
+ * "CONTROL_IVA2_BOOTMOD")
+ *
+ * 0 is defined by the 2430 and 3xxx hardware to boot directly to the
+ * address supplied by omap2_ctrl_set_dsp_bootaddr().  The remainder
+ * of the values are firmware-dependent on the IVA2 ROM code.  Known
+ * values (from the 34XX TRM reference above) include 1, to boot to
+ * the DSP's ROM code and idle, waiting for interrupts; 2, to boot to
+ * the DSP's ROM code and spin in an idle loop; 3, to copy the user's
+ * bootstrap code from the DSP's internal memory and execute it (XXX
+ * how does the DSP know where to copy from?); and 4, to execute the
+ * DSP ROM code's context restore code.  It's unclear if all of these
+ * are present on 2430.
+ */
+#define OMAP_IVA2_DSP_BOOTMODE_USER		0
+#define OMAP_IVA2_DSP_BOOTMODE_IDLE		1
+#define OMAP_IVA2_DSP_BOOTMODE_BUSYLOOP		2
+#define OMAP_IVA2_DSP_BOOTMODE_COPY		3
+#define OMAP_IVA2_DSP_BOOTMODE_RESTORE		4
+
+#endif



From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/5] omap: control: add functions for DSP boot
Date: Sun,  7 Nov 2010 23:43:26 +0200
Message-ID: <1289166209-32251-3-git-send-email-felipe.contreras@gmail.com>
References: <AANLkTinZF-47WQyF5k1Nv64NjfMNSQ-+oE0eGycR24NM@mail.gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44122 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751711Ab0KGVoe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 7 Nov 2010 16:44:34 -0500
Received: by mail-fx0-f46.google.com with SMTP id 16so3600214fxm.19
        for <linux-omap@vger.kernel.org>; Sun, 07 Nov 2010 13:44:33 -0800 (PST)
In-Reply-To: <AANLkTinZF-47WQyF5k1Nv64NjfMNSQ-+oE0eGycR24NM@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>, Greg KH <greg@kroah.com>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

From: Paul Walmsley <paul@pwsan.com>

Add two functions for OMAP2430/OMAP3 IVA2 DSP boot control.  These
registers wound up in the System Control Module.  Other kernel code that
wishes to control the DSP's boot process should now use these functions
to do so; subsequent patches implement this in the two in-tree users of
these functions.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap2/control.c         |   49 +++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/control.h         |   10 +++---
 arch/arm/plat-omap/include/plat/dsp.h |    6 ++++
 3 files changed, 60 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 1fa3294..808abeb 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -209,6 +209,55 @@ void omap4_ctrl_pad_writel(u32 val, u16 offset)
 	__raw_writel(val, OMAP4_CTRL_PAD_REGADDR(offset));
 }
 
+/* OMAP DSP control functions */
+
+/**
+ * omap_ctrl_set_dsp_bootaddr - set the DSP's boot address
+ * @pa: DSP boot address (in physical memory)
+ *
+ * Set the DSP's boot address.  This is an address in physical memory.
+ * No return value.  XXX The TRM claims that this is an "index to a
+ * 4kByte page".  If so, why is the bitfield 21 bits wide, rather than
+ * 20?
+ */
+void omap_ctrl_set_dsp_bootaddr(u32 pa)
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
+ * omap_ctrl_set_dsp_bootmode - set the DSP's boot mode
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
+void omap_ctrl_set_dsp_bootmode(u8 mode)
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
index b6c6b7c..105ee00 100644
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
@@ -330,6 +325,8 @@
 #define		FEAT_NEON		0
 #define		FEAT_NEON_NONE		1
 
+/* DSP booting-related constants */
+#define OMAP_CTRL_DSP_BOOTADDR_MASK	0xfffffc00
 
 #ifndef __ASSEMBLY__
 #ifdef CONFIG_ARCH_OMAP2PLUS
@@ -351,6 +348,9 @@ extern u32 omap3_arm_context[128];
 extern void omap3_control_save_context(void);
 extern void omap3_control_restore_context(void);
 
+extern void omap_ctrl_set_dsp_bootaddr(u32 pa);
+extern void omap_ctrl_set_dsp_bootmode(u8 mode);
+
 #else
 #define omap_ctrl_base_get()		0
 #define omap_ctrl_readb(x)		0
diff --git a/arch/arm/plat-omap/include/plat/dsp.h b/arch/arm/plat-omap/include/plat/dsp.h
index 9c604b3..079691d 100644
--- a/arch/arm/plat-omap/include/plat/dsp.h
+++ b/arch/arm/plat-omap/include/plat/dsp.h
@@ -28,4 +28,10 @@ extern void omap_dsp_reserve_sdram_memblock(void);
 static inline void omap_dsp_reserve_sdram_memblock(void) { }
 #endif
 
+#define OMAP_DSP_BOOTMODE_USER		0
+#define OMAP_DSP_BOOTMODE_IDLE		1
+#define OMAP_DSP_BOOTMODE_BUSYLOOP		2
+#define OMAP_DSP_BOOTMODE_COPY		3
+#define OMAP_DSP_BOOTMODE_RESTORE		4
+
 #endif
-- 
1.7.3.2.3.gf8529


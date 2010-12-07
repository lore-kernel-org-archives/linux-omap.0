From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 09/14] OMAP3: control/PRCM: add omap3_ctrl_write_boot_mode()
Date: Mon, 06 Dec 2010 18:25:12 -0700
Message-ID: <20101207012511.3708.89350.stgit@twilight.localdomain>
References: <20101207012242.3708.45451.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41231 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753617Ab0LGBns (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Dec 2010 20:43:48 -0500
In-Reply-To: <20101207012242.3708.45451.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Get rid of the open-coded scratchpad write in mach-omap2/prcm.c and
replace it with an actual API, omap3_ctrl_write_boot_mode().  While
there, get rid of the gratuitous omap_writel().

There's not much documentation available for what should wind up in
the scratchpad here, so more documentation would be appreciated.
Also, at some point, we should formalize our treatment of the scratchpad;
right now, accesses to the scratchpad are not well-documented.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/control.c |   31 +++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/control.h |    1 +
 arch/arm/mach-omap2/prcm.c    |   10 +---------
 3 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 1fa3294..9fda3d7 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -209,6 +209,37 @@ void omap4_ctrl_pad_writel(u32 val, u16 offset)
 	__raw_writel(val, OMAP4_CTRL_PAD_REGADDR(offset));
 }
 
+#ifdef CONFIG_ARCH_OMAP3
+
+/**
+ * omap3_ctrl_write_boot_mode - set scratchpad boot mode for the next boot
+ * @bootmode: 8-bit value to pass to some boot code
+ *
+ * Set the bootmode in the scratchpad RAM.  This is used after the
+ * system restarts.  Not sure what actually uses this - it may be the
+ * bootloader, rather than the boot ROM - contrary to the preserved
+ * comment below.  No return value.
+ */
+void omap3_ctrl_write_boot_mode(u8 bootmode)
+{
+	u32 l;
+
+	l = ('B' << 24) | ('M' << 16) | bootmode;
+
+	/*
+	 * Reserve the first word in scratchpad for communicating
+	 * with the boot ROM. A pointer to a data structure
+	 * describing the boot process can be stored there,
+	 * cf. OMAP34xx TRM, Initialization / Software Booting
+	 * Configuration.
+	 *
+	 * XXX This should use some omap_ctrl_writel()-type function
+	 */
+	__raw_writel(l, OMAP2_L4_IO_ADDRESS(OMAP343X_SCRATCHPAD + 4));
+}
+
+#endif
+
 #if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_PM)
 /*
  * Clears the scratchpad contents in case of cold boot-
diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index b6c6b7c..a9325ad 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -350,6 +350,7 @@ extern u32 *get_es3_restore_pointer(void);
 extern u32 omap3_arm_context[128];
 extern void omap3_control_save_context(void);
 extern void omap3_control_restore_context(void);
+extern void omap3_ctrl_write_boot_mode(u8 bootmode);
 
 #else
 #define omap_ctrl_base_get()		0
diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index a51846e..2eca847 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -143,16 +143,8 @@ void omap_prcm_arch_reset(char mode, const char *cmd)
 
 		prcm_offs = WKUP_MOD;
 	} else if (cpu_is_omap34xx()) {
-		u32 l;
-
 		prcm_offs = OMAP3430_GR_MOD;
-		l = ('B' << 24) | ('M' << 16) | (cmd ? (u8)*cmd : 0);
-		/* Reserve the first word in scratchpad for communicating
-		 * with the boot ROM. A pointer to a data structure
-		 * describing the boot process can be stored there,
-		 * cf. OMAP34xx TRM, Initialization / Software Booting
-		 * Configuration. */
-		omap_writel(l, OMAP343X_SCRATCHPAD + 4);
+		omap3_ctrl_write_boot_mode((cmd ? (u8)*cmd : 0));
 	} else if (cpu_is_omap44xx())
 		prcm_offs = OMAP4430_PRM_DEVICE_MOD;
 	else



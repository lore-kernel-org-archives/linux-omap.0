From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 2/5] omap2plus: prm: Trvial build break fix for undefined reference to 'omap2_prm_read_mod_reg'
Date: Wed,  5 Jan 2011 16:27:01 +0530
Message-ID: <1294225024-21857-2-git-send-email-santosh.shilimkar@ti.com>
References: <1294225024-21857-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46059 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751810Ab1AEK5R (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Jan 2011 05:57:17 -0500
In-Reply-To: <1294225024-21857-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Paul Walmsley <paul@pwsan.com>

omap2plus_defocnfig build breaks when customised with only ARCH_OMAP4
selected. This is because common files make references to the functions
which are defined only for omap2xxx and omap3xxx.

 LD      .tmp_vmlinux1
arch/arm/mach-omap2/built-in.o: In function `pm_dbg_regset_store':
arch/arm/mach-omap2/pm-debug.c:335: undefined reference to `omap2_prm_read_mod_reg'
arch/arm/mach-omap2/built-in.o: In function `omap2_pm_dump':
arch/arm/mach-omap2/pm-debug.c:121: undefined reference to `omap2_prm_read_mod_reg'
arch/arm/mach-omap2/pm-debug.c:123: undefined reference to `omap2_prm_read_mod_reg'
arch/arm/mach-omap2/pm-debug.c:124: undefined reference to `omap2_prm_read_mod_reg'
arch/arm/mach-omap2/pm-debug.c:125: undefined reference to `omap2_prm_read_mod_reg'
arch/arm/mach-omap2/built-in.o: In function `omap_prcm_arch_reset':
arch/arm/mach-omap2/prcm.c:106: undefined reference to `omap2_prm_set_mod_reg_bits'
arch/arm/mach-omap2/prcm.c:108: undefined reference to `omap2_prm_read_mod_reg'
arch/arm/mach-omap2/built-in.o: In function `omap_prcm_get_reset_sources':
arch/arm/mach-omap2/prcm.c:53: undefined reference to `omap2_prm_read_mod_reg'
arch/arm/mach-omap2/built-in.o: In function `clkdm_clear_all_wkdeps':
arch/arm/mach-omap2/clockdomain.c:545: undefined reference to `omap2_prm_clear_mod_reg_bits'
arch/arm/mach-omap2/built-in.o: In function `clkdm_del_wkdep':
arch/arm/mach-omap2/clockdomain.c:475: undefined reference to `omap2_prm_clear_mod_reg_bits'
arch/arm/mach-omap2/built-in.o: In function `clkdm_read_wkdep':
arch/arm/mach-omap2/clockdomain.c:511: undefined reference to `omap2_prm_read_mod_bits_shift'
arch/arm/mach-omap2/built-in.o: In function `clkdm_add_wkdep':
arch/arm/mach-omap2/clockdomain.c:440: undefined reference to `omap2_prm_set_mod_reg_bits'
make: *** [.tmp_vmlinux1] Error 1

This patch adds stubs for these functions so that build continues to work.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/prm2xxx_3xxx.h |   63 +++++++++++++++++++++++++++++++++++-
 1 files changed, 62 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.h b/arch/arm/mach-omap2/prm2xxx_3xxx.h
index 53d44f6..843f329 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.h
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.h
@@ -228,7 +228,67 @@
 
 
 #ifndef __ASSEMBLER__
-
+/*
+ * Stub omap2xxx/omap3xxx functions so that common files
+ * continue to build when custom builds are used
+ */
+#if defined(CONFIG_ARCH_OMAP4) && !(defined(CONFIG_ARCH_OMAP2) ||	\
+					defined(CONFIG_ARCH_OMAP3))
+static inline u32 omap2_prm_read_mod_reg(s16 module, u16 idx)
+{
+	WARN_ONCE(1, "prm: omap2xxx/omap3xxx specific function and "
+		"not suppose to be used on omap4\n");
+	return 0;
+}
+static inline void omap2_prm_write_mod_reg(u32 val, s16 module, u16 idx)
+{
+	WARN_ONCE(1, "prm: omap2xxx/omap3xxx specific function and "
+		"not suppose to be used on omap4\n");
+}
+static inline u32 omap2_prm_rmw_mod_reg_bits(u32 mask, u32 bits,
+		s16 module, s16 idx)
+{
+	WARN_ONCE(1, "prm: omap2xxx/omap3xxx specific function and "
+		"not suppose to be used on omap4\n");
+	return 0;
+}
+static inline u32 omap2_prm_set_mod_reg_bits(u32 bits, s16 module, s16 idx)
+{
+	WARN_ONCE(1, "prm: omap2xxx/omap3xxx specific function and "
+		"not suppose to be used on omap4\n");
+	return 0;
+}
+static inline u32 omap2_prm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx)
+{
+	WARN_ONCE(1, "prm: omap2xxx/omap3xxx specific function and "
+		"not suppose to be used on omap4\n");
+	return 0;
+}
+static inline u32 omap2_prm_read_mod_bits_shift(s16 domain, s16 idx, u32 mask)
+{
+	WARN_ONCE(1, "prm: omap2xxx/omap3xxx specific function and "
+		"not suppose to be used on omap4\n");
+	return 0;
+}
+static inline int omap2_prm_is_hardreset_asserted(s16 prm_mod, u8 shift)
+{
+	WARN_ONCE(1, "prm: omap2xxx/omap3xxx specific function and "
+		"not suppose to be used on omap4\n");
+	return 0;
+}
+static inline int omap2_prm_assert_hardreset(s16 prm_mod, u8 shift)
+{
+	WARN_ONCE(1, "prm: omap2xxx/omap3xxx specific function and "
+		"not suppose to be used on omap4\n");
+	return 0;
+}
+static inline int omap2_prm_deassert_hardreset(s16 prm_mod, u8 shift)
+{
+	WARN_ONCE(1, "prm: omap2xxx/omap3xxx specific function and "
+		"not suppose to be used on omap4\n");
+	return 0;
+}
+#else
 /* Power/reset management domain register get/set */
 extern u32 omap2_prm_read_mod_reg(s16 module, u16 idx);
 extern void omap2_prm_write_mod_reg(u32 val, s16 module, u16 idx);
@@ -242,6 +302,7 @@ extern int omap2_prm_is_hardreset_asserted(s16 prm_mod, u8 shift);
 extern int omap2_prm_assert_hardreset(s16 prm_mod, u8 shift);
 extern int omap2_prm_deassert_hardreset(s16 prm_mod, u8 shift);
 
+#endif	/* CONFIG_ARCH_OMAP4 */
 #endif
 
 /*
-- 
1.6.0.4


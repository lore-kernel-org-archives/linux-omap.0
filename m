From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 2/5] omap2plus: prm: Trvial build break fix for undefined reference to 'omap2_prm_read_mod_reg'
Date: Tue,  4 Jan 2011 23:56:13 +0530
Message-ID: <1294165576-15628-3-git-send-email-santosh.shilimkar@ti.com>
References: <1294165576-15628-1-git-send-email-santosh.shilimkar@ti.com>
 <1294165576-15628-2-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38710 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751828Ab1ADS0y (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Jan 2011 13:26:54 -0500
In-Reply-To: <1294165576-15628-2-git-send-email-santosh.shilimkar@ti.com>
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

Probably alternately  the build can be fixed as below but that not seems to
be the right way.

----------------------------------------------------------------------

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/Makefile       |    2 +-
 arch/arm/mach-omap2/prm2xxx_3xxx.h |   45 +++++++++++++++++++++++++++++++++++-
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 4ab82f6..359a7f2 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -84,7 +84,7 @@ obj-$(CONFIG_ARCH_OMAP3)		+= prcm.o cm2xxx_3xxx.o prm2xxx_3xxx.o
 # use OMAP4-specific PRCM functions.
 obj-$(CONFIG_ARCH_OMAP4)		+= prcm.o cm2xxx_3xxx.o cminst44xx.o \
 					   cm44xx.o prcm_mpu44xx.o \
-					   prminst44xx.o
+					   prminst44xx.o prm2xxx_3xxx.o
 
 # OMAP powerdomain framework
 powerdomain-common			+= powerdomain.o powerdomain-common.o
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.h b/arch/arm/mach-omap2/prm2xxx_3xxx.h
index 53d44f6..517e077 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.h
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.h
@@ -228,7 +228,49 @@
 
 
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
+	return 0;
+}
+static inline void omap2_prm_write_mod_reg(u32 val, s16 module, u16 idx)
+{
+}
+static inline u32 omap2_prm_rmw_mod_reg_bits(u32 mask, u32 bits,
+		s16 module, s16 idx)
+{
+	return 0;
+}
+static inline u32 omap2_prm_set_mod_reg_bits(u32 bits, s16 module, s16 idx)
+{
+	return 0;
+}
+static inline u32 omap2_prm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx)
+{
+	return 0;
+}
+static inline u32 omap2_prm_read_mod_bits_shift(s16 domain, s16 idx, u32 mask)
+{
+	return 0;
+}
+static inline int omap2_prm_is_hardreset_asserted(s16 prm_mod, u8 shift)
+{
+	return 0;
+}
+static inline int omap2_prm_assert_hardreset(s16 prm_mod, u8 shift)
+{
+	return 0;
+}
+static inline int omap2_prm_deassert_hardreset(s16 prm_mod, u8 shift)
+{
+	return 0;
+}
+#else
 /* Power/reset management domain register get/set */
 extern u32 omap2_prm_read_mod_reg(s16 module, u16 idx);
 extern void omap2_prm_write_mod_reg(u32 val, s16 module, u16 idx);
@@ -242,6 +284,7 @@ extern int omap2_prm_is_hardreset_asserted(s16 prm_mod, u8 shift);
 extern int omap2_prm_assert_hardreset(s16 prm_mod, u8 shift);
 extern int omap2_prm_deassert_hardreset(s16 prm_mod, u8 shift);
 
+#endif	/* CONFIG_ARCH_OMAP4 */
 #endif
 
 /*
-- 
1.6.0.4


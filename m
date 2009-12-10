From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 1/6 v2] OMAP4: Fix cpu detection
Date: Thu, 10 Dec 2009 11:52:35 +0530
Message-ID: <1260426156-1820-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57975 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932840AbZLJGWy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Dec 2009 01:22:54 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch fixes the OMAP4430 cpu detection. The IC rev detection is
done with hawkeye and rev. Note that rev does not map directly to
defined processor revision numbers as ES1.0 uses value 0.It also fixes
the SCM base address to read the correct ID_CODE register.

Also the cpu_is_omap44xx() and cpu_is_omap443x() correctly populated
instead of always being true

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/id.c              |   27 ++++++++++++++++++++++++++-
 arch/arm/plat-omap/common.c           |    2 +-
 arch/arm/plat-omap/include/plat/cpu.h |    9 ++++++---
 3 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index f48a4b2..3641ba0 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -246,6 +246,31 @@ void __init omap3_check_revision(void)
 	}
 }
 
+void __init omap4_check_revision(void)
+{
+	u32 idcode;
+	u16 hawkeye;
+	u8 rev;
+	char *rev_name = "ES1.0";
+
+	/*
+	 * The IC rev detection is done with hawkeye and rev.
+	 * Note that rev does not map directly to defined processor
+	 * revision numbers as ES1.0 uses value 0.
+	 */
+	idcode = read_tap_reg(OMAP_TAP_IDCODE);
+	hawkeye = (idcode >> 12) & 0xffff;
+	rev = (idcode >> 28) & 0xff;
+
+	if ((hawkeye == 0xb852) && (rev == 0x0)) {
+		omap_revision = OMAP4430_REV_ES1_0;
+		pr_info("OMAP%04x %s\n", omap_rev() >> 16, rev_name);
+		return;
+	}
+
+	pr_err("Unknown OMAP4 CPU id\n");
+}
+
 #define OMAP3_SHOW_FEATURE(feat)		\
 	if (omap3_has_ ##feat())		\
 		printk(#feat" ");
@@ -336,7 +361,7 @@ void __init omap2_check_revision(void)
 		omap3_check_features();
 		omap3_cpuinfo();
 	} else if (cpu_is_omap44xx()) {
-		printk(KERN_INFO "FIXME: CPU revision = OMAP4430\n");
+		omap4_check_revision();
 		return;
 	} else {
 		pr_err("OMAP revision unknown, please fix!\n");
diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index cc050b3..3473a80 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -280,7 +280,7 @@ void __init omap2_set_globals_343x(void)
 #if defined(CONFIG_ARCH_OMAP4)
 static struct omap_globals omap4_globals = {
 	.class	= OMAP443X_CLASS,
-	.tap	= OMAP2_L4_IO_ADDRESS(0x4830a000),
+	.tap	= OMAP2_L4_IO_ADDRESS(OMAP443X_SCM_BASE),
 	.ctrl	= OMAP2_L4_IO_ADDRESS(OMAP443X_CTRL_BASE),
 	.prm	= OMAP2_L4_IO_ADDRESS(OMAP4430_PRM_BASE),
 	.cm	= OMAP2_L4_IO_ADDRESS(OMAP4430_CM_BASE),
diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 2e17890..9359785 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -176,11 +176,13 @@ IS_OMAP_CLASS(15xx, 0x15)
 IS_OMAP_CLASS(16xx, 0x16)
 IS_OMAP_CLASS(24xx, 0x24)
 IS_OMAP_CLASS(34xx, 0x34)
+IS_OMAP_CLASS(44xx, 0x44)
 
 IS_OMAP_SUBCLASS(242x, 0x242)
 IS_OMAP_SUBCLASS(243x, 0x243)
 IS_OMAP_SUBCLASS(343x, 0x343)
 IS_OMAP_SUBCLASS(363x, 0x363)
+IS_OMAP_SUBCLASS(443x, 0x443)
 
 #define cpu_is_omap7xx()		0
 #define cpu_is_omap15xx()		0
@@ -408,8 +410,8 @@ IS_OMAP_TYPE(3517, 0x3517)
 # if defined(CONFIG_ARCH_OMAP4)
 # undef cpu_is_omap44xx
 # undef cpu_is_omap443x
-# define cpu_is_omap44xx()		1
-# define cpu_is_omap443x()		1
+# define cpu_is_omap44xx()		is_omap44xx()
+# define cpu_is_omap443x()		is_omap443x()
 # endif
 
 /* Macros to detect if we have OMAP1 or OMAP2 */
@@ -443,7 +445,8 @@ IS_OMAP_TYPE(3517, 0x3517)
 #define OMAP3505_REV(v)		(OMAP35XX_CLASS | (0x3505 << 16) | (v << 12))
 #define OMAP3517_REV(v)		(OMAP35XX_CLASS | (0x3517 << 16) | (v << 12))
 
-#define OMAP443X_CLASS		0x44300034
+#define OMAP443X_CLASS		0x44300044
+#define OMAP4430_REV_ES1_0	0x44300044
 
 /*
  * omap_chip bits
-- 
1.6.0.4


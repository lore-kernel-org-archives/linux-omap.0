From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 1/6] OMAP4: Fix cpu detection
Date: Wed,  9 Dec 2009 23:59:05 +0530
Message-ID: <1260383350-32681-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51628 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756731AbZLIS31 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Dec 2009 13:29:27 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch fixes the OMAP4430 cpu detection. Since the omap ID
register is not fused in OMAP4430 ES1.0 silicon, identification is
done using ARM CPUID register.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/id.c              |   27 ++++++++++++++++++++++++++-
 arch/arm/plat-omap/common.c           |    2 +-
 arch/arm/plat-omap/include/plat/cpu.h |    3 ++-
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index f48a4b2..52c6478 100644
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
+	printk(KERN_ERR "Unknown OMAP CPU id\n");
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
index 2e17890..2a141ba 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -443,7 +443,8 @@ IS_OMAP_TYPE(3517, 0x3517)
 #define OMAP3505_REV(v)		(OMAP35XX_CLASS | (0x3505 << 16) | (v << 12))
 #define OMAP3517_REV(v)		(OMAP35XX_CLASS | (0x3517 << 16) | (v << 12))
 
-#define OMAP443X_CLASS		0x44300034
+#define OMAP443X_CLASS		0x44300044
+#define OMAP4430_REV_ES1_0	0x44300044
 
 /*
  * omap_chip bits
-- 
1.6.0.4


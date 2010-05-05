From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [RESEND PATCHv3 4/4] OMAP3: export chip IDCODE, Production ID and Die ID
Date: Wed,  5 May 2010 11:42:08 +0300
Message-ID: <1273048928-6105-5-git-send-email-eduardo.valentin@nokia.com>
References: <1273048928-6105-1-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:48929 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932189Ab0EEIl1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 04:41:27 -0400
In-Reply-To: <1273048928-6105-1-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, Linux-OMAP <linux-omap@vger.kernel.org>
Cc: ext Tony Lindgren <tony@atomide.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, "\\\"De-Schrijver Peter (Nokia-D/Helsinki)\\\"" <Peter.De-Schrijver@nokia.com>, santosh.shilimkar@ti.com, felipe.balbi@nokia.com, Eduardo Valentin <eduardo.valentin@nokia.com>

From: Eduardo Valentin <eduardo.valentin@nokia.com>

This patch exports the OMAP3 IDCODE and Production ID to userspace
via /proc/cpuinfo using the system_soc_info.

Die ID is also exported depending on what users pass as kernel
parameter. It is same protection mechanism made for x86 product
number. So, if user passes "omap3_die_id" parameter, it will append
die id code into /proc/cpuinfo as well. A Kconfig option has been
added as well, so it can be configurable during compilation time.

This can be used to track down silicon specific issues. The info is
exported via /proc/cpuinfo because then it can be possible to include this
in corematic dumps.

This is based on Peter De Schrijver patch, which export same info via sysfs.

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 Documentation/kernel-parameters.txt |    2 +
 arch/arm/mach-omap2/Kconfig         |   10 +++++++++
 arch/arm/mach-omap2/id.c            |   37 +++++++++++++++++++++++++++++++++-
 3 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 839b21b..6a84e6c 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1809,6 +1809,8 @@ and is between 256 and 4096 characters. It is defined in the file
 			waiting for the ACK, so if this is set too high
 			interrupts *may* be lost!
 
+	omap3_die_id	[OMAP] Append DIE ID info under /proc/cpuinfo
+
 	omap_mux=	[OMAP] Override bootloader pin multiplexing.
 			Format: <mux_mode0.mode_name=value>...
 			For example, to override I2C bus2:
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 2455dcc..462c23a 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -169,3 +169,13 @@ config OMAP3_SDRC_AC_TIMING
 	  wish to say no.  Selecting yes without understanding what is
 	  going on could result in system crashes;
 
+config OMAP3_EXPORT_DIE_ID
+	bool "Export DIE ID code under /proc/cpuinfo"
+	depends on ARCH_OMAP3
+	default n
+	help
+	  Say Y here if you need DIE ID code to be exported via /proc/cpuinfo
+	  in production systems. You will need also to explicitly flag it by
+	  appending the "omap3_die_id" parameter to your boot command line.
+
+
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 4702ffe..6fe554b 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -76,6 +76,10 @@ EXPORT_SYMBOL(omap_type);
 /*----------------------------------------------------------------------------*/
 
 #define OMAP_TAP_IDCODE		0x0204
+#define OMAP_TAP_PROD_ID_0      0x0208
+#define OMAP_TAP_PROD_ID_1      0x020c
+#define OMAP_TAP_PROD_ID_2      0x0210
+#define OMAP_TAP_PROD_ID_3      0x0214
 #define OMAP_TAP_DIE_ID_0	0x0218
 #define OMAP_TAP_DIE_ID_1	0x021C
 #define OMAP_TAP_DIE_ID_2	0x0220
@@ -303,6 +307,7 @@ void __init omap4_check_revision(void)
 
 void __init omap3_cpuinfo(void)
 {
+	int sz;
 	u8 rev = GET_OMAP_REVISION();
 	char cpu_name[16], cpu_rev[16];
 
@@ -360,8 +365,8 @@ void __init omap3_cpuinfo(void)
 	}
 
 	/* Print verbose information */
-	snprintf(system_soc_info, SYSTEM_SOC_INFO_SIZE, "%s ES%s", cpu_name,
-			cpu_rev);
+	sz = snprintf(system_soc_info, SYSTEM_SOC_INFO_SIZE, "%s ES%s",
+			cpu_name, cpu_rev);
 	pr_info("%s (", system_soc_info);
 
 	OMAP3_SHOW_FEATURE(l2cache);
@@ -372,7 +377,35 @@ void __init omap3_cpuinfo(void)
 	OMAP3_SHOW_FEATURE(192mhz_clk);
 
 	printk(")\n");
+
+	/* Append OMAP3 IDCODE and Production ID to system_soc_info */
+	snprintf(system_soc_info + sz, SYSTEM_SOC_INFO_SIZE - sz,
+			"\n\tIDCODE\t: %08x\n\tPr. ID\t: %08x %08x %08x %08x",
+			read_tap_reg(OMAP_TAP_IDCODE),
+			read_tap_reg(OMAP_TAP_PROD_ID_0),
+			read_tap_reg(OMAP_TAP_PROD_ID_1),
+			read_tap_reg(OMAP_TAP_PROD_ID_2),
+			read_tap_reg(OMAP_TAP_PROD_ID_3));
+
+}
+
+#ifdef CONFIG_OMAP3_EXPORT_DIE_ID
+static int __init omap3_die_id_setup(char *s)
+{
+	int sz;
+
+	sz = strlen(system_soc_info);
+	snprintf(system_soc_info + sz, SYSTEM_SOC_INFO_SIZE - sz,
+			"\n\tDie ID\t: %08x %08x %08x %08x",
+			read_tap_reg(OMAP_TAP_DIE_ID_0),
+			read_tap_reg(OMAP_TAP_DIE_ID_1),
+			read_tap_reg(OMAP_TAP_DIE_ID_2),
+			read_tap_reg(OMAP_TAP_DIE_ID_3));
+
+	return 1;
 }
+__setup("omap3_die_id", omap3_die_id_setup);
+#endif
 
 /*
  * Try to detect the exact revision of the omap we're running on
-- 
1.7.0.4.361.g8b5fe.dirty


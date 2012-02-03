From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH-V3 2/3] ARM: OMAP4: prminst: Add boot time __init function for prminst
Date: Fri, 3 Feb 2012 17:13:55 +0530
Message-ID: <1328269436-18668-3-git-send-email-hvaibhav@ti.com>
References: <1328269436-18668-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56443 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753366Ab2BCLs1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 3 Feb 2012 06:48:27 -0500
In-Reply-To: <1328269436-18668-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, rnayak@ti.com, tony@atomide.com, paul@pwsan.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>

AM33xx PRM module is closer to OMAP4 PRM module, and
in order to reuse prminst api's we have to address
some of the differences like, base addresses and partitions.
Unlike OMAP4 PRM, AM33xx doesn't have any partitions and
maintains single partition.

So, in order to reuse the existing OMAP4 prminst code
for AM33xx this patch adds,

  - Boot time __init function, to initialize _prm_bases
    based on cpu_is_xxx
  - Instead of maintaining phy addr for PRM partition
    in _prm_bases[] table and then changing it to virt addr,
    directly maintain respective virt addr.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
CC: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/io.c          |    2 ++
 arch/arm/mach-omap2/prminst44xx.c |   26 ++++++++++++++++++--------
 arch/arm/mach-omap2/prminst44xx.h |    2 +-
 3 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 2daaec1..aa33cfb 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -39,6 +39,7 @@
 #include <plat/omap-pm.h>
 #include "voltage.h"
 #include "powerdomain.h"
+#include "prminst44xx.h"

 #include "clockdomain.h"
 #include <plat/omap_hwmod.h>
@@ -486,6 +487,7 @@ void __init omap4430_init_early(void)
 	omap4xxx_check_features();
 	omap_common_init_early();
 	omap44xx_voltagedomains_init();
+	omap44xx_prminst_init();
 	omap44xx_powerdomains_init();
 	omap44xx_clockdomains_init();
 	omap44xx_hwmod_init();
diff --git a/arch/arm/mach-omap2/prminst44xx.c b/arch/arm/mach-omap2/prminst44xx.c
index f6de5bc..68e13bd 100644
--- a/arch/arm/mach-omap2/prminst44xx.c
+++ b/arch/arm/mach-omap2/prminst44xx.c
@@ -24,32 +24,34 @@
 #include "prcm44xx.h"
 #include "prcm_mpu44xx.h"

-static u32 _prm_bases[OMAP4_MAX_PRCM_PARTITIONS] = {
+static u32 **_prm_bases;
+static u32 max_prm_partitions;
+
+static u32 *omap44xx_prm_bases[] = {
 	[OMAP4430_INVALID_PRCM_PARTITION]	= 0,
-	[OMAP4430_PRM_PARTITION]		= OMAP4430_PRM_BASE,
+	[OMAP4430_PRM_PARTITION]		= OMAP2_L4_IO_ADDRESS(OMAP4430_PRM_BASE),
 	[OMAP4430_CM1_PARTITION]		= 0,
 	[OMAP4430_CM2_PARTITION]		= 0,
 	[OMAP4430_SCRM_PARTITION]		= 0,
-	[OMAP4430_PRCM_MPU_PARTITION]		= OMAP4430_PRCM_MPU_BASE,
+	[OMAP4430_PRCM_MPU_PARTITION]		= OMAP2_L4_IO_ADDRESS(OMAP4430_PRCM_MPU_BASE),
 };

 /* Read a register in a PRM instance */
 u32 omap4_prminst_read_inst_reg(u8 part, s16 inst, u16 idx)
 {
-	BUG_ON(part >= OMAP4_MAX_PRCM_PARTITIONS ||
+	BUG_ON(part >= max_prm_partitions ||
 	       part == OMAP4430_INVALID_PRCM_PARTITION ||
 	       !_prm_bases[part]);
-	return __raw_readl(OMAP2_L4_IO_ADDRESS(_prm_bases[part] + inst +
-					       idx));
+	return __raw_readl(_prm_bases[part] + ((inst + idx)/sizeof(u32)));
 }

 /* Write into a register in a PRM instance */
 void omap4_prminst_write_inst_reg(u32 val, u8 part, s16 inst, u16 idx)
 {
-	BUG_ON(part >= OMAP4_MAX_PRCM_PARTITIONS ||
+	BUG_ON(part >= max_prm_partitions ||
 	       part == OMAP4430_INVALID_PRCM_PARTITION ||
 	       !_prm_bases[part]);
-	__raw_writel(val, OMAP2_L4_IO_ADDRESS(_prm_bases[part] + inst + idx));
+	__raw_writel(val, _prm_bases[part] + ((inst + idx)/sizeof(u32)));
 }

 /* Read-modify-write a register in PRM. Caller must lock */
@@ -174,3 +176,11 @@ void omap4_prminst_global_warm_sw_reset(void)
 				    OMAP4430_PRM_DEVICE_INST,
 				    OMAP4_PRM_RSTCTRL_OFFSET);
 }
+
+void __init omap44xx_prminst_init(void)
+{
+	if (cpu_is_omap44xx()) {
+		_prm_bases = omap44xx_prm_bases;
+		max_prm_partitions = ARRAY_SIZE(omap44xx_prm_bases);
+	}
+}
diff --git a/arch/arm/mach-omap2/prminst44xx.h b/arch/arm/mach-omap2/prminst44xx.h
index 46f2efb..9a44c68 100644
--- a/arch/arm/mach-omap2/prminst44xx.h
+++ b/arch/arm/mach-omap2/prminst44xx.h
@@ -29,5 +29,5 @@ extern int omap4_prminst_assert_hardreset(u8 shift, u8 part, s16 inst,
 					  u16 rstctrl_offs);
 extern int omap4_prminst_deassert_hardreset(u8 shift, u8 part, s16 inst,
 					    u16 rstctrl_offs);
-
+extern void __init omap44xx_prminst_init(void);
 #endif
--
1.7.0.4


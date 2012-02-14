From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH 1/2] ARM: OMAP4: cminst: Add boot time __init function for cminst
Date: Tue, 14 Feb 2012 20:59:07 +0530
Message-ID: <1329233348-23356-2-git-send-email-hvaibhav@ti.com>
References: <1329233348-23356-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49991 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751178Ab2BNPfg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Feb 2012 10:35:36 -0500
In-Reply-To: <1329233348-23356-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, khilman@ti.com, rnayak@ti.com, tony@atomide.com, paul@pwsan.com, b-cousson@ti.com, Vaibhav Hiremath <hvaibhav@ti.com>

AM33xx CM module is closer to OMAP4 CM module, and
in order to reuse cminst api's we have to address
some of the differences like, base addresses and partitions.
Unlike OMAP4 CM, AM33xx doesn't have any partitions and
maintains only single partition.

So, in order to reuse the existing OMAP4 cminst code
for AM33xx this patch adds,

  - Boot time __init function, to initialize _cm_bases
    based on cpu_is_xxx
  - Instead of maintaining phy addr for CM partition
    in _cm_bases[] table and then changing it to virt addr,
    directly maintain respective virt addr.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
CC: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/cminst44xx.c |   29 ++++++++++++++++++++---------
 arch/arm/mach-omap2/cminst44xx.h |    1 +
 arch/arm/mach-omap2/io.c         |    2 ++
 3 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index 6204dea..f709708 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -49,13 +49,16 @@
 #define CLKCTRL_IDLEST_INTERFACE_IDLE		0x2
 #define CLKCTRL_IDLEST_DISABLED			0x3

-static u32 _cm_bases[OMAP4_MAX_PRCM_PARTITIONS] = {
+static u32 **_cm_bases;
+static u32 max_cm_partitions;
+
+static u32 *omap44xx_cm_bases[] = {
 	[OMAP4430_INVALID_PRCM_PARTITION]	= 0,
-	[OMAP4430_PRM_PARTITION]		= OMAP4430_PRM_BASE,
-	[OMAP4430_CM1_PARTITION]		= OMAP4430_CM1_BASE,
-	[OMAP4430_CM2_PARTITION]		= OMAP4430_CM2_BASE,
+	[OMAP4430_PRM_PARTITION]		= OMAP2_L4_IO_ADDRESS(OMAP4430_PRM_BASE),
+	[OMAP4430_CM1_PARTITION]		= OMAP2_L4_IO_ADDRESS(OMAP4430_CM1_BASE),
+	[OMAP4430_CM2_PARTITION]		= OMAP2_L4_IO_ADDRESS(OMAP4430_CM2_BASE),
 	[OMAP4430_SCRM_PARTITION]		= 0,
-	[OMAP4430_PRCM_MPU_PARTITION]		= OMAP4430_PRCM_MPU_BASE,
+	[OMAP4430_PRCM_MPU_PARTITION]		= OMAP2_L4_IO_ADDRESS(OMAP4430_PRCM_MPU_BASE),
 };

 /* Private functions */
@@ -103,19 +106,19 @@ static bool _is_module_ready(u8 part, u16 inst, s16 cdoffs, u16 clkctrl_offs)
 /* Read a register in a CM instance */
 u32 omap4_cminst_read_inst_reg(u8 part, s16 inst, u16 idx)
 {
-	BUG_ON(part >= OMAP4_MAX_PRCM_PARTITIONS ||
+	BUG_ON(part >= max_cm_partitions ||
 	       part == OMAP4430_INVALID_PRCM_PARTITION ||
 	       !_cm_bases[part]);
-	return __raw_readl(OMAP2_L4_IO_ADDRESS(_cm_bases[part] + inst + idx));
+	return __raw_readl(_cm_bases[part] + ((inst + idx)/sizeof(u32)));
 }

 /* Write into a register in a CM instance */
 void omap4_cminst_write_inst_reg(u32 val, u8 part, s16 inst, u16 idx)
 {
-	BUG_ON(part >= OMAP4_MAX_PRCM_PARTITIONS ||
+	BUG_ON(part >= max_cm_partitions ||
 	       part == OMAP4430_INVALID_PRCM_PARTITION ||
 	       !_cm_bases[part]);
-	__raw_writel(val, OMAP2_L4_IO_ADDRESS(_cm_bases[part] + inst + idx));
+	__raw_writel(val, _cm_bases[part] + ((inst + idx)/sizeof(u32)));
 }

 /* Read-modify-write a register in CM1. Caller must lock */
@@ -349,3 +352,11 @@ void omap4_cminst_module_disable(u8 part, u16 inst, s16 cdoffs,
 	v &= ~OMAP4430_MODULEMODE_MASK;
 	omap4_cminst_write_inst_reg(v, part, inst, clkctrl_offs);
 }
+
+void __init omap44xx_cminst_init(void)
+{
+	if (cpu_is_omap44xx()) {
+		_cm_bases = omap44xx_cm_bases;
+		max_cm_partitions = ARRAY_SIZE(omap44xx_cm_bases);
+	}
+}
diff --git a/arch/arm/mach-omap2/cminst44xx.h b/arch/arm/mach-omap2/cminst44xx.h
index a018a73..3d1bde1 100644
--- a/arch/arm/mach-omap2/cminst44xx.h
+++ b/arch/arm/mach-omap2/cminst44xx.h
@@ -63,4 +63,5 @@ extern u32 omap4_cminst_clear_inst_reg_bits(u32 bits, u8 part, s16 inst,
 extern u32 omap4_cminst_read_inst_reg_bits(u8 part, u16 inst, s16 idx,
 					   u32 mask);

+extern void __init omap44xx_cminst_init(void);
 #endif
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 50cf914..ebcc242 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -40,6 +40,7 @@
 #include "voltage.h"
 #include "powerdomain.h"
 #include "prminst44xx.h"
+#include "cminst44xx.h"

 #include "clockdomain.h"
 #include <plat/omap_hwmod.h>
@@ -492,6 +493,7 @@ void __init omap4430_init_early(void)
 	omap44xx_voltagedomains_init();
 	omap44xx_prminst_init();
 	omap44xx_powerdomains_init();
+	omap44xx_cminst_init();
 	omap44xx_clockdomains_init();
 	omap44xx_hwmod_init();
 	omap_hwmod_init_postsetup();
--
1.7.0.4


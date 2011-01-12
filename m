From: Rajendra Nayak <rnayak@ti.com>
Subject: [RFC 3/3] OMAP4: clockdomain: Add wkup/sleep dependency support
Date: Wed, 12 Jan 2011 18:16:11 +0530
Message-ID: <1294836371-17249-4-git-send-email-rnayak@ti.com>
References: <1294836371-17249-1-git-send-email-rnayak@ti.com>
 <1294836371-17249-2-git-send-email-rnayak@ti.com>
 <1294836371-17249-3-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40714 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756198Ab1ALMqT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Jan 2011 07:46:19 -0500
In-Reply-To: <1294836371-17249-3-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, Rajendra Nayak <rnayak@ti.com>

Add OMAP4 platform specific implementation to support clkdm
wkup and sleep dependencies a.k.a static dependencies.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clockdomain44xx.c |   52 +++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/cm44xx.h          |    1 +
 2 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain44xx.c b/arch/arm/mach-omap2/clockdomain44xx.c
index c0ccc47..594c25d 100644
--- a/arch/arm/mach-omap2/clockdomain44xx.c
+++ b/arch/arm/mach-omap2/clockdomain44xx.c
@@ -12,8 +12,52 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/kernel.h>
 #include "clockdomain.h"
 #include "cminst44xx.h"
+#include "cm44xx.h"
+
+static void omap4_clkdm_add_wkup_sleep_dep(struct clockdomain *clkdm1,
+					struct clockdomain *clkdm2)
+{
+	omap4_cminst_set_inst_reg_bits((1 << clkdm2->dep_bit),
+					clkdm1->prcm_partition,
+					clkdm1->cm_inst, OMAP4_CM_STATICDEP);
+}
+
+static void omap4_clkdm_del_wkup_sleep_dep(struct clockdomain *clkdm1,
+					struct clockdomain *clkdm2)
+{
+	omap4_cminst_clear_inst_reg_bits((1 << clkdm2->dep_bit),
+					clkdm1->prcm_partition,
+					clkdm1->cm_inst, OMAP4_CM_STATICDEP);
+}
+
+static int omap4_clkdm_read_wkup_sleep_dep(struct clockdomain *clkdm1,
+					struct clockdomain *clkdm2)
+{
+	return omap4_cminst_read_inst_reg_bits(clkdm1->prcm_partition,
+					clkdm1->cm_inst, OMAP4_CM_STATICDEP,
+					(1 << clkdm2->dep_bit));
+}
+
+static void omap4_clkdm_clear_all_wkup_sleep_deps(struct clockdomain *clkdm)
+{
+	struct clkdm_dep *cd;
+	u32 mask = 0;
+
+	for (cd = clkdm->wkdep_srcs; cd && cd->clkdm; cd++) {
+		if (!omap_chip_is(cd->omap_chip))
+			continue;
+
+		/* PRM accesses are slow, so minimize them */
+		mask |= 1 << cd->clkdm->dep_bit;
+		atomic_set(&cd->wkdep_usecount, 0);
+	}
+
+	omap4_cminst_clear_inst_reg_bits(mask, clkdm->prcm_partition,
+					clkdm->cm_inst, OMAP4_CM_STATICDEP);
+}
 
 static int omap4_clkdm_sleep(struct clockdomain *clkdm)
 {
@@ -68,6 +112,14 @@ static int omap4_clkdm_clk_disable(struct clockdomain *clkdm)
 }
 
 struct clkdm_ops omap4_clkdm_operations = {
+	.clkdm_add_wkdep	= omap4_clkdm_add_wkup_sleep_dep,
+	.clkdm_del_wkdep	= omap4_clkdm_del_wkup_sleep_dep,
+	.clkdm_read_wkdep	= omap4_clkdm_read_wkup_sleep_dep,
+	.clkdm_clear_all_wkdeps	= omap4_clkdm_clear_all_wkup_sleep_deps,
+	.clkdm_add_sleepdep	= omap4_clkdm_add_wkup_sleep_dep,
+	.clkdm_del_sleepdep	= omap4_clkdm_del_wkup_sleep_dep,
+	.clkdm_read_sleepdep	= omap4_clkdm_read_wkup_sleep_dep,
+	.clkdm_clear_all_sleepdeps	= omap4_clkdm_clear_all_wkup_sleep_deps,
 	.clkdm_sleep		= omap4_clkdm_sleep,
 	.clkdm_wakeup		= omap4_clkdm_wakeup,
 	.clkdm_allow_idle	= omap4_clkdm_allow_idle,
diff --git a/arch/arm/mach-omap2/cm44xx.h b/arch/arm/mach-omap2/cm44xx.h
index 48fc3f4..4d0cfd3 100644
--- a/arch/arm/mach-omap2/cm44xx.h
+++ b/arch/arm/mach-omap2/cm44xx.h
@@ -21,6 +21,7 @@
 #include "cm.h"
 
 #define OMAP4_CM_CLKSTCTRL				0x0000
+#define OMAP4_CM_STATICDEP				0x4
 
 /* Function prototypes */
 # ifndef __ASSEMBLER__
-- 
1.7.0.4


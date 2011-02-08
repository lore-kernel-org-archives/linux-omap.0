From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 3/3] OMAP4: clockdomain: Add wkup/sleep dependency
 support
Date: Tue, 8 Feb 2011 16:52:01 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102081649540.21991@utopia.booyaka.com>
References: <1297084631-27474-1-git-send-email-rnayak@ti.com> <1297084631-27474-2-git-send-email-rnayak@ti.com> <1297084631-27474-3-git-send-email-rnayak@ti.com> <1297084631-27474-4-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54534 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755919Ab1BHXwC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Feb 2011 18:52:02 -0500
In-Reply-To: <1297084631-27474-4-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org

On Mon, 7 Feb 2011, Rajendra Nayak wrote:

> Add OMAP4 platform specific implementation to support clkdm
> wkup and sleep dependencies a.k.a static dependencies.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

I made two minor changes to this before merging: one to keep the 
formatting of the OMAP4_CM_STATICDEP macro value consistent with the 
previous value; the other to remove the comment referring to the PRM.  
The revised patch is below.


- Paul

From: Rajendra Nayak <rnayak@ti.com>
Date: Tue, 8 Feb 2011 14:28:22 -0700
Subject: [PATCH] OMAP4: clockdomain: Add wkup/sleep dependency support

Add OMAP4 platform specific implementation to support clkdm
wkup and sleep dependencies a.k.a static dependencies.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
[paul@pwsan.com: removed comment about PRM; zero-prefixed STATICDEP
 register offset]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clockdomain44xx.c |   58 +++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/cm44xx.h          |    1 +
 2 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain44xx.c b/arch/arm/mach-omap2/clockdomain44xx.c
index c0ccc47..e3c6522 100644
--- a/arch/arm/mach-omap2/clockdomain44xx.c
+++ b/arch/arm/mach-omap2/clockdomain44xx.c
@@ -12,8 +12,58 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/kernel.h>
 #include "clockdomain.h"
 #include "cminst44xx.h"
+#include "cm44xx.h"
+
+static int omap4_clkdm_add_wkup_sleep_dep(struct clockdomain *clkdm1,
+					struct clockdomain *clkdm2)
+{
+	omap4_cminst_set_inst_reg_bits((1 << clkdm2->dep_bit),
+					clkdm1->prcm_partition,
+					clkdm1->cm_inst, clkdm1->clkdm_offs +
+					OMAP4_CM_STATICDEP);
+	return 0;
+}
+
+static int omap4_clkdm_del_wkup_sleep_dep(struct clockdomain *clkdm1,
+					struct clockdomain *clkdm2)
+{
+	omap4_cminst_clear_inst_reg_bits((1 << clkdm2->dep_bit),
+					clkdm1->prcm_partition,
+					clkdm1->cm_inst, clkdm1->clkdm_offs +
+					OMAP4_CM_STATICDEP);
+	return 0;
+}
+
+static int omap4_clkdm_read_wkup_sleep_dep(struct clockdomain *clkdm1,
+					struct clockdomain *clkdm2)
+{
+	return omap4_cminst_read_inst_reg_bits(clkdm1->prcm_partition,
+					clkdm1->cm_inst, clkdm1->clkdm_offs +
+					OMAP4_CM_STATICDEP,
+					(1 << clkdm2->dep_bit));
+}
+
+static int omap4_clkdm_clear_all_wkup_sleep_deps(struct clockdomain *clkdm)
+{
+	struct clkdm_dep *cd;
+	u32 mask = 0;
+
+	for (cd = clkdm->wkdep_srcs; cd && cd->clkdm; cd++) {
+		if (!omap_chip_is(cd->omap_chip))
+			continue;
+
+		mask |= 1 << cd->clkdm->dep_bit;
+		atomic_set(&cd->wkdep_usecount, 0);
+	}
+
+	omap4_cminst_clear_inst_reg_bits(mask, clkdm->prcm_partition,
+					clkdm->cm_inst, clkdm->clkdm_offs +
+					OMAP4_CM_STATICDEP);
+	return 0;
+}
 
 static int omap4_clkdm_sleep(struct clockdomain *clkdm)
 {
@@ -68,6 +118,14 @@ static int omap4_clkdm_clk_disable(struct clockdomain *clkdm)
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
index 48fc3f4..0b87ec8 100644
--- a/arch/arm/mach-omap2/cm44xx.h
+++ b/arch/arm/mach-omap2/cm44xx.h
@@ -21,6 +21,7 @@
 #include "cm.h"
 
 #define OMAP4_CM_CLKSTCTRL				0x0000
+#define OMAP4_CM_STATICDEP				0x0004
 
 /* Function prototypes */
 # ifndef __ASSEMBLER__
-- 
1.7.2.3


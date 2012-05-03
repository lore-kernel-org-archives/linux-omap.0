From: R Sricharan <r.sricharan@ti.com>
Subject: [PATCH 03/13] TEMP: ARM: OMAP5: Add cpu_is_omap54xx() checks.
Date: Thu, 3 May 2012 12:56:12 +0530
Message-ID: <1336029982-31898-4-git-send-email-r.sricharan@ti.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39604 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755556Ab2ECH0j (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 May 2012 03:26:39 -0400
In-Reply-To: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, tony@atomide.com, b-cousson@ti.com, r.sricharan@ti.com

Not for merge.

Adding the cpu_is_omap54xx checks at relevant places
for that part of code to execute on OMAP5 socs as well.

This patch will no longer be needed once rebased on
top of below series from Kevin Hilman <khilman@ti.com>

http://www.spinics.net/lists/linux-omap/msg69013.html

Signed-off-by: R Sricharan <r.sricharan@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 7144ae6..4063a8c 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1221,7 +1221,7 @@ static int _wait_target_ready(struct omap_hwmod *oh)
 		ret = omap2_cm_wait_module_ready(oh->prcm.omap2.module_offs,
 						 oh->prcm.omap2.idlest_reg_id,
 						 oh->prcm.omap2.idlest_idle_bit);
-	} else if (cpu_is_omap44xx()) {
+	} else if (cpu_is_omap44xx() || cpu_is_omap54xx()) {
 		if (!oh->clkdm)
 			return -EINVAL;
 
@@ -1291,13 +1291,16 @@ static int _assert_hardreset(struct omap_hwmod *oh, const char *name)
 	if (cpu_is_omap24xx() || cpu_is_omap34xx())
 		return omap2_prm_assert_hardreset(oh->prcm.omap2.module_offs,
 						  ohri.rst_shift);
-	else if (cpu_is_omap44xx())
+	else if (cpu_is_omap44xx() || cpu_is_omap54xx()) {
 		return omap4_prminst_assert_hardreset(ohri.rst_shift,
 				  oh->clkdm->pwrdm.ptr->prcm_partition,
 				  oh->clkdm->pwrdm.ptr->prcm_offs,
 				  oh->prcm.omap4.rstctrl_offs);
-	else
+	} else {
 		return -EINVAL;
+	}
+
+	return ret;
 }
 
 /**
@@ -1326,9 +1329,9 @@ static int _deassert_hardreset(struct omap_hwmod *oh, const char *name)
 		ret = omap2_prm_deassert_hardreset(oh->prcm.omap2.module_offs,
 						   ohri.rst_shift,
 						   ohri.st_shift);
-	} else if (cpu_is_omap44xx()) {
+	} else if (cpu_is_omap44xx() || cpu_is_omap54xx()) {
 		if (ohri.st_shift)
-			pr_err("omap_hwmod: %s: %s: hwmod data error: OMAP4 does not support st_shift\n",
+			pr_err("omap_hwmod: %s: %s: hwmod data error: OMAP4+ does not support st_shift\n",
 			       oh->name, name);
 		ret = omap4_prminst_deassert_hardreset(ohri.rst_shift,
 				  oh->clkdm->pwrdm.ptr->prcm_partition,
@@ -1367,7 +1370,7 @@ static int _read_hardreset(struct omap_hwmod *oh, const char *name)
 	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
 		return omap2_prm_is_hardreset_asserted(oh->prcm.omap2.module_offs,
 						       ohri.st_shift);
-	} else if (cpu_is_omap44xx()) {
+	} else if (cpu_is_omap44xx() || cpu_is_omap54xx()) {
 		return omap4_prminst_is_hardreset_asserted(ohri.rst_shift,
 				  oh->clkdm->pwrdm.ptr->prcm_partition,
 				  oh->clkdm->pwrdm.ptr->prcm_offs,
-- 
1.7.1


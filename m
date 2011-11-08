From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH] ARM: omap: Fix omap_prcm_get_reset_sources() for omap3/4
Date: Tue, 8 Nov 2011 14:28:23 +0530
Message-ID: <1320742703-18090-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40168 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750710Ab1KHI6k (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Nov 2011 03:58:40 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id pA88wb6H031380
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 8 Nov 2011 02:58:39 -0600
Received: from DBDE71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id pA88waSP019079
	for <linux-omap@vger.kernel.org>; Tue, 8 Nov 2011 14:28:36 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>, Gina Glaser <g-glaser@ti.com>, Benoit Cousson <b-cousson@ti.com>

Fix omap_prcm_get_reset_sources() for omap3 to look into the
right register, and for omap4 to use the right api (and hence
look into the right register).

With this, get rid of some of the unused and also wrongly
defined macros for OMAP4.

Thanks to Gina Glaser for identifying the issue with the
offset macros for OMAP4_RM_RSTST and OMAP4_RM_RSTTIME being
swapped, which resulted in this patch.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Gina Glaser <g-glaser@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/prcm.c    |   12 ++++++++----
 arch/arm/mach-omap2/prm44xx.h |    3 ---
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 597e2da..bb19393 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -37,7 +37,7 @@
 #include "prm44xx.h"
 #include "prminst44xx.h"
 #include "prm-regbits-24xx.h"
-#include "prm-regbits-44xx.h"
+#include "prcm44xx.h"
 #include "control.h"
 
 void __iomem *prm_base;
@@ -48,11 +48,15 @@ void __iomem *cm2_base;
 
 u32 omap_prcm_get_reset_sources(void)
 {
-	/* XXX This presumably needs modification for 34XX */
-	if (cpu_is_omap24xx() || cpu_is_omap34xx())
+	if (cpu_is_omap24xx())
 		return omap2_prm_read_mod_reg(WKUP_MOD, OMAP2_RM_RSTST) & 0x7f;
+	if (cpu_is_omap34xx())
+		return omap2_prm_read_mod_reg(OMAP3430_GR_MOD,
+					      OMAP3_PRM_RSTST_OFFSET) & 0x7ff;
 	if (cpu_is_omap44xx())
-		return omap2_prm_read_mod_reg(WKUP_MOD, OMAP4_RM_RSTST) & 0x7f;
+		return omap4_prminst_read_inst_reg(OMAP4430_PRM_PARTITION,
+					      OMAP4430_PRM_DEVICE_INST,
+					      OMAP4_PRM_RSTST_OFFSET) & 0x7ff;
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/prm44xx.h b/arch/arm/mach-omap2/prm44xx.h
index 3d66ccd..b6ac13f 100644
--- a/arch/arm/mach-omap2/prm44xx.h
+++ b/arch/arm/mach-omap2/prm44xx.h
@@ -61,9 +61,6 @@
 #define OMAP4430_PRM_EMU_CM_EMU_CDOFFS		0x0000
 
 /* OMAP4 specific register offsets */
-#define OMAP4_RM_RSTCTRL				0x0000
-#define OMAP4_RM_RSTTIME				0x0004
-#define OMAP4_RM_RSTST					0x0008
 #define OMAP4_PM_PWSTCTRL				0x0000
 #define OMAP4_PM_PWSTST					0x0004
 
-- 
1.7.1


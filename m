From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH 2/2] ARM: omap: Fix omap_prcm_get_reset_sources() for omap3/4
Date: Mon, 23 Jan 2012 16:43:08 +0530
Message-ID: <1327317188-14782-3-git-send-email-shubhrajyoti@ti.com>
References: <1327317188-14782-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38997 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752770Ab2AWLNV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Jan 2012 06:13:21 -0500
In-Reply-To: <1327317188-14782-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-watchdog@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Shubhrajyoti D <shubhrajyoti@ti.com>, Gina Glaser <g-glaser@ti.com>, Benoit Cousson <b-cousson@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

Fix omap_prcm_get_reset_sources() for omap3 to look into the
right register, and for omap4 to use the right api (and hence
look into the right register).

With this, get rid of some of the unused and also wrongly
defined macros for OMAP4.

Thanks to Gina Glaser for identifying the issue with the
offset macros for OMAP4_RM_RSTST and OMAP4_RM_RSTTIME being
swapped, which resulted in this patch.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: Gina Glaser <g-glaser@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/prcm.c    |   13 ++++++++-----
 arch/arm/mach-omap2/prm44xx.h |    3 ---
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 626acfa..d855f40 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -36,7 +36,7 @@
 #include "prm44xx.h"
 #include "prminst44xx.h"
 #include "prm-regbits-24xx.h"
-#include "prm-regbits-44xx.h"
+#include "prcm44xx.h"
 #include "control.h"
 
 void __iomem *prm_base;
@@ -47,12 +47,15 @@ void __iomem *cm2_base;
 
 u32 omap_prcm_get_reset_sources(void)
 {
-	/* XXX This presumably needs modification for 34XX */
-	if (cpu_is_omap24xx() || cpu_is_omap34xx())
+	if (cpu_is_omap24xx())
 		return omap2_prm_read_mod_reg(WKUP_MOD, OMAP2_RM_RSTST) & 0x7f;
+	if (cpu_is_omap34xx())
+		return omap2_prm_read_mod_reg(OMAP3430_GR_MOD,
+				OMAP3_PRM_RSTST_OFFSET) & 0x7ff;
 	if (cpu_is_omap44xx())
-		return omap2_prm_read_mod_reg(WKUP_MOD, OMAP4_RM_RSTST) & 0x7f;
-
+		return omap4_prminst_read_inst_reg(OMAP4430_PRM_PARTITION,
+				OMAP4430_PRM_DEVICE_INST,
+				OMAP4_PRM_RSTST_OFFSET) & 0x7ff;
 	return 0;
 }
 EXPORT_SYMBOL(omap_prcm_get_reset_sources);
diff --git a/arch/arm/mach-omap2/prm44xx.h b/arch/arm/mach-omap2/prm44xx.h
index 7978092..41353e4 100644
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


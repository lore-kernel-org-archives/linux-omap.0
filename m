From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 4/4] OMAP4: prcm: Fix global warm reset bit position
Date: Wed,  4 Aug 2010 23:38:30 +0200
Message-ID: <1280957910-22718-5-git-send-email-b-cousson@ti.com>
References: <1280957910-22718-1-git-send-email-b-cousson@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57741 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751186Ab0HDVip (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 Aug 2010 17:38:45 -0400
In-Reply-To: <1280957910-22718-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, paul@pwsan.com
Cc: rnayak@ti.com, santosh.shilimkar@ti.com, Rajeev Kulkarni <rajeevk@ti.com>, Leed Aguilar <leed.aguilar@ti.com>, Benoit Cousson <b-cousson@ti.com>

From: Rajeev Kulkarni <rajeevk@ti.com>

OMAP4 platform has different register bits for Warm and Cold Resets.
Write one into appropriate bits.

Signed-off-by: Rajeev Kulkarni <rajeevk@ti.com>
Cc: Leed Aguilar <leed.aguilar@ti.com>
[b-cousson@ti.com: Change the define with the proper one from omap4 headers]
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/prcm.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index c201374..96f4616 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -33,6 +33,7 @@
 #include "cm.h"
 #include "prm.h"
 #include "prm-regbits-24xx.h"
+#include "prm-regbits-44xx.h"
 
 static void __iomem *prm_base;
 static void __iomem *cm_base;
@@ -161,8 +162,8 @@ void omap_prcm_arch_reset(char mode, const char *cmd)
 		prm_set_mod_reg_bits(OMAP_RST_DPLL3_MASK, prcm_offs,
 						 OMAP2_RM_RSTCTRL);
 	if (cpu_is_omap44xx())
-		prm_set_mod_reg_bits(OMAP_RST_DPLL3_MASK, prcm_offs,
-						 OMAP4_RM_RSTCTRL);
+		prm_set_mod_reg_bits(OMAP4430_RST_GLOBAL_WARM_SW_MASK,
+				     prcm_offs, OMAP4_RM_RSTCTRL);
 }
 
 static inline u32 __omap_prcm_read(void __iomem *base, s16 module, u16 reg)
-- 
1.6.1.3


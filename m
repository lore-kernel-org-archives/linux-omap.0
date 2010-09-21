From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 04/11] OMAP4: prcm: Fix global warm reset bit position
Date: Tue, 21 Sep 2010 10:34:46 -0600
Message-ID: <20100921163445.20258.92292.stgit@twilight.localdomain>
References: <20100921163021.20258.87587.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47029 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754498Ab0IUQfk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Sep 2010 12:35:40 -0400
In-Reply-To: <20100921163021.20258.87587.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Leed Aguilar <leed.aguilar@ti.com>, Rajeev Kulkarni <rajeevk@ti.com>, Benoit Cousson <b-cousson@ti.com>

From: Rajeev Kulkarni <rajeevk@ti.com>

OMAP4 platform has different register bits for Warm and Cold Resets.
Write one into appropriate bits.

Signed-off-by: Rajeev Kulkarni <rajeevk@ti.com>
Cc: Leed Aguilar <leed.aguilar@ti.com>
[b-cousson@ti.com: Change the define with the proper one from omap4 headers]
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
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



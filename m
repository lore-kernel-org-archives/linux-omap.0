From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 18/18] ARM: OMAP5: PM: handle device instance for warm reset
Date: Mon, 25 Mar 2013 15:35:10 +0530
Message-ID: <1364205910-32392-19-git-send-email-santosh.shilimkar@ti.com>
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42670 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754168Ab3CYKET (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Mar 2013 06:04:19 -0400
In-Reply-To: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com, tony@atomide.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Nishanth Menon <nm@ti.com>

OMAP5 and OMAP4 have different device instance offsets.

So to handle them properly, use a runtime detected instance offset
Other bit offsets and register offsets remained constant.

Creating a new function is not really worthwhile here as the logic
will be replicated without much benefit.

Signed-off-by: Nishanth Menon <nm@ti.com>
[santosh.shilimkar@ti.com: Refreshed patch against 3.9]
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/prminst44xx.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/prminst44xx.c b/arch/arm/mach-omap2/prminst44xx.c
index c12320c..430fb1d 100644
--- a/arch/arm/mach-omap2/prminst44xx.c
+++ b/arch/arm/mach-omap2/prminst44xx.c
@@ -20,10 +20,12 @@
 #include "common.h"
 #include "prcm-common.h"
 #include "prm44xx.h"
+#include "prm54xx.h"
 #include "prminst44xx.h"
 #include "prm-regbits-44xx.h"
 #include "prcm44xx.h"
 #include "prcm_mpu44xx.h"
+#include "soc.h"
 
 static void __iomem *_prm_bases[OMAP4_MAX_PRCM_PARTITIONS];
 
@@ -165,17 +167,19 @@ int omap4_prminst_deassert_hardreset(u8 shift, u8 part, s16 inst,
 void omap4_prminst_global_warm_sw_reset(void)
 {
 	u32 v;
+	s16 dev_inst = cpu_is_omap44xx() ? OMAP4430_PRM_DEVICE_INST :
+					   OMAP54XX_PRM_DEVICE_INST;
 
 	v = omap4_prminst_read_inst_reg(OMAP4430_PRM_PARTITION,
-				    OMAP4430_PRM_DEVICE_INST,
+				    dev_inst,
 				    OMAP4_PRM_RSTCTRL_OFFSET);
 	v |= OMAP4430_RST_GLOBAL_WARM_SW_MASK;
 	omap4_prminst_write_inst_reg(v, OMAP4430_PRM_PARTITION,
-				 OMAP4430_PRM_DEVICE_INST,
+				 dev_inst,
 				 OMAP4_PRM_RSTCTRL_OFFSET);
 
 	/* OCP barrier */
 	v = omap4_prminst_read_inst_reg(OMAP4430_PRM_PARTITION,
-				    OMAP4430_PRM_DEVICE_INST,
+				    dev_inst,
 				    OMAP4_PRM_RSTCTRL_OFFSET);
 }
-- 
1.7.9.5


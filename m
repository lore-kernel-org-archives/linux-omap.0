From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v1 02/14] ARM: OMAP: counter-32k: Select the CR register offset using the IP scheme.
Date: Thu, 5 Jul 2012 17:38:41 +0530
Message-ID: <1341490136-25901-4-git-send-email-santosh.shilimkar@ti.com>
References: <1341490136-25901-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56040 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753630Ab2GEMKi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 Jul 2012 08:10:38 -0400
In-Reply-To: <1341490136-25901-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, R Sricharan <r.sricharan@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: R Sricharan <r.sricharan@ti.com>

OMAP socs has a legacy and a highlander version of the
32k sync counter IP. The register offsets vary between the
highlander and the legacy scheme. So use the 'SCHEME'
bits(30-31) of the revision register to distinguish between
the two versions and choose the CR register offset accordingly.

Signed-off-by: R Sricharan <r.sricharan@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/plat-omap/counter_32k.c |   16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
index 2132c4f..dbf1e03 100644
--- a/arch/arm/plat-omap/counter_32k.c
+++ b/arch/arm/plat-omap/counter_32k.c
@@ -29,7 +29,10 @@
 #include <plat/clock.h>
 
 /* OMAP2_32KSYNCNT_CR_OFF: offset of 32ksync counter register */
-#define OMAP2_32KSYNCNT_CR_OFF		0x10
+#define OMAP2_32KSYNCNT_REV_OFF		0x0
+#define OMAP2_32KSYNCNT_REV_SCHEME	(0x3 << 30)
+#define OMAP2_32KSYNCNT_CR_OFF_LOW	0x10
+#define OMAP2_32KSYNCNT_CR_OFF_HIGH	0x30
 
 /*
  * 32KHz clocksource ... always available, on pretty most chips except
@@ -84,9 +87,16 @@ int __init omap_init_clocksource_32k(void __iomem *vbase)
 	int ret;
 
 	/*
-	 * 32k sync Counter register offset is at 0x10
+	 * 32k sync Counter IP register offsets vary between the
+	 * highlander version and the legacy ones.
+	 * The 'SCHEME' bits(30-31) of the revision register is used
+	 * to identify the version.
 	 */
-	sync32k_cnt_reg = vbase + OMAP2_32KSYNCNT_CR_OFF;
+	if (__raw_readl(vbase + OMAP2_32KSYNCNT_REV_OFF) &
+						OMAP2_32KSYNCNT_REV_SCHEME)
+		sync32k_cnt_reg = vbase + OMAP2_32KSYNCNT_CR_OFF_HIGH;
+	else
+		sync32k_cnt_reg = vbase + OMAP2_32KSYNCNT_CR_OFF_LOW;
 
 	/*
 	 * 120000 rough estimate from the calculations in
-- 
1.7.9.5


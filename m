From: R Sricharan <r.sricharan@ti.com>
Subject: [PATCH 4/4] ARM: OMAP: counter-32k: Select the CR register offset using the IP scheme.
Date: Thu, 10 May 2012 22:36:55 +0530
Message-ID: <1336669615-16454-5-git-send-email-r.sricharan@ti.com>
References: <1336669615-16454-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47787 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754330Ab2EJRHN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 May 2012 13:07:13 -0400
In-Reply-To: <1336669615-16454-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, tony@atomide.com, b-cousson@ti.com, r.sricharan@ti.com, paul@pswan.com

OMAP socs has a legacy and a highlander version of the
32k sync counter IP. The register offsets vary between the
highlander and the legacy scheme. So use the 'SCHEME'
bits(30-31) of the revision register to distinguish between
the two versions and choose the CR register offset accordingly.

Signed-off-by: R Sricharan <r.sricharan@ti.com>
---
 arch/arm/plat-omap/counter_32k.c |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
index b2f634b..cbd939d 100644
--- a/arch/arm/plat-omap/counter_32k.c
+++ b/arch/arm/plat-omap/counter_32k.c
@@ -28,7 +28,10 @@
 #include <plat/clock.h>
 
 /* OMAP2_32KSYNCNT_CR_OFF: offset of 32ksync counter register */
-#define OMAP2_32KSYNCNT_CR_OFF		0x10
+#define OMAP2_32KSYNCNT_REV_OFF		0x0
+#define OMAP2_32KSYNCNT_REV_SCHEME	(0x3 << 30)
+#define OMAP2_32KSYNCNT_CR_OFF_LOW	0x10
+#define OMAP2_32KSYNCNT_CR_OFF_HIGH	0x30
 
 /*
  * 32KHz clocksource ... always available, on pretty most chips except
@@ -83,9 +86,16 @@ int __init omap_init_clocksource_32k(void __iomem *vbase)
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
1.7.1


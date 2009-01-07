From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [OMAPZOOM][PATCH] OMAP3: PM: SRAM: Fixes build without TI PM enabled
Date: Tue, 6 Jan 2009 19:01:10 -0600
Message-ID: <A24693684029E5489D1D202277BE8944163282D2@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49304 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758165AbZAGBBS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jan 2009 20:01:18 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n0711CTJ023163
	for <linux-omap@vger.kernel.org>; Tue, 6 Jan 2009 19:01:17 -0600
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n0711CP3018586
	for <linux-omap@vger.kernel.org>; Tue, 6 Jan 2009 19:01:12 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, "Pandita, Vikram" <vikram.pandita@ti.com>

>From cdc02ee36ce8da385b857575be3ad369a063bf8c Mon Sep 17 00:00:00 2001
From: Sergio Aguirre <saaguirre@ti.com>
Date: Tue, 6 Jan 2009 18:53:13 -0600
Subject: [PATCH] OMAP3: PM: SRAM: Fixes build without TI PM enabled

This fixes build without TI PM on omapzoom tree, as symbols
sram_reprogram_gpmc and sram_reprogram_gpmc_sz doesn't exist in
that case.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 arch/arm/plat-omap/sram.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index d2a691c..f97e718 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -383,9 +383,10 @@ int __init omap3_sram_init(void)
 	_omap3_sram_configure_core_dpll =
 		omap_sram_push(omap3_sram_configure_core_dpll,
 			       omap3_sram_configure_core_dpll_sz);
+#if defined(CONFIG_OMAP3_PM)
 	_omap3_sram_reprogram_gpmc = omap_sram_push(sram_reprogram_gpmc,
 			sram_reprogram_gpmc_sz);
-
+#endif
 	return 0;
 }
 #else
-- 
1.5.6.5


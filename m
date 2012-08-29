From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 1/2] arm: omap: sram: fix OMAP4 errata handling
Date: Wed, 29 Aug 2012 18:24:30 +0300
Message-ID: <1346253871-5761-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:49182 "EHLO
	filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644Ab2H2PYd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Aug 2012 11:24:33 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, santosh.shilimkar@ti.com

OMAP4-specific code should be executed only if we are running on
OMAP4. Otherwise it may break multi-OMAP kernels. Found by reading
the code.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/plat-omap/sram.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 766181c..85c23db 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -175,8 +175,10 @@ static void __init omap_map_sram(void)
 		return;
 
 #ifdef CONFIG_OMAP4_ERRATA_I688
+	if (cpu_is_omap44xx()) {
 		omap_sram_start += PAGE_SIZE;
 		omap_sram_size -= SZ_16K;
+	}
 #endif
 	if (cpu_is_omap34xx()) {
 		/*
-- 
1.7.2.5


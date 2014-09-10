From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH v3 1/3] ARM: AM335x: Get rid of unused sram init function
Date: Wed, 10 Sep 2014 11:04:02 -0500
Message-ID: <a28cef967f4b3f0b486ac473f6e3b0a189c047cc.1410362895.git.d-gerlach@ti.com>
References: <cover.1410362895.git.d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46296 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751084AbaIJQE1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Sep 2014 12:04:27 -0400
In-Reply-To: <cover.1410362895.git.d-gerlach@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

Remove the empty am33xx_sram_init() function.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/mach-omap2/sram.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm/mach-omap2/sram.c b/arch/arm/mach-omap2/sram.c
index ddf1818..5e45df0 100644
--- a/arch/arm/mach-omap2/sram.c
+++ b/arch/arm/mach-omap2/sram.c
@@ -285,11 +285,6 @@ static inline int omap34xx_sram_init(void)
 }
 #endif /* CONFIG_ARCH_OMAP3 */
 
-static inline int am33xx_sram_init(void)
-{
-	return 0;
-}
-
 int __init omap_sram_init(void)
 {
 	omap_detect_sram();
@@ -299,8 +294,6 @@ int __init omap_sram_init(void)
 		omap242x_sram_init();
 	else if (cpu_is_omap2430())
 		omap243x_sram_init();
-	else if (soc_is_am33xx())
-		am33xx_sram_init();
 	else if (cpu_is_omap34xx())
 		omap34xx_sram_init();
 
-- 
1.9.0


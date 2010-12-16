From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH] OMAP: RM-680: fix omap2_init_common_hw compile break
Date: Thu, 16 Dec 2010 11:27:18 -0600
Message-ID: <1292520438-29122-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60295 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756243Ab0LPRiW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Dec 2010 12:38:22 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Omar Ramirez Luna <omar.ramirez@ti.com>

This solves the following:

arch/arm/mach-omap2/board-rm680.c: In function 'rm680_init_irq':
arch/arm/mach-omap2/board-rm680.c:149: error: implicit
	declaration of function 'omap2_init_common_hw'

And another occurence of the same functions in am3517crane
board file.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/mach-omap2/board-am3517crane.c |    3 ++-
 arch/arm/mach-omap2/board-rm680.c       |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517crane.c b/arch/arm/mach-omap2/board-am3517crane.c
index 8ba4047..781ed25 100644
--- a/arch/arm/mach-omap2/board-am3517crane.c
+++ b/arch/arm/mach-omap2/board-am3517crane.c
@@ -47,7 +47,8 @@ static void __init am3517_crane_init_irq(void)
 	omap_board_config = am3517_crane_config;
 	omap_board_config_size = ARRAY_SIZE(am3517_crane_config);
 
-	omap2_init_common_hw(NULL, NULL);
+	omap2_init_common_infrastructure();
+	omap2_init_common_devices(NULL, NULL);
 	omap_init_irq();
 }
 
diff --git a/arch/arm/mach-omap2/board-rm680.c b/arch/arm/mach-omap2/board-rm680.c
index 8da65bd..e51e737 100644
--- a/arch/arm/mach-omap2/board-rm680.c
+++ b/arch/arm/mach-omap2/board-rm680.c
@@ -146,7 +146,8 @@ static void __init rm680_init_irq(void)
 	struct omap_sdrc_params *sdrc_params;
 
 	sdrc_params = nokia_get_sdram_timings();
-	omap2_init_common_hw(sdrc_params, sdrc_params);
+	omap2_init_common_infrastructure();
+	omap2_init_common_devices(sdrc_params, sdrc_params);
 	omap_init_irq();
 }
 
-- 
1.7.1


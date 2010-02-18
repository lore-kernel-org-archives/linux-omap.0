From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 14/23] omap3: Use timing data for omap2_init_common_hw on IGEP
	v2
Date: Wed, 17 Feb 2010 17:32:25 -0800
Message-ID: <20100218013225.32075.39485.stgit@baageli.muru.com>
References: <20100218013012.32075.43788.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:59097 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754414Ab0BRBbf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Feb 2010 20:31:35 -0500
In-Reply-To: <20100218013012.32075.43788.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Enric Balletbo i Serra <eballetbo@iseebcn.com>, linux-omap@vger.kernel.org

From: Enric Balletbo i Serra <eballetbo@iseebcn.com>

Signed-off-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-igep0020.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 8ed935c..3d1fde7 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -33,6 +33,7 @@
 
 #include "mux.h"
 #include "hsmmc.h"
+#include "sdram-numonyx-m65kxxxxam.h"
 
 #define IGEP2_SMSC911X_CS       5
 #define IGEP2_SMSC911X_GPIO     176
@@ -340,7 +341,7 @@ static void __init igep2_init_irq(void)
 {
 	omap_board_config = igep2_config;
 	omap_board_config_size = ARRAY_SIZE(igep2_config);
-	omap2_init_common_hw(NULL, NULL);
+	omap2_init_common_hw(m65kxxxxam_sdrc_params, m65kxxxxam_sdrc_params);
 	omap_init_irq();
 	omap_gpio_init();
 }


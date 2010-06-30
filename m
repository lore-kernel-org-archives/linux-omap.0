From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 13/16] omap: mux: Mux Apollon LCD power in board-apollon.c
Date: Wed, 30 Jun 2010 15:07:19 +0300
Message-ID: <20100630120719.2637.65586.stgit@baageli.muru.com>
References: <20100630120226.2637.31198.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52303 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754027Ab0F3MHL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Jun 2010 08:07:11 -0400
In-Reply-To: <20100630120226.2637.31198.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-omap@vger.kernel.org

Use the new mux function for that.

Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-apollon.c |    3 +++
 drivers/video/omap/lcd_apollon.c    |    3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index b86a879..bc67026 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -332,6 +332,9 @@ static void __init omap_apollon_init(void)
 	/* REVISIT: where's the correct place */
 	omap_cfg_reg(W19_24XX_SYS_NIRQ);
 
+	/* LCD PWR_EN */
+	omap_mux_init_signal("mcbsp2_dr.gpio_11", OMAP_PULL_ENA | OMAP_PULL_UP);
+
 	/* Use Interal loop-back in MMC/SDIO Module Input Clock selection */
 	v = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
 	v |= (1 << 24);
diff --git a/drivers/video/omap/lcd_apollon.c b/drivers/video/omap/lcd_apollon.c
index 2be94eb..10459d8 100644
--- a/drivers/video/omap/lcd_apollon.c
+++ b/drivers/video/omap/lcd_apollon.c
@@ -25,7 +25,6 @@
 #include <linux/platform_device.h>
 
 #include <mach/gpio.h>
-#include <plat/mux.h>
 
 #include "omapfb.h"
 
@@ -34,8 +33,6 @@
 static int apollon_panel_init(struct lcd_panel *panel,
 				struct omapfb_device *fbdev)
 {
-	/* configure LCD PWR_EN */
-	omap_cfg_reg(M21_242X_GPIO11);
 	return 0;
 }
 


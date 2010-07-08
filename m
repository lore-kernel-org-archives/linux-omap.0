From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 03/13] omap2: Fix GPIO numbers and smc91x for 2430sdp
Date: Thu, 08 Jul 2010 16:54:35 +0300
Message-ID: <20100708135435.26276.28828.stgit@baageli.muru.com>
References: <20100708135342.26276.80936.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:59693 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757831Ab0GHNyh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jul 2010 09:54:37 -0400
In-Reply-To: <20100708135342.26276.80936.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Fix GPIO numbers and smc91x for 2430sdp. The earlier code
had cut and paste errors from 3430sdp code. Also, 2430
has five GPIO banks for a total of 160 GPIO lines.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-2430sdp.c |    6 +-----
 arch/arm/plat-omap/gpio.c           |    4 +++-
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 71bf509..ba188cf 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -122,11 +122,7 @@ static struct omap_smc91x_platform_data board_smc91x_data = {
 
 static void __init board_smc91x_init(void)
 {
-	if (omap_rev() > OMAP3430_REV_ES1_0)
-		board_smc91x_data.gpio_irq = 6;
-	else
-		board_smc91x_data.gpio_irq = 29;
-
+	omap_mux_init_gpio(149, OMAP_PIN_INPUT);
 	gpmc_smc91x_init(&board_smc91x_data);
 }
 
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 9b7e354..7951eef 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -390,7 +390,9 @@ static inline int gpio_valid(int gpio)
 		return 0;
 	if (cpu_is_omap7xx() && gpio < 192)
 		return 0;
-	if (cpu_is_omap24xx() && gpio < 128)
+	if (cpu_is_omap2420() && gpio < 128)
+		return 0;
+	if (cpu_is_omap2430() && gpio < 160)
 		return 0;
 	if ((cpu_is_omap34xx() || cpu_is_omap44xx()) && gpio < 192)
 		return 0;


From: Benoit Cousson <b-cousson@ti.com>
Subject: [RFC v2 2/7] OMAP3: RX-51: Temporary disable dynamic mux change for eMMC
Date: Wed, 20 Oct 2010 00:22:31 +0200
Message-ID: <1287526956-21853-3-git-send-email-b-cousson@ti.com>
References: <1287526956-21853-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36364 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754479Ab0JSWXY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Oct 2010 18:23:24 -0400
In-Reply-To: <1287526956-21853-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, nm@ti.com, Benoit Cousson <b-cousson@ti.com>

RX-51 board is using some low level function in order to change
the padconf settings at runtime.
Since these functions will not be usable anymore after the
partition introduction, remove the code that use these code.

As soon as a proper API will be proposed, this patch will be drop.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 25a273d..56a49a0 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -260,6 +260,7 @@ static struct twl4030_madc_platform_data rx51_madc_data = {
 	.irq_line		= 1,
 };
 
+#if 0
 /* Enable input logic and pull all lines up when eMMC is on. */
 static struct omap_board_mux rx51_mmc2_on_mux[] = {
 	OMAP3_MUX(SDMMC2_CMD, OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0),
@@ -299,6 +300,7 @@ static void rx51_mmc2_remux(struct device *dev, int slot, int power_on)
 	else
 		omap_mux_write_array(rx51_mmc2_off_mux);
 }
+#endif
 
 static struct omap2_hsmmc_info mmc[] __initdata = {
 	{
@@ -319,7 +321,6 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
 		.gpio_wp	= -EINVAL,
 		.nonremovable	= true,
 		.power_saving	= true,
-		.remux		= rx51_mmc2_remux,
 	},
 	{}	/* Terminator */
 };
-- 
1.7.0.4


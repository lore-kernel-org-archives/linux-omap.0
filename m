From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP2 H4: fix build by removing IRDA support
Date: Sat, 25 Apr 2009 15:52:43 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0904251551150.28378@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35214 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751638AbZDYVwp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 25 Apr 2009 17:52:45 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>


Commit 5c2c33ae65b949b8c901754090eb95d7b77dc5e4 breaks H4 builds, so 
remove the gpio_expa IRDA support in the same manner as that commit did 
for H3.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-h4.c |   39 ++++-----------------------------------
 1 files changed, 4 insertions(+), 35 deletions(-)

diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index cbca22a..6145139 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -186,43 +186,12 @@ static struct platform_device h4_flash_device = {
 	.resource	= &h4_flash_resource,
 };
 
-#if defined(CONFIG_OMAP_IR) || defined(CONFIG_OMAP_IR_MODULE)
-
-/* Select between the IrDA and aGPS module */
-static int h4_select_irda(struct device *dev, int state)
-{
-	/* U192.P0 = high for IRDA; else AGPS */
-	gpio_set_value_cansleep(H4_GPIO_IRDA_AGPSn, state & IR_SEL);
-
-	/* NOTE:  UART3 can also hook up to a DB9 or to GSM ... */
-	return 0;
-}
-
-static void set_trans_mode(struct work_struct *work)
-{
-	struct omap_irda_config *irda_config =
-		container_of(work, struct omap_irda_config, gpio_expa.work);
-	int mode = irda_config->mode;
-
-	/* U191.P0 = low for SIR; else MIR/FIR */
-	gpio_set_value_cansleep(H4_GPIO_IRDA_FIRSEL, !(mode & IR_SIRMODE));
-}
-
-static int h4_transceiver_mode(struct device *dev, int mode)
-{
-	struct omap_irda_config *irda_config = dev->platform_data;
-
-	irda_config->mode = mode;
-	cancel_delayed_work(&irda_config->gpio_expa);
-	PREPARE_DELAYED_WORK(&irda_config->gpio_expa, set_trans_mode);
-	schedule_delayed_work(&irda_config->gpio_expa, 0);
-
-	return 0;
-}
-#else
+/*
+ * IRDA code removed due to dependency on dead gpio_expa code -
+ * feel free to fix and add back in if you are a user
+ */
 static int h4_select_irda(struct device *dev, int state) { return 0; }
 static int h4_transceiver_mode(struct device *dev, int mode) { return 0; }
-#endif
 
 static struct omap_irda_config h4_irda_data = {
 	.transceiver_cap	= IR_SIRMODE | IR_MIRMODE | IR_FIRMODE,
-- 
1.6.3.rc1.51.gea0b7


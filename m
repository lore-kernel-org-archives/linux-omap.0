From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH] usb: musb: am35x: fix compile error when building am35x
Date: Mon,  2 May 2011 12:46:57 +0300
Message-ID: <1304329617-5233-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:57595 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757045Ab1EBJrE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 May 2011 05:47:04 -0400
Received: by bwz17 with SMTP id 17so5583773bwz.0
        for <linux-omap@vger.kernel.org>; Mon, 02 May 2011 02:47:01 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Felipe Balbi <balbi@ti.com>

am35x_musb_set_mode() was redefined. Fix it.

Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/board-am3517evm.c   |    2 +-
 arch/arm/mach-omap2/omap_phy_internal.c |    2 +-
 arch/arm/plat-omap/include/plat/usb.h   |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index ce7d5e6..d8a0484 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -396,7 +396,7 @@ static struct omap_musb_board_data musb_board_data = {
 	.power                  = 500,
 	.set_phy_power		= am35x_musb_phy_power,
 	.clear_irq		= am35x_musb_clear_irq,
-	.set_mode		= am35x_musb_set_mode,
+	.set_mode		= am35x_set_mode,
 	.reset			= am35x_musb_reset,
 };
 
diff --git a/arch/arm/mach-omap2/omap_phy_internal.c b/arch/arm/mach-omap2/omap_phy_internal.c
index 05f6abc..eff6e24 100644
--- a/arch/arm/mach-omap2/omap_phy_internal.c
+++ b/arch/arm/mach-omap2/omap_phy_internal.c
@@ -228,7 +228,7 @@ void am35x_musb_clear_irq(void)
 	regval = omap_ctrl_readl(AM35XX_CONTROL_LVL_INTR_CLEAR);
 }
 
-void am35x_musb_set_mode(u8 musb_mode)
+void am35x_set_mode(u8 musb_mode)
 {
 	u32 devconf2 = omap_ctrl_readl(AM35XX_CONTROL_DEVCONF2);
 
diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/include/plat/usb.h
index 02b96c8..17d3c93 100644
--- a/arch/arm/plat-omap/include/plat/usb.h
+++ b/arch/arm/plat-omap/include/plat/usb.h
@@ -113,7 +113,7 @@ extern int omap4430_phy_suspend(struct device *dev, int suspend);
 extern void am35x_musb_reset(void);
 extern void am35x_musb_phy_power(u8 on);
 extern void am35x_musb_clear_irq(void);
-extern void am35x_musb_set_mode(u8 musb_mode);
+extern void am35x_set_mode(u8 musb_mode);
 
 /*
  * FIXME correct answer depends on hmc_mode,
-- 
1.7.4.1.343.ga91df


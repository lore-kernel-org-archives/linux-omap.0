From: Zumeng Chen <zumeng.chen@windriver.com>
Subject: [PATCH 4/5] ARM: OMAP3EVM: cosmetic fixes for parent clk set
Date: Wed, 20 Jun 2012 17:14:52 +0800
Message-ID: <1340183693-3195-5-git-send-email-zumeng.chen@windriver.com>
References: <1340183693-3195-1-git-send-email-zumeng.chen@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:49128 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754656Ab2FTJPa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jun 2012 05:15:30 -0400
In-Reply-To: <1340183693-3195-1-git-send-email-zumeng.chen@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jon-hunter@ti.com, mike@compulab.co.il, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, khilman@ti.com, hvaibhav@ti.com, ajay.gupta@ti.com

Since it's no more sense to set parent for dummy clock,
so we can just ignore it to mute failed message.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
Signed-off-by: Zumeng Chen <zumeng.chen@gmail.com>
---
 arch/arm/plat-omap/clock.c  |    4 ++++
 drivers/mfd/omap-usb-host.c |    2 +-
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 62ec5c4..c7e26e4 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -149,6 +149,10 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 	if (!arch_clock || !arch_clock->clk_set_parent)
 		return ret;
 
+	/* If the clock is a dummy clock just return */
+	if (clk == &dummy_ck)
+		return 0;
+
 	spin_lock_irqsave(&clockfw_lock, flags);
 	if (clk->usecount == 0) {
 		ret = arch_clock->clk_set_parent(clk, parent);
diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 7e96bb2..c9d27c4 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -699,7 +699,7 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
 	}
 
 	if (is_ehci_phy_mode(pdata->port_mode[0])) {
-		/* for OMAP3 , the clk set paretn fails */
+		/* for OMAP3 , the clk set parent fails */
 		ret = clk_set_parent(omap->utmi_p1_fck,
 					omap->xclk60mhsp1_ck);
 		if (ret != 0)
-- 
1.7.5.4


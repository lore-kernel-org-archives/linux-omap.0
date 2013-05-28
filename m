From: yegorslists@googlemail.com
Subject: [PATCH v2] usb: musb: fix clock naming
Date: Tue, 28 May 2013 09:21:01 +0200
Message-ID: <1369725661-3114-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.vscom.de ([62.145.30.242]:50631 "EHLO mail.visionsystems.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755671Ab3E1HVh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 May 2013 03:21:37 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, linux-usb@vger.kernel.org, kishon@ti.com, Yegor Yefremov <yegorslists@googlemail.com>, Jan Luebbe <jlu@pengutronix.de>

From: Yegor Yefremov <yegorslists@googlemail.com>

'ick' was changed to 'hsotgusb_ick'
'fck' was changed to 'hsotgusb_fck'

Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
v2: CC linux-usb mailing list

 drivers/usb/musb/am35x.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/am35x.c b/drivers/usb/musb/am35x.c
index 2231850..92b5b23 100644
--- a/drivers/usb/musb/am35x.c
+++ b/drivers/usb/musb/am35x.c
@@ -477,14 +477,14 @@ static int am35x_probe(struct platform_device *pdev)
 		goto err1;
 	}
 
-	phy_clk = clk_get(&pdev->dev, "fck");
+	phy_clk = clk_get(&pdev->dev, "hsotgusb_ick");
 	if (IS_ERR(phy_clk)) {
 		dev_err(&pdev->dev, "failed to get PHY clock\n");
 		ret = PTR_ERR(phy_clk);
 		goto err3;
 	}
 
-	clk = clk_get(&pdev->dev, "ick");
+	clk = clk_get(&pdev->dev, "hsotgusb_fck");
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "failed to get clock\n");
 		ret = PTR_ERR(clk);
-- 
1.7.7


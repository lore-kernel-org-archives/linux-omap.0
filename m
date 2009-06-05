From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 02/07] dma: rework dw_dmac suspend_late()/resume_early()
Date: Fri, 05 Jun 2009 16:54:55 +0900
Message-ID: <20090605075455.14756.13684.sendpatchset@rx1.opensource.se>
References: <20090605075436.14756.80501.sendpatchset@rx1.opensource.se>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.239]:33932 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754759AbZFEH6N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jun 2009 03:58:13 -0400
Received: by rv-out-0506.google.com with SMTP id f9so604462rvb.1
        for <linux-omap@vger.kernel.org>; Fri, 05 Jun 2009 00:58:15 -0700 (PDT)
In-Reply-To: <20090605075436.14756.80501.sendpatchset@rx1.opensource.se>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: pavel@ucw.cz, hskinnemoen@atmel.com, anemo@mba.ocn.ne.jp, gregkh@suse.de, rjw@sisk.pl, stern@rowland.harvard.edu, ben-linux@fluff.org, felipe.balbi@nokia.com, linux-omap@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

From: Magnus Damm <damm@igel.co.jp>

This patch reworks platform driver power management code
for dw_dmac from legacy late/early callbacks to dev_pm_ops.

The callbacks are converted for CONFIG_SUSPEND like this:
  suspend_late() -> suspend_noirq()
  resume_early() -> resume_noirq()

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Untested and not test compiled due to lack of cross compiler.

 drivers/dma/dw_dmac.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

--- 0001/drivers/dma/dw_dmac.c
+++ work/drivers/dma/dw_dmac.c	2009-06-01 16:31:34.000000000 +0900
@@ -1399,8 +1399,9 @@ static void dw_shutdown(struct platform_
 	clk_disable(dw->clk);
 }
 
-static int dw_suspend_late(struct platform_device *pdev, pm_message_t mesg)
+static int dw_suspend_noirq(struct device *dev)
 {
+	struct platform_device *pdev = to_platform_device(dev);
 	struct dw_dma	*dw = platform_get_drvdata(pdev);
 
 	dw_dma_off(platform_get_drvdata(pdev));
@@ -1408,23 +1409,27 @@ static int dw_suspend_late(struct platfo
 	return 0;
 }
 
-static int dw_resume_early(struct platform_device *pdev)
+static int dw_resume_noirq(struct device *dev)
 {
+	struct platform_device *pdev = to_platform_device(dev);
 	struct dw_dma	*dw = platform_get_drvdata(pdev);
 
 	clk_enable(dw->clk);
 	dma_writel(dw, CFG, DW_CFG_DMA_EN);
 	return 0;
-
 }
 
+static struct dev_pm_ops dw_dev_pm_ops = {
+	.suspend_noirq = dw_suspend_noirq,
+	.resume_noirq = dw_resume_noirq,
+};
+
 static struct platform_driver dw_driver = {
 	.remove		= __exit_p(dw_remove),
 	.shutdown	= dw_shutdown,
-	.suspend_late	= dw_suspend_late,
-	.resume_early	= dw_resume_early,
 	.driver = {
 		.name	= "dw_dmac",
+		.pm	= &dw_dev_pm_ops,
 	},
 };
 

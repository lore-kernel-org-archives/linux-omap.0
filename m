From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 03/07] dma: rework txx9dmac suspend_late()/resume_early()
Date: Fri, 05 Jun 2009 16:55:04 +0900
Message-ID: <20090605075504.14756.68449.sendpatchset@rx1.opensource.se>
References: <20090605075436.14756.80501.sendpatchset@rx1.opensource.se>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.234]:27625 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754821AbZFEH6X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jun 2009 03:58:23 -0400
Received: by rv-out-0506.google.com with SMTP id k40so290502rvb.5
        for <linux-omap@vger.kernel.org>; Fri, 05 Jun 2009 00:58:25 -0700 (PDT)
In-Reply-To: <20090605075436.14756.80501.sendpatchset@rx1.opensource.se>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: ben-linux@fluff.org, hskinnemoen@atmel.com, anemo@mba.ocn.ne.jp, gregkh@suse.de, rjw@sisk.pl, stern@rowland.harvard.edu, pavel@ucw.cz, felipe.balbi@nokia.com, linux-omap@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

From: Magnus Damm <damm@igel.co.jp>

This patch reworks platform driver power management code
for txx9dmac from legacy late/early callbacks to dev_pm_ops.

The callbacks are converted for CONFIG_SUSPEND like this:
  suspend_late() -> suspend_noirq()
  resume_early() -> resume_noirq()

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Untested but compiles fine.

 drivers/dma/txx9dmac.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

--- 0001/drivers/dma/txx9dmac.c
+++ work/drivers/dma/txx9dmac.c	2009-06-01 16:34:23.000000000 +0900
@@ -1287,17 +1287,18 @@ static void txx9dmac_shutdown(struct pla
 	txx9dmac_off(ddev);
 }
 
-static int txx9dmac_suspend_late(struct platform_device *pdev,
-				 pm_message_t mesg)
+static int txx9dmac_suspend_noirq(struct device *dev)
 {
+	struct platform_device *pdev = to_platform_device(dev);
 	struct txx9dmac_dev *ddev = platform_get_drvdata(pdev);
 
 	txx9dmac_off(ddev);
 	return 0;
 }
 
-static int txx9dmac_resume_early(struct platform_device *pdev)
+static int txx9dmac_resume_noirq(struct device *dev)
 {
+	struct platform_device *pdev = to_platform_device(dev);
 	struct txx9dmac_dev *ddev = platform_get_drvdata(pdev);
 	struct txx9dmac_platform_data *pdata = pdev->dev.platform_data;
 	u32 mcr;
@@ -1310,6 +1311,11 @@ static int txx9dmac_resume_early(struct 
 
 }
 
+static struct dev_pm_ops txx9dmac_dev_pm_ops = {
+	.suspend_noirq = txx9dmac_suspend_noirq,
+	.resume_noirq = txx9dmac_resume_noirq,
+};
+
 static struct platform_driver txx9dmac_chan_driver = {
 	.remove		= __exit_p(txx9dmac_chan_remove),
 	.driver = {
@@ -1320,10 +1326,9 @@ static struct platform_driver txx9dmac_c
 static struct platform_driver txx9dmac_driver = {
 	.remove		= __exit_p(txx9dmac_remove),
 	.shutdown	= txx9dmac_shutdown,
-	.suspend_late	= txx9dmac_suspend_late,
-	.resume_early	= txx9dmac_resume_early,
 	.driver = {
 		.name	= "txx9dmac",
+		.pm	= &txx9dmac_dev_pm_ops,
 	},
 };
 

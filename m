From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH] Fix OMAP4 boot regression
Date: Thu, 24 May 2012 10:04:49 +0100
Message-ID: <20120524090449.GA24486@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:46454 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753395Ab2EXJEy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 May 2012 05:04:54 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Fix a boot regression in existing kernels causing:

genirq: Threaded irq requested with handler=NULL and !ONESHOT for irq XXX

caused by 1c6c6952 (genirq: Reject bogus threaded irq requests).

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
--
 drivers/mmc/host/omap_hsmmc.c |    2 +-
 drivers/rtc/rtc-twl.c         |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index d76fc82..84016cb 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1962,7 +1962,7 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
 		ret = request_threaded_irq(mmc_slot(host).card_detect_irq,
 					   NULL,
 					   omap_hsmmc_detect,
-					   IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+					   IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 					   mmc_hostname(mmc), host);
 		if (ret) {
 			dev_dbg(mmc_dev(host->mmc),
diff --git a/drivers/rtc/rtc-twl.c b/drivers/rtc/rtc-twl.c
index 258abea..c5d06fe 100644
--- a/drivers/rtc/rtc-twl.c
+++ b/drivers/rtc/rtc-twl.c
@@ -510,7 +510,7 @@ static int __devinit twl_rtc_probe(struct platform_device *pdev)
 	}
 
 	ret = request_threaded_irq(irq, NULL, twl_rtc_interrupt,
-				   IRQF_TRIGGER_RISING,
+				   IRQF_TRIGGER_RISING | IRQF_ONESHOT,
 				   dev_name(&rtc->dev), rtc);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "IRQ is not free.\n");

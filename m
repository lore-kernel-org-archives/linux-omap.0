From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.27-rc6-omap] hsmmc: request_irq says which controller is involved
Date: Sun, 21 Sep 2008 14:16:14 -0700
Message-ID: <200809211416.14496.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:41246 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752822AbYIUVUU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 21 Sep 2008 17:20:20 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Make the hsmmc driver irq requests say which controller they're
associated with (e.g. "mmc0") so /proc/interrupts is more useful.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -908,8 +908,8 @@ static int __init omap_mmc_probe(struct platform_device *pdev)
 			OMAP_HSMMC_READ(host->base, HCTL) | SDBP);
 
 	/* Request IRQ for MMC operations */
-	ret = request_irq(host->irq, mmc_omap_irq, IRQF_DISABLED, pdev->name,
-			 host);
+	ret = request_irq(host->irq, mmc_omap_irq, IRQF_DISABLED,
+			mmc_hostname(mmc), host);
 	if (ret) {
 		dev_dbg(mmc_dev(host->mmc), "Unable to grab HSMMC IRQ\n");
 		goto err_irq;
@@ -918,8 +918,8 @@ static int __init omap_mmc_probe(struct platform_device *pdev)
 	/* Request IRQ for card detect */
 	if ((mmc_slot(host).card_detect_irq) && (mmc_slot(host).card_detect)) {
 		ret = request_irq(mmc_slot(host).card_detect_irq,
-				  omap_mmc_cd_handler, IRQF_DISABLED, "MMC CD",
-				  host);
+				  omap_mmc_cd_handler, IRQF_DISABLED,
+				  mmc_hostname(mmc), host);
 		if (ret) {
 			dev_dbg(mmc_dev(host->mmc),
 				"Unable to grab MMC CD IRQ\n");

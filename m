From: David Brownell <david-b@pacbell.net>
Subject: [patch omap-git] hsmmc: card detect irq bugfix
Date: Tue, 13 Jan 2009 02:49:48 -0800
Message-ID: <200901130249.48729.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:20224 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750891AbZAMKtu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Jan 2009 05:49:50 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Work around lockdep issue when card detect IRQ handlers run in
thread context ... it forces IRQF_DISABLED, which prevents all
access to twl4030 card detect signals.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
With so many OMAP3 boards having only one MMC/SD slot, used
for rootfs by developers, it's no surprise this hasn't been
noticed before!

 drivers/mmc/host/omap_hsmmc.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -568,6 +568,9 @@ static void mmc_omap_detect(struct work_
 {
 	struct mmc_omap_host *host = container_of(work, struct mmc_omap_host,
 						mmc_carddetect_work);
+	struct omap_mmc_slot_data *slot = &mmc_slot(host);
+
+	host->carddetect = slot->card_detect(slot->card_detect_irq);
 
 	sysfs_notify(&host->mmc->class_dev.kobj, NULL, "cover_switch");
 	mmc_omap_fclk_state(host, ON);
@@ -591,7 +594,6 @@ static irqreturn_t omap_mmc_cd_handler(i
 {
 	struct mmc_omap_host *host = (struct mmc_omap_host *)dev_id;
 
-	host->carddetect = mmc_slot(host).card_detect(irq);
 	schedule_work(&host->mmc_carddetect_work);
 
 	return IRQ_HANDLED;

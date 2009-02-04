From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.29-rc3] omap_hsmmc:  card detect irq bugfix
Date: Wed, 4 Feb 2009 14:42:03 -0800
Message-ID: <200902041442.04033.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:22305 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756782AbZBDWmG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Feb 2009 17:42:06 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pierre Ossman <drzeus-mmc@drzeus.cx>
Cc: OMAP <linux-omap@vger.kernel.org>

From: David Brownell <dbrownell@users.sourceforge.net>

Work around lockdep issue when card detect IRQ handlers run in
thread context ... it forces IRQF_DISABLED, which prevents all
access to twl4030 card detect signals.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/mmc/host/omap_hsmmc.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -517,6 +517,9 @@ static void mmc_omap_detect(struct work_
 {
 	struct mmc_omap_host *host = container_of(work, struct mmc_omap_host,
 						mmc_carddetect_work);
+	struct omap_mmc_slot_data *slot = &mmc_slot(host);
+
+	host->carddetect = slot->card_detect(slot->card_detect_irq);
 
 	sysfs_notify(&host->mmc->class_dev.kobj, NULL, "cover_switch");
 	if (host->carddetect) {
@@ -538,7 +541,6 @@ static irqreturn_t omap_mmc_cd_handler(i
 {
 	struct mmc_omap_host *host = (struct mmc_omap_host *)dev_id;
 
-	host->carddetect = mmc_slot(host).card_detect(irq);
 	schedule_work(&host->mmc_carddetect_work);
 
 	return IRQ_HANDLED;

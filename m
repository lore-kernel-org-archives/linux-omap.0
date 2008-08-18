From: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Subject: [PATCH] MMC: Add sysfs file cover_switch
Date: Mon, 18 Aug 2008 18:13:20 +0300
Message-ID: <1219072400-7814-7-git-send-email-jarkko.lavinen@nokia.com>
References: <1219072400-7814-1-git-send-email-jarkko.lavinen@nokia.com>
 <1219072400-7814-2-git-send-email-jarkko.lavinen@nokia.com>
 <1219072400-7814-3-git-send-email-jarkko.lavinen@nokia.com>
 <1219072400-7814-4-git-send-email-jarkko.lavinen@nokia.com>
 <1219072400-7814-5-git-send-email-jarkko.lavinen@nokia.com>
 <1219072400-7814-6-git-send-email-jarkko.lavinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:55380 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752178AbYHRPQy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Aug 2008 11:16:54 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m7IFG7fI015837
	for <linux-omap@vger.kernel.org>; Mon, 18 Aug 2008 10:16:53 -0500
In-Reply-To: <1219072400-7814-6-git-send-email-jarkko.lavinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>

Add sysfs cover_switch with the status of cover.

Signed-off-by: Francisco Alecrim <francisco.alecrim@indt.org.br>
Signed-off-by: Jarkko Lavinen <jarkko.lavinen@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 17a3d8c..f9ba09d 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -175,6 +175,27 @@ static void send_init_stream(struct mmc_omap_host *host)
 	enable_irq(host->irq);
 }
 
+static inline
+int mmc_omap_cover_is_closed(struct mmc_omap_host *host)
+{
+	if (host->pdata->slots[host->slot_id].get_cover_state)
+		return host->pdata->slots[host->slot_id].get_cover_state(host->dev, host->slot_id);
+	return 1;
+}
+
+static ssize_t
+mmc_omap_show_cover_switch(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	struct mmc_host *mmc = container_of(dev, struct mmc_host, class_dev);
+	struct mmc_omap_host *host = mmc_priv(mmc);
+
+	return sprintf(buf, "%s\n", mmc_omap_cover_is_closed(host) ? "closed" :
+		       "open");
+}
+
+static DEVICE_ATTR(cover_switch, S_IRUGO, mmc_omap_show_cover_switch, NULL);
+
 static ssize_t
 mmc_omap_show_slot_name(struct device *dev, struct device_attribute *attr,
 			char *buf)
@@ -476,6 +497,7 @@ static void mmc_omap_detect(struct work_struct *work)
 	struct mmc_omap_host *host = container_of(work, struct mmc_omap_host,
 						mmc_carddetect_work);
 
+	sysfs_notify(&host->mmc->class_dev.kobj, NULL, "cover_switch");
 	if (host->carddetect) {
 		if (!(OMAP_HSMMC_READ(host->base, HCTL) & SDVSDET)) {
 			/*
@@ -926,9 +948,17 @@ static int __init omap_mmc_probe(struct platform_device *pdev)
 		if (ret < 0)
 			goto err_slot_name;
 	}
+	if (mmc_slot(host).card_detect_irq && mmc_slot(host).card_detect &&
+			host->pdata->slots[host->slot_id].get_cover_state) {
+		ret = device_create_file(&mmc->class_dev, &dev_attr_cover_switch);
+		if (ret < 0)
+			goto err_cover_switch;
+	}
 
 	return 0;
 
+err_cover_switch:
+	device_remove_file(&mmc->class_dev, &dev_attr_cover_switch);
 err_slot_name:
 	mmc_remove_host(mmc);
 err_irq_cd_init:
-- 
1.5.6.3


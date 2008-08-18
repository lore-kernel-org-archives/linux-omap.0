From: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Subject: [PATCH] MMC: OMAP: Add slot_name entry to sysfs
Date: Mon, 18 Aug 2008 18:13:19 +0300
Message-ID: <1219072400-7814-6-git-send-email-jarkko.lavinen@nokia.com>
References: <1219072400-7814-1-git-send-email-jarkko.lavinen@nokia.com>
 <1219072400-7814-2-git-send-email-jarkko.lavinen@nokia.com>
 <1219072400-7814-3-git-send-email-jarkko.lavinen@nokia.com>
 <1219072400-7814-4-git-send-email-jarkko.lavinen@nokia.com>
 <1219072400-7814-5-git-send-email-jarkko.lavinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:55351 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752115AbYHRPQo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Aug 2008 11:16:44 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m7IFGfpl016273
	for <linux-omap@vger.kernel.org>; Mon, 18 Aug 2008 10:16:42 -0500
In-Reply-To: <1219072400-7814-5-git-send-email-jarkko.lavinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Francisco Alecrim <francisco.alecrim@indt.org.br>, Jarkko Lavinen <jarkko.lavinen@nokia.com>

From: Francisco Alecrim <francisco.alecrim@indt.org.br>

Add slot_name entry to sysfs.

Signed-off-by: Francisco Alecrim <francisco.alecrim@indt.org.br>
Acked-by: Anderson Lizardo <anderson.lizardo@indt.org.br>
---
 drivers/mmc/host/omap_hsmmc.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 824e7e9..17a3d8c 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -175,6 +175,19 @@ static void send_init_stream(struct mmc_omap_host *host)
 	enable_irq(host->irq);
 }
 
+static ssize_t
+mmc_omap_show_slot_name(struct device *dev, struct device_attribute *attr,
+			char *buf)
+{
+	struct mmc_host *mmc = container_of(dev, struct mmc_host, class_dev);
+	struct mmc_omap_host *host = mmc_priv(mmc);
+	struct omap_mmc_slot_data slot = host->pdata->slots[host->slot_id];
+
+	return sprintf(buf, "slot:%s\n", slot.name);
+}
+
+static DEVICE_ATTR(slot_name, S_IRUGO, mmc_omap_show_slot_name, NULL);
+
 /*
  * Configure the response type and send the cmd.
  */
@@ -908,8 +921,16 @@ static int __init omap_mmc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, host);
 	mmc_add_host(mmc);
 
+	if (host->pdata->slots[host->slot_id].name != NULL) {
+		ret = device_create_file(&mmc->class_dev, &dev_attr_slot_name);
+		if (ret < 0)
+			goto err_slot_name;
+	}
+
 	return 0;
 
+err_slot_name:
+	mmc_remove_host(mmc);
 err_irq_cd_init:
 	free_irq(mmc_slot(host).card_detect_irq, host);
 err_irq_cd:
-- 
1.5.6.3


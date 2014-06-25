From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 1/7] mailbox/omap: use devm_* interfaces
Date: Tue, 24 Jun 2014 19:43:37 -0500
Message-ID: <1403657023-53897-2-git-send-email-s-anna@ti.com>
References: <1403657023-53897-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33785 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752612AbaFYAoT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jun 2014 20:44:19 -0400
In-Reply-To: <1403657023-53897-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Dave Gerlach <d-gerlach@ti.com>, Jassi Brar <jaswinder.singh@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>

Use the various devm_ interfaces to simplify the cleanup in
probe and remove functions in OMAP2+ mailbox driver.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/mailbox/mailbox-omap2.c | 64 ++++++++++++-----------------------------
 1 file changed, 19 insertions(+), 45 deletions(-)

diff --git a/drivers/mailbox/mailbox-omap2.c b/drivers/mailbox/mailbox-omap2.c
index 42d2b89..75fbc90 100644
--- a/drivers/mailbox/mailbox-omap2.c
+++ b/drivers/mailbox/mailbox-omap2.c
@@ -236,23 +236,24 @@ static int omap2_mbox_probe(struct platform_device *pdev)
 	}
 
 	/* allocate one extra for marking end of list */
-	list = kzalloc((pdata->info_cnt + 1) * sizeof(*list), GFP_KERNEL);
+	list = devm_kzalloc(&pdev->dev, (pdata->info_cnt + 1) * sizeof(*list),
+			    GFP_KERNEL);
 	if (!list)
 		return -ENOMEM;
 
-	mboxblk = mbox = kzalloc(pdata->info_cnt * sizeof(*mbox), GFP_KERNEL);
-	if (!mboxblk) {
-		ret = -ENOMEM;
-		goto free_list;
-	}
+	mboxblk = devm_kzalloc(&pdev->dev, pdata->info_cnt * sizeof(*mbox),
+			       GFP_KERNEL);
+	if (!mboxblk)
+		return -ENOMEM;
 
-	privblk = priv = kzalloc(pdata->info_cnt * sizeof(*priv), GFP_KERNEL);
-	if (!privblk) {
-		ret = -ENOMEM;
-		goto free_mboxblk;
-	}
+	privblk = devm_kzalloc(&pdev->dev, pdata->info_cnt * sizeof(*priv),
+			       GFP_KERNEL);
+	if (!privblk)
+		return -ENOMEM;
 
 	info = pdata->info;
+	mbox = mboxblk;
+	priv = privblk;
 	for (i = 0; i < pdata->info_cnt; i++, info++, priv++) {
 		priv->tx_fifo.msg = MAILBOX_MESSAGE(info->tx_id);
 		priv->tx_fifo.fifo_stat = MAILBOX_FIFOSTATUS(info->tx_id);
@@ -276,55 +277,28 @@ static int omap2_mbox_probe(struct platform_device *pdev)
 		mbox->name = info->name;
 		mbox->ops = &omap2_mbox_ops;
 		mbox->irq = platform_get_irq(pdev, info->irq_id);
-		if (mbox->irq < 0) {
-			ret = mbox->irq;
-			goto free_privblk;
-		}
+		if (mbox->irq < 0)
+			return mbox->irq;
 		list[i] = mbox++;
 	}
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!mem) {
-		ret = -ENOENT;
-		goto free_privblk;
-	}
-
-	mbox_base = ioremap(mem->start, resource_size(mem));
-	if (!mbox_base) {
-		ret = -ENOMEM;
-		goto free_privblk;
-	}
+	mbox_base = devm_ioremap_resource(&pdev->dev, mem);
+	if (IS_ERR(mbox_base))
+		return PTR_ERR(mbox_base);
 
 	ret = omap_mbox_register(&pdev->dev, list);
 	if (ret)
-		goto unmap_mbox;
+		return ret;
+
 	platform_set_drvdata(pdev, list);
 
 	return 0;
-
-unmap_mbox:
-	iounmap(mbox_base);
-free_privblk:
-	kfree(privblk);
-free_mboxblk:
-	kfree(mboxblk);
-free_list:
-	kfree(list);
-	return ret;
 }
 
 static int omap2_mbox_remove(struct platform_device *pdev)
 {
-	struct omap_mbox2_priv *privblk;
-	struct omap_mbox **list = platform_get_drvdata(pdev);
-	struct omap_mbox *mboxblk = list[0];
-
-	privblk = mboxblk->priv;
 	omap_mbox_unregister();
-	iounmap(mbox_base);
-	kfree(privblk);
-	kfree(mboxblk);
-	kfree(list);
 
 	return 0;
 }
-- 
2.0.0


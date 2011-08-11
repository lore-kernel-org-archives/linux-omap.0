From: Kyle Manna <kyle@kylemanna.com>
Subject: [PATCH 1/3] twl4030-madc: copy the device pointer
Date: Wed, 10 Aug 2011 22:27:50 -0500
Message-ID: <1313033272-16774-2-git-send-email-kyle@kylemanna.com>
References: <1313033272-16774-1-git-send-email-kyle@kylemanna.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hapkido.dreamhost.com ([66.33.216.122]:44944 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753930Ab1HKD17 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Aug 2011 23:27:59 -0400
Received: from homiemail-a66.g.dreamhost.com (caiajhbdcbbj.dreamhost.com [208.97.132.119])
	by hapkido.dreamhost.com (Postfix) with ESMTP id E136217E55A
	for <linux-omap@vger.kernel.org>; Wed, 10 Aug 2011 20:27:58 -0700 (PDT)
In-Reply-To: <1313033272-16774-1-git-send-email-kyle@kylemanna.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kyle Manna <kyle@kylemanna.com>

Worst case this fixes the following error:
[   72.086212] (NULL device *): conversion timeout!

Best case it prevents a crash

Signed-off-by: Kyle Manna <kyle@kylemanna.com>
---
 drivers/mfd/twl4030-madc.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/mfd/twl4030-madc.c b/drivers/mfd/twl4030-madc.c
index b5d598c..8ef7801 100644
--- a/drivers/mfd/twl4030-madc.c
+++ b/drivers/mfd/twl4030-madc.c
@@ -706,6 +706,9 @@ static int __devinit twl4030_madc_probe(struct platform_device *pdev)
 	if (!madc)
 		return -ENOMEM;
 
+	/* Copy the pointer to device struct */
+	madc->dev = &pdev->dev;
+
 	/*
 	 * Phoenix provides 2 interrupt lines. The first one is connected to
 	 * the OMAP. The other one can be connected to the other processor such
@@ -733,7 +736,7 @@ static int __devinit twl4030_madc_probe(struct platform_device *pdev)
 	ret = twl_i2c_write_u8(TWL4030_MODULE_MAIN_CHARGE,
 			       regval, TWL4030_BCI_BCICTL1);
 	if (ret) {
-		dev_err(&pdev->dev, "unable to write reg BCI Ctl1 0x%X\n",
+		dev_err(&pdev->dev, "unable to write reg BCI CTL1 0x%X\n",
 			TWL4030_BCI_BCICTL1);
 		goto err_i2c;
 	}
-- 
1.7.4.1


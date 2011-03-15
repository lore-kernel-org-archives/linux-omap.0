From: Andy Green <andy@warmcat.com>
Subject: [PATCH 3 09/18] I2C: OMAP2+: Solve array bounds overflow error on i2c
 idle
Date: Tue, 15 Mar 2011 19:56:56 +0000
Message-ID: <20110315195656.30000.17732.stgit@otae.warmcat.com>
References: <20110315195147.30000.86184.stgit@otae.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37340 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755854Ab1COT47 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Mar 2011 15:56:59 -0400
Received: by mail-ww0-f44.google.com with SMTP id 36so1206062wwa.1
        for <linux-omap@vger.kernel.org>; Tue, 15 Mar 2011 12:56:59 -0700 (PDT)
In-Reply-To: <20110315195147.30000.86184.stgit@otae.warmcat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: patches@linaro.org, Ben Dooks <ben-linux@fluff.org>, Andy Green <andy.green@linaro.org>

This solves the main problem the patch series is about.  Prior
to this patch on OMAP3530 the driver wrongly interprets the I2C
peripheral unit's own reported revision as meaning it is running
on an IP V2 device and must use the extended registers.

In fact OMAP3530 is IP V1 with the smaller register set, the
reason for the confusion is that the hardware does in fact report
having the same IP revision index as is found on an OMAP4430,
which really is IP V2 and has the extended registers.

This corrects the test for which registers to use so that it
decides using hwmod knowledge found in the platform_data.

Cc: patches@linaro.org
Cc: Ben Dooks <ben-linux@fluff.org>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
---

 drivers/i2c/busses/i2c-omap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index eee0bb8..14f5b50 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -309,7 +309,7 @@ static void omap_i2c_idle(struct omap_i2c_dev *dev)
 	pdata = pdev->dev.platform_data;
 
 	dev->iestate = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
-	if (dev->rev >= OMAP_I2C_REV_ON_4430)
+	if (pdata->rev == OMAP_I2C_IP_VERSION_2)
 		omap_i2c_write_reg(dev, OMAP_I2C_IP_V2_IRQENABLE_CLR, 1);
 	else
 		omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, 0);


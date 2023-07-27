Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC93C001E0
	for <linux-omap@archiver.kernel.org>; Thu, 27 Jul 2023 09:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbjG0J0Z (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 27 Jul 2023 05:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbjG0JZ6 (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Thu, 27 Jul 2023 05:25:58 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D59E5241;
        Thu, 27 Jul 2023 02:15:41 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RBQ7q6X5GzrRqy;
        Thu, 27 Jul 2023 17:14:31 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 27 Jul
 2023 17:15:26 +0800
From:   Ruan Jinjie <ruanjinjie@huawei.com>
To:     <j-keerthy@ti.com>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <andy@kernel.org>, <grygorii.strashko@ti.com>,
        <ssantosh@kernel.org>, <khilman@kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-omap@vger.kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next] gpio: Remove redundant dev_err_probe()
Date:   Thu, 27 Jul 2023 17:14:46 +0800
Message-ID: <20230727091446.859984-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

There is no need to call the dev_err_probe() function directly to print
a custom message when handling an error from platform_get_irq() function as
it is going to display an appropriate error message in case of a failure.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 drivers/gpio/gpio-davinci.c | 2 +-
 drivers/gpio/gpio-omap.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index fff510d86e31..8db5717bdabe 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -236,7 +236,7 @@ static int davinci_gpio_probe(struct platform_device *pdev)
 	for (i = 0; i < nirq; i++) {
 		chips->irqs[i] = platform_get_irq(pdev, i);
 		if (chips->irqs[i] < 0)
-			return dev_err_probe(dev, chips->irqs[i], "IRQ not populated\n");
+			return chips->irqs[i];
 	}
 
 	chips->chip.label = dev_name(dev);
diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 2b78fde74e30..21c8cfedfd64 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1415,7 +1415,7 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	if (bank->irq <= 0) {
 		if (!bank->irq)
 			bank->irq = -ENXIO;
-		return dev_err_probe(dev, bank->irq, "can't get irq resource\n");
+		return bank->irq;
 	}
 
 	bank->chip.parent = dev;
-- 
2.34.1


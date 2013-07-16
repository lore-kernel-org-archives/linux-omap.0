From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] ARM: OMAP: dma: fix error return code in omap_system_dma_probe()
Date: Tue, 16 Jul 2013 20:10:46 +0800
Message-ID: <CAPgLHd-yE_qW1NeK5KkPSUtA1wGfQcnROywrcfa7cH+Dtwfezw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:55497 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932162Ab3GPMKr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Jul 2013 08:10:47 -0400
Received: by mail-bk0-f46.google.com with SMTP id na10so226506bkb.5
        for <linux-omap@vger.kernel.org>; Tue, 16 Jul 2013 05:10:46 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux@arm.linux.org.uk
Cc: yongjun_wei@trendmicro.com.cn, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fix to return a negative error code from the error handling
case instead of 0, as done elsewhere in this function.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/arm/plat-omap/dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 4d463ca..0376606 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -2083,6 +2083,7 @@ static int omap_system_dma_probe(struct platform_device *pdev)
 		dma_irq = platform_get_irq_byname(pdev, irq_name);
 		if (dma_irq < 0) {
 			dev_err(&pdev->dev, "failed: request IRQ %d", dma_irq);
+			ret = dma_irq;
 			goto exit_dma_lch_fail;
 		}
 		ret = setup_irq(dma_irq, &omap24xx_dma_irq);


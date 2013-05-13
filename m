From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] ARM: OMAP: fix error return code in omap1_system_dma_init()
Date: Mon, 13 May 2013 12:25:23 +0800
Message-ID: <CAPgLHd8iPa4efHsYsCmGE-j-GzZw7DtWdSaQqpEuF60-BRtmbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:46307 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763Ab3EMEZY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 May 2013 00:25:24 -0400
Received: by mail-wi0-f176.google.com with SMTP id hr14so2467333wib.3
        for <linux-omap@vger.kernel.org>; Sun, 12 May 2013 21:25:23 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux@arm.linux.org.uk
Cc: yongjun_wei@trendmicro.com.cn, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fix to return -ENOMEM in the d->chan alloc error handling
case instead of 0, as done elsewhere in this function.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/arm/mach-omap1/dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
index 68ab858..a94b3a7 100644
--- a/arch/arm/mach-omap1/dma.c
+++ b/arch/arm/mach-omap1/dma.c
@@ -345,6 +345,7 @@ static int __init omap1_system_dma_init(void)
 		dev_err(&pdev->dev,
 			"%s: Memory allocation failed for d->chan!\n",
 			__func__);
+		ret = -ENOMEM;
 		goto exit_release_d;
 	}
 


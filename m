From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] ARM: OMAP1: DMA: fix error handling in omap1_system_dma_init()
Date: Fri, 26 Apr 2013 16:31:44 +0800
Message-ID: <CAPgLHd-5cRFtN-rF8c5Jvg9cqE3jvxuOa6KaDgcoYHPM4DhbMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f54.google.com ([209.85.214.54]:56427 "EHLO
	mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754122Ab3DZIbq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Apr 2013 04:31:46 -0400
Received: by mail-bk0-f54.google.com with SMTP id q11so1654622bkw.27
        for <linux-omap@vger.kernel.org>; Fri, 26 Apr 2013 01:31:45 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux@arm.linux.org.uk
Cc: yongjun_wei@trendmicro.com.cn, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Add the missing iounmap() before return from omap1_system_dma_init()
in the error handling case.
Also removed platform_device_del() on add resources error case which
cause dup device delete.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
no compile test.
---
 arch/arm/mach-omap1/dma.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
index 1a4e887..68ab858 100644
--- a/arch/arm/mach-omap1/dma.c
+++ b/arch/arm/mach-omap1/dma.c
@@ -301,7 +301,7 @@ static int __init omap1_system_dma_init(void)
 	if (ret) {
 		dev_err(&pdev->dev, "%s: Unable to add resources for %s%d\n",
 			__func__, pdev->name, pdev->id);
-		goto exit_device_put;
+		goto exit_iounmap;
 	}
 
 	p = kzalloc(sizeof(struct omap_system_dma_plat_info), GFP_KERNEL);
@@ -309,7 +309,7 @@ static int __init omap1_system_dma_init(void)
 		dev_err(&pdev->dev, "%s: Unable to allocate 'p' for %s\n",
 			__func__, pdev->name);
 		ret = -ENOMEM;
-		goto exit_device_del;
+		goto exit_iounmap;
 	}
 
 	d = kzalloc(sizeof(struct omap_dma_dev_attr), GFP_KERNEL);
@@ -402,8 +402,8 @@ exit_release_d:
 	kfree(d);
 exit_release_p:
 	kfree(p);
-exit_device_del:
-	platform_device_del(pdev);
+exit_iounmap:
+	iounmap(dma_base);
 exit_device_put:
 	platform_device_put(pdev);
 


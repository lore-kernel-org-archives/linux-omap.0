From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] ARM: OMAP: fix return value check in omap_device_build_from_dt()
Date: Thu, 4 Jul 2013 21:42:34 +0800
Message-ID: <CAPgLHd_E8wht4q5c9=TjUTwXxysjbbX+HnZyYe2KJU=w79cK4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f54.google.com ([209.85.214.54]:60304 "EHLO
	mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468Ab3GDNmg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Jul 2013 09:42:36 -0400
Received: by mail-bk0-f54.google.com with SMTP id it16so661816bkc.13
        for <linux-omap@vger.kernel.org>; Thu, 04 Jul 2013 06:42:35 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux@arm.linux.org.uk
Cc: yongjun_wei@trendmicro.com.cn, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function omap_device_alloc() returns ERR_PTR()
and never returns NULL. The NULL test in the return value check
should be replaced with IS_ERR().

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/arm/mach-omap2/omap_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
index 5cc9287..28e70c0 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -155,7 +155,7 @@ static int omap_device_build_from_dt(struct platform_device *pdev)
 	}
 
 	od = omap_device_alloc(pdev, hwmods, oh_cnt);
-	if (!od) {
+	if (IS_ERR(od)) {
 		dev_err(&pdev->dev, "Cannot allocate omap_device for :%s\n",
 			oh_name);
 		ret = PTR_ERR(od);


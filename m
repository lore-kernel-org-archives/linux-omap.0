From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] ARM: OMAP: omap_device: fix return value check in omap_device_build_ss()
Date: Fri, 21 Sep 2012 14:32:04 +0800
Message-ID: <CAPgLHd8ys7uU8wBhMF7JWZEDAddOnGo4vHPu1V_+Q3__WWK-3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:45581 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440Ab2IUGcF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Sep 2012 02:32:05 -0400
Received: by qaas11 with SMTP id s11so1011943qaa.19
        for <linux-omap@vger.kernel.org>; Thu, 20 Sep 2012 23:32:04 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux@arm.linux.org.uk, grant.likely@secretlab.ca, rob.herring@calxeda.com
Cc: yongjun_wei@trendmicro.com.cn, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function omap_device_alloc() returns ERR_PTR()
and never returns NULL pointer. The NULL test in the return value
check should be replaced with IS_ERR().

dpatch engine is used to auto generated this patch.
(https://github.com/weiyj/dpatch)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/arm/plat-omap/omap_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index c490240..3f62de6 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -671,7 +671,7 @@ struct platform_device __init *omap_device_build_ss(const char *pdev_name, int p
 		dev_set_name(&pdev->dev, "%s", pdev->name);
 
 	od = omap_device_alloc(pdev, ohs, oh_cnt, pm_lats, pm_lats_cnt);
-	if (!od)
+	if (IS_ERR(od))
 		goto odbs_exit1;
 
 	ret = platform_device_add_data(pdev, pdata, pdata_len);



From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] ARM: OMAP: fix return value check in beagle_opp_init()
Date: Fri, 21 Sep 2012 14:26:37 +0800
Message-ID: <CAPgLHd9aJUYX_a7_iXLi5r6VEVuB0W15G9Ryw2bVzNzko2NpBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:53748 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753601Ab2IUG0h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Sep 2012 02:26:37 -0400
Received: by qcro28 with SMTP id o28so2351911qcr.19
        for <linux-omap@vger.kernel.org>; Thu, 20 Sep 2012 23:26:37 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux@arm.linux.org.uk
Cc: yongjun_wei@trendmicro.com.cn, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function omap_device_get_by_hwmod_name()
returns ERR_PTR() not NULL pointer. The NULL test in the return
value check should be replaced with IS_ERR().

dpatch engine is used to auto generated this patch.
(https://github.com/weiyj/dpatch)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/arm/mach-omap2/board-omap3beagle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 6202fc7..a548d70 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -466,7 +466,7 @@ static void __init beagle_opp_init(void)
 		mpu_dev = omap_device_get_by_hwmod_name("mpu");
 		iva_dev = omap_device_get_by_hwmod_name("iva");
 
-		if (!mpu_dev || !iva_dev) {
+		if (IS_ERR(mpu_dev) || IS_ERR(iva_dev)) {
 			pr_err("%s: Aiee.. no mpu/dsp devices? %p %p\n",
 				__func__, mpu_dev, iva_dev);
 			return;



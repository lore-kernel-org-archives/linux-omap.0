From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] ARM: OMAP3: Beagle: fix return value check in beagle_opp_init()
Date: Wed, 30 Oct 2013 13:23:21 +0800
Message-ID: <CAPgLHd_DZkrzaSa9cdYYUBL=p18s=P=5RFyTJTT+toFgTqNZGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f44.google.com ([209.85.214.44]:64181 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709Ab3J3FXW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Oct 2013 01:23:22 -0400
Received: by mail-bk0-f44.google.com with SMTP id mx11so269584bkb.17
        for <linux-omap@vger.kernel.org>; Tue, 29 Oct 2013 22:23:21 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux@arm.linux.org.uk
Cc: yongjun_wei@trendmicro.com.cn, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function get_cpu_device() returns NULL pointer
not ERR_PTR(). The IS_ERR() test in the return value check should be
replaced with NULL test.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/arm/mach-omap2/board-omap3beagle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index a516c1b..d6ed819 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -510,7 +510,7 @@ static int __init beagle_opp_init(void)
 		mpu_dev = get_cpu_device(0);
 		iva_dev = omap_device_get_by_hwmod_name("iva");
 
-		if (IS_ERR(mpu_dev) || IS_ERR(iva_dev)) {
+		if (!mpu_dev || IS_ERR(iva_dev)) {
 			pr_err("%s: Aiee.. no mpu/dsp devices? %p %p\n",
 				__func__, mpu_dev, iva_dev);
 			return -ENODEV;


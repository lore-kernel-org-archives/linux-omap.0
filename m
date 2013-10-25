From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] ARM: OMAP2+: smsc911x: fix return value check in gpmc_smsc911x_init()
Date: Fri, 25 Oct 2013 17:31:51 +0800
Message-ID: <CAPgLHd9V0=GHGYgfuL7cCkzmZT7HVzuNg0iwwsOcipbnJ90bVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f170.google.com ([209.85.215.170]:48451 "EHLO
	mail-ea0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967Ab3JYJbw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Oct 2013 05:31:52 -0400
Received: by mail-ea0-f170.google.com with SMTP id q10so360458eaj.15
        for <linux-omap@vger.kernel.org>; Fri, 25 Oct 2013 02:31:51 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com, tony@atomide.com, linux@arm.linux.org.uk
Cc: yongjun_wei@trendmicro.com.cn, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function platform_device_register_resndata()
returns ERR_PTR() and never returns NULL. The NULL test in the return
value check should be replaced with IS_ERR().

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/arm/mach-omap2/gpmc-smsc911x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/gpmc-smsc911x.c b/arch/arm/mach-omap2/gpmc-smsc911x.c
index ef99011..2757504 100644
--- a/arch/arm/mach-omap2/gpmc-smsc911x.c
+++ b/arch/arm/mach-omap2/gpmc-smsc911x.c
@@ -83,7 +83,7 @@ void __init gpmc_smsc911x_init(struct omap_smsc911x_platform_data *gpmc_cfg)
 	pdev = platform_device_register_resndata(NULL, "smsc911x", gpmc_cfg->id,
 		 gpmc_smsc911x_resources, ARRAY_SIZE(gpmc_smsc911x_resources),
 		 &gpmc_smsc911x_config, sizeof(gpmc_smsc911x_config));
-	if (!pdev) {
+	if (IS_ERR(pdev)) {
 		pr_err("Unable to register platform device\n");
 		gpio_free(gpmc_cfg->gpio_reset);
 		goto free2;


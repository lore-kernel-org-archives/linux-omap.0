From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] gpio/omap: fix possible memory leak in omap2_gpio_dev_init()
Date: Mon, 3 Sep 2012 18:13:33 +0800
Message-ID: <CAPgLHd9A0-Esqt8D87RunMWFFG7uTCERksia26DSO1xw8OUfmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:53398 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756236Ab2ICKNe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Sep 2012 06:13:34 -0400
Received: by qcro28 with SMTP id o28so3263583qcr.19
        for <linux-omap@vger.kernel.org>; Mon, 03 Sep 2012 03:13:33 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux@arm.linux.org.uk
Cc: yongjun_wei@trendmicro.com.cn, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

pdata and pdata->regs have been allocated in this function and 
should be freed before leaving it, and in the other error handling
cases too.

spatch with a semantic match is used to found this problem.
(http://coccinelle.lip6.fr/)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/arm/mach-omap2/gpio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index 9ad7d48..3bfa4bb 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -60,6 +60,7 @@ static int __init omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 	pdata->regs = kzalloc(sizeof(struct omap_gpio_reg_offs), GFP_KERNEL);
 	if (!pdata->regs) {
 		pr_err("gpio%d: Memory allocation failed\n", id);
+		kfree(pdata);
 		return -ENOMEM;
 	}
 
@@ -121,6 +122,7 @@ static int __init omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 		break;
 	default:
 		WARN(1, "Invalid gpio bank_type\n");
+		kfree(pdata->regs);
 		kfree(pdata);
 		return -EINVAL;
 	}
@@ -130,6 +132,7 @@ static int __init omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 
 	pdev = omap_device_build(name, id - 1, oh, pdata,
 				sizeof(*pdata),	NULL, 0, false);
+	kfree(pdata->regs);
 	kfree(pdata);
 
 	if (IS_ERR(pdev)) {



From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] OMAPDSS: fix return value check in create_dss_pdev()
Date: Fri, 21 Sep 2012 14:28:23 +0800
Message-ID: <CAPgLHd-G9Otuu2KT3e8WuW+yxLrHH68vj3dEgOXOZFo70=YFnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:50444 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440Ab2IUG2y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Sep 2012 02:28:54 -0400
Received: by vbbff1 with SMTP id ff1so3487883vbb.19
        for <linux-omap@vger.kernel.org>; Thu, 20 Sep 2012 23:28:53 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux@arm.linux.org.uk
Cc: yongjun_wei@trendmicro.com.cn, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function omap_device_alloc() returns ERR_PTR()
not NULL pointer. The NULL test in the return value check should
be replaced with IS_ERR().

dpatch engine is used to auto generated this patch.
(https://github.com/weiyj/dpatch)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/arm/mach-omap2/display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index af1ed7d..eb1bd01 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -221,7 +221,7 @@ static struct platform_device *create_dss_pdev(const char *pdev_name,
 
 	ohs[0] = oh;
 	od = omap_device_alloc(pdev, ohs, 1, NULL, 0);
-	if (!od) {
+	if (IS_ERR(od)) {
 		pr_err("Could not alloc omap_device for %s\n", pdev_name);
 		r = -ENOMEM;
 		goto err;



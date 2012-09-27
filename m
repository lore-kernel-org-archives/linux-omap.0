From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] ARM: OMAP2+: SmartReflex: fix return value check in sr_dev_init()
Date: Thu, 27 Sep 2012 13:54:22 +0800
Message-ID: <CAPgLHd_jXBNGNh452sGh5OweX+CdwpcVuWHmnfZKaCt4FnsTuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:38591 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475Ab2I0FyW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Sep 2012 01:54:22 -0400
Received: by mail-qc0-f174.google.com with SMTP id d3so786900qch.19
        for <linux-omap@vger.kernel.org>; Wed, 26 Sep 2012 22:54:22 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux@arm.linux.org.uk
Cc: yongjun_wei@trendmicro.com.cn, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function voltdm_lookup() returns NULL
not ERR_PTR(). The IS_ERR() test in the return value check
should be replaced with NULL test.

dpatch engine is used to auto generate this patch.
(https://github.com/weiyj/dpatch)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/arm/mach-omap2/sr_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
index d033a65..c248b30 100644
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -123,7 +123,7 @@ static int __init sr_dev_init(struct omap_hwmod *oh, void *user)
 	sr_data->senp_mod = 0x1;
 
 	sr_data->voltdm = voltdm_lookup(sr_dev_attr->sensor_voltdm_name);
-	if (IS_ERR(sr_data->voltdm)) {
+	if (!sr_data->voltdm) {
 		pr_err("%s: Unable to get voltage domain pointer for VDD %s\n",
 			__func__, sr_dev_attr->sensor_voltdm_name);
 		goto exit;


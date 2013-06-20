From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] ARM: OMAP2+: devices: remove duplicated include from devices.c
Date: Thu, 20 Jun 2013 08:01:05 +0800
Message-ID: <CAPgLHd9rXBA_QtQqOj4JbcFpfPoRTN5Ac9m9ofbP2PKVSmgANA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f41.google.com ([209.85.214.41]:38856 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935056Ab3FTABG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Jun 2013 20:01:06 -0400
Received: by mail-bk0-f41.google.com with SMTP id jc3so2607559bkc.14
        for <linux-omap@vger.kernel.org>; Wed, 19 Jun 2013 17:01:05 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux@arm.linux.org.uk
Cc: yongjun_wei@trendmicro.com.cn, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Remove duplicated include.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/arm/mach-omap2/devices.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index c0f99ab..8349238 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -15,7 +15,6 @@
 #include <linux/io.h>
 #include <linux/clk.h>
 #include <linux/err.h>
-#include <linux/gpio.h>
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/pinctrl/machine.h>


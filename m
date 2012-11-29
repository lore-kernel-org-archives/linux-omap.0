From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] ARM: OMAP4: remove duplicated include from omap_hwmod_44xx_data.c
Date: Wed, 28 Nov 2012 21:45:51 -0500
Message-ID: <CAPgLHd-WVCm8Ewndtu4THRW4gg+tOE6dBj9LDfRfA7MoKgXpBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:63280 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755310Ab2K2Cpx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Nov 2012 21:45:53 -0500
Received: by mail-qc0-f174.google.com with SMTP id o22so10388313qcr.19
        for <linux-omap@vger.kernel.org>; Wed, 28 Nov 2012 18:45:51 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com, tony@atomide.com, linux@arm.linux.org.uk
Cc: yongjun_wei@trendmicro.com.cn, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Remove duplicated include.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index e5eda55..f13fdbb 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -26,7 +26,6 @@
 
 #include <plat-omap/dma-omap.h>
 
-#include <linux/platform_data/omap_ocp2scp.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 #include <linux/platform_data/asoc-ti-mcbsp.h>
 #include <plat/dmtimer.h>



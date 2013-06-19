From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] ARM: OMAP1: remove duplicated include from board-voiceblue.c
Date: Thu, 20 Jun 2013 07:43:29 +0800
Message-ID: <CAPgLHd8t3h03XAzgge8aif-fkGBxqE21hDfThh6neF0WzKJK3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f41.google.com ([209.85.214.41]:44171 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934170Ab3FSXnb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Jun 2013 19:43:31 -0400
Received: by mail-bk0-f41.google.com with SMTP id jc3so2593374bkc.0
        for <linux-omap@vger.kernel.org>; Wed, 19 Jun 2013 16:43:30 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux@arm.linux.org.uk
Cc: yongjun_wei@trendmicro.com.cn, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Remove duplicated include.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/arm/mach-omap1/board-voiceblue.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
index 4677a9c..4b382a0 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -26,7 +26,6 @@
 #include <linux/serial_reg.h>
 #include <linux/smc91x.h>
 #include <linux/export.h>
-#include <linux/reboot.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>


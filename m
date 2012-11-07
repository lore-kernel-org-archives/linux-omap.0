From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] ARM: OMAP2+: remove duplicated include from board-overo.c
Date: Wed, 7 Nov 2012 20:53:49 +0800
Message-ID: <CAPgLHd9ZWdBzaM15ZBckZUGwSq-xcMncFayUrLtWjs0V+QYeqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:48605 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753419Ab2KGMxt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Nov 2012 07:53:49 -0500
Received: by mail-qa0-f46.google.com with SMTP id n12so418646qat.19
        for <linux-omap@vger.kernel.org>; Wed, 07 Nov 2012 04:53:49 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux@arm.linux.org.uk
Cc: yongjun_wei@trendmicro.com.cn, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Remove duplicated include.

dpatch engine is used to auto generate this patch.
(https://github.com/weiyj/dpatch)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/arm/mach-omap2/board-overo.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 1cfb037..f5ba43f 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -45,7 +45,6 @@
 #include <asm/mach/flash.h>
 #include <asm/mach/map.h>
 
-#include "common.h"
 #include <video/omapdss.h>
 #include <video/omap-panel-generic-dpi.h>
 #include <video/omap-panel-tfp410.h>


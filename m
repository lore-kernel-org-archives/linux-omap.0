From: Huang Weiyi <weiyi.huang@gmail.com>
Subject: [PATCH] ARM: OMAP: remove duplicated #include's
Date: Sat, 21 Mar 2009 13:51:04 +0800
Message-ID: <1237614664-3120-1-git-send-email-weiyi.huang@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.185]:48678 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761833AbZCUFvL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 21 Mar 2009 01:51:11 -0400
Received: by ti-out-0910.google.com with SMTP id i7so885025tid.23
        for <linux-omap@vger.kernel.org>; Fri, 20 Mar 2009 22:51:09 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Huang Weiyi <weiyi.huang@gmail.com>

Remove duplicated #include's.

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
---
 arch/arm/mach-omap2/mcbsp.c       |    1 -
 arch/arm/mach-s3c2412/mach-jive.c |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index a9e631f..f548bf4 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -19,7 +19,6 @@
 
 #include <mach/irqs.h>
 #include <mach/dma.h>
-#include <mach/irqs.h>
 #include <mach/mux.h>
 #include <mach/cpu.h>
 #include <mach/mcbsp.h>
diff --git a/arch/arm/mach-s3c2412/mach-jive.c b/arch/arm/mach-s3c2412/mach-jive.c
index ecddbbb..6e85625 100644
--- a/arch/arm/mach-s3c2412/mach-jive.c
+++ b/arch/arm/mach-s3c2412/mach-jive.c
@@ -52,7 +52,6 @@
 #include <plat/cpu.h>
 #include <plat/pm.h>
 #include <plat/udc.h>
-#include <plat/iic.h>
 
 static struct map_desc jive_iodesc[] __initdata = {
 };
-- 
1.6.0.4


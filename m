From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 11/17] omap: mailbox: trivial sync between omap1 and 2
Date: Fri, 14 May 2010 18:01:44 +0300
Message-ID: <1273849310-32169-12-git-send-email-felipe.contreras@gmail.com>
References: <1273849310-32169-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:31925 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755464Ab0ENPCZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 11:02:25 -0400
Received: by ey-out-2122.google.com with SMTP id d26so283220eyd.19
        for <linux-omap@vger.kernel.org>; Fri, 14 May 2010 08:02:24 -0700 (PDT)
In-Reply-To: <1273849310-32169-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Felipe Contreras <felipe.contreras@gmail.com>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap1/mailbox.c |    2 +-
 arch/arm/mach-omap2/mailbox.c |    6 ++----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap1/mailbox.c b/arch/arm/mach-omap1/mailbox.c
index 8c1b83f..91780a0 100644
--- a/arch/arm/mach-omap1/mailbox.c
+++ b/arch/arm/mach-omap1/mailbox.c
@@ -1,5 +1,5 @@
 /*
- * Mailbox reservation modules for DSP
+ * Mailbox reservation modules for OMAP1
  *
  * Copyright (C) 2006-2009 Nokia Corporation
  * Written by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 4f3b84e..adbf5d7 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -18,8 +18,6 @@
 #include <plat/mailbox.h>
 #include <mach/irqs.h>
 
-#define DRV_NAME "omap2-mailbox"
-
 #define MAILBOX_REVISION		0x000
 #define MAILBOX_SYSCONFIG		0x010
 #define MAILBOX_SYSSTATUS		0x014
@@ -475,7 +473,7 @@ static struct platform_driver omap2_mbox_driver = {
 	.probe = omap2_mbox_probe,
 	.remove = __devexit_p(omap2_mbox_remove),
 	.driver = {
-		.name = DRV_NAME,
+		.name = "omap2-mailbox",
 	},
 };
 
@@ -560,4 +558,4 @@ MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("omap mailbox: omap2/3/4 architecture specific functions");
 MODULE_AUTHOR("Hiroshi DOYU <Hiroshi.DOYU@nokia.com>");
 MODULE_AUTHOR("Paul Mundt");
-MODULE_ALIAS("platform:"DRV_NAME);
+MODULE_ALIAS("platform:omap2-mailbox");
-- 
1.7.1


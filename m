From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 13/14] omap: mailbox: standarize on 'omap-mailbox'
Date: Fri, 11 Jun 2010 18:51:48 +0300
Message-ID: <1276271509-11983-14-git-send-email-felipe.contreras@gmail.com>
References: <1276271509-11983-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:41041 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758121Ab0FKPwz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Jun 2010 11:52:55 -0400
Received: by mail-ww0-f46.google.com with SMTP id 18so872602wwb.19
        for <linux-omap@vger.kernel.org>; Fri, 11 Jun 2010 08:52:54 -0700 (PDT)
In-Reply-To: <1276271509-11983-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Felipe Contreras <felipe.contreras@gmail.com>

omap{1,2}-mailbox are modules that provide the 'omap-mailbox' driver.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap1/devices.c |    2 +-
 arch/arm/mach-omap1/mailbox.c |    4 ++--
 arch/arm/mach-omap2/devices.c |    2 +-
 arch/arm/mach-omap2/mailbox.c |    6 ++----
 4 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index 314fea3..16e43e5 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -87,7 +87,7 @@ static struct resource mbox_resources[] = {
 };
 
 static struct platform_device mbox_device = {
-	.name		= "omap1-mailbox",
+	.name		= "omap-mailbox",
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(mbox_resources),
 	.resource	= mbox_resources,
diff --git a/arch/arm/mach-omap1/mailbox.c b/arch/arm/mach-omap1/mailbox.c
index 9ca0d58..afc3963 100644
--- a/arch/arm/mach-omap1/mailbox.c
+++ b/arch/arm/mach-omap1/mailbox.c
@@ -1,5 +1,5 @@
 /*
- * Mailbox reservation modules for DSP
+ * Mailbox reservation modules for OMAP1
  *
  * Copyright (C) 2006-2009 Nokia Corporation
  * Written by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
@@ -179,7 +179,7 @@ static struct platform_driver omap1_mbox_driver = {
 	.probe	= omap1_mbox_probe,
 	.remove	= __devexit_p(omap1_mbox_remove),
 	.driver	= {
-		.name	= "omap1-mailbox",
+		.name	= "omap-mailbox",
 	},
 };
 
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index b621476..d9ac853 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -206,7 +206,7 @@ static int omap4_mbox_resources_sz = ARRAY_SIZE(omap4_mbox_resources);
 #endif
 
 static struct platform_device mbox_device = {
-	.name		= "omap2-mailbox",
+	.name		= "omap-mailbox",
 	.id		= -1,
 };
 
diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 4c0c112..62d5ffe 100644
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
@@ -451,7 +449,7 @@ static struct platform_driver omap2_mbox_driver = {
 	.probe = omap2_mbox_probe,
 	.remove = __devexit_p(omap2_mbox_remove),
 	.driver = {
-		.name = DRV_NAME,
+		.name = "omap-mailbox",
 	},
 };
 
@@ -472,4 +470,4 @@ MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("omap mailbox: omap2/3/4 architecture specific functions");
 MODULE_AUTHOR("Hiroshi DOYU <Hiroshi.DOYU@nokia.com>");
 MODULE_AUTHOR("Paul Mundt");
-MODULE_ALIAS("platform:"DRV_NAME);
+MODULE_ALIAS("platform:omap2-mailbox");
-- 
1.7.1


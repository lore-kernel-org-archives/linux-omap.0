From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 09/14] omap: mailbox: add IRQ names
Date: Sat, 22 May 2010 20:14:20 +0300
Message-ID: <1274548465-20208-10-git-send-email-felipe.contreras@gmail.com>
References: <1274548465-20208-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55289 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755873Ab0EVROw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 22 May 2010 13:14:52 -0400
Received: by mail-bw0-f46.google.com with SMTP id 7so383709bwz.19
        for <linux-omap@vger.kernel.org>; Sat, 22 May 2010 10:14:51 -0700 (PDT)
In-Reply-To: <1274548465-20208-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Tony Lindgren <tony@atomide.com>, Felipe Contreras <felipe.contreras@gmail.com>

Will be useful to identify them later.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap1/devices.c |    1 +
 arch/arm/mach-omap2/devices.c |    4 ++++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index da796f2..314fea3 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -82,6 +82,7 @@ static struct resource mbox_resources[] = {
 	{
 		.start		= INT_DSP_MAILBOX1,
 		.flags		= IORESOURCE_IRQ,
+		.name		= "dsp",
 	},
 };
 
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 2271b9b..b621476 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -150,10 +150,12 @@ static struct resource omap2_mbox_resources[] = {
 	{
 		.start		= INT_24XX_MAIL_U0_MPU,
 		.flags		= IORESOURCE_IRQ,
+		.name		= "dsp",
 	},
 	{
 		.start		= INT_24XX_MAIL_U3_MPU,
 		.flags		= IORESOURCE_IRQ,
+		.name		= "iva",
 	},
 };
 static int omap2_mbox_resources_sz = ARRAY_SIZE(omap2_mbox_resources);
@@ -172,6 +174,7 @@ static struct resource omap3_mbox_resources[] = {
 	{
 		.start		= INT_24XX_MAIL_U0_MPU,
 		.flags		= IORESOURCE_IRQ,
+		.name		= "dsp",
 	},
 };
 static int omap3_mbox_resources_sz = ARRAY_SIZE(omap3_mbox_resources);
@@ -193,6 +196,7 @@ static struct resource omap4_mbox_resources[] = {
 	{
 		.start          = OMAP44XX_IRQ_MAIL_U0,
 		.flags          = IORESOURCE_IRQ,
+		.name		= "mbox",
 	},
 };
 static int omap4_mbox_resources_sz = ARRAY_SIZE(omap4_mbox_resources);
-- 
1.7.1


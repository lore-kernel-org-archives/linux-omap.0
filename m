From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 09/14] omap: mailbox: add IRQ names
Date: Fri, 11 Jun 2010 18:51:44 +0300
Message-ID: <1276271509-11983-10-git-send-email-felipe.contreras@gmail.com>
References: <1276271509-11983-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:40606 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758024Ab0FKPwo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Jun 2010 11:52:44 -0400
Received: by yxl31 with SMTP id 31so329831yxl.19
        for <linux-omap@vger.kernel.org>; Fri, 11 Jun 2010 08:52:43 -0700 (PDT)
In-Reply-To: <1276271509-11983-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Felipe Contreras <felipe.contreras@gmail.com>

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


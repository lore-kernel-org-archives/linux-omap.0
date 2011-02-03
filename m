From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/RFC/PATCH 06/13] arm: omap: cbus: pass irq_base and irq_end via platform_data
Date: Thu,  3 Feb 2011 12:20:21 +0200
Message-ID: <1296728428-26399-7-git-send-email-balbi@ti.com>
References: <1296728428-26399-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:58306 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756152Ab1BCKUu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Feb 2011 05:20:50 -0500
Received: by mail-fx0-f46.google.com with SMTP id 20so1164302fxm.5
        for <linux-omap@vger.kernel.org>; Thu, 03 Feb 2011 02:20:49 -0800 (PST)
In-Reply-To: <1296728428-26399-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

Pass CBUS_RETU_IRQ_BASE and CBUS_RETU_IRQ_END via
platform_data to retu platform_driver.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap1/board-nokia770.c   |    8 ++++++++
 arch/arm/mach-omap2/board-n8x0.c       |    8 ++++++++
 arch/arm/plat-omap/include/plat/cbus.h |    5 +++++
 3 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index 84797a7..d939370 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -123,11 +123,19 @@ static struct resource retu_resource[] = {
 	},
 };
 
+static struct cbus_retu_platform_data nokia770_retu_data = {
+	.irq_base	= CBUS_RETU_IRQ_BASE,
+	.irq_end	= CBUS_RETU_IRQ_END,
+};
+
 static struct platform_device retu_device = {
 	.name		= "retu",
 	.id		= -1,
 	.resource	= retu_resource,
 	.num_resources	= ARRAY_SIZE(retu_resource),
+	.dev		= {
+		.platform_data = &nokia770_retu_data,
+	},
 };
 
 static struct resource tahvo_resource[] = {
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index 1cb53bc..1e4bfb2 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -220,11 +220,19 @@ static struct resource retu_resource[] = {
 	},
 };
 
+static struct cbus_retu_platform_data n8x0_retu_data = {
+	.irq_base	= CBUS_RETU_IRQ_BASE,
+	.irq_end	= CBUS_RETU_IRQ_END,
+};
+
 static struct platform_device retu_device = {
 	.name		= "retu",
 	.id		= -1,
 	.resource	= retu_resource,
 	.num_resources	= ARRAY_SIZE(retu_resource),
+	.dev		= {
+		.platform_data = &n8x0_retu_data,
+	},
 };
 
 static struct resource tahvo_resource[] = {
diff --git a/arch/arm/plat-omap/include/plat/cbus.h b/arch/arm/plat-omap/include/plat/cbus.h
index d938e23..1f0e8be 100644
--- a/arch/arm/plat-omap/include/plat/cbus.h
+++ b/arch/arm/plat-omap/include/plat/cbus.h
@@ -28,4 +28,9 @@ struct cbus_host_platform_data {
 	int	sel_gpio;
 };
 
+struct cbus_retu_platform_data {
+	int	irq_base;
+	int	irq_end;
+};
+
 #endif /* __PLAT_CBUS_H */
-- 
1.7.4.rc2


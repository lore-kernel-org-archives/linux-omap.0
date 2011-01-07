From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/PATCH v2 06/12] arm: omap: cbus: pass irq_base and irq_end via platform_data
Date: Fri,  7 Jan 2011 11:08:04 +0200
Message-ID: <1294391290-7285-7-git-send-email-balbi@ti.com>
References: <1294391290-7285-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:50007 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754265Ab1AGJIc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 04:08:32 -0500
Received: by mail-ew0-f47.google.com with SMTP id 28so4339813ewy.6
        for <linux-omap@vger.kernel.org>; Fri, 07 Jan 2011 01:08:31 -0800 (PST)
In-Reply-To: <1294391290-7285-1-git-send-email-balbi@ti.com>
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
index 9b52e2d..cd5091f 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -221,11 +221,19 @@ static struct resource retu_resource[] = {
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
1.7.3.4.598.g85356


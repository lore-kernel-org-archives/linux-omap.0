From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 4/4] cbus: retu: drop useless platform_data
Date: Mon, 17 Oct 2011 23:50:43 +0300
Message-ID: <1318884643-4137-4-git-send-email-balbi@ti.com>
References: <1318884643-4137-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:48954 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754115Ab1JQUuy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Oct 2011 16:50:54 -0400
Received: by mail-bw0-f43.google.com with SMTP id 17so7278870bke.30
        for <linux-omap@vger.kernel.org>; Mon, 17 Oct 2011 13:50:53 -0700 (PDT)
In-Reply-To: <1318884643-4137-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

there's no need for that at all.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap1/board-nokia770.c |    5 -----
 arch/arm/mach-omap2/board-n8x0.c     |    5 -----
 include/linux/platform_data/cbus.h   |    4 ----
 3 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index 3a72a44..62533cd 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -123,17 +123,12 @@ static struct resource retu_resource[] = {
 	},
 };
 
-static struct cbus_retu_platform_data nokia770_retu_data = {
-	.devid		= CBUS_RETU_DEVICE_ID,
-};
-
 static struct platform_device retu_device = {
 	.name		= "retu",
 	.id		= -1,
 	.resource	= retu_resource,
 	.num_resources	= ARRAY_SIZE(retu_resource),
 	.dev		= {
-		.platform_data = &nokia770_retu_data,
 		.parent	= &nokia770_cbus_device.dev,
 	},
 };
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index bf2e51f..1cbacde 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -219,17 +219,12 @@ static struct resource retu_resource[] = {
 	},
 };
 
-static struct cbus_retu_platform_data n8x0_retu_data = {
-	.devid		= CBUS_RETU_DEVICE_ID,
-};
-
 static struct platform_device retu_device = {
 	.name		= "retu",
 	.id		= -1,
 	.resource	= retu_resource,
 	.num_resources	= ARRAY_SIZE(retu_resource),
 	.dev		= {
-		.platform_data = &n8x0_retu_data,
 		.parent	= &n8x0_cbus_device.dev,
 	},
 };
diff --git a/include/linux/platform_data/cbus.h b/include/linux/platform_data/cbus.h
index 5bd9211..7a977e1 100644
--- a/include/linux/platform_data/cbus.h
+++ b/include/linux/platform_data/cbus.h
@@ -28,8 +28,4 @@ struct cbus_host_platform_data {
 	int	sel_gpio;
 };
 
-struct cbus_retu_platform_data {
-	int	devid;
-};
-
 #endif /* __INCLUDE_LINUX_CBUS_H */
-- 
1.7.7


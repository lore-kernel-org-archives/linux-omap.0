From: Archit Taneja <archit@ti.com>
Subject: [PATCH 32/33] arm: dss-common: don't use reset_gpio from omap4_panda_dvi_device
Date: Wed, 13 Feb 2013 19:52:24 +0530
Message-ID: <1360765345-19312-33-git-send-email-archit@ti.com>
References: <1360765345-19312-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39967 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934039Ab3BMOYv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Feb 2013 09:24:51 -0500
In-Reply-To: <1360765345-19312-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>, Tony Lindgren <tony@atomide.com>

gpio reset info is passed to the tfp410 panel driver via the panel's platform
data struct 'tfp410_platform_data'. The tfp driver doesn't use the reset_gpio
field in the omap4_panda_dvi_device struct. Remove this field.

Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Archit Taneja <archit@ti.com>
---
 arch/arm/mach-omap2/dss-common.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-omap2/dss-common.c b/arch/arm/mach-omap2/dss-common.c
index b073e8b..393aeef 100644
--- a/arch/arm/mach-omap2/dss-common.c
+++ b/arch/arm/mach-omap2/dss-common.c
@@ -52,7 +52,6 @@ static struct omap_dss_device omap4_panda_dvi_device = {
 	.driver_name		= "tfp410",
 	.data			= &omap4_dvi_panel,
 	.phy.dpi.data_lines	= 24,
-	.reset_gpio		= PANDA_DVI_TFP410_POWER_DOWN_GPIO,
 	.channel		= OMAP_DSS_CHANNEL_LCD2,
 };
 
-- 
1.7.9.5


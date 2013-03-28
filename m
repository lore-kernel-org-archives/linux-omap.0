From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 02/28] ARM: OMAP: don't use reset_gpio from omap4_panda_dvi_device
Date: Thu, 28 Mar 2013 14:48:56 +0200
Message-ID: <1364474962-20439-3-git-send-email-tomi.valkeinen@ti.com>
References: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38194 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755121Ab3C1Mtq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Mar 2013 08:49:46 -0400
In-Reply-To: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

From: Archit Taneja <archit@ti.com>

gpio reset info is passed to the tfp410 panel driver via the panel's platform
data struct 'tfp410_platform_data'. The tfp driver doesn't use the reset_gpio
field in the omap4_panda_dvi_device struct. Remove this field.

Signed-off-by: Archit Taneja <archit@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/dss-common.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-omap2/dss-common.c b/arch/arm/mach-omap2/dss-common.c
index 4be5cfc..4228e57 100644
--- a/arch/arm/mach-omap2/dss-common.c
+++ b/arch/arm/mach-omap2/dss-common.c
@@ -54,7 +54,6 @@ static struct omap_dss_device omap4_panda_dvi_device = {
 	.driver_name		= "tfp410",
 	.data			= &omap4_dvi_panel,
 	.phy.dpi.data_lines	= 24,
-	.reset_gpio		= PANDA_DVI_TFP410_POWER_DOWN_GPIO,
 	.channel		= OMAP_DSS_CHANNEL_LCD2,
 };
 
-- 
1.7.10.4


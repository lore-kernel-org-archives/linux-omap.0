From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 05/21] ARM: OMAP: 4430SDP: remove picodlp device data
Date: Fri, 26 Jul 2013 10:08:08 +0300
Message-ID: <1374822504-28949-6-git-send-email-tomi.valkeinen@ti.com>
References: <1374822504-28949-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38922 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757040Ab3GZHJb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Jul 2013 03:09:31 -0400
In-Reply-To: <1374822504-28949-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

4430SDP board has an option for a PicoDLP mini-projector. PicoDLP cannot
be used at the same time as the second LCD, and there are GPIOs that
need to be set/unset when changing the used display.

Managing that kind of board specific setup is not simple without board
file callbacks. As only some 4430SDP boards actually have the PicoDLP
installed, and 4430SDP boards are not that common in the first place,
let's remove PicoDLP data from the board file.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/dss-common.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/arch/arm/mach-omap2/dss-common.c b/arch/arm/mach-omap2/dss-common.c
index 3215412..bf89eff 100644
--- a/arch/arm/mach-omap2/dss-common.c
+++ b/arch/arm/mach-omap2/dss-common.c
@@ -181,28 +181,7 @@ static struct platform_device sdp4430_tpd_device = {
 };
 
 
-static struct picodlp_panel_data sdp4430_picodlp_pdata = {
-	.picodlp_adapter_id	= 2,
-	.emu_done_gpio		= 44,
-	.pwrgood_gpio		= 45,
-};
-
-static struct omap_dss_device sdp4430_picodlp_device = {
-	.name			= "picodlp",
-	.driver_name		= "picodlp_panel",
-	.type			= OMAP_DISPLAY_TYPE_DPI,
-	.phy.dpi.data_lines	= 24,
-	.channel		= OMAP_DSS_CHANNEL_LCD2,
-	.data			= &sdp4430_picodlp_pdata,
-};
-
-static struct omap_dss_device *sdp4430_dss_devices[] = {
-	&sdp4430_picodlp_device,
-};
-
 static struct omap_dss_board_info sdp4430_dss_data = {
-	.num_devices	= ARRAY_SIZE(sdp4430_dss_devices),
-	.devices	= sdp4430_dss_devices,
 	.default_display_name = "lcd",
 };
 
-- 
1.8.1.2


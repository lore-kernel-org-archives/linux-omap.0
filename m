From: Igor Grinberg <grinberg@compulab.co.il>
Subject: [PATCH 2/2] [ARM] omap: cm-t35: fix video signal on DVI panels
Date: Mon, 26 Jul 2010 13:34:28 +0300
Message-ID: <1280140468-8183-2-git-send-email-grinberg@compulab.co.il>
References: <1280140468-8183-1-git-send-email-grinberg@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:46246 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753884Ab0GZKeq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Jul 2010 06:34:46 -0400
In-Reply-To: <1280140468-8183-1-git-send-email-grinberg@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Igor Grinberg <grinberg@compulab.co.il>, Mike Rapoport <mike@compulab.co.il>

CM-T35 DVI transmitter sampling the data on the raising edge of the
pixel clock, therefore the data strobe should happen on the falling
edge.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mach-omap2/board-cm-t35.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index e679a2c..1b636f8 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -384,6 +384,7 @@ static struct omap_dss_device cm_t35_dvi_device = {
 	.driver_name		= "generic_panel",
 	.type			= OMAP_DISPLAY_TYPE_DPI,
 	.phy.dpi.data_lines	= 24,
+	.panel.config		= OMAP_DSS_LCD_IPC | OMAP_DSS_LCD_ONOFF,
 	.platform_enable	= cm_t35_panel_enable_dvi,
 	.platform_disable	= cm_t35_panel_disable_dvi,
 };
-- 
1.7.1


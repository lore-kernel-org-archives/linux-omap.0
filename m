From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Using DSI PLL for LCD pixel clock
Date: Mon, 23 May 2011 10:26:02 +0300
Message-ID: <1306135562.1871.3.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:52125 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751082Ab1EWH0I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 May 2011 03:26:08 -0400
Received: by eyx24 with SMTP id 24so1721294eyx.19
        for <linux-omap@vger.kernel.org>; Mon, 23 May 2011 00:26:06 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <steve@sakoman.com>
Cc: linux-omap@vger.kernel.org

Hi Steve,

I know you've been using OMAP2_DSS_USE_DSI_PLL Kconfig option to use DSI
PLL for pixel clock, so I wanted to point out that that has changed in
the current DSS2 master (soon to be merged, I hope). You will now need
to select the clock usage in the board file, for example:

diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 9d192ff..68a33bb 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -345,6 +345,11 @@ static struct omap_dss_device overo_lcd43_device = {
        .driver_name            = "generic_dpi_panel",
        .data                   = &lcd43_panel,
        .phy.dpi.data_lines     = 24,
+       .clocks = {
+               .dispc = {
+                       .dispc_fclk_src = OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC,
+               },
+       },
 };

 Tomi





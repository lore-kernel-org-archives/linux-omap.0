From: "Nagarajan, Rajkumar" <x0133774@ti.com>
Subject: [PATCH] OMAP: DSS: Fix for dsi_pll to dpll4 clk switch
Date: Thu, 17 Jun 2010 10:42:18 +0530
Message-ID: <FF55437E1F14DA4BAEB721A458B6701706BDA5E730@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40806 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065Ab0FQFMX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jun 2010 01:12:23 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o5H5CK55031700
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 17 Jun 2010 00:12:22 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o5H5CJRQ007155
	for <linux-omap@vger.kernel.org>; Thu, 17 Jun 2010 10:42:19 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


When switching between clocks, The new functional clock is
effective when the next vertical blanking interval occurs.
GOLCD bit has to be set for the new clock to take effect.

Signed-off-by: Kishore Y <kishore.y@ti.com>
Signed-off-by: Mukund Mittal <mmittal@ti.com>
Signed-off-by: Rajkumar N <rajkumar.nagarajan@ti.com>
---
 drivers/video/omap2/dss/dpi.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 960e977..5d778d6 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -214,10 +214,15 @@ void omapdss_dpi_display_disable(struct omap_dss_device *dssdev)
 
 #ifdef CONFIG_OMAP2_DSS_USE_DSI_PLL
 	dss_select_dispc_clk_source(DSS_SRC_DSS1_ALWON_FCLK);
+	dispc_go(OMAP_DSS_CHANNEL_LCD);
+	while	(dispc_go_busy(OMAP_DSS_CHANNEL_LCD))
+		;
 	dsi_pll_uninit();
 	dss_clk_disable(DSS_CLK_FCK2);
 #endif
 
+	dispc_enable_channel(OMAP_DSS_CHANNEL_LCD, 0);
+
 	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1);
 
 	if (cpu_is_omap34xx())
-- 
1.5.4.3

From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 1/6] OMAP: 4430SDP/Panda: use gpio_free_array to free HDMI gpios
Date: Tue, 17 Jan 2012 14:48:57 +0200
Message-ID: <1326804542-22285-2-git-send-email-tomi.valkeinen@ti.com>
References: <1326804542-22285-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:38307 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753399Ab2AQMte (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Jan 2012 07:49:34 -0500
In-Reply-To: <1326804542-22285-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, mythripk@ti.com
Cc: archit@ti.com, x0132446@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Instead of freeing the GPIOs individually, use gpio_free_array().

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c    |    3 +--
 arch/arm/mach-omap2/board-omap4panda.c |    3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 4af874a..d7017f2 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -614,8 +614,7 @@ static int sdp4430_panel_enable_hdmi(struct omap_dss_device *dssdev)
 
 static void sdp4430_panel_disable_hdmi(struct omap_dss_device *dssdev)
 {
-	gpio_free(HDMI_GPIO_LS_OE);
-	gpio_free(HDMI_GPIO_HPD);
+	gpio_free_array(sdp4430_hdmi_gpios, ARRAY_SIZE(sdp4430_hdmi_gpios));
 }
 
 static struct nokia_dsi_panel_data dsi1_panel = {
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 00103e3..b9f90ba 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -497,8 +497,7 @@ static int omap4_panda_panel_enable_hdmi(struct omap_dss_device *dssdev)
 
 static void omap4_panda_panel_disable_hdmi(struct omap_dss_device *dssdev)
 {
-	gpio_free(HDMI_GPIO_LS_OE);
-	gpio_free(HDMI_GPIO_HPD);
+	gpio_free_array(panda_hdmi_gpios, ARRAY_SIZE(panda_hdmi_gpios));
 }
 
 static struct omap_dss_device  omap4_panda_hdmi_device = {
-- 
1.7.4.1


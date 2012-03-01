From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 2/7] OMAP: 4430SDP/Panda: use gpio_free_array to free HDMI gpios
Date: Thu,  1 Mar 2012 14:34:41 +0200
Message-ID: <1330605286-24166-3-git-send-email-tomi.valkeinen@ti.com>
References: <1330605286-24166-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:37834 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759134Ab2CAMfF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Mar 2012 07:35:05 -0500
Received: by lagv3 with SMTP id v3so963105lag.13
        for <linux-omap@vger.kernel.org>; Thu, 01 Mar 2012 04:35:03 -0800 (PST)
In-Reply-To: <1330605286-24166-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: stable@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Instead of freeing the GPIOs individually, use gpio_free_array().

Backported from 575753e3bea3b67eef8e454fb87f719e3f7da599

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-4430sdp.c    |    3 +--
 arch/arm/mach-omap2/board-omap4panda.c |    3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index f515fa2..7feefb8 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -609,8 +609,7 @@ static int sdp4430_panel_enable_hdmi(struct omap_dss_device *dssdev)
 
 static void sdp4430_panel_disable_hdmi(struct omap_dss_device *dssdev)
 {
-	gpio_free(HDMI_GPIO_LS_OE);
-	gpio_free(HDMI_GPIO_HPD);
+	gpio_free_array(sdp4430_hdmi_gpios, ARRAY_SIZE(sdp4430_hdmi_gpios));
 }
 
 static struct omap_dss_device sdp4430_hdmi_device = {
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 0cfe200..2e9a6f36 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -645,8 +645,7 @@ static int omap4_panda_panel_enable_hdmi(struct omap_dss_device *dssdev)
 
 static void omap4_panda_panel_disable_hdmi(struct omap_dss_device *dssdev)
 {
-	gpio_free(HDMI_GPIO_LS_OE);
-	gpio_free(HDMI_GPIO_HPD);
+	gpio_free_array(panda_hdmi_gpios, ARRAY_SIZE(panda_hdmi_gpios));
 }
 
 static struct omap_dss_device  omap4_panda_hdmi_device = {
-- 
1.7.4.1


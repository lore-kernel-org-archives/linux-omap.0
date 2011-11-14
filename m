From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 1/3] OMAPDSS: HDMI: fix returned HDMI pixel clock
Date: Mon, 14 Nov 2011 17:01:43 +0200
Message-ID: <1321282905-12939-2-git-send-email-tomi.valkeinen@ti.com>
References: <1321282905-12939-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:33674 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752279Ab1KNPB7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Nov 2011 10:01:59 -0500
In-Reply-To: <1321282905-12939-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

hdmi_get_pixel_clock() returns the pixel clock in Hz, but the pck is
stored as kHz. This means the return value has to be multiplied by 1000,
not by 10000 as the code did.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/hdmi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 3262f0f..c56378c 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -269,7 +269,7 @@ static void update_hdmi_timings(struct hdmi_config *cfg,
 unsigned long hdmi_get_pixel_clock(void)
 {
 	/* HDMI Pixel Clock in Mhz */
-	return hdmi.ip_data.cfg.timings.timings.pixel_clock * 10000;
+	return hdmi.ip_data.cfg.timings.timings.pixel_clock * 1000;
 }
 
 static void hdmi_compute_pll(struct omap_dss_device *dssdev, int phy,
-- 
1.7.4.1


From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 2/8] OMAPDSS: HDMI: Add delay to wait for 5V power
Date: Thu, 23 Aug 2012 16:45:08 +0300
Message-ID: <1345729514-2441-3-git-send-email-tomi.valkeinen@ti.com>
References: <1345729514-2441-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:60845 "EHLO
	na3sys009aog131.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933047Ab2HWNpi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Aug 2012 09:45:38 -0400
Received: by lahd3 with SMTP id d3so457880lah.0
        for <linux-omap@vger.kernel.org>; Thu, 23 Aug 2012 06:45:34 -0700 (PDT)
In-Reply-To: <1345729514-2441-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

TPD12S015A spec says to wait 300us after setting CT_CP_HPD gpio for the
5V power output to reach 90% of the voltage. This patch adds the delay
to the driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/hdmi.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 4fbe271..96a6e29 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -492,6 +492,9 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 	gpio_set_value(hdmi.ct_cp_hpd_gpio, 1);
 	gpio_set_value(hdmi.ls_oe_gpio, 1);
 
+	/* wait 300us after CT_CP_HPD for the 5V power output to reach 90% */
+	udelay(300);
+
 	r = hdmi_runtime_get();
 	if (r)
 		goto err_runtime_get;
-- 
1.7.9.5


From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 20/22] OMAPDSS: HDMI: remove extra poweroff
Date: Wed, 12 Nov 2014 13:52:22 +0200
Message-ID: <1415793144-11723-21-git-send-email-tomi.valkeinen@ti.com>
References: <1415793144-11723-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53631 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752554AbaKLLxP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Nov 2014 06:53:15 -0500
In-Reply-To: <1415793144-11723-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

hdmi_pll_enable powers off the PLL as the first thing it does. Right
after that, it enables the PLL powers.

The initial power-off is pointless, so let's remove it.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi_pll.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi_pll.c b/drivers/video/fbdev/omap2/dss/hdmi_pll.c
index c14c3d132513..92d22252f86a 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi_pll.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi_pll.c
@@ -171,10 +171,6 @@ int hdmi_pll_enable(struct hdmi_pll_data *pll)
 	struct hdmi_wp_data *wp = pll->wp;
 	u16 r = 0;
 
-	r = hdmi_wp_set_pll_pwr(wp, HDMI_PLLPWRCMD_ALLOFF);
-	if (r)
-		return r;
-
 	r = hdmi_wp_set_pll_pwr(wp, HDMI_PLLPWRCMD_BOTHON_ALLCLKS);
 	if (r)
 		return r;
-- 
2.1.3


From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 02/15] OMAPDSS: HDMI5: Increase DDC SDA-HOLD time
Date: Thu, 26 Feb 2015 14:48:56 +0200
Message-ID: <1424954949-12801-2-git-send-email-tomi.valkeinen@ti.com>
References: <1424954949-12801-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60613 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932105AbbBZMtf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Feb 2015 07:49:35 -0500
In-Reply-To: <1424954949-12801-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

It has been observed that the current SDA-HOLD time is too short for
some board/cable/monitor combinations. Increase the SDA-HOLD time to
1000ns.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi5_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi5_core.c b/drivers/video/fbdev/omap2/dss/hdmi5_core.c
index a3cfe3d708f7..bfc0c4c297d6 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi5_core.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi5_core.c
@@ -55,7 +55,7 @@ static void hdmi_core_ddc_init(struct hdmi_core_data *core)
 	const unsigned ss_scl_low = 4700;		/* ns */
 	const unsigned fs_scl_high = 600;		/* ns */
 	const unsigned fs_scl_low = 1300;		/* ns */
-	const unsigned sda_hold = 300;			/* ns */
+	const unsigned sda_hold = 1000;			/* ns */
 	const unsigned sfr_div = 10;
 	unsigned long long sfr;
 	unsigned v;
-- 
2.3.0


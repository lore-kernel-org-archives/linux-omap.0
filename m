From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] OMAPDSS: Correct check for the callback pointer in dss_dsi_disable_pads()
Date: Tue, 16 Oct 2012 13:51:21 +0200
Message-ID: <1350388281-20397-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51962 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558Ab2JPLv0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Oct 2012 07:51:26 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

Appear to be a copy-paste bug: the code was checking board_data->dsi_enable_pads
while calling board_data->dsi_disable_pads.


Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---

Hi Tomi,

not sure if this need to be included to 3.7

Regards,
Peter

 drivers/video/omap2/dss/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index b2af72d..7afaf61 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -122,7 +122,7 @@ void dss_dsi_disable_pads(int dsi_id, unsigned lane_mask)
 {
 	struct omap_dss_board_info *board_data = core.pdev->dev.platform_data;
 
-	if (!board_data->dsi_enable_pads)
+	if (!board_data->dsi_disable_pads)
 		return;
 
 	return board_data->dsi_disable_pads(dsi_id, lane_mask);
-- 
1.7.12.3


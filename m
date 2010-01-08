From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 02/15] OMAP: DSS2: DSI: print debug DCS cmd in hex
Date: Fri,  8 Jan 2010 15:22:36 +0200
Message-ID: <1262956969-1664-3-git-send-email-tomi.valkeinen@nokia.com>
References: <1262956969-1664-1-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-2-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:25273 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752516Ab0AHNWX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jan 2010 08:22:23 -0500
In-Reply-To: <1262956969-1664-2-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 drivers/video/omap2/dss/dsi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index c37bc5b..dda7b3f 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -2059,7 +2059,7 @@ int dsi_vc_dcs_read(int channel, u8 dcs_cmd, u8 *buf, int buflen)
 	int r;
 
 	if (dsi.debug_read)
-		DSSDBG("dsi_vc_dcs_read(ch%d, dcs_cmd %u)\n", channel, dcs_cmd);
+		DSSDBG("dsi_vc_dcs_read(ch%d, dcs_cmd %x)\n", channel, dcs_cmd);
 
 	r = dsi_vc_send_short(channel, DSI_DT_DCS_READ, dcs_cmd, 0);
 	if (r)
-- 
1.6.5


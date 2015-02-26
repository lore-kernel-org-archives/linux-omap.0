From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 03/15] OMAPDSS: fix paddr check for TILER addresses
Date: Thu, 26 Feb 2015 14:48:57 +0200
Message-ID: <1424954949-12801-3-git-send-email-tomi.valkeinen@ti.com>
References: <1424954949-12801-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37395 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932165AbbBZMth (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Feb 2015 07:49:37 -0500
In-Reply-To: <1424954949-12801-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The DISPC driver checks that the buffer address is not 0. However, when
using TILER, the address space is TILER specific and 0 is a valid
address.

Fix the check to allow address of 0 for TILER.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Reported-by: srinivas pulukuru <srinivas.pulukuru@ti.com>
---
 drivers/video/fbdev/omap2/dss/dispc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/dss/dispc.c b/drivers/video/fbdev/omap2/dss/dispc.c
index 31b743c70272..a19a1d4b2d19 100644
--- a/drivers/video/fbdev/omap2/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/dss/dispc.c
@@ -2441,7 +2441,7 @@ static int dispc_ovl_setup_common(enum omap_plane plane,
 	unsigned long pclk = dispc_plane_pclk_rate(plane);
 	unsigned long lclk = dispc_plane_lclk_rate(plane);
 
-	if (paddr == 0)
+	if (paddr == 0 && rotation_type != OMAP_DSS_ROT_TILER)
 		return -EINVAL;
 
 	out_width = out_width == 0 ? width : out_width;
-- 
2.3.0


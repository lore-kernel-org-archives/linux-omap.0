From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 01/11] OMAPDSS: DISPC: work-around for errata i631
Date: Wed, 17 Jun 2015 15:54:25 +0300
Message-ID: <1434545675-477-2-git-send-email-tomi.valkeinen@ti.com>
References: <1434545675-477-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43894 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753116AbbFQMyv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Jun 2015 08:54:51 -0400
In-Reply-To: <1434545675-477-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Errata i631 description:

"When in YUV4:2:0 format in 1D burst, the DISPC DMA skips lines when
fetching Chroma sampling."

Workaround:

"If YUV4:2:0-1D burst is required: Set
DISPC_VIDp_ATTRIBUTES[22]DOUBLESTRIDE to 0x0 and
DISPC_VIDp_ATTRIBUTES[13:12]ROTATION to 0x1 or 0x3"

The description is somewhat confusing, but testing has shown that DSS
fetches extra rows from memory when using NV12 format in 1D mode. If the
memory after the framebuffer is inaccessible, this leads to OCP errors.

The driver always uses DOUBLESTRIDE=0 when using 1D mode, so we only
need to handle the ROTATION part.

The issue exist on all OMAP4 and OMAP5 based DSS IPs.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dispc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/dispc.c b/drivers/video/fbdev/omap2/dss/dispc.c
index f4fc77d9d3bf..a074d8b70591 100644
--- a/drivers/video/fbdev/omap2/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/dss/dispc.c
@@ -1741,6 +1741,15 @@ static void dispc_ovl_set_rotation_attrs(enum omap_plane plane, u8 rotation,
 			row_repeat = false;
 	}
 
+	/*
+	 * OMAP4/5 Errata i631:
+	 * NV12 in 1D mode must use ROTATION=1. Otherwise DSS will fetch extra
+	 * rows beyond the framebuffer, which may cause OCP error.
+	 */
+	if (color_mode == OMAP_DSS_COLOR_NV12 &&
+			rotation_type != OMAP_DSS_ROT_TILER)
+		vidrot = 1;
+
 	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(plane), vidrot, 13, 12);
 	if (dss_has_feature(FEAT_ROWREPEATENABLE))
 		REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(plane),
-- 
2.1.4


From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 2/2] video:omapdrm: make omapdrm assume the tv-out cable is always connected
Date: Fri, 13 Nov 2015 11:29:08 +0100
Message-ID: <5942ddb7ab4f42f207c6c2b54be31a3d9fe3b912.1447410544.git.hns@goldelico.com>
References: <cover.1447410543.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1447410543.git.hns@goldelico.com>
In-Reply-To: <cover.1447410543.git.hns@goldelico.com>
References: <cover.1447410543.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Airlie <airlied@linux.ie>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, gta04-owner@goldelico.com, notasas@gmail.com, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

Include VENC in the set of drivers where it is assimed that the cable
is always connected. Like DPI, DSI, DBI and SDI do.

Otherwise, the VENC will return cable status "unknown" and is not enabled
by the X-server. So there is no video output signal.

Tested on: BeagleBoard XM, GTA04 and OpenPandora

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/gpu/drm/omapdrm/omap_connector.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/omapdrm/omap_connector.c b/drivers/gpu/drm/omapdrm/omap_connector.c
index 83f2a91..98ddb5d 100644
--- a/drivers/gpu/drm/omapdrm/omap_connector.c
+++ b/drivers/gpu/drm/omapdrm/omap_connector.c
@@ -120,6 +120,7 @@ static enum drm_connector_status omap_connector_detect(
 		else
 			ret = connector_status_disconnected;
 	} else if (dssdev->type == OMAP_DISPLAY_TYPE_DPI ||
+			dssdev->type == OMAP_DISPLAY_TYPE_VENC ||
 			dssdev->type == OMAP_DISPLAY_TYPE_DBI ||
 			dssdev->type == OMAP_DISPLAY_TYPE_SDI ||
 			dssdev->type == OMAP_DISPLAY_TYPE_DSI) {
-- 
2.5.1

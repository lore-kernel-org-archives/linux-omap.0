From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH] drm: omapdrm: displays: fix port_num for opa362 output
Date: Fri, 27 Jul 2018 16:24:32 +0200
Message-ID: <dccf0cafc194743cd037513ef19e889fb880892d.1532701471.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, David Airlie <airlied@linux.ie>, Sebastian Reichel <sre@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "Andrew F. Davis" <afd@ti.com>, "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

The opa362 amplifier has two ports, an input (usually connected
to the OMAP3 VENC) and an output port connected to the external
connector.

These are usually defined as input port@0 and outpt port@1 in
the DT and really distinguished by the reg = <port_num> property
of these nodes.

But we are missing to define the output port as number 1 so
it does not match the DT entry.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/gpu/drm/omapdrm/displays/encoder-opa362.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/omapdrm/displays/encoder-opa362.c b/drivers/gpu/drm/omapdrm/displays/encoder-opa362.c
index afee1b8b457a..296d46f060b2 100644
--- a/drivers/gpu/drm/omapdrm/displays/encoder-opa362.c
+++ b/drivers/gpu/drm/omapdrm/displays/encoder-opa362.c
@@ -208,6 +208,7 @@ static int opa362_probe(struct platform_device *pdev)
 	dssdev->type = OMAP_DISPLAY_TYPE_VENC;
 	dssdev->output_type = OMAP_DISPLAY_TYPE_VENC;
 	dssdev->owner = THIS_MODULE;
+	dssdev->port_num = 1;	/* second port */
 
 	r = omapdss_register_output(dssdev);
 	if (r) {
-- 
2.12.2

From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 18/23] drm: omapdrm: panel-dsi-cm: use threaded irq handler
Date: Tue,  8 Mar 2016 17:39:50 +0100
Message-ID: <1457455195-1938-19-git-send-email-sre@kernel.org>
References: <1457455195-1938-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457455195-1938-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Use threaded irq handler for the tearing effect gpio,
since it updates the display content, which requires
too much time for a fastpath irq.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
index 768e92d1ec8b..8316b6c2d8aa 100644
--- a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
+++ b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
@@ -1317,9 +1317,9 @@ static int dsicm_probe(struct platform_device *pdev)
 			return r;
 		}
 
-		r = devm_request_irq(dev, gpio_to_irq(ddata->ext_te_gpio),
-				dsicm_te_isr,
-				IRQF_TRIGGER_RISING,
+		r = devm_request_threaded_irq(dev, gpio_to_irq(ddata->ext_te_gpio),
+				NULL, dsicm_te_isr,
+				IRQF_TRIGGER_RISING | IRQF_ONESHOT,
 				"taal vsync", ddata);
 
 		if (r) {
-- 
2.7.0

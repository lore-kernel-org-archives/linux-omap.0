From: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: [PATCHv2 1/4] wlcore: add wl1285 compatible
Date: Wed,  3 May 2017 16:22:23 +0200
Message-ID: <20170503142226.32380-2-sebastian.reichel@collabora.co.uk>
References: <20170503142226.32380-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170503142226.32380-1-sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Motorola Droid 4 uses a WL 1285C. With differences between
chips not being public let's add explicit binding for wl1285
instead of relying on wl1283 being very similar.

Signed-off-by: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
---
 Documentation/devicetree/bindings/net/wireless/ti,wlcore.txt | 1 +
 drivers/net/wireless/ti/wlcore/sdio.c                        | 1 +
 drivers/net/wireless/ti/wlcore/spi.c                         | 1 +
 3 files changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/ti,wlcore.txt b/Documentation/devicetree/bindings/net/wireless/ti,wlcore.txt
index 2a3d90de18ee..7b2cbb14113e 100644
--- a/Documentation/devicetree/bindings/net/wireless/ti,wlcore.txt
+++ b/Documentation/devicetree/bindings/net/wireless/ti,wlcore.txt
@@ -10,6 +10,7 @@ Required properties:
     * "ti,wl1273"
     * "ti,wl1281"
     * "ti,wl1283"
+    * "ti,wl1285"
     * "ti,wl1801"
     * "ti,wl1805"
     * "ti,wl1807"
diff --git a/drivers/net/wireless/ti/wlcore/sdio.c b/drivers/net/wireless/ti/wlcore/sdio.c
index 287023ef4a78..2fb38717346f 100644
--- a/drivers/net/wireless/ti/wlcore/sdio.c
+++ b/drivers/net/wireless/ti/wlcore/sdio.c
@@ -237,6 +237,7 @@ static const struct of_device_id wlcore_sdio_of_match_table[] = {
 	{ .compatible = "ti,wl1273", .data = &wl127x_data },
 	{ .compatible = "ti,wl1281", .data = &wl128x_data },
 	{ .compatible = "ti,wl1283", .data = &wl128x_data },
+	{ .compatible = "ti,wl1285", .data = &wl128x_data },
 	{ .compatible = "ti,wl1801", .data = &wl18xx_data },
 	{ .compatible = "ti,wl1805", .data = &wl18xx_data },
 	{ .compatible = "ti,wl1807", .data = &wl18xx_data },
diff --git a/drivers/net/wireless/ti/wlcore/spi.c b/drivers/net/wireless/ti/wlcore/spi.c
index f949ad2bd898..1f5d9ebb0925 100644
--- a/drivers/net/wireless/ti/wlcore/spi.c
+++ b/drivers/net/wireless/ti/wlcore/spi.c
@@ -433,6 +433,7 @@ static const struct of_device_id wlcore_spi_of_match_table[] = {
 	{ .compatible = "ti,wl1273", .data = &wl127x_data},
 	{ .compatible = "ti,wl1281", .data = &wl128x_data},
 	{ .compatible = "ti,wl1283", .data = &wl128x_data},
+	{ .compatible = "ti,wl1285", .data = &wl128x_data},
 	{ .compatible = "ti,wl1801", .data = &wl18xx_data},
 	{ .compatible = "ti,wl1805", .data = &wl18xx_data},
 	{ .compatible = "ti,wl1807", .data = &wl18xx_data},
-- 
2.11.0

From: Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [RFC 1/6] drm/etnaviv: add binding for the gc320 found in ti socs
Date: Thu, 17 Nov 2016 20:44:31 -0600
Message-ID: <20161118024436.13447-1-robertcnelson@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Julien <jboulnois-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
CC: Julien <jboulnois-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
CC: Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
CC: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
CC: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
CC: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
CC: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
CC: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 Documentation/devicetree/bindings/display/etnaviv/etnaviv-drm.txt | 1 +
 drivers/gpu/drm/etnaviv/etnaviv_drv.c                             | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/etnaviv/etnaviv-drm.txt b/Documentation/devicetree/bindings/display/etnaviv/etnaviv-drm.txt
index ed5e0a7..9fa259d 100644
--- a/Documentation/devicetree/bindings/display/etnaviv/etnaviv-drm.txt
+++ b/Documentation/devicetree/bindings/display/etnaviv/etnaviv-drm.txt
@@ -8,6 +8,7 @@ Required properties:
 - compatible: Should be one of
     "fsl,imx-gpu-subsystem"
     "marvell,dove-gpu-subsystem"
+    "ti,gc320-gpu-subsystem"
 - cores: Should contain a list of phandles pointing to Vivante GPU devices
 
 example:
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index a6799b0..ce51270 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -653,6 +653,7 @@ static int etnaviv_pdev_remove(struct platform_device *pdev)
 static const struct of_device_id dt_match[] = {
 	{ .compatible = "fsl,imx-gpu-subsystem" },
 	{ .compatible = "marvell,dove-gpu-subsystem" },
+	{ .compatible = "ti,gc320-gpu-subsystem" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, dt_match);
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

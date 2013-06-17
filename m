From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: [PATCH 1/2] musb: musb: dsps: support multiple instances
Date: Mon, 17 Jun 2013 17:13:33 +0200
Message-ID: <1371482014-5244-2-git-send-email-bigeasy@linutronix.de>
References: <1371482014-5244-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1371482014-5244-1-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

If we specify right now more than once instance then we attempt to add
the platform device twice. The nop driver does not mind the second add
because it checks for it and returns without a word. At removal time a
segfault is likely because the first intance clean ups the phy and
second, well, goes boom.
This patchs adds two dummy device node to the am33xx for the dummy phy
which we have now. During probe time, we grab the phy based on the
device node if we have one. If not, we use the same hack we used so far.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
---
 arch/arm/boot/dts/am33xx.dtsi |  8 ++++++++
 drivers/usb/musb/musb_dsps.c  | 18 +++++++++++++-----
 include/linux/usb/musb.h      |  1 +
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 8e1248f..30d0d45 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -341,6 +341,14 @@
 			port1-mode = <3>;
 			power = <250>;
 			ti,hwmods = "usb_otg_hs";
+			phys = <&nopphy0 &nopphy1>;
+		};
+
+		nopphy0: usbphy@0 {
+			compatible = "usb-nop-xceiv";
+		};
+		nopphy1: usbphy@1 {
+			compatible = "usb-nop-xceiv";
 		};
 
 		mac: ethernet@4a100000 {
diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index e1b661d..d9ff390 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -415,9 +415,14 @@ static int dsps_musb_init(struct musb *musb)
 	/* mentor core register starts at offset of 0x400 from musb base */
 	musb->mregs += wrp->musb_core_offset;
 
-	/* NOP driver needs change if supporting dual instance */
-	usb_nop_xceiv_register();
-	musb->xceiv = usb_get_phy(USB_PHY_TYPE_USB2);
+	if (!glue->dev->of_node) {
+		/* This hack works only for a single instance. */
+		usb_nop_xceiv_register();
+		musb->xceiv = usb_get_phy(USB_PHY_TYPE_USB2);
+	} else {
+		musb->xceiv = devm_usb_get_phy_by_phandle(glue->dev, "phys",
+				musb->config->instance);
+	}
 	if (IS_ERR_OR_NULL(musb->xceiv))
 		return -EPROBE_DEFER;
 
@@ -449,7 +454,8 @@ static int dsps_musb_init(struct musb *musb)
 	return 0;
 err0:
 	usb_put_phy(musb->xceiv);
-	usb_nop_xceiv_unregister();
+	if (!glue->dev->of_node)
+		usb_nop_xceiv_unregister();
 	return status;
 }
 
@@ -466,7 +472,8 @@ static int dsps_musb_exit(struct musb *musb)
 
 	/* NOP driver needs change if supporting dual instance */
 	usb_put_phy(musb->xceiv);
-	usb_nop_xceiv_unregister();
+	if (!glue->dev->of_node)
+		usb_nop_xceiv_unregister();
 
 	return 0;
 }
@@ -570,6 +577,7 @@ static int dsps_create_musb_pdev(struct dsps_glue *glue, u8 id)
 		of_property_read_u32(np, res_name, (u32 *)&pdata->mode);
 		of_property_read_u32(np, "power", (u32 *)&pdata->power);
 		config->multipoint = of_property_read_bool(np, "multipoint");
+		config->instance = id;
 
 		pdata->config		= config;
 	}
diff --git a/include/linux/usb/musb.h b/include/linux/usb/musb.h
index 053c268..e027705 100644
--- a/include/linux/usb/musb.h
+++ b/include/linux/usb/musb.h
@@ -83,6 +83,7 @@ struct musb_hdrc_config {
 	u8		vendor_stat __deprecated; /* vendor status reg witdh */
 	u8		dma_req_chan __deprecated; /* bitmask for required dma channels */
 	u8		ram_bits;	/* ram address size */
+	u8		instance;
 
 	struct musb_hdrc_eps_bits *eps_bits __deprecated;
 #ifdef CONFIG_BLACKFIN
-- 
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

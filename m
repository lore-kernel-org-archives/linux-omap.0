From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: [PATCH 4/5] usb: musb: dsps: use proper child nodes
Date: Fri,  5 Jul 2013 15:32:57 +0200
Message-ID: <1373031178-8871-5-git-send-email-bigeasy@linutronix.de>
References: <1373031178-8871-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1373031178-8871-1-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, george.cherian-l0cyMroinI0@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This moves the two instances from the big node into two child nodes. The
glue layer ontop does almost nothing.
This could be two indepentant child nodes but I have no idea how
'ti,hwmods = "usb_otg_hs";' affects the two musb controler.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
---
 arch/arm/boot/dts/am335x-bone.dts  |  8 ++++++
 arch/arm/boot/dts/am335x-evm.dts   | 16 ++++++++++++
 arch/arm/boot/dts/am335x-evmsk.dts | 16 ++++++++++++
 arch/arm/boot/dts/am33xx.dtsi      | 47 ++++++++++++++++++++++++-----------
 drivers/usb/musb/musb_dsps.c       | 51 ++++++++++++++++++--------------------
 5 files changed, 97 insertions(+), 41 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index 83184e5..ae50fd7 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -124,6 +124,14 @@
 			status = "okay";
 		};
 
+		musb: usb@47400000 {
+			status = "okay";
+
+			usb0@47401000 {
+				status = "okay";
+			};
+		};
+
 		i2c0: i2c@44e0b000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&i2c0_pins>;
diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 317637a..dc236f4 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -175,6 +175,22 @@
 			status = "okay";
 		};
 
+		musb1_phy: phy1@47401800 {
+			status = "okay";
+		};
+
+		musb: usb@47400000 {
+			status = "okay";
+
+			usb0@47401000 {
+				status = "okay";
+			};
+
+			usb1@47401800 {
+				status = "okay";
+			};
+		};
+
 		i2c1: i2c@4802a000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&i2c1_pins>;
diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index 99d9444..74ce579 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -211,6 +211,22 @@
 			status = "okay";
 		};
 
+		musb1_phy: phy1@47401800 {
+			status = "okay";
+		};
+
+		musb: usb@47400000 {
+			status = "okay";
+
+			usb0@47401000 {
+				status = "okay";
+			};
+
+			usb1@47401800 {
+				status = "okay";
+			};
+		};
+
 		epwmss2: epwmss@48304000 {
 			status = "okay";
 
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 66bb420..bb2298c 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -349,22 +349,41 @@
 			status = "disabled";
 		};
 
-		usb@47400000 {
+		musb: usb@47400000 {
 			compatible = "ti,musb-am33xx";
-			reg = <0x47400000 0x1000	/* usbss */
-			       0x47401000 0x800		/* musb instance 0 */
-			       0x47401800 0x800>;	/* musb instance 1 */
-			interrupts = <17		/* usbss */
-				      18		/* musb instance 0 */
-				      19>;		/* musb instance 1 */
-			multipoint = <1>;
-			num-eps = <16>;
-			ram-bits = <12>;
-			port0-mode = <3>;
-			port1-mode = <3>;
-			power = <250>;
+			reg = <0x47400000 0x1000>;
+			ranges;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			interrupts = <17>;
 			ti,hwmods = "usb_otg_hs";
-			phys = <&musb1_phy>;
+			status = "disabled";
+
+			usb0@47401000 {
+				reg = <0x47401000 0x800>;
+				interrupts = <18>;
+				interrupt-names = "mc";
+				multipoint = <1>;
+				num-eps = <16>;
+				ram-bits = <12>;
+				port-mode = <3>;
+				power = <250>;
+				phys = <&musb0_phy>;
+				status = "disabled";
+			};
+
+			usb1@47401800 {
+				reg = <0x47401800 0x800>;
+				interrupts = <19>;
+				interrupt-names = "mc";
+				multipoint = <1>;
+				num-eps = <16>;
+				ram-bits = <12>;
+				port-mode = <3>;
+				power = <250>;
+				phys = <&musb1_phy>;
+				status = "disabled";
+			};
 		};
 
 		epwmss0: epwmss@48300000 {
diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 22ad532..0e01cc1 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -43,6 +43,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_address.h>
+#include <linux/of_irq.h>
 
 #include "musb_core.h"
 
@@ -375,9 +376,9 @@ static int dsps_musb_init(struct musb *musb)
 	musb->mregs += wrp->musb_core_offset;
 
 	/* NOP driver needs change if supporting dual instance */
-	musb->xceiv = devm_usb_get_phy_by_phandle(glue->dev, "phys", 0);
-	if (IS_ERR_OR_NULL(musb->xceiv))
-		return -EPROBE_DEFER;
+	musb->xceiv = devm_usb_get_phy_by_phandle(dev, "phys", 0);
+	if (IS_ERR(musb->xceiv))
+		return PTR_ERR(musb->xceiv);
 
 	/* Returns zero if e.g. not clocked */
 	rev = dsps_readl(reg_base, wrp->revision);
@@ -429,39 +430,32 @@ static struct musb_platform_ops dsps_ops = {
 
 static u64 musb_dmamask = DMA_BIT_MASK(32);
 
-static int dsps_create_musb_pdev(struct dsps_glue *glue, u8 id)
+static int dsps_create_musb_pdev(struct dsps_glue *glue, u8 id,
+		struct device_node *np)
 {
 	struct device *dev = glue->dev;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct musb_hdrc_platform_data  *pdata = dev->platform_data;
-	struct device_node *np = pdev->dev.of_node;
 	struct musb_hdrc_config	*config;
 	struct platform_device	*musb;
-	struct resource *res;
 	struct resource	resources[2];
-	char res_name[11];
 	int ret;
 
-	/* first resource is for usbss, so start index from 1 */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, id + 1);
-	if (!res) {
+	ret = of_address_to_resource(np, 0, &resources[0]);
+	if (ret) {
 		dev_err(dev, "failed to get memory for instance %d\n", id);
-		ret = -ENODEV;
 		goto err0;
 	}
-	res->parent = NULL;
-	resources[0] = *res;
 
 	/* first resource is for usbss, so start index from 1 */
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, id + 1);
-	if (!res) {
+	ret = of_irq_to_resource(np, 0, &resources[1]);
+	if (ret == 0) {
 		dev_err(dev, "failed to get irq for instance %d\n", id);
-		ret = -ENODEV;
+		ret = -EINVAL;
 		goto err0;
 	}
-	res->parent = NULL;
-	resources[1] = *res;
-	resources[1].name = "mc";
+	resources[0].parent = NULL;
+	resources[1].parent = NULL;
 
 	/* allocate the child platform device */
 	musb = platform_device_alloc("musb-hdrc", PLATFORM_DEVID_AUTO);
@@ -474,6 +468,7 @@ static int dsps_create_musb_pdev(struct dsps_glue *glue, u8 id)
 	musb->dev.parent		= dev;
 	musb->dev.dma_mask		= &musb_dmamask;
 	musb->dev.coherent_dma_mask	= musb_dmamask;
+	musb->dev.of_node		= of_node_get(np);
 
 	glue->musb[id]			= musb;
 
@@ -502,8 +497,7 @@ static int dsps_create_musb_pdev(struct dsps_glue *glue, u8 id)
 
 		of_property_read_u32(np, "num-eps", (u32 *)&config->num_eps);
 		of_property_read_u32(np, "ram-bits", (u32 *)&config->ram_bits);
-		snprintf(res_name, sizeof(res_name), "port%d-mode", id);
-		of_property_read_u32(np, res_name, (u32 *)&pdata->mode);
+		of_property_read_u32(np, "port-mode", (u32 *)&pdata->mode);
 		of_property_read_u32(np, "power", (u32 *)&pdata->power);
 		config->multipoint = of_property_read_bool(np, "multipoint");
 
@@ -537,6 +531,7 @@ static int dsps_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 	const struct dsps_musb_wrapper *wrp;
 	struct dsps_glue *glue;
+	struct device_node *child;
 	struct resource *iomem;
 	int ret, i;
 
@@ -583,9 +578,9 @@ static int dsps_probe(struct platform_device *pdev)
 		goto err2;
 	}
 
-	/* create the child platform device for all instances of musb */
-	for (i = 0; i < wrp->instances ; i++) {
-		ret = dsps_create_musb_pdev(glue, i);
+	i = 0;
+	for_each_available_child_of_node(pdev->dev.of_node, child) {
+		ret = dsps_create_musb_pdev(glue, i, child);
 		if (ret != 0) {
 			dev_err(&pdev->dev, "failed to create child pdev\n");
 			/* release resources of previously created instances */
@@ -593,6 +588,7 @@ static int dsps_probe(struct platform_device *pdev)
 				platform_device_unregister(glue->musb[i]);
 			goto err3;
 		}
+		i++;
 	}
 
 	return 0;
@@ -610,12 +606,13 @@ static int dsps_probe(struct platform_device *pdev)
 static int dsps_remove(struct platform_device *pdev)
 {
 	struct dsps_glue *glue = platform_get_drvdata(pdev);
-	const struct dsps_musb_wrapper *wrp = glue->wrp;
 	int i;
 
 	/* delete the child platform device */
-	for (i = 0; i < wrp->instances ; i++)
-		platform_device_unregister(glue->musb[i]);
+	for (i = 0; i < ARRAY_SIZE(glue->musb); i++) {
+		if (glue->musb[i])
+			platform_device_unregister(glue->musb[i]);
+	}
 
 	/* disable usbss clocks */
 	pm_runtime_put(&pdev->dev);
-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

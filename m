From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v3 3/3] arm: omap2: gpmc: add DT bindings for OneNAND
Date: Fri, 25 Jan 2013 09:23:11 -0300
Message-ID: <1359116591-32730-3-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1359116591-32730-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:47797 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754841Ab3AYM0D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jan 2013 07:26:03 -0500
In-Reply-To: <1359116591-32730-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, zonque@gmail.com, tony@atomide.com, matthias.bgg@googlemail.com, Javier Martinez Canillas <martinez.javier@gmail.com>, Enric Balletbo Serra <eballetbo@gmail.com>, devicetree-discuss@lists.ozlabs.org, linux-mtd@lists.infradead.org, b-cousson@ti.com, grant.likely@secretlab.ca, jon-hunter@ti.com, Artem Bityutskiy <dedekind1@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

This patch adds device tree bindings for OMAP OneNAND devices.
Tested on an OMAP3 3430 IGEPv2 board.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
Changes from v2:
 * Remove unneeded of_node_put() as reported by Mark Rutland

Changes from v1:
 * Fix typo in Documentation/devicetree/bindings/mtd/gpmc-onenand.txt

 .../devicetree/bindings/mtd/gpmc-onenand.txt       |   43 +++++++++++++++++++
 arch/arm/mach-omap2/gpmc.c                         |   45 ++++++++++++++++++++
 2 files changed, 88 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/gpmc-onenand.txt

diff --git a/Documentation/devicetree/bindings/mtd/gpmc-onenand.txt b/Documentation/devicetree/bindings/mtd/gpmc-onenand.txt
new file mode 100644
index 0000000..deec9da
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/gpmc-onenand.txt
@@ -0,0 +1,43 @@
+Device tree bindings for GPMC connected OneNANDs
+
+GPMC connected OneNAND (found on OMAP boards) are represented as child nodes of
+the GPMC controller with a name of "onenand".
+
+All timing relevant properties as well as generic gpmc child properties are
+explained in a separate documents - please refer to
+Documentation/devicetree/bindings/bus/ti-gpmc.txt
+
+Required properties:
+
+ - reg:			The CS line the peripheral is connected to
+
+Optional properties:
+
+ - dma-channel:		DMA Channel index
+
+For inline partiton table parsing (optional):
+
+ - #address-cells: should be set to 1
+ - #size-cells: should be set to 1
+
+Example for an OMAP3430 board:
+
+	gpmc: gpmc@6e000000 {
+		compatible = "ti,omap3430-gpmc";
+		ti,hwmods = "gpmc";
+		reg = <0x6e000000 0x1000000>;
+		interrupts = <20>;
+		gpmc,num-cs = <8>;
+		gpmc,num-waitpins = <4>;
+		#address-cells = <2>;
+		#size-cells = <1>;
+
+		onenand@0 {
+			reg = <0 0 0>; /* CS0, offset 0 */
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			/* partitions go here */
+		};
+	};
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index c6255f7..0636d0a 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -39,6 +39,7 @@
 #include "omap_device.h"
 #include "gpmc.h"
 #include "gpmc-nand.h"
+#include "gpmc-onenand.h"
 
 #define	DEVICE_NAME		"omap-gpmc"
 
@@ -1259,6 +1260,43 @@ static int gpmc_probe_nand_child(struct platform_device *pdev,
 }
 #endif
 
+#ifdef CONFIG_MTD_ONENAND
+static int gpmc_probe_onenand_child(struct platform_device *pdev,
+				 struct device_node *child)
+{
+	u32 val;
+	struct omap_onenand_platform_data *gpmc_onenand_data;
+
+	if (of_property_read_u32(child, "reg", &val) < 0) {
+		dev_err(&pdev->dev, "%s has no 'reg' property\n",
+			child->full_name);
+		return -ENODEV;
+	}
+
+	gpmc_onenand_data = devm_kzalloc(&pdev->dev, sizeof(*gpmc_onenand_data),
+					 GFP_KERNEL);
+	if (!gpmc_onenand_data)
+		return -ENOMEM;
+
+	gpmc_onenand_data->cs = val;
+	gpmc_onenand_data->of_node = child;
+	gpmc_onenand_data->dma_channel = -1;
+
+	if (!of_property_read_u32(child, "dma-channel", &val))
+		gpmc_onenand_data->dma_channel = val;
+
+	gpmc_onenand_init(gpmc_onenand_data);
+
+	return 0;
+}
+#else
+static int gpmc_probe_onenand_child(struct platform_device *pdev,
+				    struct device_node *child)
+{
+	return 0;
+}
+#endif
+
 static int gpmc_probe_dt(struct platform_device *pdev)
 {
 	int ret;
@@ -1277,6 +1315,13 @@ static int gpmc_probe_dt(struct platform_device *pdev)
 		}
 	}
 
+	for_each_node_by_name(child, "onenand") {
+		ret = gpmc_probe_onenand_child(pdev, child);
+		if (ret < 0) {
+			of_node_put(child);
+			return ret;
+		}
+	}
 	return 0;
 }
 #else
-- 
1.7.8.6


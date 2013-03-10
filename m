From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH 1/1] ARM: OMAP: gpmc: request CS address space for ethernet chips
Date: Sun, 10 Mar 2013 18:18:22 +0100
Message-ID: <1362935902-29720-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:39319 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751619Ab3CJRSq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 10 Mar 2013 13:18:46 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Grant Likely <grant.likely@secretlab.ca>, Enric Balletbo i Serra <eballetbo@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-omap <linux-omap@vger.kernel.org>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Besides being used to interface with external memory devices,
the General-Purpose Memory Controller can be used to connect
Pseudo-SRAM devices such as ethernet controllers to OMAP2+
processors using the GPMC as a data bus.

The actual mapping between the GPMC address space and OMAP2+
address space is made using the GPMC DT "ranges" property.
But also a explicit call to gpmc_cs_request() is needed.

So, this patch allows an ethernet chip to be defined as an
GPMC child node an its chip-select memory address be requested.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---

Jon,

This patch assumes that we have solved somehow the issue that a
call to request_irq() is needed before before using a GPIO as an
IRQ and this is no longer the case when using from Device Trees.

Anyway, this is independent as how we solve this, whether is
using Jan's patch [1], adding a .request function pointer to
irq_chip as suggested by Stephen [2], or any other approach.

[1]: https://patchwork.kernel.org/patch/2009331/
[2]: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg85592.html

 arch/arm/mach-omap2/gpmc.c |   45 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 4fe9ee7..d1bf48b 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -29,6 +29,7 @@
 #include <linux/of.h>
 #include <linux/of_mtd.h>
 #include <linux/of_device.h>
+#include <linux/of_address.h>
 #include <linux/mtd/nand.h>
 
 #include <linux/platform_data/mtd-nand-omap2.h>
@@ -1296,6 +1297,42 @@ static int gpmc_probe_onenand_child(struct platform_device *pdev,
 }
 #endif
 
+static int gpmc_probe_ethernet_child(struct platform_device *pdev,
+				     struct device_node *child)
+{
+	int ret, cs;
+	unsigned long base;
+	struct resource res;
+	struct platform_device *of_dev;
+
+	if (of_property_read_u32(child, "reg", &cs) < 0) {
+		dev_err(&pdev->dev, "%s has no 'reg' property\n",
+			child->full_name);
+		return -ENODEV;
+	}
+
+	if (of_address_to_resource(child, 0, &res)) {
+		dev_err(&pdev->dev, "%s has malformed 'reg' property\n",
+			child->full_name);
+		return -ENODEV;
+	}
+
+	ret = gpmc_cs_request(cs, resource_size(&res), &base);
+	if (IS_ERR_VALUE(ret)) {
+		dev_err(&pdev->dev, "cannot request GPMC CS %d\n", cs);
+		return ret;
+	}
+
+	of_dev = of_platform_device_create(child, NULL, &pdev->dev);
+	if (!of_dev) {
+		dev_err(&pdev->dev, "cannot create platform device for %s\n",
+			child->full_name);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
 static int gpmc_probe_dt(struct platform_device *pdev)
 {
 	int ret;
@@ -1326,6 +1363,14 @@ static int gpmc_probe_dt(struct platform_device *pdev)
 			return ret;
 		}
 	}
+
+	for_each_node_by_name(child, "ethernet") {
+		ret = gpmc_probe_ethernet_child(pdev, child);
+		if (ret < 0) {
+			of_node_put(child);
+			return ret;
+		}
+	}
 	return 0;
 }
 #else
-- 
1.7.7.6


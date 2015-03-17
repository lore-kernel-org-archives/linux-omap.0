From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RESEND PATCH 2/2] bus: ocp2scp: SYNC2 value should be changed to 0x6
Date: Tue, 17 Mar 2015 16:54:51 +0530
Message-ID: <1426591491-3685-2-git-send-email-kishon@ti.com>
References: <1426591491-3685-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42266 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750958AbbCQLZb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Mar 2015 07:25:31 -0400
In-Reply-To: <1426591491-3685-1-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-kernel@vger.kernel.org, tony@atomide.com, gregkh@linuxfoundation.org
Cc: linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, nsekhar@ti.com, kishon@ti.com, nm@ti.com, praneeth@ti.com, Arnd Bergmann <arnd@arndb.de>

As per the TRMs of AM572x, OMAP4430, OMAP4460, OMAP543x, the value of
SYNC2 must be set to 0x6 in order to ensure correct operation.

So modified the SYNC2 value of OCP2SCP TIMING register to 0x6 in all the
platforms that use OCP2SCP driver except AM437x. Also introduced a new
compatible property since we don't want to modify the OCP2SCP TIMING
register for AM437x.

The sections in TRM where the above caution can be found is mentioned below.
AM572x TRM SPRUHZ6 (http://www.ti.com/lit/ug/spruhz6/spruhz6.pdf) under
section 26.3.2.2, table 26-26.

OMAP4430 TRM SWPU231AP (http://www.ti.com/lit/ug/swpu231ap/swpu231ap.pdf)
under section 23.12.6.2.2 , Table 23-1213.

OMAP4460 TRM SWPU235AB (http://www.ti.com/lit/ug/swpu235ab/swpu235ab.pdf)
under section 23.12.6.2.2, Table 23-1213.

OMAP543x TRM SWPU249 (http://www.ti.com/lit/pdf/swpu249)
under section 27.3.2.2, Table 27-27.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Praneeth Bajjuri <praneeth@ti.com>
---
 drivers/bus/omap-ocp2scp.c |   34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/bus/omap-ocp2scp.c b/drivers/bus/omap-ocp2scp.c
index 723ec06..9f18569 100644
--- a/drivers/bus/omap-ocp2scp.c
+++ b/drivers/bus/omap-ocp2scp.c
@@ -16,6 +16,7 @@
  *
  */
 
+#include <linux/io.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/err.h>
@@ -23,6 +24,9 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 
+#define OCP2SCP_TIMING 0x18
+#define SYNC2_MASK 0xf
+
 static int ocp2scp_remove_devices(struct device *dev, void *c)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -35,6 +39,9 @@ static int ocp2scp_remove_devices(struct device *dev, void *c)
 static int omap_ocp2scp_probe(struct platform_device *pdev)
 {
 	int ret;
+	u32 reg;
+	void __iomem *regs;
+	struct resource *res;
 	struct device_node *np = pdev->dev.of_node;
 
 	if (np) {
@@ -47,6 +54,32 @@ static int omap_ocp2scp_probe(struct platform_device *pdev)
 	}
 
 	pm_runtime_enable(&pdev->dev);
+	/*
+	 * As per AM572x TRM: http://www.ti.com/lit/ug/spruhz6/spruhz6.pdf
+	 * under section 26.3.2.2, table 26-26 OCP2SCP TIMING Caution;
+	 * As per OMAP4430 TRM: http://www.ti.com/lit/ug/swpu231ap/swpu231ap.pdf
+	 * under section 23.12.6.2.2 , Table 23-1213 OCP2SCP TIMING Caution;
+	 * As per OMAP4460 TRM: http://www.ti.com/lit/ug/swpu235ab/swpu235ab.pdf
+	 * under section 23.12.6.2.2, Table 23-1213 OCP2SCP TIMING Caution;
+	 * As per OMAP543x TRM http://www.ti.com/lit/pdf/swpu249
+	 * under section 27.3.2.2, Table 27-27 OCP2SCP TIMING Caution;
+	 *
+	 * Read path of OCP2SCP is not working properly due to low reset value
+	 * of SYNC2 parameter in OCP2SCP. Suggested reset value is 0x6 or more.
+	 */
+	if (!of_device_is_compatible(np, "ti,am437x-ocp2scp")) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		regs = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(regs))
+			goto err0;
+
+		pm_runtime_get_sync(&pdev->dev);
+		reg = readl_relaxed(regs + OCP2SCP_TIMING);
+		reg &= ~(SYNC2_MASK);
+		reg |= 0x6;
+		writel_relaxed(reg, regs + OCP2SCP_TIMING);
+		pm_runtime_put_sync(&pdev->dev);
+	}
 
 	return 0;
 
@@ -67,6 +100,7 @@ static int omap_ocp2scp_remove(struct platform_device *pdev)
 #ifdef CONFIG_OF
 static const struct of_device_id omap_ocp2scp_id_table[] = {
 	{ .compatible = "ti,omap-ocp2scp" },
+	{ .compatible = "ti,am437x-ocp2scp" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, omap_ocp2scp_id_table);
-- 
1.7.9.5


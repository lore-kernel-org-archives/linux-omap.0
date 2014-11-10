From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2 1/2] bus: omap_l3_noc: Add resume hook to restore context
Date: Mon, 10 Nov 2014 23:49:47 +0530
Message-ID: <1415643588-14508-2-git-send-email-j-keerthy@ti.com>
References: <1415643588-14508-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52689 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750941AbaKJSYE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Nov 2014 13:24:04 -0500
In-Reply-To: <1415643588-14508-1-git-send-email-j-keerthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: j-keerthy@ti.com, nm@ti.com, afzal@ti.com, tony@atomide.com

On certain SoCs such as AM437x SoC, L3_noc error registers are
maintained in power domain such as per domain which looses context as part
of low power state such as RTC+DDR mode. On these platforms when we
mask interrupts which we cannot handle, the source of these interrupts
still remain on resume, however, the flag mux registers now contain
their reset value (unmasked) - this breaks the system with infinite
interrupts since we do not these interrupts to take place ever again.

To handle this: restore the masking of interrupts which we have
already recorded in the system as ones we cannot handle.

Fixes: 2100b595b7 ("bus: omap_l3_noc: ignore masked out unclearable targets")
Acked-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
---

Changes from v1:

    * Fixed the commit log with the right commit ID of the patch that is fixed
 
 drivers/bus/omap_l3_noc.c |   55 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/bus/omap_l3_noc.c b/drivers/bus/omap_l3_noc.c
index 531ae59..b5eac29 100644
--- a/drivers/bus/omap_l3_noc.c
+++ b/drivers/bus/omap_l3_noc.c
@@ -296,11 +296,66 @@ static int omap_l3_probe(struct platform_device *pdev)
 	return ret;
 }
 
+#ifdef	CONFIG_PM
+
+/**
+ * l3_resume_noirq() - resume function for l3_noc
+ * @dev:	pointer to l3_noc device structure
+ *
+ * We only have the resume handler only since we
+ * have already maintained the delta register
+ * configuration as part of configuring the system
+ */
+static int l3_resume_noirq(struct device *dev)
+{
+	struct omap_l3 *l3 = dev_get_drvdata(dev);
+	int i;
+	struct l3_flagmux_data *flag_mux;
+	void __iomem *base, *mask_regx = NULL;
+	u32 mask_val;
+
+	for (i = 0; i < l3->num_modules; i++) {
+		base = l3->l3_base[i];
+		flag_mux = l3->l3_flagmux[i];
+		if (!flag_mux->mask_app_bits && !flag_mux->mask_dbg_bits)
+			continue;
+
+		mask_regx = base + flag_mux->offset + L3_FLAGMUX_MASK0 +
+			   (L3_APPLICATION_ERROR << 3);
+		mask_val = readl_relaxed(mask_regx);
+		mask_val &= ~(flag_mux->mask_app_bits);
+
+		writel_relaxed(mask_val, mask_regx);
+		mask_regx = base + flag_mux->offset + L3_FLAGMUX_MASK0 +
+			   (L3_DEBUG_ERROR << 3);
+		mask_val = readl_relaxed(mask_regx);
+		mask_val &= ~(flag_mux->mask_dbg_bits);
+
+		writel_relaxed(mask_val, mask_regx);
+	}
+
+	/* Dummy read to force OCP barrier */
+	if (mask_regx)
+		(void)readl(mask_regx);
+
+	return 0;
+}
+
+static const struct dev_pm_ops l3_dev_pm_ops = {
+	.resume_noirq		= l3_resume_noirq,
+};
+
+#define L3_DEV_PM_OPS (&l3_dev_pm_ops)
+#else
+#define L3_DEV_PM_OPS NULL
+#endif
+
 static struct platform_driver omap_l3_driver = {
 	.probe		= omap_l3_probe,
 	.driver		= {
 		.name		= "omap_l3_noc",
 		.owner		= THIS_MODULE,
+		.pm		= L3_DEV_PM_OPS,
 		.of_match_table = of_match_ptr(l3_noc_match),
 	},
 };
-- 
1.7.9.5


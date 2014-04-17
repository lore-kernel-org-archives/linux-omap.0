From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH V2 17/19] bus: omap_l3_noc: introduce concept of submodule
Date: Thu, 17 Apr 2014 15:49:33 -0500
Message-ID: <1397767775-10965-18-git-send-email-nm@ti.com>
References: <1397492726-17203-1-git-send-email-nm@ti.com>
 <1397767775-10965-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1397767775-10965-1-git-send-email-nm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>
Cc: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

While OMAP4 and OMAP5 had 3 separate clock domains, DRA7 has only 2
and the first one then is internally divided into 2 sub clock domains.

To better represent this in the driver, we use the concept of submodule.

The address defintions in the devicetree is as per the high level
clock domain(module) base, the sub clockdomain/subdomain which shares
the same register space of a clockdomain is marked in the SoC data as
L3_BASE_IS_SUBMODULE.

L3_BASE_IS_SUBMODULE is used as an indication that it's base address is
the same as the parent module and offsets are considered from the same
base address as they are usually intermingled.

Other than the base address, the submodule is same as a module as it is
functionally so.

Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
---

V2: reordering only. no functional change.

V1: https://patchwork.kernel.org/patch/3984351/
 drivers/bus/omap_l3_noc.c |   17 ++++++++++++-----
 drivers/bus/omap_l3_noc.h |    6 +++++-
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/omap_l3_noc.c b/drivers/bus/omap_l3_noc.c
index 9e68d6b..cf923f1 100644
--- a/drivers/bus/omap_l3_noc.c
+++ b/drivers/bus/omap_l3_noc.c
@@ -233,7 +233,7 @@ static int omap_l3_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *of_id;
 	static struct omap_l3 *l3;
-	int ret, i;
+	int ret, i, res_idx;
 
 	of_id = of_match_device(l3_noc_match, &pdev->dev);
 	if (!of_id) {
@@ -250,15 +250,22 @@ static int omap_l3_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, l3);
 
 	/* Get mem resources */
-	for (i = 0; i < l3->num_modules; i++) {
-		struct resource	*res = platform_get_resource(pdev,
-							     IORESOURCE_MEM, i);
-
+	for (i = 0, res_idx = 0; i < l3->num_modules; i++) {
+		struct resource	*res;
+
+		if (l3->l3_base[i] == L3_BASE_IS_SUBMODULE) {
+			/* First entry cannot be submodule */
+			BUG_ON(i == 0);
+			l3->l3_base[i] = l3->l3_base[i - 1];
+			continue;
+		}
+		res = platform_get_resource(pdev, IORESOURCE_MEM, res_idx);
 		l3->l3_base[i] = devm_ioremap_resource(&pdev->dev, res);
 		if (IS_ERR(l3->l3_base[i])) {
 			dev_err(l3->dev, "ioremap %d failed\n", i);
 			return PTR_ERR(l3->l3_base[i]);
 		}
+		res_idx++;
 	}
 
 	/*
diff --git a/drivers/bus/omap_l3_noc.h b/drivers/bus/omap_l3_noc.h
index 49258bb..9df9f25 100644
--- a/drivers/bus/omap_l3_noc.h
+++ b/drivers/bus/omap_l3_noc.h
@@ -41,6 +41,8 @@
 
 #define L3_TARGET_NOT_SUPPORTED		NULL
 
+#define L3_BASE_IS_SUBMODULE		((void __iomem *)(1 << 0))
+
 static const char * const l3_transaction_type[] = {
 	/* 0 0 0 */ "Idle",
 	/* 0 0 1 */ "Write",
@@ -92,7 +94,9 @@ struct l3_flagmux_data {
 /**
  * struct omap_l3 - Description of data relevant for L3 bus.
  * @dev:	device representing the bus (populated runtime)
- * @l3_base:	base addresses of modules (populated runtime)
+ * @l3_base:	base addresses of modules (populated runtime if 0)
+ *		if set to L3_BASE_IS_SUBMODULE, then uses previous
+ *		module index as the base address
  * @l3_flag_mux: array containing flag mux data per module
  *		 offset from corresponding module base indexed per
  *		 module.
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

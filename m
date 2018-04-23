From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 04/16] ARM: OMAP2+: Only probe SDMA via ti-sysc if configured in dts
Date: Mon, 23 Apr 2018 10:45:37 -0700
Message-ID: <20180423174549.57412-5-tony@atomide.com>
References: <20180423174549.57412-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180423174549.57412-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>
List-Id: linux-omap@vger.kernel.org

We still have some SDMA probing using omap_device_build() for the
arch/arm/plat-omap/dma.c part that the dmaengine driver then uses.

So we still need to ensure that omap_device_build() works even if we
probe and manage the dmaengine driver via ti-sysc. And we don't want
to call dev_pm_domain_set() as otherwise we'd also have omap_device
try to manage the hardware in addition to ti-sysc.

Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_device.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -143,7 +143,7 @@ static int omap_device_build_from_dt(struct platform_device *pdev)
 	struct resource res;
 	const char *oh_name;
 	int oh_cnt, i, ret = 0;
-	bool device_active = false;
+	bool device_active = false, skip_pm_domain = false;
 
 	oh_cnt = of_property_count_strings(node, "ti,hwmods");
 	if (oh_cnt <= 0) {
@@ -151,8 +151,15 @@ static int omap_device_build_from_dt(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	/* SDMA still needs special handling for omap_device_build() */
+	ret = of_property_read_string_index(node, "ti,hwmods", 0, &oh_name);
+	if (!ret && (!strncmp("dma_system", oh_name, 10) ||
+		     !strncmp("dma", oh_name, 3)))
+		skip_pm_domain = true;
+
 	/* Use ti-sysc driver instead of omap_device? */
-	if (!omap_hwmod_parse_module_range(NULL, node, &res))
+	if (!skip_pm_domain &&
+	    !omap_hwmod_parse_module_range(NULL, node, &res))
 		return -ENODEV;
 
 	hwmods = kzalloc(sizeof(struct omap_hwmod *) * oh_cnt, GFP_KERNEL);
@@ -191,11 +198,12 @@ static int omap_device_build_from_dt(struct platform_device *pdev)
 			r->name = dev_name(&pdev->dev);
 	}
 
-	dev_pm_domain_set(&pdev->dev, &omap_device_pm_domain);
-
-	if (device_active) {
-		omap_device_enable(pdev);
-		pm_runtime_set_active(&pdev->dev);
+	if (!skip_pm_domain) {
+		dev_pm_domain_set(&pdev->dev, &omap_device_pm_domain);
+		if (device_active) {
+			omap_device_enable(pdev);
+			pm_runtime_set_active(&pdev->dev);
+		}
 	}
 
 odbfd_exit1:
-- 
2.17.0

From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH v4 04/11] ARM: OMAP2+: Use pdata-quirks for wkup_m3 deassert_hardreset
Date: Thu, 10 Jul 2014 21:55:42 -0500
Message-ID: <1405047349-15101-5-git-send-email-d-gerlach@ti.com>
References: <1405047349-15101-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60112 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840AbaGKC5b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Jul 2014 22:57:31 -0400
In-Reply-To: <1405047349-15101-1-git-send-email-d-gerlach@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Russ Dill <russ.dill@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Mack <daniel@zonque.org>, Suman Anna <s-anna@ti.com>, Benoit Cousson <bcousson@baylibre.com>, Dave Gerlach <d-gerlach@ti.com>

Use pdata-quirks to reset the wkup_m3 during boot.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/mach-omap2/pdata-quirks.c    | 12 ++++++++++++
 include/linux/platform_data/wkup_m3.h | 17 +++++++++++++++++
 2 files changed, 29 insertions(+)
 create mode 100644 include/linux/platform_data/wkup_m3.h

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 90c88d4..8e4a541 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -17,6 +17,7 @@
 
 #include <linux/platform_data/pinctrl-single.h>
 #include <linux/platform_data/iommu-omap.h>
+#include <linux/platform_data/wkup_m3.h>
 
 #include "am35xx.h"
 #include "common.h"
@@ -255,6 +256,13 @@ static void __init nokia_n900_legacy_init(void)
 }
 #endif /* CONFIG_ARCH_OMAP3 */
 
+#ifdef CONFIG_SOC_AM33XX
+static struct wkup_m3_platform_data wkup_m3_data = {
+	.reset_name = "wkup_m3",
+	.deassert_reset = omap_device_deassert_hardreset,
+};
+#endif
+
 #ifdef CONFIG_ARCH_OMAP4
 static void __init omap4_sdp_legacy_init(void)
 {
@@ -348,6 +356,10 @@ struct of_dev_auxdata omap_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("ti,am3517-emac", 0x5c000000, "davinci_emac.0",
 		       &am35xx_emac_pdata),
 #endif
+#ifdef CONFIG_SOC_AM33XX
+	OF_DEV_AUXDATA("ti,am3353-wkup-m3", 0x44d00000, "44d00000.wkup_m3",
+		       &wkup_m3_data),
+#endif
 #ifdef CONFIG_ARCH_OMAP4
 	OF_DEV_AUXDATA("ti,omap4-padconf", 0x4a100040, "4a100040.pinmux", &pcs_pdata),
 	OF_DEV_AUXDATA("ti,omap4-padconf", 0x4a31e040, "4a31e040.pinmux", &pcs_pdata),
diff --git a/include/linux/platform_data/wkup_m3.h b/include/linux/platform_data/wkup_m3.h
new file mode 100644
index 0000000..07282bd
--- /dev/null
+++ b/include/linux/platform_data/wkup_m3.h
@@ -0,0 +1,17 @@
+/*
+ * omap wkup_m3: platform data
+ *
+ * Copyright (C) 2014 Texas Instruments, Inc.
+ *
+ * Dave Gerlach <d-gerlach@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+struct wkup_m3_platform_data {
+	const char *reset_name;
+
+	int (*deassert_reset)(struct platform_device *pdev, const char *name);
+};
-- 
1.9.0


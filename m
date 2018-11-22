From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 02/17] soc: ti: pruss: Define platform data for PRUSS bus driver
Date: Thu, 22 Nov 2018 13:38:58 +0200
Message-ID: <1542886753-17625-3-git-send-email-rogerq@ti.com>
References: <1542886753-17625-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542886753-17625-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org, ohad@wizery.com, bjorn.andersson@linaro.org, s-anna@ti.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, rogerq@ti.com
List-Id: linux-omap@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

The PRUSS can have a PRCM reset line associated with the IP on
some OMAP architecture based SoCs. The reset needs to be programmed
properly before accessing any of the internal registers in the PRUSS.
This functionality is achieved through the omap_device layer, which
is not exposed outside of mach-omap2 layer. Define a platform data
structure for PRUSS so that this API can be invoked through platform
data ops from the driver.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 include/linux/platform_data/ti-pruss.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 include/linux/platform_data/ti-pruss.h

diff --git a/include/linux/platform_data/ti-pruss.h b/include/linux/platform_data/ti-pruss.h
new file mode 100644
index 0000000..96a66cc
--- /dev/null
+++ b/include/linux/platform_data/ti-pruss.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Platform data for PRUSS on TI SoCs
+ *
+ * Copyright (C) 2014-2018 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+#ifndef _PLAT_TI_PRUSS_H
+#define _PLAT_TI_PRUSS_H
+
+struct platform_device;
+
+/**
+ * struct pruss_platform_data - PRUSS platform data
+ * @reset_name: name of the reset
+ * @assert_reset: PRU-specific handler for putting the device in reset
+ * @deassert_reset: PRU-specific handler for releasing the device from reset
+ */
+struct pruss_platform_data {
+	const char *reset_name;
+	int (*assert_reset)(struct platform_device *pdev, const char *name);
+	int (*deassert_reset)(struct platform_device *pdev, const char *name);
+};
+
+#endif /* _PLAT_TI_PRUSS_H */
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

From: David Lechner <david@lechnology.com>
Subject: [PATCH 3/8] ARM: OMAP2+: add pdata quirks for PRUSS reset
Date: Sat, 23 Jun 2018 16:08:05 -0500
Message-ID: <20180623210810.21232-4-david@lechnology.com>
References: <20180623210810.21232-1-david@lechnology.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180623210810.21232-1-david@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: David Lechner <david@lechnology.com>, Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This adds platform data for the PRUSS reset on OMAP2+. This is following
the pattern used by several other platform devices on these SoCs since
there is not a proper reset controller.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-omap2/pdata-quirks.c     |  9 +++++++++
 include/linux/platform_data/ti-pruss.h | 18 ++++++++++++++++++
 2 files changed, 27 insertions(+)
 create mode 100644 include/linux/platform_data/ti-pruss.h

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 7f02743edbe4..8ea35d6cded5 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -25,6 +25,7 @@
 #include <linux/platform_data/hsmmc-omap.h>
 #include <linux/platform_data/iommu-omap.h>
 #include <linux/platform_data/ti-sysc.h>
+#include <linux/platform_data/ti-pruss.h>
 #include <linux/platform_data/wkup_m3.h>
 #include <linux/platform_data/asoc-ti-mcbsp.h>
 
@@ -424,6 +425,12 @@ static struct wkup_m3_platform_data wkup_m3_data = {
 	.assert_reset = omap_device_assert_hardreset,
 	.deassert_reset = omap_device_deassert_hardreset,
 };
+
+static struct ti_pruss_platform_data pruss_data = {
+	.reset_name = "pruss",
+	.assert_reset = omap_device_assert_hardreset,
+	.deassert_reset = omap_device_deassert_hardreset,
+};
 #endif
 
 #ifdef CONFIG_SOC_OMAP5
@@ -568,6 +575,8 @@ static struct of_dev_auxdata omap_auxdata_lookup[] = {
 #ifdef CONFIG_SOC_AM33XX
 	OF_DEV_AUXDATA("ti,am3352-wkup-m3", 0x44d00000, "44d00000.wkup_m3",
 		       &wkup_m3_data),
+	OF_DEV_AUXDATA("ti,am3352-pru-rproc", 0x4a300000, "4a300000.cpu",
+		       &pruss_data),
 #endif
 #ifdef CONFIG_SOC_AM43XX
 	OF_DEV_AUXDATA("ti,am4372-wkup-m3", 0x44d00000, "44d00000.wkup_m3",
diff --git a/include/linux/platform_data/ti-pruss.h b/include/linux/platform_data/ti-pruss.h
new file mode 100644
index 000000000000..e401e621ebdf
--- /dev/null
+++ b/include/linux/platform_data/ti-pruss.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * TI PRU remote processor platform data
+ */
+
+#ifndef _LINUX_PLATFORM_DATA_TI_PRU_H
+#define _LINUX_PLATFORM_DATA_TI_PRU_H
+
+struct platform_device;
+
+struct ti_pruss_platform_data {
+	const char *reset_name;
+
+	int (*assert_reset)(struct platform_device *pdev, const char *name);
+	int (*deassert_reset)(struct platform_device *pdev, const char *name);
+};
+
+#endif /* _LINUX_PLATFORM_DATA_TI_PRU_H */
-- 
2.17.1

From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [RFC 5/6] omap: add remoteproc device(s)
Date: Fri,  2 Jul 2010 01:23:13 +0300
Message-ID: <1278022994-28476-6-git-send-email-ohad@wizery.com>
References: <1278022994-28476-1-git-send-email-ohad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49802 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759822Ab0GAWXm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Jul 2010 18:23:42 -0400
Received: by mail-bw0-f46.google.com with SMTP id 1so1212780bwz.19
        for <linux-omap@vger.kernel.org>; Thu, 01 Jul 2010 15:23:41 -0700 (PDT)
In-Reply-To: <1278022994-28476-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kanigeri Hari <h-kanigeri2@ti.com>, Ohad Ben-Cohen <ohadb@ti.com>

From: Ohad Ben-Cohen <ohadb@ti.com>

Add an omap_device for each remote processor on the system

Signed-off-by: Ohad Ben-Cohen <ohadb@ti.com>
Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 arch/arm/mach-omap2/devices.c |   86 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 86 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 18ad931..d365db6 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -15,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/clk.h>
+#include <linux/err.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -26,9 +27,13 @@
 #include <plat/mux.h>
 #include <mach/gpio.h>
 #include <plat/mmc.h>
+#include <plat/remoteproc.h>
 
 #include "mux.h"
 
+#include <plat/omap_device.h>
+#include <plat/omap_hwmod.h>
+
 #if defined(CONFIG_VIDEO_OMAP2) || defined(CONFIG_VIDEO_OMAP2_MODULE)
 
 static struct resource cam_resources[] = {
@@ -136,6 +141,86 @@ static inline void omap_init_camera(void)
 }
 #endif
 
+#if defined(CONFIG_OMAP_REMOTE_PROC) || defined(CONFIG_OMAP_REMOTE_PROC_MODULE)
+static struct omap_device_pm_latency omap_rproc_latency[] = {
+	{
+		.deactivate_func = omap_device_idle_hwmods,
+		.activate_func = omap_device_enable_hwmods,
+		.deactivate_lat = 1,
+		.activate_lat = 1,
+	},
+};
+
+static struct omap_rproc_platform_data *omap_get_remoteproc_data(void)
+{
+	struct omap_rproc_platform_data *rproc_data = NULL;
+
+	if (cpu_is_omap3430() || cpu_is_omap3630())
+		rproc_data = omap3_get_rproc_data();
+	else if (cpu_is_omap44xx())
+		rproc_data = omap4_get_rproc_data();
+	else
+		pr_err("%s: platform not supported\n", __func__);
+
+	return rproc_data;
+}
+
+int omap_get_num_of_remoteproc(void)
+{
+	int num = -1;
+
+	if (cpu_is_omap3430() || cpu_is_omap3630())
+		num = omap3_get_rproc_data_size();
+	else if (cpu_is_omap44xx())
+		num = omap4_get_rproc_data_size();
+	else
+		pr_err("%s: platform not supported\n", __func__);
+
+	return num;
+}
+EXPORT_SYMBOL(omap_get_num_of_remoteproc);
+
+static inline void omap_init_rproc(void)
+{
+	struct omap_hwmod *oh;
+	struct omap_device *od;
+	struct omap_device_pm_latency *ohl;
+	char *oh_name, *pdev_name;
+	int ohl_cnt = 0, i;
+	int rproc_data_size;
+	struct omap_rproc_platform_data *rproc_data;
+
+	pdev_name = "omap-rproc";
+	ohl = omap_rproc_latency;
+	ohl_cnt = ARRAY_SIZE(omap_rproc_latency);
+
+	rproc_data = omap_get_remoteproc_data();
+	rproc_data_size = omap_get_num_of_remoteproc();
+	if (rproc_data == NULL || rproc_data_size <= 0) {
+		pr_err("%s: platform not supported\n", __func__);
+		return;
+	}
+
+	for (i = 0; i < rproc_data_size; i++) {
+		oh_name = rproc_data[i].oh_name;
+		oh = omap_hwmod_lookup(oh_name);
+		if (!oh) {
+			pr_err("%s: could not look up %s\n", __func__, oh_name);
+			continue;
+		}
+
+		od = omap_device_build(pdev_name, i, oh,
+					&rproc_data[i],
+					sizeof(struct omap_rproc_platform_data),
+					ohl, ohl_cnt);
+		WARN(IS_ERR(od), "Could not build omap_device for %s %s\n",
+			pdev_name, oh_name);
+	}
+}
+#else
+static inline void omap_init_rproc(void) { }
+#endif /* CONFIG_OMAP_REMOTE_PROC */
+
 #if defined(CONFIG_OMAP_MBOX_FWK) || defined(CONFIG_OMAP_MBOX_FWK_MODULE)
 
 #define MBOX_REG_SIZE   0x120
@@ -773,6 +858,7 @@ static int __init omap2_init_devices(void)
 	omap_hsmmc_reset();
 	omap_init_camera();
 	omap_init_mbox();
+	omap_init_rproc();
 	omap_init_mcspi();
 	omap_hdq_init();
 	omap_init_sti();
-- 
1.7.0.4


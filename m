From: Manjunatha GK <manjugk@ti.com>
Subject: [PATCH v5] OMAP3: Registering sgx device and it's platform data
Date: Fri, 21 May 2010 11:26:20 +0530
Message-ID: <1274421380-27654-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54938 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754870Ab0EUF5D (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 May 2010 01:57:03 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Preshit Agarwal <preshit.agarwal@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, Mike Turquette <mturquette@ti.com>, Hemanth V <hemanthv@ti.com>

The SGX powervr_device is registered with it's platform specific
data to provide information about setting constraint through
omap_pm_set_min_bus_tput.

Signed-off-by: Preshit Agarwal <preshit.agarwal@ti.com>
Signed-off-by: Manjunatha GK <manjugk@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Mike Turquette <mturquette@ti.com>
Cc: Hemanth V <hemanthv@ti.com>
---
 arch/arm/mach-omap2/devices.c                  |   20 ++++++++++++++++++++
 arch/arm/mach-omap2/include/mach/omap_sgxdef.h |   11 +++++++++++
 2 files changed, 31 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/include/mach/omap_sgxdef.h

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 3d30f22..c46cfb3 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -26,6 +26,7 @@
 #include <plat/mux.h>
 #include <mach/gpio.h>
 #include <plat/mmc.h>
+#include <mach/omap_sgxdef.h>
 
 #include "mux.h"
 
@@ -797,6 +798,23 @@ static inline void omap_hdq_init(void) {}
 
 /*---------------------------------------------------------------------------*/
 
+struct sgx_platform_data omap_sgx_data = {
+	.set_min_bus_tput = omap_pm_set_min_bus_tput,
+};
+
+static struct platform_device powervr_device = {
+	.name            = "pvrsrvkm",
+	.id              = -1,
+	.dev            = {
+	.platform_data = &omap_sgx_data,
+	}
+};
+
+static void omap_init_sgx(void)
+{
+	(void) platform_device_register(&powervr_device);
+}
+
 #if defined(CONFIG_VIDEO_OMAP2_VOUT) || \
 	defined(CONFIG_VIDEO_OMAP2_VOUT_MODULE)
 #if defined(CONFIG_FB_OMAP2) || defined(CONFIG_FB_OMAP2_MODULE)
@@ -837,6 +855,8 @@ static int __init omap2_init_devices(void)
 	omap_init_sti();
 	omap_init_sha1_md5();
 	omap_init_vout();
+	if (omap3_has_sgx)
+		omap_init_sgx();
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/include/mach/omap_sgxdef.h b/arch/arm/mach-omap2/include/mach/omap_sgxdef.h
new file mode 100644
index 0000000..5d90a6a
--- /dev/null
+++ b/arch/arm/mach-omap2/include/mach/omap_sgxdef.h
@@ -0,0 +1,11 @@
+#ifndef OMAP_SGXDEF_H
+#define OMAP_SGXDEF_H
+
+#include <plat/omap-pm.h>
+
+struct sgx_platform_data {
+	void(*set_min_bus_tput)(struct device *dev, u8 agent_id,
+							unsigned long r);
+};
+
+#endif
-- 
1.7.0.4


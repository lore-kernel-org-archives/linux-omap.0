From: "Agarwal, Preshit" <preshit.agarwal@ti.com>
Subject: [PATCH v3 1/1] Registering sgx device and it's platform data
Date: Tue, 30 Mar 2010 12:36:33 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DEBF372@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45016 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752312Ab0C3HF2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Mar 2010 03:05:28 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pais, Allen" <allen.pais@ti.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>

In this patch SGX powervr_device is registered with it's platform specific
data to provide information about setting constraint through
omap_pm_set_min_bus_tput.
This patch removes the requirement of EXPORT_SYMBOL for the same function.

Signed-off-by: Preshit Agarwal <preshit.agarwal@ti.com>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
Signed-off-by: Allen Pais <allen.pais@ti.com>

---
 arch/arm/mach-omap2/devices.c                  |   32 ++++++++++++++++++++++++
 arch/arm/mach-omap2/include/mach/omap_sgxdef.h |   11 ++++++++
 2 files changed, 43 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/include/mach/omap_sgxdef.h

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 7131d8d..fe76248 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -27,6 +27,7 @@
 #include <mach/gpio.h>
 #include <plat/mmc.h>
 
+#include <mach/omap_sgxdef.h>
 #include "mux.h"
 
 #if defined(CONFIG_VIDEO_OMAP2) || defined(CONFIG_VIDEO_OMAP2_MODULE)
@@ -773,6 +774,36 @@ static inline void omap_hdq_init(void)
 static inline void omap_hdq_init(void) {}
 #endif
 
+#ifdef CONFIG_PM
+static void omap_sgx_pm_constraints(struct device *dev, u8 agent_id,
+							unsigned long r)
+{
+	omap_pm_set_min_bus_tput(dev, agent_id, r);
+}
+#else
+static inline void omap_sgx_pm_constraints(struct device *dev, u8 agent_id,
+							unsigned long r)
+{
+}
+#endif
+
+struct sgx_platform_data omap_sgx_data = {
+	.set_min_bus_tput = omap_sgx_pm_constraints,
+};
+
+static struct platform_device powervr_device = {
+	.name		= "pvrsrvkm",
+	.id		= -1,
+	.dev		= {
+		.platform_data = &omap_sgx_data,
+	},
+};
+
+static void omap_init_sgx(void)
+{
+	(void) platform_device_register(&powervr_device);
+}
+
 /*-------------------------------------------------------------------------*/
 
 static int __init omap2_init_devices(void)
@@ -787,6 +818,7 @@ static int __init omap2_init_devices(void)
 	omap_hdq_init();
 	omap_init_sti();
 	omap_init_sha1_md5();
+	omap_init_sgx();
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/include/mach/omap_sgxdef.h b/arch/arm/mach-omap2/include/mach/omap_sgxdef.h
new file mode 100644
index 0000000..195df97
--- /dev/null
+++ b/arch/arm/mach-omap2/include/mach/omap_sgxdef.h
@@ -0,0 +1,11 @@
+#ifndef OMAP_SGXDEF_H
+#define OMAP_SGXDEF_H
+
+#include <plat/omap-pm.h>
+
+struct sgx_platform_data {
+	void (*set_min_bus_tput)(struct device *dev, u8 agent_id,
+						unsigned long r);
+};
+
+#endif
-- 
1.5.4.3
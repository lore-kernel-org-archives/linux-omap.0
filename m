From: "Agarwal, Preshit" <preshit.agarwal@ti.com>
Subject: [PATCH] Registering sgx device and it's platform specific data
Date: Fri, 26 Mar 2010 16:03:26 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DEBED02@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51468 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351Ab0CZKc1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Mar 2010 06:32:27 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o2QAWOOK014759
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 26 Mar 2010 05:32:26 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o2QAWNrt029718
	for <linux-omap@vger.kernel.org>; Fri, 26 Mar 2010 16:02:23 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

In this patch SGX powervr_device is registered with it's platform specific
data to provide information about setting constraint through 
omap_pm_set_min_bus_tput.
This patch removes the requirement of EXPORT_SYMBOL for the omap_pm_set_min_bus_tput
function.

Signed-off-by: Allen Pais <allen.pais@ti.com>
Signed-off-by: Preshit Agarwal <preshit.agarwal@ti.com>
---
 arch/arm/mach-omap2/devices.c                  |   26 ++++++++++++++++++++++-
 arch/arm/mach-omap2/include/mach/omap_sgxdef.h |   13 ++++++++++++
 2 files changed, 37 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-omap2/include/mach/omap_sgxdef.h

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 7131d8d..32a06b6 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -26,7 +26,7 @@
 #include <plat/mux.h>
 #include <mach/gpio.h>
 #include <plat/mmc.h>
-
+#include <mach/omap_sgxdef.h>
 #include "mux.h"
 
 #if defined(CONFIG_VIDEO_OMAP2) || defined(CONFIG_VIDEO_OMAP2_MODULE)
@@ -773,6 +773,28 @@ static inline void omap_hdq_init(void)
 static inline void omap_hdq_init(void) {}
 #endif
 
+struct sgx_platform_data omap_sgx_data = {
+	.set_min_bus_tput = omap_pm_set_min_bus_tput,
+};
+
+static struct platform_device powervr_device = {
+	.name            = "pvrsrvkm",
+	.id              = -1,
+#ifdef CONFIG_PM
+	.dev            = {
+	.platform_data = &omap_sgx_data,
+       }
+#else
+	.dev            = {
+	.platform_data = NULL,}
+#endif
+};
+static void omap_init_sgx(void)
+{
+       (void) platform_device_register(&powervr_device);
+}
+
+
 /*-------------------------------------------------------------------------*/
 
 static int __init omap2_init_devices(void)
@@ -787,7 +809,7 @@ static int __init omap2_init_devices(void)
 	omap_hdq_init();
 	omap_init_sti();
 	omap_init_sha1_md5();
-
+	omap_init_sgx();
 	return 0;
 }
 arch_initcall(omap2_init_devices);
diff --git a/arch/arm/mach-omap2/include/mach/omap_sgxdef.h b/arch/arm/mach-omap2/include/mach/omap_sgxdef.h
new file mode 100644
index 0000000..08e24bb
--- /dev/null
+++ b/arch/arm/mach-omap2/include/mach/omap_sgxdef.h
@@ -0,0 +1,13 @@
+#ifndef OMAP_SGXDEF_H
+#define OMAP_SGXDEF_H
+
+#include <plat/omap-pm.h>
+
+#ifdef CONFIG_PM
+struct sgx_platform_data {
+	void(*set_min_bus_tput)(struct device *dev, u8 agent_id,
+							unsigned long r);
+};
+
+#endif
+#endif
-- 
1.5.4.3
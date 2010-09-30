From: Abraham Arce <x0066660@ti.com>
Subject: [PATCH v6 6/8] OMAP4: Keyboard device registration
Date: Thu, 30 Sep 2010 00:29:23 -0500
Message-ID: <1285824565-24906-7-git-send-email-x0066660@ti.com>
References: <1285824565-24906-1-git-send-email-x0066660@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42578 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753137Ab0I3FbT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Sep 2010 01:31:19 -0400
In-Reply-To: <1285824565-24906-1-git-send-email-x0066660@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-input@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Abraham Arce <x0066660@ti.com>

Register keyboard device with hwmod framework

Signed-off-by: Abraham Arce <x0066660@ti.com>
---
 arch/arm/mach-omap2/devices.c |   39 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 9e5d51b..226cc7a 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -28,6 +28,9 @@
 #include <mach/gpio.h>
 #include <plat/mmc.h>
 #include <plat/dma.h>
+#include <plat/omap_device.h>
+#include <plat/omap_hwmod.h>
+#include <plat/omap4-keypad.h>
 
 #include "mux.h"
 
@@ -138,6 +141,42 @@ static inline void omap_init_camera(void)
 }
 #endif
 
+struct omap_device_pm_latency omap4_keyboard_latency[] = {
+	{
+		.deactivate_func = omap_device_idle_hwmods,
+		.activate_func   = omap_device_enable_hwmods,
+		.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
+	},
+};
+
+int omap4_keyboard_init(struct omap4_keypad_platform_data
+						*keypad_data)
+{
+	struct omap_device *od;
+	struct omap_hwmod *oh;
+	const char *oh_name = "kbd";
+	const char *name = "omap4-keypad";
+
+	if (!cpu_is_omap44xx())
+		return -ENODEV;
+
+	oh = omap_hwmod_lookup(oh_name);
+	if (!oh) {
+		pr_err("Could not look up %s\n", oh_name);
+		return -ENODEV;
+	}
+
+	od = omap_device_build(name, -1, oh, keypad_data,
+			sizeof(*keypad_data),
+			omap4_keyboard_latency,
+			ARRAY_SIZE(omap4_keyboard_latency), 0);
+	if (WARN(IS_ERR(od), "Could not build omap_device for %s %s\n",
+		name, oh->name))
+		return -ENODEV;
+
+	return 0;
+}
+
 #if defined(CONFIG_OMAP_MBOX_FWK) || defined(CONFIG_OMAP_MBOX_FWK_MODULE)
 
 #define MBOX_REG_SIZE   0x120
-- 
1.6.3.3


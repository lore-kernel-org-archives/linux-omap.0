From: "Arce, Abraham" <x0066660@ti.com>
Subject: [RFC] [PATCH v3 2/4] OMAP4: Keyboard device registration
Date: Mon, 31 May 2010 16:44:52 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043E537F74@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
List-Id: linux-omap@vger.kernel.org

Register keyboard device with hwmod framework

Signed-off-by: Abraham Arce <x0066660@ti.com>
---
 arch/arm/mach-omap2/devices.c |   59 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 2271b9b..64d68a9 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -15,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/clk.h>
+#include <linux/slab.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -26,6 +27,9 @@
 #include <plat/mux.h>
 #include <mach/gpio.h>
 #include <plat/mmc.h>
+#include <plat/omap_hwmod.h>
+#include <plat/omap_device.h>
+#include <plat/omap4-keypad.h>
 
 #include "mux.h"
 
@@ -136,6 +140,61 @@ static inline void omap_init_camera(void)
 }
 #endif
 
+#ifdef CONFIG_ARCH_OMAP4
+
+struct omap_device_pm_latency omap_keyboard_latency[] = {
+	{
+		.deactivate_func = omap_device_idle_hwmods,
+		.activate_func   = omap_device_enable_hwmods,
+		.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
+	},
+};
+
+int omap4_init_kp(struct omap4_keypad_platform_data *kp)
+{
+	struct omap_hwmod *oh;
+	struct omap_device *od;
+	struct omap4_keypad_platform_data *pdata;
+
+	unsigned int length = 0, id = 0;
+	int hw_mod_name_len = 16;
+	char oh_name[hw_mod_name_len];
+	char *name = "omap4-keypad";
+
+	length = snprintf(oh_name, hw_mod_name_len, "kbd");
+
+	oh = omap_hwmod_lookup(oh_name);
+	if (!oh) {
+		pr_err("Could not look up %s\n", oh_name);
+		return -EIO;
+	}
+
+	pdata = kzalloc(sizeof(struct omap4_keypad_platform_data), GFP_KERNEL);
+	if (!pdata) {
+		WARN(1, "Keyboard pdata memory allocation failed\n");
+		return -ENOMEM;
+	}
+
+	pdata = kp;
+
+	pdata->base = oh->_rt_va;
+	pdata->irq = oh->mpu_irqs[0].irq;
+	pdata->device_enable = omap_device_enable;
+	pdata->device_idle = omap_device_idle;
+	pdata->device_shutdown = omap_device_shutdown;
+
+	od = omap_device_build(name, id, oh, pdata,
+			sizeof(struct matrix_keypad_platform_data),
+			omap_keyboard_latency,
+			ARRAY_SIZE(omap_keyboard_latency), 1);
+	WARN(IS_ERR(od), "Could not build omap_device for %s %s\n",
+		name, oh_name);
+
+	return 0;
+}
+
+#endif
+
 #if defined(CONFIG_OMAP_MBOX_FWK) || defined(CONFIG_OMAP_MBOX_FWK_MODULE)
 
 #define MBOX_REG_SIZE   0x120
-- 
1.5.4.3


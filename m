From: Ranjith Lohithakshan <ranjithl@ti.com>
Subject: [PATCH 1/2] AM35xx: Add support for AM3517 EVM board
Date: Wed, 28 Oct 2009 19:44:10 +0530
Message-ID: <1256739250-8318-1-git-send-email-ranjithl@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45596 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751506AbZJ1OOK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Oct 2009 10:14:10 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9SEEB89024874
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2009 09:14:14 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: ranjithl@ti.com

This patch creates a minimal AM3517 EVM board support.

Signed-off-by: Ranjith Lohithakshan <ranjithl@ti.com>
---
 arch/arm/mach-omap2/Makefile          |    2 +
 arch/arm/mach-omap2/board-am3517evm.c |   73 +++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-am3517evm.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 7468505..b923567 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -79,6 +79,8 @@ obj-$(CONFIG_MACH_CM_T35)		+= board-cm-t35.o \
 
 obj-$(CONFIG_MACH_OMAP_4430SDP)		+= board-4430sdp.o
 
+obj-$(CONFIG_MACH_OMAP3517EVM)     += board-am3517evm.o
+
 # Platform specific device init code
 obj-y					+= usb-musb.o
 obj-$(CONFIG_MACH_OMAP2_TUSB6010)	+= usb-tusb6010.o
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
new file mode 100644
index 0000000..78a77eb
--- /dev/null
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -0,0 +1,73 @@
+/*
+ * linux/arch/arm/mach-omap2/board-am3517evm.c
+ *
+ * Copyright (C) 2009 Texas Instruments Incorporated
+ * Author: Ranjith Lohithakshan <ranjithl@ti.com>
+ *
+ * Based on mach-omap2/board-omap3evm.c
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as  published by the
+ * Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any kind,
+ * whether express or implied; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/gpio.h>
+
+#include <mach/hardware.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+
+#include <plat/board.h>
+#include <plat/common.h>
+
+/*
+ * Board initialization
+ */
+static struct omap_board_config_kernel am3517_evm_config[] __initdata = {
+};
+
+static struct platform_device *am3517_evm_devices[] __initdata = {
+};
+
+static void __init am3517_evm_init_irq(void)
+{
+	omap_board_config = am3517_evm_config;
+	omap_board_config_size = ARRAY_SIZE(am3517_evm_config);
+
+	omap2_init_common_hw(NULL, NULL);
+	omap_init_irq();
+	omap_gpio_init();
+}
+
+static void __init am3517_evm_init(void)
+{
+	platform_add_devices(am3517_evm_devices,
+				ARRAY_SIZE(am3517_evm_devices));
+
+	omap_serial_init();
+}
+
+static void __init am3517_evm_map_io(void)
+{
+	omap2_set_globals_343x();
+	omap2_map_common_io();
+}
+
+MACHINE_START(OMAP3517EVM, "OMAP3517/AM3517 EVM")
+	.phys_io	= 0x48000000,
+	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
+	.boot_params	= 0x80000100,
+	.map_io		= am3517_evm_map_io,
+	.init_irq	= am3517_evm_init_irq,
+	.init_machine	= am3517_evm_init,
+	.timer		= &omap_timer,
+MACHINE_END
-- 
1.6.2.4


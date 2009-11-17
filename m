From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 11/12] AM35xx: Add support for AM3517 EVM board
Date: Tue, 17 Nov 2009 15:07:01 -0800
Message-ID: <20091117230701.19869.93311.stgit@localhost>
References: <20091117230324.19869.44927.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:62358 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756753AbZKQXG4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Nov 2009 18:06:56 -0500
In-Reply-To: <20091117230324.19869.44927.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Ranjith Lohithakshan <ranjithl@ti.com>

From: Ranjith Lohithakshan <ranjithl@ti.com>

This patch creates a minimal AM3517 EVM board support.

Signed-off-by: Ranjith Lohithakshan <ranjithl@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Kconfig           |    4 ++
 arch/arm/mach-omap2/Makefile          |    2 +
 arch/arm/mach-omap2/board-am3517evm.c |   86 +++++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-am3517evm.c

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index b271a65..034d990 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -65,6 +65,10 @@ config MACH_OMAP3EVM
 	bool "OMAP 3530 EVM board"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
 
+config MACH_OMAP3517EVM
+	bool "OMAP3517/ AM3517 EVM board"
+	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+
 config MACH_OMAP3_PANDORA
 	bool "OMAP3 Pandora"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 3e1b45f..59b0ccc 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -93,6 +93,8 @@ obj-$(CONFIG_MACH_IGEP0020)		+= board-igep0020.o \
 
 obj-$(CONFIG_MACH_OMAP_4430SDP)		+= board-4430sdp.o
 
+obj-$(CONFIG_MACH_OMAP3517EVM)     += board-am3517evm.o
+
 # Platform specific device init code
 obj-y					+= usb-musb.o
 obj-$(CONFIG_MACH_OMAP2_TUSB6010)	+= usb-tusb6010.o
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
new file mode 100644
index 0000000..415a13d
--- /dev/null
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -0,0 +1,86 @@
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
+#include <plat/usb.h>
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
+static struct ehci_hcd_omap_platform_data ehci_pdata __initdata = {
+	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
+	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
+	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+
+	.phy_reset  = true,
+	.reset_gpio_port[0]  = 57,
+	.reset_gpio_port[1]  = -EINVAL,
+	.reset_gpio_port[2]  = -EINVAL
+};
+
+static void __init am3517_evm_init(void)
+{
+	platform_add_devices(am3517_evm_devices,
+				ARRAY_SIZE(am3517_evm_devices));
+
+	omap_serial_init();
+	usb_ehci_init(&ehci_pdata);
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


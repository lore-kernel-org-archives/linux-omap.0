From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 5/6] ti814evm: Add support for musb interface
Date: Fri, 26 Aug 2011 16:41:47 +0530
Message-ID: <1314357108-2279-6-git-send-email-ajay.gupta@ti.com>
References: <1314357108-2279-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41325 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750747Ab1HZLL6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Aug 2011 07:11:58 -0400
In-Reply-To: <1314357108-2279-1-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-usb@vger.kernel.org, balbi@ti.com, tony@atomide.com, Ravi B <ravibabu@ti.com>, Ajay Kumar Gupta <ajay.gupta@ti.com>

From: Ravi B <ravibabu@ti.com>

Adding musb support in ti814 EVM board file.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
Signed-off-by: Ravi B <ravibabu@ti.com>
---
 arch/arm/mach-omap2/board-ti8148evm.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-ti8148evm.c b/arch/arm/mach-omap2/board-ti8148evm.c
index 588d6b7..d9c8505 100644
--- a/arch/arm/mach-omap2/board-ti8148evm.c
+++ b/arch/arm/mach-omap2/board-ti8148evm.c
@@ -23,6 +23,20 @@
 #include <plat/irqs.h>
 #include <plat/board.h>
 #include <plat/common.h>
+#include <plat/usb.h>
+
+static struct omap_musb_board_data musb_board_data = {
+	.set_phy_power	= ti81xx_musb_phy_power,
+	.interface_type	= MUSB_INTERFACE_ULPI,
+#ifdef CONFIG_USB_MUSB_OTG
+	.mode           = MUSB_OTG,
+#elif defined(CONFIG_USB_MUSB_HDRC_HCD)
+	.mode           = MUSB_HOST,
+#elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
+	.mode           = MUSB_PERIPHERAL,
+#endif
+	.power		= 500,
+};
 
 static struct omap_board_config_kernel ti8148_evm_config[] __initdata = {
 };
@@ -38,6 +52,7 @@ static void __init ti8148_evm_init(void)
 	omap_serial_init();
 	omap_board_config = ti8148_evm_config;
 	omap_board_config_size = ARRAY_SIZE(ti8148_evm_config);
+	usb_musb_init(&musb_board_data);
 }
 
 static void __init ti8148_evm_map_io(void)
-- 
1.6.2.4


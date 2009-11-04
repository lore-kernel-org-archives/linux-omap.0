From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 1/2] AM35xx:  Add USB EHCI support
Date: Wed,  4 Nov 2009 19:48:32 +0530
Message-ID: <1257344313-14370-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58738 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754417AbZKDOSd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 Nov 2009 09:18:33 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id nA4EIZUw008631
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 4 Nov 2009 08:18:37 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Ajay Kumar Gupta <ajay.gupta@ti.com>

AM3517 EVM has one EHCI interface on baseboard using port1 and another
EHCI interface on UI card using port2.

GPIO57 is used as port1 PHY reset system reset line is used as port2
PHY reset.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
Both the patches are created against linux-omap/master branch and
on top of below patches supporting AM35xx.
[1] AM35xx: Runtime detection of the device
[2] AM35xx: Define the AM3517EVM board
[3] AM35xx: Add support for AM3517 EVM board
[4] AM35xx: Defconfig for AM3517 EVM board

 arch/arm/mach-omap2/board-am3517evm.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 23cf949..415a13d 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -28,6 +28,7 @@
 
 #include <plat/board.h>
 #include <plat/common.h>
+#include <plat/usb.h>
 
 /*
  * Board initialization
@@ -48,12 +49,24 @@ static void __init am3517_evm_init_irq(void)
 	omap_gpio_init();
 }
 
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
 static void __init am3517_evm_init(void)
 {
 	platform_add_devices(am3517_evm_devices,
 				ARRAY_SIZE(am3517_evm_devices));
 
 	omap_serial_init();
+	usb_ehci_init(&ehci_pdata);
 }
 
 static void __init am3517_evm_map_io(void)
-- 
1.6.2.4


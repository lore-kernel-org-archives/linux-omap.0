From: Lesly A M <leslyam@ti.com>
Subject: [PATCH v9 8/9] OMAP3630: Updating the board file to use TWL4030 scripts
Date: Thu, 14 Apr 2011 17:57:56 +0530
Message-ID: <1302784077-16697-9-git-send-email-leslyam@ti.com>
References: <1302784077-16697-1-git-send-email-leslyam@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:32838 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757612Ab1DNM15 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Apr 2011 08:27:57 -0400
In-Reply-To: <1302784077-16697-1-git-send-email-leslyam@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Lesly A M <leslyam@ti.com>, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Using TWL4030 power scripts to control the LDOs and DCDC regulators
while going to low power mode.

Signed-off-by: Lesly A M <leslyam@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: David Derrick <dderrick@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
---
 arch/arm/mach-omap2/board-zoom-peripherals.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index 448ab60..aa8f50d 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -31,6 +31,7 @@
 
 #include "mux.h"
 #include "hsmmc.h"
+#include "twl4030-script.h"
 
 #define OMAP_ZOOM_WLAN_PMENA_GPIO	(101)
 #define OMAP_ZOOM_WLAN_IRQ_GPIO		(162)
@@ -339,6 +340,7 @@ static struct twl4030_platform_data zoom_twldata = {
 	.usb		= &zoom_usb_data,
 	.gpio		= &zoom_gpio_data,
 	.keypad		= &zoom_kp_twl4030_data,
+	.power		= &twl4030_generic_script,
 	.codec		= &zoom_codec_data,
 	.vmmc1          = &zoom_vmmc1,
 	.vmmc2          = &zoom_vmmc2,
-- 
1.7.1


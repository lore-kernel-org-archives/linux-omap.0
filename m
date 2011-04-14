From: Lesly A M <leslyam@ti.com>
Subject: [PATCH v9 7/9] OMAP3430: Updating the board file to use TWL4030 scripts
Date: Thu, 14 Apr 2011 17:57:55 +0530
Message-ID: <1302784077-16697-8-git-send-email-leslyam@ti.com>
References: <1302784077-16697-1-git-send-email-leslyam@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42257 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757545Ab1DNM14 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Apr 2011 08:27:56 -0400
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
 arch/arm/mach-omap2/Makefile        |    1 +
 arch/arm/mach-omap2/board-3430sdp.c |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 82b2a67..51d17da 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -66,6 +66,7 @@ obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o pm_bus.o
 obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
 obj-$(CONFIG_OMAP_SMARTREFLEX)          += sr_device.o smartreflex.o
 obj-$(CONFIG_OMAP_SMARTREFLEX_CLASS3)	+= smartreflex-class3.o
+obj-$(CONFIG_TWL4030_POWER)		+= twl4030-script.o
 
 AFLAGS_sleep24xx.o			:=-Wa,-march=armv6
 AFLAGS_sleep34xx.o			:=-Wa,-march=armv7-a
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index b391804..fafbfb5 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -46,6 +46,7 @@
 #include "mux.h"
 #include "sdram-qimonda-hyb18m512160af-6.h"
 #include "hsmmc.h"
+#include "twl4030-script.h"
 #include "pm.h"
 #include "control.h"
 
@@ -569,6 +570,7 @@ static struct twl4030_platform_data sdp3430_twldata = {
 	.madc		= &sdp3430_madc_data,
 	.keypad		= &sdp3430_kp_data,
 	.usb		= &sdp3430_usb_data,
+	.power		= &twl4030_generic_script,
 	.codec		= &sdp3430_codec,
 
 	.vaux1		= &sdp3430_vaux1,
-- 
1.7.1


From: Lesly A M <leslyam@ti.com>
Subject: [PATCH 11/12] omap3430: Updating the board file to use TWL4030 scripts
Date: Fri, 18 Feb 2011 22:38:57 +0530
Message-ID: <1298048938-1480-12-git-send-email-leslyam@ti.com>
References: <1298048938-1480-1-git-send-email-leslyam@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34801 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755109Ab1BRRJX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Feb 2011 12:09:23 -0500
In-Reply-To: <1298048938-1480-1-git-send-email-leslyam@ti.com>
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
 arch/arm/mach-omap2/Makefile        |    3 ++-
 arch/arm/mach-omap2/board-3430sdp.c |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 742ca67..bb11329 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -175,7 +175,8 @@ obj-$(CONFIG_MACH_OMAP3_PANDORA)	+= board-omap3pandora.o \
 					   hsmmc.o
 obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o \
 					   hsmmc.o \
-					   board-flash.o
+					   board-flash.o \
+					   twl4030.o
 obj-$(CONFIG_MACH_NOKIA_N8X0)		+= board-n8x0.o
 obj-$(CONFIG_MACH_NOKIA_RM680)		+= board-rm680.o \
 					   sdram-nokia.o \
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 813893b..c294f98 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -46,6 +46,7 @@
 #include "mux.h"
 #include "sdram-qimonda-hyb18m512160af-6.h"
 #include "hsmmc.h"
+#include "twl4030.h"
 #include "pm.h"
 #include "control.h"
 
@@ -676,7 +677,7 @@ static struct twl4030_platform_data sdp3430_twldata = {
 	.power		= &sdp3430_t2scripts_data,
 	.usb		= &sdp3430_usb_data,
 	.codec		= &sdp3430_codec,
-
+	.power		= &twl4030_generic_script,
 	.vaux1		= &sdp3430_vaux1,
 	.vaux2		= &sdp3430_vaux2,
 	.vaux3		= &sdp3430_vaux3,
-- 
1.7.1


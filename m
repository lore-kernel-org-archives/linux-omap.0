From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCHv2 10/12] ARM: OMAP2+: CM: increase the module disable timeout
Date: Sun, 10 Jun 2012 18:46:23 -0600
Message-ID: <20120611004620.20034.4341.stgit@dusk>
References: <20120611004502.20034.8840.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42599 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752227Ab2FKAwM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 10 Jun 2012 20:52:12 -0400
In-Reply-To: <20120611004502.20034.8840.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tero Kristo <t-kristo@ti.com>

Increase the timeout for disabling an IP block to five milliseconds.
This is to handle the usb_host_fs idle latency, which takes almost
four milliseconds after a host controller reset.

This is the second of two patches needed to resolve the following
boot warning:

omap_hwmod: usb_host_fs: _wait_target_disable failed

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cm.h                   |   11 +++++++++++
 arch/arm/mach-omap2/cminst44xx.c           |    4 ++--
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    1 +
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/cm.h b/arch/arm/mach-omap2/cm.h
index a7bc096..f24e3f7 100644
--- a/arch/arm/mach-omap2/cm.h
+++ b/arch/arm/mach-omap2/cm.h
@@ -22,4 +22,15 @@
  */
 #define MAX_MODULE_READY_TIME		2000
 
+/*
+ * MAX_MODULE_DISABLE_TIME: max duration in microseconds to wait for
+ * the PRCM to request that a module enter the inactive state in the
+ * case of OMAP2 & 3.  In the case of OMAP4 this is the max duration
+ * in microseconds for the module to reach the inactive state from
+ * a functional state.
+ * XXX FSUSB on OMAP4430 takes ~4ms to idle after reset during
+ * kernel init.
+ */
+#define MAX_MODULE_DISABLE_TIME		5000
+
 #endif
diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index 8c86d29..1a39945 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -313,9 +313,9 @@ int omap4_cminst_wait_module_idle(u8 part, u16 inst, s16 cdoffs, u16 clkctrl_off
 
 	omap_test_timeout((_clkctrl_idlest(part, inst, cdoffs, clkctrl_offs) ==
 			   CLKCTRL_IDLEST_DISABLED),
-			  MAX_MODULE_READY_TIME, i);
+			  MAX_MODULE_DISABLE_TIME, i);
 
-	return (i < MAX_MODULE_READY_TIME) ? 0 : -EBUSY;
+	return (i < MAX_MODULE_DISABLE_TIME) ? 0 : -EBUSY;
 }
 
 /**
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index b8b28be..3613054 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -33,6 +33,7 @@
 #include <plat/mmc.h>
 #include <plat/dmtimer.h>
 #include <plat/common.h>
+#include <plat/usb.h>
 
 #include "omap_hwmod_common_data.h"
 



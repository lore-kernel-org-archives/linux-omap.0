From: Rajendra Nayak <rnayak@ti.com>
Subject: [RFC 1/8] OMAP: powerdomain: Move powerdomain.c from mach-omap2 to plat-omap
Date: Thu, 23 Sep 2010 18:04:44 +0530
Message-ID: <1285245291-26442-2-git-send-email-rnayak@ti.com>
References: <1285245291-26442-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40353 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755156Ab0IWMfC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Sep 2010 08:35:02 -0400
In-Reply-To: <1285245291-26442-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com, b-cousson@ti.com, Rajendra Nayak <rnayak@ti.com>

This is in preparation of splitting the powerdomain framework into
platform-independent part (for all omaps) and platform-specific
parts.
The platform-independent code would reside in plat-omap/powerdomain.c
and the platform-specific code will resides in
mach-omap2/powerdomain-xxxx.c files.

Some of the hacks to include header files are done to make sure the
patch compiles and works fine. These hacks will be removed in the
subsequent patches.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/Makefile                     |    2 +-
 arch/arm/plat-omap/Makefile                      |    6 +++---
 arch/arm/{mach-omap2 => plat-omap}/powerdomain.c |   14 +++++++-------
 3 files changed, 11 insertions(+), 11 deletions(-)
 rename arch/arm/{mach-omap2 => plat-omap}/powerdomain.c (99%)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 88d3a1e..42209b5 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -8,7 +8,7 @@ obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o pm.o
 omap-2-3-common				= irq.o sdrc.o
 hwmod-common				= omap_hwmod.o \
 					  omap_hwmod_common_data.o
-prcm-common				= prcm.o powerdomain.o
+prcm-common				= prcm.o
 clock-common				= clock.o clock_common_data.o \
 					  clockdomain.o clkt_dpll.o \
 					  clkt_clksel.o
diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index 9405831..485404e 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -13,9 +13,9 @@ obj-  :=
 obj-$(CONFIG_ARCH_OMAP16XX) += ocpi.o
 
 # omap_device support (OMAP2+ only at the moment)
-obj-$(CONFIG_ARCH_OMAP2) += omap_device.o
-obj-$(CONFIG_ARCH_OMAP3) += omap_device.o
-obj-$(CONFIG_ARCH_OMAP4) += omap_device.o
+obj-$(CONFIG_ARCH_OMAP2) += omap_device.o powerdomain.o
+obj-$(CONFIG_ARCH_OMAP3) += omap_device.o powerdomain.o
+obj-$(CONFIG_ARCH_OMAP4) += omap_device.o powerdomain.o
 
 obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
 obj-$(CONFIG_OMAP_IOMMU) += iommu.o iovmm.o
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/plat-omap/powerdomain.c
similarity index 99%
rename from arch/arm/mach-omap2/powerdomain.c
rename to arch/arm/plat-omap/powerdomain.c
index 6527ec3..9204799 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/plat-omap/powerdomain.c
@@ -26,19 +26,19 @@
 
 #include <asm/atomic.h>
 
-#include "cm.h"
-#include "cm-regbits-34xx.h"
-#include "cm-regbits-44xx.h"
-#include "prm.h"
-#include "prm-regbits-34xx.h"
-#include "prm-regbits-44xx.h"
+#include "../mach-omap2/cm.h"
+#include "../mach-omap2/cm-regbits-34xx.h"
+#include "../mach-omap2/cm-regbits-44xx.h"
+#include "../mach-omap2/prm.h"
+#include "../mach-omap2/prm-regbits-34xx.h"
+#include "../mach-omap2/prm-regbits-44xx.h"
 
 #include <plat/cpu.h>
 #include <plat/powerdomain.h>
 #include <plat/clockdomain.h>
 #include <plat/prcm.h>
 
-#include "pm.h"
+#include "../mach-omap2/pm.h"
 
 enum {
 	PWRDM_STATE_NOW = 0,
-- 
1.7.0.4


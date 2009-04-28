From: Roger Quadros <ext-roger.quadros@nokia.com>
Subject: [PATCH] OMAP: PM: Fix boot with OMAP_SMARTREFLEX and OMAP_PM_NOOP
Date: Tue, 28 Apr 2009 12:37:46 +0300
Message-ID: <1240911467-12269-2-git-send-email-ext-roger.quadros@nokia.com>
References: <1240911467-12269-1-git-send-email-ext-roger.quadros@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:29356 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754293AbZD1Jii (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Apr 2009 05:38:38 -0400
In-Reply-To: <1240911467-12269-1-git-send-email-ext-roger.quadros@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, ext-roger.quadros@nokia.com

Return sane values for all *_get_opp() and *_get_freq() functions.
Other modules e.g. Smartreflex will be requiring sane values of OPP
and CPU Frequency irrespective of the PM layer being used.

Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>
---
 arch/arm/mach-omap2/Makefile      |    1 +
 arch/arm/plat-omap/Makefile       |    3 ++-
 arch/arm/plat-omap/omap-pm-noop.c |   15 ++++++---------
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index c58bab4..b82df3f 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_OMAP_SMARTREFLEX)		+= smartreflex.o
 obj-$(CONFIG_ARCH_OMAP2)		+= clock24xx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= clock34xx.o
 obj-$(CONFIG_OMAP_PM_SRF)		+=  resource34xx.o
+obj-$(CONFIG_OMAP_PM_NOOP)		+=  resource34xx.o
 
 # DSP
 obj-$(CONFIG_OMAP_MBOX_FWK)	+= mailbox_mach.o
diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index 3d7b517..038cdaf 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -27,6 +27,7 @@ obj-y += $(i2c-omap-m) $(i2c-omap-y)
 # OMAP mailbox framework
 obj-$(CONFIG_OMAP_MBOX_FWK) += mailbox.o
 
-obj-$(CONFIG_OMAP_PM_NOOP) += omap-pm-noop.o
+obj-$(CONFIG_OMAP_PM_NOOP) += omap-pm-noop.o \
+				resource.o
 obj-$(CONFIG_OMAP_PM_SRF) += omap-pm-srf.o \
 				resource.o
diff --git a/arch/arm/plat-omap/omap-pm-noop.c b/arch/arm/plat-omap/omap-pm-noop.c
index 490bc8e..f384df3 100644
--- a/arch/arm/plat-omap/omap-pm-noop.c
+++ b/arch/arm/plat-omap/omap-pm-noop.c
@@ -23,7 +23,7 @@
 
 /* Interface documentation is in mach/omap-pm.h */
 #include <mach/omap-pm.h>
-
+#include <mach/resource.h>
 #include <mach/powerdomain.h>
 
 struct omap_opp *dsp_opps;
@@ -194,8 +194,7 @@ u8 omap_pm_dsp_get_opp(void)
 	 * Call clk_get_rate() on the OPP custom clock, map that to an
 	 * OPP ID using the tables defined in board-*.c/chip-*.c files.
 	 */
-
-	return 0;
+	return resource_get_level("vdd1_opp");
 }
 
 u8 omap_pm_vdd1_get_opp(void)
@@ -205,8 +204,7 @@ u8 omap_pm_vdd1_get_opp(void)
 	/*
 	 * For l-o call resource_get_level of vdd1_opp resource.
 	 */
-
-	return 0;
+	return resource_get_level("vdd1_opp");
 }
 
 u8 omap_pm_vdd2_get_opp(void)
@@ -216,8 +214,7 @@ u8 omap_pm_vdd2_get_opp(void)
 	/*
 	 * For l-o call resource_get_level of vdd2_opp resource.
 	 */
-
-	return 0;
+	return resource_get_level("vdd2_opp");
 }
 
 /*
@@ -267,8 +264,7 @@ unsigned long omap_pm_cpu_get_freq(void)
 	/*
 	 * Call clk_get_rate() on the mpu_ck.
 	 */
-
-	return 0;
+	return resource_get_level("mpu_freq");
 }
 
 /*
@@ -345,6 +341,7 @@ int __init omap_pm_if_early_init(struct omap_opp *mpu_opp_table,
 /* Must be called after clock framework is initialized */
 int __init omap_pm_if_init(void)
 {
+	resource_init(resources_omap);
 	return 0;
 }
 
-- 
1.6.0.4


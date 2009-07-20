From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [RFC][PATCH 1/1] DSPBRIDGE: workaround for SR with inappropriate OPP
Date: Mon, 20 Jul 2009 10:55:52 +0300
Message-ID: <1248076552-14520-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:38824 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752685AbZGTH4Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Jul 2009 03:56:16 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: nm@ti.com
Cc: ameya.palande@nokia.com, linux-omap@vger.kernel.org, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

It seems that we have had some cases where SR may not work with some
OPP level. This patch will introduce a workaround to turn off SR with
specific OPP, in this case it's OPP2. With this patch, we can use all
OPP but can disable SR on problematic OPP2 case. It seems that this
will get the advantage of SR/DVFS at most, working around the
problematic combination(SR + OPP2).

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/mach-omap2/dspbridge.c   |   24 +++++++++++++++++++++++-
 arch/arm/mach-omap2/smartreflex.c |    2 ++
 2 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/dspbridge.c b/arch/arm/mach-omap2/dspbridge.c
index 43283c9..3657de7 100644
--- a/arch/arm/mach-omap2/dspbridge.c
+++ b/arch/arm/mach-omap2/dspbridge.c
@@ -14,13 +14,35 @@
 #include <linux/platform_device.h>
 
 #include <mach/omap-pm.h>
+#include <mach/resource.h>
 
 #include <dspbridge/host_os.h>
 
+#include "smartreflex.h"
+
 static struct platform_device *dspbridge_pdev;
 
+#ifdef CONFIG_OMAP_SMARTREFLEX
+/* workaround for SR with inappropriate OPP */
+static void __omap_pm_dsp_set_min_opp(u8 opp_id)
+{
+	switch (opp_id) {
+	case 2:
+		disable_smartreflex(SR1);
+		omap_pm_dsp_set_min_opp(opp_id);
+		break;
+	default:
+		omap_pm_dsp_set_min_opp(opp_id);
+		enable_smartreflex(SR1);
+		break;
+	}
+}
+#else
+#define __omap_pm_dsp_set_min_opp omap_pm_dsp_set_min_opp
+#endif
+
 static struct dspbridge_platform_data dspbridge_pdata __initdata = {
-	.dsp_set_min_opp = omap_pm_dsp_set_min_opp,
+	.dsp_set_min_opp = __omap_pm_dsp_set_min_opp,
 	.dsp_get_opp	 = omap_pm_dsp_get_opp,
 	.cpu_set_freq	 = omap_pm_cpu_set_freq,
 	.cpu_get_freq	 = omap_pm_cpu_get_freq,
diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index f35e2e6..4057aef 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -636,6 +636,7 @@ void enable_smartreflex(int srid)
 		}
 	}
 }
+EXPORT_SYMBOL(enable_smartreflex);
 
 void disable_smartreflex(int srid)
 {
@@ -674,6 +675,7 @@ void disable_smartreflex(int srid)
 		}
 	}
 }
+EXPORT_SYMBOL(disable_smartreflex);
 
 /* Voltage Scaling using SR VCBYPASS */
 int sr_voltagescale_vcbypass(u32 target_opp, u32 current_opp,
-- 
1.6.0.4


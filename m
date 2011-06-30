From: Mike Turquette <mturquette@ti.com>
Subject: [PATCH 8/8] OMAP3+: Voltage: add ABB to voltage scaling
Date: Wed, 29 Jun 2011 17:26:00 -0700
Message-ID: <1309393560-8874-9-git-send-email-mturquette@ti.com>
References: <1309393560-8874-1-git-send-email-mturquette@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:52682 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754144Ab1F3Adk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Jun 2011 20:33:40 -0400
Received: by ywf7 with SMTP id 7so1070894ywf.27
        for <linux-omap@vger.kernel.org>; Wed, 29 Jun 2011 17:33:39 -0700 (PDT)
In-Reply-To: <1309393560-8874-1-git-send-email-mturquette@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, nm@ti.com, Mike Turquette <mturquette@ti.com>

Adaptive Body-Bias ldo state should be transitioned (if necessary) after
a voltage scaling sequence completes via vc_bypass or vp_forceupdate
methods.

This patch initializes the ABB ldo's as a part of the greater voltage
initialization function and adds the ABB transition routine to both the
vc_bypass and vp_forceupdate sequences.

Signed-off-by: Mike Turquette <mturquette@ti.com>
---
 arch/arm/mach-omap2/vc.c      |   10 ++++++++--
 arch/arm/mach-omap2/voltage.c |    4 ++++
 arch/arm/mach-omap2/vp.c      |    9 +++++++--
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index aa9f0bc..6c51cc3 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -6,6 +6,7 @@
 
 #include "voltage.h"
 #include "vc.h"
+#include "abb.h"
 #include "prm-regbits-34xx.h"
 #include "prm-regbits-44xx.h"
 #include "prm44xx.h"
@@ -155,7 +156,7 @@ int omap_vc_bypass_scale_voltage(struct voltagedomain *voltdm,
 	u32 loop_cnt = 0, retries_cnt = 0;
 	u32 vc_valid, vc_bypass_val_reg, vc_bypass_value;
 	u8 target_vsel, current_vsel;
-	int ret;
+	int ret = 0;
 
 	ret = omap_vc_pre_scale(voltdm, target_volt, &target_vsel, &current_vsel);
 	if (ret)
@@ -193,7 +194,12 @@ int omap_vc_bypass_scale_voltage(struct voltagedomain *voltdm,
 	}
 
 	omap_vc_post_scale(voltdm, target_volt, target_vsel, current_vsel);
-	return 0;
+
+	/* transition Adaptive Body-Bias ldo */
+	if (voltdm->abb)
+		ret = omap_abb_set_opp(voltdm);
+
+	return ret;
 }
 
 static void __init omap3_vfsm_init(struct voltagedomain *voltdm)
diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 97f96ae..df6eac6 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -40,6 +40,7 @@
 
 #include "vc.h"
 #include "vp.h"
+#include "abb.h"
 
 static LIST_HEAD(voltdm_list);
 
@@ -311,6 +312,9 @@ int __init omap_voltage_late_init(void)
 
 		if (voltdm->vc)
 			omap_vc_init_channel(voltdm);
+
+		if (voltdm->abb)
+			omap_abb_init(voltdm);
 	}
 
 	return 0;
diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
index 3807620..76de8cd 100644
--- a/arch/arm/mach-omap2/vp.c
+++ b/arch/arm/mach-omap2/vp.c
@@ -5,6 +5,7 @@
 
 #include "voltage.h"
 #include "vp.h"
+#include "abb.h"
 #include "prm-regbits-34xx.h"
 #include "prm-regbits-44xx.h"
 #include "prm44xx.h"
@@ -124,7 +125,7 @@ int omap_vp_forceupdate_scale(struct voltagedomain *voltdm,
 	struct omap_vp_instance *vp = voltdm->vp;
 	u32 vpconfig;
 	u8 target_vsel, current_vsel;
-	int ret, timeout = 0;
+	int ret = 0, timeout = 0;
 
 	ret = omap_vc_pre_scale(voltdm, target_volt, &target_vsel, &current_vsel);
 	if (ret)
@@ -202,7 +203,11 @@ int omap_vp_forceupdate_scale(struct voltagedomain *voltdm,
 	vpconfig &= ~vp->common->vpconfig_forceupdate;
 	voltdm->write(vpconfig, vp->vpconfig);
 
-	return 0;
+	/* transition Adaptive Body-Bias LDO */
+	if (voltdm->abb)
+		ret = omap_abb_set_opp(voltdm);
+
+	return ret;
 }
 
 /**
-- 
1.7.4.1


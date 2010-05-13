From: shweta gulati <shweta.gulati@ti.com>
Subject: [PATCH v3 OMAP3 PM]: Remove IVA state conflict between PM and DspBridge code
Date: Thu, 13 May 2010 15:46:18 +0530
Message-ID: <1273745778-32325-1-git-send-email-shweta.gulati@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40663 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756660Ab0EMKQX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 May 2010 06:16:23 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o4DAGJ4D018493
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 13 May 2010 05:16:22 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Shweta Gulati <shweta.gulati@ti.com>, Sripathy Vishwanath <vishwanath.bs@ti.com>

From: Shweta Gulati <shweta.gulati@ti.com>

This version of patch incorporates review comments which includes
shifting the code change in specific function 'omap3_iva_idle' and
removing iva_pwrdm from pwrst_list rather than checking all the pwrdms
in list to exclude iva_pwrdm. 

The PM code should not set latency on IVA power state based on 
the flag 'enable_off_mode'.This is taken care of in this version.   

Signed-off-by: Sripathy Vishwanath <vishwanath.bs@ti.com>
Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
---

Index: linux-omap-pm/arch/arm/mach-omap2/pm34xx.c
===================================================================
--- linux-omap-pm.orig/arch/arm/mach-omap2/pm34xx.c
+++ linux-omap-pm/arch/arm/mach-omap2/pm34xx.c
@@ -786,6 +786,12 @@ static void __init omap3_iva_idle(void)
 			  OMAP3430_RST2_IVA2 |
 			  OMAP3430_RST3_IVA2,
 			  OMAP3430_IVA2_MOD, OMAP2_RM_RSTCTRL);
+	/* Put the IVA2 In Idle */
+	prm_rmw_mod_reg_bits(OMAP3430_LASTPOWERSTATEENTERED_MASK, 0,
+				OMAP3430_IVA2_MOD, OMAP2_PM_PWSTCTRL);
+	/* Make Clock transition Automatic*/
+	cm_rmw_mod_reg_bits(OMAP3430_CLKTRCTRL_IVA2_MASK, 0x3,
+				OMAP3430_IVA2_MOD, OMAP2_CM_CLKSTCTRL);
 }
 
 static void __init omap3_d2d_idle(void)
@@ -1074,8 +1080,11 @@ static int __init pwrdms_setup(struct po
 	if (!pwrst)
 		return -ENOMEM;
 	pwrst->pwrdm = pwrdm;
-	pwrst->next_state = PWRDM_POWER_RET;
-	list_add(&pwrst->node, &pwrst_list);
+	if (strcmp("iva2_pwrdm", pwrdm->name)) {
+		pwrst->next_state = PWRDM_POWER_RET;
+		list_add(&pwrst->node, &pwrst_list);
+	} else
+		 pwrst->next_state = PWRDM_POWER_OFF;
 
 	if (pwrdm_has_hdwr_sar(pwrdm))
 		pwrdm_enable_hdwr_sar(pwrdm);
Index: linux-omap-pm/arch/arm/mach-omap2/resource34xx.c
===================================================================
--- linux-omap-pm.orig/arch/arm/mach-omap2/resource34xx.c
+++ linux-omap-pm/arch/arm/mach-omap2/resource34xx.c
@@ -140,7 +140,8 @@ int set_pd_latency(struct shared_resourc
 	}
 
 	if (!enable_off_mode && pd_lat_level == PD_LATENCY_OFF)
-		pd_lat_level = PD_LATENCY_RET;
+		if (strcmp("iva2_pwrdm", pwrdm->name))
+			pd_lat_level = PD_LATENCY_RET;
 
 	resp->curr_level = pd_lat_level;
 	set_pwrdm_state(pwrdm, pd_lat_level);

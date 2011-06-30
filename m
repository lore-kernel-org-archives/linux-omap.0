From: Mike Turquette <mturquette@ti.com>
Subject: [PATCH 6/8] OMAP3+: Voltage: add ABB data to voltage domains
Date: Wed, 29 Jun 2011 17:25:58 -0700
Message-ID: <1309393560-8874-7-git-send-email-mturquette@ti.com>
References: <1309393560-8874-1-git-send-email-mturquette@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:47213 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753661Ab1F3AfY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Jun 2011 20:35:24 -0400
Received: by mail-gw0-f43.google.com with SMTP id 21so754202gwj.30
        for <linux-omap@vger.kernel.org>; Wed, 29 Jun 2011 17:35:23 -0700 (PDT)
In-Reply-To: <1309393560-8874-1-git-send-email-mturquette@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, nm@ti.com, Mike Turquette <mturquette@ti.com>

Starting with OMAP36xx, some voltage domains have an ABB ldo meant to
insure stability when that voltage domain is operating at a high OPP.

This patch adds struct omap_abb_instance to struct voltagedomain and
populates the data for those voltage domains that have an ABB ldo on
both 36xx and 44xx silicon.

Signed-off-by: Mike Turquette <mturquette@ti.com>
---
 arch/arm/mach-omap2/voltage.h                 |    1 +
 arch/arm/mach-omap2/voltagedomains3xxx_data.c |    3 +++
 arch/arm/mach-omap2/voltagedomains44xx_data.c |    3 +++
 3 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index 51c0b31..5d567a2 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -71,6 +71,7 @@ struct voltagedomain {
 	struct omap_vc_channel *vc;
 	const struct omap_vfsm_instance *vfsm;
 	struct omap_vp_instance *vp;
+	struct omap_abb_instance *abb;
 	struct omap_voltdm_pmic *pmic;
 
 	/* VC/VP register access functions: SoC specific */
diff --git a/arch/arm/mach-omap2/voltagedomains3xxx_data.c b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
index e7a0be1..a7473e1 100644
--- a/arch/arm/mach-omap2/voltagedomains3xxx_data.c
+++ b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
@@ -26,6 +26,7 @@
 #include "voltage.h"
 #include "vc.h"
 #include "vp.h"
+#include "abb.h"
 
 /*
  * VDD data
@@ -96,6 +97,8 @@ void __init omap3xxx_voltagedomains_init(void)
 	if (cpu_is_omap3630()) {
 		omap3_vdd1_info.volt_data = omap36xx_vddmpu_volt_data;
 		omap3_vdd2_info.volt_data = omap36xx_vddcore_volt_data;
+
+		omap3_voltdm_mpu.abb = &omap36xx_abb_mpu;
 	} else {
 		omap3_vdd1_info.volt_data = omap34xx_vddmpu_volt_data;
 		omap3_vdd2_info.volt_data = omap34xx_vddcore_volt_data;
diff --git a/arch/arm/mach-omap2/voltagedomains44xx_data.c b/arch/arm/mach-omap2/voltagedomains44xx_data.c
index d5f06c5e..31124c4 100644
--- a/arch/arm/mach-omap2/voltagedomains44xx_data.c
+++ b/arch/arm/mach-omap2/voltagedomains44xx_data.c
@@ -32,6 +32,7 @@
 #include "omap_opp_data.h"
 #include "vc.h"
 #include "vp.h"
+#include "abb.h"
 
 static const struct omap_vfsm_instance omap4_vdd_mpu_vfsm = {
 	.voltsetup_reg = OMAP4_PRM_VOLTSETUP_MPU_RET_SLEEP_OFFSET,
@@ -60,6 +61,7 @@ static struct voltagedomain omap4_voltdm_mpu = {
 	.vc = &omap4_vc_mpu,
 	.vfsm = &omap4_vdd_mpu_vfsm,
 	.vp = &omap4_vp_mpu,
+	.abb = &omap4_abb_mpu,
 	.vdd = &omap4_vdd_mpu_info,
 };
 
@@ -72,6 +74,7 @@ static struct voltagedomain omap4_voltdm_iva = {
 	.vc = &omap4_vc_iva,
 	.vfsm = &omap4_vdd_iva_vfsm,
 	.vp = &omap4_vp_iva,
+	.abb = &omap4_abb_iva,
 	.vdd = &omap4_vdd_iva_info,
 };
 
-- 
1.7.4.1


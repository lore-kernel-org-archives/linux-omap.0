From: Mike Turquette <mturquette@ti.com>
Subject: [PATCH 5/7] ARM: omap: voltage: per-voltage domain ABB data
Date: Wed, 3 Oct 2012 18:26:12 -0700
Message-ID: <1349313974-5473-6-git-send-email-mturquette@ti.com>
References: <1349313974-5473-1-git-send-email-mturquette@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52440 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753867Ab2JDB0o (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 3 Oct 2012 21:26:44 -0400
In-Reply-To: <1349313974-5473-1-git-send-email-mturquette@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com, paul@pwsan.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mike Turquette <mturquette@ti.com>, Mike Turquette <mturquette@linaro.org>

This patch adds struct omap_abb_instance to struct voltagedomain and
populates the data for those voltage domains that have an ABB ldo on
both 36xx and 44xx silicon.

Signed-off-by: Mike Turquette <mturquette@ti.com>
Signed-off-by: Mike Turquette <mturquette@linaro.org>
---
 arch/arm/mach-omap2/voltage.h                 |    1 +
 arch/arm/mach-omap2/voltagedomains3xxx_data.c |    2 ++
 arch/arm/mach-omap2/voltagedomains44xx_data.c |    3 +++
 3 files changed, 6 insertions(+)

diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index 0ded54f..546b3d7 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -73,6 +73,7 @@ struct voltagedomain {
 	struct omap_vc_channel *vc;
 	const struct omap_vfsm_instance *vfsm;
 	struct omap_vp_instance *vp;
+	struct omap_abb_instance *abb;
 	struct omap_voltdm_pmic *pmic;
 
 	/* VC/VP register access functions: SoC specific */
diff --git a/arch/arm/mach-omap2/voltagedomains3xxx_data.c b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
index d0103c8..f6c8a59 100644
--- a/arch/arm/mach-omap2/voltagedomains3xxx_data.c
+++ b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
@@ -26,6 +26,7 @@
 #include "voltage.h"
 #include "vc.h"
 #include "vp.h"
+#include "abb.h"
 
 /*
  * VDD data
@@ -112,6 +113,7 @@ void __init omap3xxx_voltagedomains_init(void)
 	if (cpu_is_omap3630()) {
 		omap3_voltdm_mpu.volt_data = omap36xx_vddmpu_volt_data;
 		omap3_voltdm_core.volt_data = omap36xx_vddcore_volt_data;
+		omap3_voltdm_mpu.abb = &omap36xx_abb_mpu;
 	} else {
 		omap3_voltdm_mpu.volt_data = omap34xx_vddmpu_volt_data;
 		omap3_voltdm_core.volt_data = omap34xx_vddcore_volt_data;
diff --git a/arch/arm/mach-omap2/voltagedomains44xx_data.c b/arch/arm/mach-omap2/voltagedomains44xx_data.c
index c3115f6..da4c70b 100644
--- a/arch/arm/mach-omap2/voltagedomains44xx_data.c
+++ b/arch/arm/mach-omap2/voltagedomains44xx_data.c
@@ -31,6 +31,7 @@
 #include "omap_opp_data.h"
 #include "vc.h"
 #include "vp.h"
+#include "abb.h"
 
 static const struct omap_vfsm_instance omap4_vdd_mpu_vfsm = {
 	.voltsetup_reg = OMAP4_PRM_VOLTSETUP_MPU_RET_SLEEP_OFFSET,
@@ -53,6 +54,7 @@ static struct voltagedomain omap4_voltdm_mpu = {
 	.vc = &omap4_vc_mpu,
 	.vfsm = &omap4_vdd_mpu_vfsm,
 	.vp = &omap4_vp_mpu,
+	.abb = &omap4_abb_mpu,
 };
 
 static struct voltagedomain omap4_voltdm_iva = {
@@ -64,6 +66,7 @@ static struct voltagedomain omap4_voltdm_iva = {
 	.vc = &omap4_vc_iva,
 	.vfsm = &omap4_vdd_iva_vfsm,
 	.vp = &omap4_vp_iva,
+	.abb = &omap4_abb_iva,
 };
 
 static struct voltagedomain omap4_voltdm_core = {
-- 
1.7.9.5


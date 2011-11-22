From: jean.pihet@newoldbits.com
Subject: [PATCH 05/26] OMAP: hwmod/SmartReflex: remove IP block instance-specific data from the driver code
Date: Tue, 22 Nov 2011 16:05:49 +0100
Message-ID: <1321974370-25800-6-git-send-email-j-pihet@ti.com>
References: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:48485 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756108Ab1KVPG6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Nov 2011 10:06:58 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so270729eye.19
        for <linux-omap@vger.kernel.org>; Tue, 22 Nov 2011 07:06:57 -0800 (PST)
In-Reply-To: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, paul@pwsan.com, khilman@ti.com, balbi@ti.com, rjw@sisk.pl
Cc: Jean Pihet <j-pihet@ti.com>

From: Paul Walmsley <paul@pwsan.com>

Add SmartReflex IP instance-specific data (dev_attr data) to the hwmod
data.  This data is IP block instance-specific and may even be
semiconductor process-specific; it definitely should not be hardcoded
in the driver.

The pdev_inst_id field is only needed until the clkdev entries for
SmartReflex can be removed.

ToDo:
. this patch needs to be reviewed to determine the correct SmartReflex
omap_sr_dev_attr values for OMAP4.
. kerneldoc needed in smartreflex.h

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   33 ++++++++++++++++++++++---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   37 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/smartreflex.h          |   11 ++++++++
 3 files changed, 77 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 7f8915a..403421a 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -32,6 +32,7 @@
 #include "prm-regbits-34xx.h"
 #include "cm-regbits-34xx.h"
 #include "wd_timer.h"
+#include "smartreflex.h"
 #include <mach/am35xx.h>
 
 /*
@@ -2592,8 +2593,18 @@ static struct omap_hwmod_ocp_if *omap3_sr1_slaves[] = {
 	&omap3_l4_core__sr1,
 };
 
+static struct omap_sr_dev_attr omap3xxx_sr1_dev_attr = {
+	.pdev_inst_id = 0,
+	.sensor_voltdm_name = "mpu",
+	.errweight = OMAP3430_SR_ERRWEIGHT,
+	.errmaxlimit = OMAP3430_SR_ERRMAXLIMIT,
+	.accumdata = OMAP3430_SR_ACCUMDATA,
+	.senn_avgweight = OMAP3430_SR1_SENNAVGWEIGHT,
+	.senp_avgweight = OMAP3430_SR1_SENPAVGWEIGHT,
+};
+
 static struct omap_hwmod omap34xx_sr1_hwmod = {
-	.name		= "sr1_hwmod",
+	.name		= "sr1",
 	.class		= &omap34xx_smartreflex_hwmod_class,
 	.main_clk	= "sr1_fck",
 	.vdd_name	= "mpu_iva",
@@ -2608,11 +2619,12 @@ static struct omap_hwmod omap34xx_sr1_hwmod = {
 	},
 	.slaves		= omap3_sr1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3_sr1_slaves),
+	.dev_attr	= &omap3xxx_sr1_dev_attr,
 	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 static struct omap_hwmod omap36xx_sr1_hwmod = {
-	.name		= "sr1_hwmod",
+	.name		= "sr1",
 	.class		= &omap36xx_smartreflex_hwmod_class,
 	.main_clk	= "sr1_fck",
 	.vdd_name	= "mpu_iva",
@@ -2627,6 +2639,7 @@ static struct omap_hwmod omap36xx_sr1_hwmod = {
 	},
 	.slaves		= omap3_sr1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3_sr1_slaves),
+	.dev_attr	= &omap3xxx_sr1_dev_attr,
 };
 
 /* SR2 */
@@ -2634,8 +2647,18 @@ static struct omap_hwmod_ocp_if *omap3_sr2_slaves[] = {
 	&omap3_l4_core__sr2,
 };
 
+static struct omap_sr_dev_attr omap3xxx_sr2_dev_attr = {
+	.pdev_inst_id = 1,
+	.sensor_voltdm_name = "core",
+	.errweight = OMAP3430_SR_ERRWEIGHT,
+	.errmaxlimit = OMAP3430_SR_ERRMAXLIMIT,
+	.accumdata = OMAP3430_SR_ACCUMDATA,
+	.senn_avgweight = OMAP3430_SR2_SENNAVGWEIGHT,
+	.senp_avgweight = OMAP3430_SR2_SENPAVGWEIGHT,
+};
+
 static struct omap_hwmod omap34xx_sr2_hwmod = {
-	.name		= "sr2_hwmod",
+	.name		= "sr2",
 	.class		= &omap34xx_smartreflex_hwmod_class,
 	.main_clk	= "sr2_fck",
 	.vdd_name	= "core",
@@ -2650,11 +2673,12 @@ static struct omap_hwmod omap34xx_sr2_hwmod = {
 	},
 	.slaves		= omap3_sr2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3_sr2_slaves),
+	.dev_attr	= &omap3xxx_sr2_dev_attr,
 	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
 static struct omap_hwmod omap36xx_sr2_hwmod = {
-	.name		= "sr2_hwmod",
+	.name		= "sr2",
 	.class		= &omap36xx_smartreflex_hwmod_class,
 	.main_clk	= "sr2_fck",
 	.vdd_name	= "core",
@@ -2669,6 +2693,7 @@ static struct omap_hwmod omap36xx_sr2_hwmod = {
 	},
 	.slaves		= omap3_sr2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3_sr2_slaves),
+	.dev_attr	= &omap3xxx_sr2_dev_attr,
 };
 
 /*
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index daaf165..3fbeadc 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -39,6 +39,7 @@
 #include "prm44xx.h"
 #include "prm-regbits-44xx.h"
 #include "wd_timer.h"
+#include "smartreflex.h"
 
 /* Base offset for all OMAP4 interrupts external to MPUSS */
 #define OMAP44XX_IRQ_GIC_START	32
@@ -3987,6 +3988,17 @@ static struct omap_hwmod_ocp_if *omap44xx_smartreflex_core_slaves[] = {
 	&omap44xx_l4_cfg__smartreflex_core,
 };
 
+#warning omap44xx_sr_core_dev_attr values are likely wrong
+static struct omap_sr_dev_attr omap44xx_sr_core_dev_attr = {
+	.pdev_inst_id = 0,
+	.sensor_voltdm_name = "core",
+	.errweight = OMAP3430_SR_ERRWEIGHT,
+	.errmaxlimit = OMAP3430_SR_ERRMAXLIMIT,
+	.accumdata = OMAP3430_SR_ACCUMDATA,
+	.senn_avgweight = OMAP3430_SR2_SENNAVGWEIGHT,
+	.senp_avgweight = OMAP3430_SR2_SENPAVGWEIGHT,
+};
+
 static struct omap_hwmod omap44xx_smartreflex_core_hwmod = {
 	.name		= "smartreflex_core",
 	.class		= &omap44xx_smartreflex_hwmod_class,
@@ -4004,6 +4016,7 @@ static struct omap_hwmod omap44xx_smartreflex_core_hwmod = {
 	},
 	.slaves		= omap44xx_smartreflex_core_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_smartreflex_core_slaves),
+	.dev_attr	= &omap44xx_sr_core_dev_attr,
 };
 
 /* smartreflex_iva */
@@ -4036,6 +4049,17 @@ static struct omap_hwmod_ocp_if *omap44xx_smartreflex_iva_slaves[] = {
 	&omap44xx_l4_cfg__smartreflex_iva,
 };
 
+#warning omap44xx_sr_iva_dev_attr values are likely wrong
+static struct omap_sr_dev_attr omap44xx_sr_iva_dev_attr = {
+	.pdev_inst_id = 1,
+	.sensor_voltdm_name = "iva",
+	.errweight = OMAP3430_SR_ERRWEIGHT,
+	.errmaxlimit = OMAP3430_SR_ERRMAXLIMIT,
+	.accumdata = OMAP3430_SR_ACCUMDATA,
+	.senn_avgweight = OMAP3430_SR2_SENNAVGWEIGHT,
+	.senp_avgweight = OMAP3430_SR2_SENPAVGWEIGHT,
+};
+
 static struct omap_hwmod omap44xx_smartreflex_iva_hwmod = {
 	.name		= "smartreflex_iva",
 	.class		= &omap44xx_smartreflex_hwmod_class,
@@ -4052,6 +4076,7 @@ static struct omap_hwmod omap44xx_smartreflex_iva_hwmod = {
 	},
 	.slaves		= omap44xx_smartreflex_iva_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_smartreflex_iva_slaves),
+	.dev_attr	= &omap44xx_sr_iva_dev_attr,
 };
 
 /* smartreflex_mpu */
@@ -4084,6 +4109,17 @@ static struct omap_hwmod_ocp_if *omap44xx_smartreflex_mpu_slaves[] = {
 	&omap44xx_l4_cfg__smartreflex_mpu,
 };
 
+#warning omap44xx_sr_mpu_dev_attr values are likely wrong
+static struct omap_sr_dev_attr omap44xx_sr_mpu_dev_attr = {
+	.pdev_inst_id = 2,
+	.sensor_voltdm_name = "mpu",
+	.errweight = OMAP3430_SR_ERRWEIGHT,
+	.errmaxlimit = OMAP3430_SR_ERRMAXLIMIT,
+	.accumdata = OMAP3430_SR_ACCUMDATA,
+	.senn_avgweight = OMAP3430_SR1_SENNAVGWEIGHT,
+	.senp_avgweight = OMAP3430_SR1_SENPAVGWEIGHT,
+};
+
 static struct omap_hwmod omap44xx_smartreflex_mpu_hwmod = {
 	.name		= "smartreflex_mpu",
 	.class		= &omap44xx_smartreflex_hwmod_class,
@@ -4100,6 +4136,7 @@ static struct omap_hwmod omap44xx_smartreflex_mpu_hwmod = {
 	},
 	.slaves		= omap44xx_smartreflex_mpu_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_smartreflex_mpu_slaves),
+	.dev_attr	= &omap44xx_sr_mpu_dev_attr,
 };
 
 /*
diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
index d7e8d90..deed861 100644
--- a/arch/arm/mach-omap2/smartreflex.h
+++ b/arch/arm/mach-omap2/smartreflex.h
@@ -176,6 +176,17 @@ struct omap_sr_pmic_data {
 	void (*sr_pmic_init) (void);
 };
 
+/* XXX Kerneldoc documentation needed */
+struct omap_sr_dev_attr {
+	char *sensor_voltdm_name; /* XXX should be const */
+	u32 errweight;
+	u32 errmaxlimit;
+	u32 accumdata;
+	u32 senn_avgweight;
+	u32 senp_avgweight;
+	u8 pdev_inst_id;
+};
+
 #ifdef CONFIG_OMAP_SMARTREFLEX
 /*
  * The smart reflex driver supports CLASS1 CLASS2 and CLASS3 SR.
-- 
1.7.5.4


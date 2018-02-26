From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0.5/12] ARM: OMAP2+: Prepare to pass auxdata for
 smartreflex
Date: Mon, 26 Feb 2018 14:23:23 -0800
Message-ID: <20180226222323.GJ16043@atomide.com>
References: <20180223214119.GB5593@atomide.com>
 <201802261623.teHicLDZ%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201802261623.teHicLDZ%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, linux-omap@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* kbuild test robot <lkp@intel.com> [180226 08:39]:
> >> arch/arm/mach-omap2/pdata-quirks.c:517:36: error: array type has incomplete element type 'struct omap_sr_data'
>     struct omap_sr_data __maybe_unused omap_sr_pdata[OMAP_SR_NR];
>                                        ^~~~~~~~~~~~~
> 
> vim +517 arch/arm/mach-omap2/pdata-quirks.c
> 
>    516	
>  > 517	struct omap_sr_data __maybe_unused omap_sr_pdata[OMAP_SR_NR];
>    518	

Thanks kbt. Looks like it needs to be out of the ifdef
CONFIG_POWER_AVS_OMAP in include/linux/power/smartreflex.h.

Updated patch below.

Regards,

Tony

8< ---------------------
>From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Thu, 22 Feb 2018 13:57:30 -0800
Subject: [PATCH] ARM: OMAP2+: Prepare to pass auxdata for smartreflex

We are still initializing smartreflex with platform data using
omap_device_build(). We can instead pass the platform data in
with auxdata in pdata-quirks.c and make the driver use that
in later patches.

Note that we cannot enable the auxdata use yet, this is done
in the last patch of the series.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/pdata-quirks.c | 13 +++++++++++++
 arch/arm/mach-omap2/sr_device.c    |  2 ++
 include/linux/power/smartreflex.h  | 10 +++++++++-
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -17,6 +17,7 @@
 #include <linux/wl12xx.h>
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
+#include <linux/power/smartreflex.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/fixed.h>
 
@@ -542,6 +543,8 @@ static struct pdata_init auxdata_quirks[] __initdata = {
 	{ /* sentinel */ },
 };
 
+struct omap_sr_data __maybe_unused omap_sr_pdata[OMAP_SR_NR];
+
 static struct of_dev_auxdata omap_auxdata_lookup[] __initdata = {
 #ifdef CONFIG_MACH_NOKIA_N8X0
 	OF_DEV_AUXDATA("ti,omap2420-mmc", 0x4809c000, "mmci-omap.0", NULL),
@@ -551,6 +554,10 @@ static struct of_dev_auxdata omap_auxdata_lookup[] __initdata = {
 #ifdef CONFIG_ARCH_OMAP3
 	OF_DEV_AUXDATA("ti,omap2-iommu", 0x5d000000, "5d000000.mmu",
 		       &omap3_iommu_pdata),
+	OF_DEV_AUXDATA("ti,omap3-smartreflex-core", 0x480cb000,
+		       "480cb000.smartreflex", &omap_sr_pdata[OMAP_SR_CORE]),
+	OF_DEV_AUXDATA("ti,omap3-smartreflex-mpu-iva", 0x480c9000,
+		       "480c9000.smartreflex", &omap_sr_pdata[OMAP_SR_MPU]),
 	OF_DEV_AUXDATA("ti,omap3-hsmmc", 0x4809c000, "4809c000.mmc", &mmc_pdata[0]),
 	OF_DEV_AUXDATA("ti,omap3-hsmmc", 0x480b4000, "480b4000.mmc", &mmc_pdata[1]),
 	OF_DEV_AUXDATA("nokia,n900-ir", 0, "n900-ir", &rx51_ir_data),
@@ -580,6 +587,12 @@ static struct of_dev_auxdata omap_auxdata_lookup[] __initdata = {
 		       &omap4_iommu_pdata),
 	OF_DEV_AUXDATA("ti,omap4-iommu", 0x55082000, "55082000.mmu",
 		       &omap4_iommu_pdata),
+	OF_DEV_AUXDATA("ti,omap4-smartreflex-iva", 0x4a0db000,
+		       "4a0db000.smartreflex", &omap_sr_pdata[OMAP_SR_IVA]),
+	OF_DEV_AUXDATA("ti,omap4-smartreflex-core", 0x4a0dd000,
+		       "4a0dd000.smartreflex", &omap_sr_pdata[OMAP_SR_CORE]),
+	OF_DEV_AUXDATA("ti,omap4-smartreflex-mpu", 0x4a0d9000,
+		       "4a0d9000.smartreflex", &omap_sr_pdata[OMAP_SR_MPU]),
 #endif
 #ifdef CONFIG_SOC_DRA7XX
 	OF_DEV_AUXDATA("ti,dra7-hsmmc", 0x4809c000, "4809c000.mmc",
diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -89,6 +89,8 @@ static void __init sr_set_nvalues(struct omap_volt_data *volt_data,
 	sr_data->nvalue_count = j;
 }
 
+extern struct omap_sr_data omap_sr_pdata[];
+
 static int __init sr_dev_init(struct omap_hwmod *oh, void *user)
 {
 	struct omap_sr_data *sr_data;
diff --git a/include/linux/power/smartreflex.h b/include/linux/power/smartreflex.h
--- a/include/linux/power/smartreflex.h
+++ b/include/linux/power/smartreflex.h
@@ -143,6 +143,13 @@
 #define OMAP3430_SR_ERRWEIGHT		0x04
 #define OMAP3430_SR_ERRMAXLIMIT		0x02
 
+enum sr_instance {
+	OMAP_SR_MPU,			/* shared with iva on omap3 */
+	OMAP_SR_CORE,
+	OMAP_SR_IVA,
+	OMAP_SR_NR,
+};
+
 struct omap_sr {
 	char				*name;
 	struct list_head		node;
@@ -207,7 +214,6 @@ struct omap_smartreflex_dev_attr {
 	const char      *sensor_voltdm_name;
 };
 
-#ifdef CONFIG_POWER_AVS_OMAP
 /*
  * The smart reflex driver supports CLASS1 CLASS2 and CLASS3 SR.
  * The smartreflex class driver should pass the class type.
@@ -290,6 +296,8 @@ struct omap_sr_data {
 	struct voltagedomain		*voltdm;
 };
 
+#ifdef CONFIG_POWER_AVS_OMAP
+
 /* Smartreflex module enable/disable interface */
 void omap_sr_enable(struct voltagedomain *voltdm);
 void omap_sr_disable(struct voltagedomain *voltdm);
-- 
2.16.2

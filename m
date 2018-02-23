From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0.5/12] ARM: OMAP2+: Prepare to pass auxdata for smartreflex
Date: Fri, 23 Feb 2018 13:41:19 -0800
Message-ID: <20180223214119.GB5593@atomide.com>
References: <20180223210100.86732-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180223210100.86732-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Dave Gerlach <d-gerlach@ti.com>, linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

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
 include/linux/power/smartreflex.h  |  7 +++++++
 3 files changed, 22 insertions(+)

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
-- 
2.16.2

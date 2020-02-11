From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv6 07/14] remoteproc/omap: Add support for DRA7xx remote processors
Date: Tue, 11 Feb 2020 17:21:18 +0200
Message-ID: <20200211152125.23819-8-t-kristo@ti.com>
References: <20200211152125.23819-1-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200211152125.23819-1-t-kristo@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bjorn.andersson@linaro.org, ohad@wizery.com, linux-remoteproc@vger.kernel.org, afd@ti.com
Cc: linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org, linux-omap@vger.kernel.org, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

DRA7xx/AM57xx SoCs have two IPU and up to two DSP processor subsystems
for offloading different computation algorithms. The IPU processor
subsystem contains dual-core ARM Cortex-M4 processors, and is very
similar to those on OMAP5. The DSP processor subsystem is based on
the TI's standard TMS320C66x DSP CorePac core.

Support has been added to the OMAP remoteproc driver through new
DRA7xx specific compatibles for properly probing and booting all
the different processor subsystem instances on DRA7xx/AM57xx
SoCs - IPU1, IPU2, DSP1 & DSP2. A build dependency with SOC_DRA7XX
is added to enable the driver to be built in DRA7xx-only configuration.

The DSP boot address programming needed enhancement for DRA7xx as the
boot register fields are different on DRA7 compared to OMAP4 and OMAP5
SoCs. The register on DRA7xx contains additional fields within the
register and the boot address bit-field is right-shifted by 10 bits.
The internal memory parsing logic has also been updated to compute
the device addresses for the L2 RAM for DSP devices using relative
addressing logic, and to parse two additional RAMs at L1 level - L1P
and L1D. This allows the remoteproc driver to support loading into
these regions for a small subset of firmware images requiring as
such. The most common usage would be to use the L1 programmable
RAMs as L1 Caches.

The firmware lookup logic also has to be adjusted for DRA7xx as
there are (can be) more than one instance of both the IPU and DSP
remote processors for the first time in OMAP4+ SoCs.

Signed-off-by: Suman Anna <s-anna@ti.com>
[t-kristo@ti.com: moved address translation quirks to pdata]
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/remoteproc/Kconfig           |  2 +-
 drivers/remoteproc/omap_remoteproc.c | 38 +++++++++++++++++++++++++++-
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index de3862c15fcc..b52abc2268cc 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -35,7 +35,7 @@ config MTK_SCP
 
 config OMAP_REMOTEPROC
 	tristate "OMAP remoteproc support"
-	depends on ARCH_OMAP4 || SOC_OMAP5
+	depends on ARCH_OMAP4 || SOC_OMAP5 || SOC_DRA7XX
 	depends on OMAP_IOMMU
 	select MAILBOX
 	select OMAP2PLUS_MBOX
diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
index a0711c1035d3..e8cf9d846f44 100644
--- a/drivers/remoteproc/omap_remoteproc.c
+++ b/drivers/remoteproc/omap_remoteproc.c
@@ -34,10 +34,13 @@
  * struct omap_rproc_boot_data - boot data structure for the DSP omap rprocs
  * @syscon: regmap handle for the system control configuration module
  * @boot_reg: boot register offset within the @syscon regmap
+ * @boot_reg_shift: bit-field shift required for the boot address value in
+ *		    @boot_reg
  */
 struct omap_rproc_boot_data {
 	struct regmap *syscon;
 	unsigned int boot_reg;
+	unsigned int boot_reg_shift;
 };
 
 /**
@@ -159,6 +162,8 @@ static int omap_rproc_write_dsp_boot_addr(struct rproc *rproc)
 	struct omap_rproc *oproc = rproc->priv;
 	struct omap_rproc_boot_data *bdata = oproc->boot_data;
 	u32 offset = bdata->boot_reg;
+	u32 value;
+	u32 mask;
 
 	if (rproc->bootaddr & (SZ_1K - 1)) {
 		dev_err(dev, "invalid boot address 0x%x, must be aligned on a 1KB boundary\n",
@@ -166,7 +171,10 @@ static int omap_rproc_write_dsp_boot_addr(struct rproc *rproc)
 		return -EINVAL;
 	}
 
-	regmap_write(bdata->syscon, offset, rproc->bootaddr);
+	value = rproc->bootaddr >> bdata->boot_reg_shift;
+	mask = ~(SZ_1K - 1) >> bdata->boot_reg_shift;
+
+	regmap_update_bits(bdata->syscon, offset, mask, value);
 
 	return 0;
 }
@@ -296,6 +304,13 @@ static const struct omap_rproc_mem_data ipu_mems[] = {
 	{ },
 };
 
+static const struct omap_rproc_mem_data dra7_dsp_mems[] = {
+	{ .name = "l2ram", .dev_addr = 0x800000 },
+	{ .name = "l1pram", .dev_addr = 0xe00000 },
+	{ .name = "l1dram", .dev_addr = 0xf00000 },
+	{ },
+};
+
 static const struct omap_rproc_dev_data omap4_dsp_dev_data = {
 	.device_name	= "dsp",
 };
@@ -314,6 +329,16 @@ static const struct omap_rproc_dev_data omap5_ipu_dev_data = {
 	.mems		= ipu_mems,
 };
 
+static const struct omap_rproc_dev_data dra7_dsp_dev_data = {
+	.device_name	= "dsp",
+	.mems		= dra7_dsp_mems,
+};
+
+static const struct omap_rproc_dev_data dra7_ipu_dev_data = {
+	.device_name	= "ipu",
+	.mems		= ipu_mems,
+};
+
 static const struct of_device_id omap_rproc_of_match[] = {
 	{
 		.compatible     = "ti,omap4-dsp",
@@ -331,6 +356,14 @@ static const struct of_device_id omap_rproc_of_match[] = {
 		.compatible     = "ti,omap5-ipu",
 		.data           = &omap5_ipu_dev_data,
 	},
+	{
+		.compatible     = "ti,dra7-dsp",
+		.data           = &dra7_dsp_dev_data,
+	},
+	{
+		.compatible     = "ti,dra7-ipu",
+		.data           = &dra7_ipu_dev_data,
+	},
 	{
 		/* end */
 	},
@@ -383,6 +416,9 @@ static int omap_rproc_get_boot_data(struct platform_device *pdev,
 		return -EINVAL;
 	}
 
+	of_property_read_u32_index(np, "ti,bootreg", 2,
+				   &oproc->boot_data->boot_reg_shift);
+
 	return 0;
 }
 
-- 
2.17.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v2 2/3] ARM: OMAP2+: onenand: prepare for gpmc driver migration
Date: Sat, 16 Jun 2012 13:33:10 +0530
Message-ID: <1414767dd444d4ab3998adf957e77ff4f3394f92.1339828867.git.afzal@ti.com>
References: <cover.1339828867.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38122 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755237Ab2FPISm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 16 Jun 2012 04:18:42 -0400
In-Reply-To: <cover.1339828867.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, jon-hunter@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

Reorganize gpmc-onenand initialization so that changes
required for gpmc driver migration can be made smooth.

Ensuring sync read/write are disabled in onenand cannot
be expected to work properly unless GPMC is setup, this
has been removed. And invocation of set_async has been
moved from set_sync to gpmc_onenand_init function; gpmc
for onenand needs to be initialized to async mode (even
for sync mode initially). Ensuring that onenand part
has been setup for async mode has been moved now to
setup function.

Thanks to Jon for his suggestions on improving this change.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---

v2: Move ensuring that async mode in OneNAND has been setup from
 set_sync to setup function, improve commit message

 arch/arm/mach-omap2/gpmc-onenand.c |   25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
index 71d7c07..975c1f9 100644
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -38,10 +38,9 @@ static struct platform_device gpmc_onenand_device = {
 	.resource	= &gpmc_onenand_resource,
 };
 
-static int omap2_onenand_set_async_mode(int cs, void __iomem *onenand_base)
+static int omap2_onenand_set_async_mode(int cs)
 {
 	struct gpmc_timings t;
-	u32 reg;
 	int err;
 
 	const int t_cer = 15;
@@ -55,11 +54,6 @@ static int omap2_onenand_set_async_mode(int cs, void __iomem *onenand_base)
 	const int t_wpl = 40;
 	const int t_wph = 30;
 
-	/* Ensure sync read and sync write are disabled */
-	reg = readw(onenand_base + ONENAND_REG_SYS_CFG1);
-	reg &= ~ONENAND_SYS_CFG1_SYNC_READ & ~ONENAND_SYS_CFG1_SYNC_WRITE;
-	writew(reg, onenand_base + ONENAND_REG_SYS_CFG1);
-
 	memset(&t, 0, sizeof(t));
 	t.sync_clk = 0;
 	t.cs_on = 0;
@@ -95,10 +89,6 @@ static int omap2_onenand_set_async_mode(int cs, void __iomem *onenand_base)
 	if (err)
 		return err;
 
-	/* Ensure sync read and sync write are disabled */
-	reg = readw(onenand_base + ONENAND_REG_SYS_CFG1);
-	reg &= ~ONENAND_SYS_CFG1_SYNC_READ & ~ONENAND_SYS_CFG1_SYNC_WRITE;
-	writew(reg, onenand_base + ONENAND_REG_SYS_CFG1);
 
 	return 0;
 }
@@ -197,13 +187,10 @@ static int omap2_onenand_set_sync_mode(struct omap_onenand_platform_data *cfg,
 		sync_read = 1;
 		sync_write = 1;
 	} else
-		return omap2_onenand_set_async_mode(cs, onenand_base);
+		return 0;
 
 	if (!freq) {
 		/* Very first call freq is not known */
-		err = omap2_onenand_set_async_mode(cs, onenand_base);
-		if (err)
-			return err;
 		freq = omap2_onenand_get_freq(cfg, onenand_base, &clk_dep);
 		first_time = 1;
 	}
@@ -385,6 +372,12 @@ static int omap2_onenand_set_sync_mode(struct omap_onenand_platform_data *cfg,
 static int gpmc_onenand_setup(void __iomem *onenand_base, int *freq_ptr)
 {
 	struct device *dev = &gpmc_onenand_device.dev;
+	u32 reg;
+
+	/* Ensure sync read and sync write are disabled */
+	reg = readw(onenand_base + ONENAND_REG_SYS_CFG1);
+	reg &= ~ONENAND_SYS_CFG1_SYNC_READ & ~ONENAND_SYS_CFG1_SYNC_WRITE;
+	writew(reg, onenand_base + ONENAND_REG_SYS_CFG1);
 
 	/* Set sync timings in GPMC */
 	if (omap2_onenand_set_sync_mode(gpmc_onenand_data, onenand_base,
@@ -421,6 +414,8 @@ void __init gpmc_onenand_init(struct omap_onenand_platform_data *_onenand_data)
 	gpmc_onenand_resource.end = gpmc_onenand_resource.start +
 							ONENAND_IO_SIZE - 1;
 
+	omap2_onenand_set_async_mode(gpmc_onenand_data->cs);
+
 	if (platform_device_register(&gpmc_onenand_device) < 0) {
 		pr_err("%s: Unable to register OneNAND device\n", __func__);
 		gpmc_cs_free(gpmc_onenand_data->cs);
-- 
1.7.10.2


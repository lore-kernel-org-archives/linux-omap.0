From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 04/11] ARM: OMAP2+: Remove unused legacy code for device init
Date: Wed, 31 May 2017 15:51:32 -0700
Message-ID: <20170531225139.30723-5-tony@atomide.com>
References: <20170531225139.30723-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170531225139.30723-1-tony@atomide.com>
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
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We are now booting all mach-omap2 in device tree only mode.
Any code that is only called in legacy boot mode where
of_have_populated_dt() is not set is safe to remove now.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/devices.c | 163 ------------------------------------------
 1 file changed, 163 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -36,130 +36,8 @@
 #define L3_MODULES_MAX_LEN 12
 #define L3_MODULES 3
 
-static int __init omap3_l3_init(void)
-{
-	struct omap_hwmod *oh;
-	struct platform_device *pdev;
-	char oh_name[L3_MODULES_MAX_LEN];
-
-	/*
-	 * To avoid code running on other OMAPs in
-	 * multi-omap builds
-	 */
-	if (!(cpu_is_omap34xx()) || of_have_populated_dt())
-		return -ENODEV;
-
-	snprintf(oh_name, L3_MODULES_MAX_LEN, "l3_main");
-
-	oh = omap_hwmod_lookup(oh_name);
-
-	if (!oh)
-		pr_err("could not look up %s\n", oh_name);
-
-	pdev = omap_device_build("omap_l3_smx", 0, oh, NULL, 0);
-
-	WARN(IS_ERR(pdev), "could not build omap_device for %s\n", oh_name);
-
-	return PTR_ERR_OR_ZERO(pdev);
-}
-omap_postcore_initcall(omap3_l3_init);
-
 static inline void omap_init_sti(void) {}
 
-#if IS_ENABLED(CONFIG_SPI_OMAP24XX)
-
-#include <linux/platform_data/spi-omap2-mcspi.h>
-
-static int __init omap_mcspi_init(struct omap_hwmod *oh, void *unused)
-{
-	struct platform_device *pdev;
-	char *name = "omap2_mcspi";
-	struct omap2_mcspi_platform_config *pdata;
-	static int spi_num;
-	struct omap2_mcspi_dev_attr *mcspi_attrib = oh->dev_attr;
-
-	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
-	if (!pdata) {
-		pr_err("Memory allocation for McSPI device failed\n");
-		return -ENOMEM;
-	}
-
-	pdata->num_cs = mcspi_attrib->num_chipselect;
-	switch (oh->class->rev) {
-	case OMAP2_MCSPI_REV:
-	case OMAP3_MCSPI_REV:
-			pdata->regs_offset = 0;
-			break;
-	case OMAP4_MCSPI_REV:
-			pdata->regs_offset = OMAP4_MCSPI_REG_OFFSET;
-			break;
-	default:
-			pr_err("Invalid McSPI Revision value\n");
-			kfree(pdata);
-			return -EINVAL;
-	}
-
-	spi_num++;
-	pdev = omap_device_build(name, spi_num, oh, pdata, sizeof(*pdata));
-	WARN(IS_ERR(pdev), "Can't build omap_device for %s:%s\n",
-				name, oh->name);
-	kfree(pdata);
-	return 0;
-}
-
-static void omap_init_mcspi(void)
-{
-	omap_hwmod_for_each_by_class("mcspi", omap_mcspi_init, NULL);
-}
-
-#else
-static inline void omap_init_mcspi(void) {}
-#endif
-
-/**
- * omap_init_rng - bind the RNG hwmod to the RNG omap_device
- *
- * Bind the RNG hwmod to the RNG omap_device.  No return value.
- */
-static void __init omap_init_rng(void)
-{
-	struct omap_hwmod *oh;
-	struct platform_device *pdev;
-
-	oh = omap_hwmod_lookup("rng");
-	if (!oh)
-		return;
-
-	pdev = omap_device_build("omap_rng", -1, oh, NULL, 0);
-	WARN(IS_ERR(pdev), "Can't build omap_device for omap_rng\n");
-}
-
-static void __init omap_init_sham(void)
-{
-	struct omap_hwmod *oh;
-	struct platform_device *pdev;
-
-	oh = omap_hwmod_lookup("sham");
-	if (!oh)
-		return;
-
-	pdev = omap_device_build("omap-sham", -1, oh, NULL, 0);
-	WARN(IS_ERR(pdev), "Can't build omap_device for omap-sham\n");
-}
-
-static void __init omap_init_aes(void)
-{
-	struct omap_hwmod *oh;
-	struct platform_device *pdev;
-
-	oh = omap_hwmod_lookup("aes");
-	if (!oh)
-		return;
-
-	pdev = omap_device_build("omap-aes", -1, oh, NULL, 0);
-	WARN(IS_ERR(pdev), "Can't build omap_device for omap-aes\n");
-}
-
 /*-------------------------------------------------------------------------*/
 
 #if IS_ENABLED(CONFIG_VIDEO_OMAP2_VOUT)
@@ -190,49 +68,8 @@ int __init omap_init_vout(void) { return 0; }
 
 static int __init omap2_init_devices(void)
 {
-	/* Enable dummy states for those platforms without pinctrl support */
-	if (!of_have_populated_dt())
-		pinctrl_provide_dummies();
-
-	/* If dtb is there, the devices will be created dynamically */
-	if (!of_have_populated_dt()) {
-		/*
-		 * please keep these calls, and their implementations above,
-		 * in alphabetical order so they're easier to sort through.
-		 */
-		omap_init_mcspi();
-		omap_init_sham();
-		omap_init_aes();
-		omap_init_rng();
-	}
 	omap_init_sti();
 
 	return 0;
 }
 omap_arch_initcall(omap2_init_devices);
-
-static int __init omap_gpmc_init(void)
-{
-	struct omap_hwmod *oh;
-	struct platform_device *pdev;
-	char *oh_name = "gpmc";
-
-	/*
-	 * if the board boots up with a populated DT, do not
-	 * manually add the device from this initcall
-	 */
-	if (of_have_populated_dt())
-		return -ENODEV;
-
-	oh = omap_hwmod_lookup(oh_name);
-	if (!oh) {
-		pr_err("Could not look up %s\n", oh_name);
-		return -ENODEV;
-	}
-
-	pdev = omap_device_build("omap-gpmc", -1, oh, NULL, 0);
-	WARN(IS_ERR(pdev), "could not build omap_device for %s\n", oh_name);
-
-	return PTR_ERR_OR_ZERO(pdev);
-}
-omap_postcore_initcall(omap_gpmc_init);
-- 
2.13.0

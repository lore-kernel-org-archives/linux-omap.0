From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH] arm: omap: drop unused IRQ defines
Date: Fri,  8 Jun 2012 17:10:12 +0300
Message-ID: <1339164612-24402-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:42649 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932082Ab2FHOMI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jun 2012 10:12:08 -0400
Received: by lags15 with SMTP id s15so1200721lag.6
        for <linux-omap@vger.kernel.org>; Fri, 08 Jun 2012 07:12:03 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

twl[46]030 have been converted to sparse IRQ
already, so we can remove the unused defines
and drop some code from board-files.

compile tested with omap2plus_defconfig.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---

patch mostly generated with:

$ sed -i '/.irq_\(base\|end\).*TWL4030_\(GPIO_\|\)IRQ_\(BASE\|END\),/d' arch/arm/mach-omap2/*.c

When building omap2plus_defconfig, found a few section
mismatches:

drivers/mtd/chips/cfi_cmdset_0001.c: In function 'cfi_intelext_write_words':
include/linux/mtd/map.h:331:11: warning: 'r$x$0' may be used uninitialized in this function
WARNING: drivers/mmc/host/built-in.o(.devinit.text+0x2fc): Section mismatch in reference from the function mmc_omap_probe() to the function .init.text:mmc_omap_new_slot()
The function __devinit mmc_omap_probe() references
a function __init mmc_omap_new_slot().
If mmc_omap_new_slot is only used by mmc_omap_probe then
annotate mmc_omap_new_slot with a matching annotation.

WARNING: drivers/mmc/built-in.o(.devinit.text+0x2fc): Section mismatch in reference from the function mmc_omap_probe() to the function .init.text:mmc_omap_new_slot()
The function __devinit mmc_omap_probe() references
a function __init mmc_omap_new_slot().
If mmc_omap_new_slot is only used by mmc_omap_probe then
annotate mmc_omap_new_slot with a matching annotation.

fs/ubifs/dir.c: In function 'ubifs_rename':
fs/ubifs/dir.c:972:15: warning: 'saved_nlink' may be used uninitialized in this function
net/mac80211/mlme.c: In function 'ieee80211_prep_connection':
net/mac80211/mlme.c:3017:19: warning: 'sta' may be used uninitialized in this function
WARNING: drivers/built-in.o(.devinit.text+0x73d4): Section mismatch in reference from the function mmc_omap_probe() to the function .init.text:mmc_omap_new_slot()
The function __devinit mmc_omap_probe() references
a function __init mmc_omap_new_slot().
If mmc_omap_new_slot is only used by mmc_omap_probe then
annotate mmc_omap_new_slot with a matching annotation.

WARNING: vmlinux.o(.devinit.text+0x7f08): Section mismatch in reference from the function mmc_omap_probe() to the function .init.text:mmc_omap_new_slot()
The function __devinit mmc_omap_probe() references
a function __init mmc_omap_new_slot().
If mmc_omap_new_slot is only used by mmc_omap_probe then
annotate mmc_omap_new_slot with a matching annotation.

not sure if they were already fixed.

 arch/arm/mach-omap2/board-2430sdp.c          |    4 ---
 arch/arm/mach-omap2/board-3430sdp.c          |    2 --
 arch/arm/mach-omap2/board-cm-t35.c           |    2 --
 arch/arm/mach-omap2/board-devkit8000.c       |    2 --
 arch/arm/mach-omap2/board-igep0020.c         |    2 --
 arch/arm/mach-omap2/board-ldp.c              |    2 --
 arch/arm/mach-omap2/board-omap3beagle.c      |    2 --
 arch/arm/mach-omap2/board-omap3evm.c         |    2 --
 arch/arm/mach-omap2/board-omap3logic.c       |    4 ---
 arch/arm/mach-omap2/board-omap3pandora.c     |    2 --
 arch/arm/mach-omap2/board-omap3stalker.c     |    2 --
 arch/arm/mach-omap2/board-omap3touchbook.c   |    2 --
 arch/arm/mach-omap2/board-overo.c            |    2 --
 arch/arm/mach-omap2/board-rm680.c            |    2 --
 arch/arm/mach-omap2/board-rx51-peripherals.c |    2 --
 arch/arm/mach-omap2/board-zoom-peripherals.c |    2 --
 arch/arm/mach-omap2/twl-common.c             |    9 ------
 arch/arm/plat-omap/include/plat/irqs.h       |   41 ++------------------------
 include/linux/i2c/twl.h                      |    2 --
 19 files changed, 2 insertions(+), 86 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 99ca6ba..dcb6475 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -213,13 +213,9 @@ static struct regulator_init_data sdp2430_vmmc1 = {
 
 static struct twl4030_gpio_platform_data sdp2430_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
-	.irq_base	= TWL4030_GPIO_IRQ_BASE,
-	.irq_end	= TWL4030_GPIO_IRQ_END,
 };
 
 static struct twl4030_platform_data sdp2430_twldata = {
-	.irq_base	= TWL4030_IRQ_BASE,
-	.irq_end	= TWL4030_IRQ_END,
 
 	/* platform_data for children goes here */
 	.gpio		= &sdp2430_gpio_data,
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index a98c688..a91abfa 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -234,8 +234,6 @@ static int sdp3430_twl_gpio_setup(struct device *dev,
 
 static struct twl4030_gpio_platform_data sdp3430_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
-	.irq_base	= TWL4030_GPIO_IRQ_BASE,
-	.irq_end	= TWL4030_GPIO_IRQ_END,
 	.pulldowns	= BIT(2) | BIT(6) | BIT(8) | BIT(13)
 				| BIT(16) | BIT(17),
 	.setup		= sdp3430_twl_gpio_setup,
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index ded100c..8328318 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -471,8 +471,6 @@ static int cm_t35_twl_gpio_setup(struct device *dev, unsigned gpio,
 
 static struct twl4030_gpio_platform_data cm_t35_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
-	.irq_base	= TWL4030_GPIO_IRQ_BASE,
-	.irq_end	= TWL4030_GPIO_IRQ_END,
 	.setup          = cm_t35_twl_gpio_setup,
 };
 
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 6567c1c..89671a2 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -237,8 +237,6 @@ static int devkit8000_twl_gpio_setup(struct device *dev,
 
 static struct twl4030_gpio_platform_data devkit8000_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
-	.irq_base	= TWL4030_GPIO_IRQ_BASE,
-	.irq_end	= TWL4030_GPIO_IRQ_END,
 	.use_leds	= true,
 	.pulldowns	= BIT(1) | BIT(2) | BIT(6) | BIT(8) | BIT(13)
 				| BIT(15) | BIT(16) | BIT(17),
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 7491529..761b32f 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -426,8 +426,6 @@ static int igep_twl_gpio_setup(struct device *dev,
 
 static struct twl4030_gpio_platform_data igep_twl4030_gpio_pdata = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
-	.irq_base	= TWL4030_GPIO_IRQ_BASE,
-	.irq_end	= TWL4030_GPIO_IRQ_END,
 	.use_leds	= true,
 	.setup		= igep_twl_gpio_setup,
 };
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index ef9e829..bd3378e 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -276,8 +276,6 @@ static int ldp_twl_gpio_setup(struct device *dev, unsigned gpio, unsigned ngpio)
 
 static struct twl4030_gpio_platform_data ldp_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
-	.irq_base	= TWL4030_GPIO_IRQ_BASE,
-	.irq_end	= TWL4030_GPIO_IRQ_END,
 	.setup		= ldp_twl_gpio_setup,
 };
 
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 79c6909..9d057d9 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -300,8 +300,6 @@ static int beagle_twl_gpio_setup(struct device *dev,
 
 static struct twl4030_gpio_platform_data beagle_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
-	.irq_base	= TWL4030_GPIO_IRQ_BASE,
-	.irq_end	= TWL4030_GPIO_IRQ_END,
 	.use_leds	= true,
 	.pullups	= BIT(1),
 	.pulldowns	= BIT(2) | BIT(6) | BIT(7) | BIT(8) | BIT(13)
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 639bd07..8750d00 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -360,8 +360,6 @@ static int omap3evm_twl_gpio_setup(struct device *dev,
 
 static struct twl4030_gpio_platform_data omap3evm_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
-	.irq_base	= TWL4030_GPIO_IRQ_BASE,
-	.irq_end	= TWL4030_GPIO_IRQ_END,
 	.use_leds	= true,
 	.setup		= omap3evm_twl_gpio_setup,
 };
diff --git a/arch/arm/mach-omap2/board-omap3logic.c b/arch/arm/mach-omap2/board-omap3logic.c
index 932e177..97d2948 100644
--- a/arch/arm/mach-omap2/board-omap3logic.c
+++ b/arch/arm/mach-omap2/board-omap3logic.c
@@ -79,8 +79,6 @@ static struct regulator_init_data omap3logic_vmmc1 = {
 
 static struct twl4030_gpio_platform_data omap3logic_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
-	.irq_base	= TWL4030_GPIO_IRQ_BASE,
-	.irq_end	= TWL4030_GPIO_IRQ_END,
 	.use_leds	= true,
 	.pullups	= BIT(1),
 	.pulldowns	= BIT(2)  | BIT(6)  | BIT(7)  | BIT(8)
@@ -93,8 +91,6 @@ static struct twl4030_usb_data omap3logic_usb_data = {
 
 
 static struct twl4030_platform_data omap3logic_twldata = {
-	.irq_base	= TWL4030_IRQ_BASE,
-	.irq_end	= TWL4030_IRQ_END,
 
 	/* platform_data for children goes here */
 	.gpio		= &omap3logic_gpio_data,
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 57aebee..2241e41 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -322,8 +322,6 @@ static int omap3pandora_twl_gpio_setup(struct device *dev,
 
 static struct twl4030_gpio_platform_data omap3pandora_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
-	.irq_base	= TWL4030_GPIO_IRQ_BASE,
-	.irq_end	= TWL4030_GPIO_IRQ_END,
 	.setup		= omap3pandora_twl_gpio_setup,
 };
 
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index b318f56..11391ab 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -280,8 +280,6 @@ omap3stalker_twl_gpio_setup(struct device *dev,
 
 static struct twl4030_gpio_platform_data omap3stalker_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
-	.irq_base	= TWL4030_GPIO_IRQ_BASE,
-	.irq_end	= TWL4030_GPIO_IRQ_END,
 	.use_leds	= true,
 	.setup		= omap3stalker_twl_gpio_setup,
 };
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 485d14d..079e663 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -140,8 +140,6 @@ static int touchbook_twl_gpio_setup(struct device *dev,
 
 static struct twl4030_gpio_platform_data touchbook_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
-	.irq_base	= TWL4030_GPIO_IRQ_BASE,
-	.irq_end	= TWL4030_GPIO_IRQ_END,
 	.use_leds	= true,
 	.pullups	= BIT(1),
 	.pulldowns	= BIT(2) | BIT(6) | BIT(7) | BIT(8) | BIT(13)
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 8fa2fc3..d42cab0 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -400,8 +400,6 @@ static int overo_twl_gpio_setup(struct device *dev,
 
 static struct twl4030_gpio_platform_data overo_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
-	.irq_base	= TWL4030_GPIO_IRQ_BASE,
-	.irq_end	= TWL4030_GPIO_IRQ_END,
 	.use_leds	= true,
 	.setup		= overo_twl_gpio_setup,
 };
diff --git a/arch/arm/mach-omap2/board-rm680.c b/arch/arm/mach-omap2/board-rm680.c
index 0ad1bb3b..e728d3f 100644
--- a/arch/arm/mach-omap2/board-rm680.c
+++ b/arch/arm/mach-omap2/board-rm680.c
@@ -73,8 +73,6 @@ static struct platform_device *rm680_peripherals_devices[] __initdata = {
 /* TWL */
 static struct twl4030_gpio_platform_data rm680_gpio_data = {
 	.gpio_base		= OMAP_MAX_GPIO_LINES,
-	.irq_base		= TWL4030_GPIO_IRQ_BASE,
-	.irq_end		= TWL4030_GPIO_IRQ_END,
 	.pullups		= BIT(0),
 	.pulldowns		= BIT(1) | BIT(2) | BIT(8) | BIT(15),
 };
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index ff53dec..b480ac7 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -776,8 +776,6 @@ static int rx51_twlgpio_setup(struct device *dev, unsigned gpio, unsigned n)
 
 static struct twl4030_gpio_platform_data rx51_gpio_data = {
 	.gpio_base		= OMAP_MAX_GPIO_LINES,
-	.irq_base		= TWL4030_GPIO_IRQ_BASE,
-	.irq_end		= TWL4030_GPIO_IRQ_END,
 	.pulldowns		= BIT(0) | BIT(1) | BIT(2) | BIT(3)
 				| BIT(4) | BIT(5)
 				| BIT(8) | BIT(9) | BIT(10) | BIT(11)
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index b797cb2..85abda2 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -252,8 +252,6 @@ static void zoom2_set_hs_extmute(int mute)
 
 static struct twl4030_gpio_platform_data zoom_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
-	.irq_base	= TWL4030_GPIO_IRQ_BASE,
-	.irq_end	= TWL4030_GPIO_IRQ_END,
 	.setup		= zoom_twl_gpio_setup,
 };
 
diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
index 119d5a9..ce7cccf 100644
--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -211,10 +211,6 @@ static struct twl_regulator_driver_data omap3_vdd2_drvdata = {
 void __init omap3_pmic_get_config(struct twl4030_platform_data *pmic_data,
 				  u32 pdata_flags, u32 regulators_flags)
 {
-	if (!pmic_data->irq_base)
-		pmic_data->irq_base = TWL4030_IRQ_BASE;
-	if (!pmic_data->irq_end)
-		pmic_data->irq_end = TWL4030_IRQ_END;
 	if (!pmic_data->vdd1) {
 		omap3_vdd1.driver_data = &omap3_vdd1_drvdata;
 		omap3_vdd1_drvdata.data = voltdm_lookup("mpu_iva");
@@ -479,11 +475,6 @@ static struct regulator_init_data omap4_v2v1_idata = {
 void __init omap4_pmic_get_config(struct twl4030_platform_data *pmic_data,
 				  u32 pdata_flags, u32 regulators_flags)
 {
-	if (!pmic_data->irq_base)
-		pmic_data->irq_base = TWL6030_IRQ_BASE;
-	if (!pmic_data->irq_end)
-		pmic_data->irq_end = TWL6030_IRQ_END;
-
 	if (!pmic_data->vdd1) {
 		omap4_vdd1.driver_data = &omap4_vdd1_drvdata;
 		omap4_vdd1_drvdata.data = voltdm_lookup("mpu");
diff --git a/arch/arm/plat-omap/include/plat/irqs.h b/arch/arm/plat-omap/include/plat/irqs.h
index 37bbbbb..0b375cc 100644
--- a/arch/arm/plat-omap/include/plat/irqs.h
+++ b/arch/arm/plat-omap/include/plat/irqs.h
@@ -378,37 +378,7 @@
 #endif
 #define OMAP_FPGA_IRQ_END	(OMAP_FPGA_IRQ_BASE + OMAP_FPGA_NR_IRQS)
 
-/* External TWL4030 can handle interrupts on 2430 and 34xx boards */
-#define	TWL4030_IRQ_BASE	(OMAP_FPGA_IRQ_END)
-#ifdef	CONFIG_TWL4030_CORE
-#define	TWL4030_BASE_NR_IRQS	8
-#define	TWL4030_PWR_NR_IRQS	8
-#else
-#define	TWL4030_BASE_NR_IRQS	0
-#define	TWL4030_PWR_NR_IRQS	0
-#endif
-#define TWL4030_IRQ_END		(TWL4030_IRQ_BASE + TWL4030_BASE_NR_IRQS)
-#define TWL4030_PWR_IRQ_BASE	TWL4030_IRQ_END
-#define	TWL4030_PWR_IRQ_END	(TWL4030_PWR_IRQ_BASE + TWL4030_PWR_NR_IRQS)
-
-/* External TWL4030 gpio interrupts are optional */
-#define TWL4030_GPIO_IRQ_BASE	TWL4030_PWR_IRQ_END
-#ifdef	CONFIG_GPIO_TWL4030
-#define TWL4030_GPIO_NR_IRQS	18
-#else
-#define	TWL4030_GPIO_NR_IRQS	0
-#endif
-#define TWL4030_GPIO_IRQ_END	(TWL4030_GPIO_IRQ_BASE + TWL4030_GPIO_NR_IRQS)
-
-#define	TWL6030_IRQ_BASE	(OMAP_FPGA_IRQ_END)
-#ifdef CONFIG_TWL4030_CORE
-#define	TWL6030_BASE_NR_IRQS	20
-#else
-#define	TWL6030_BASE_NR_IRQS	0
-#endif
-#define TWL6030_IRQ_END		(TWL6030_IRQ_BASE + TWL6030_BASE_NR_IRQS)
-
-#define TWL6040_CODEC_IRQ_BASE	TWL6030_IRQ_END
+#define TWL6040_CODEC_IRQ_BASE	OMAP_FPGA_IRQ_END
 #ifdef CONFIG_TWL6040_CODEC
 #define TWL6040_CODEC_NR_IRQS	6
 #else
@@ -416,15 +386,8 @@
 #endif
 #define TWL6040_CODEC_IRQ_END	(TWL6040_CODEC_IRQ_BASE + TWL6040_CODEC_NR_IRQS)
 
-/* Total number of interrupts depends on the enabled blocks above */
-#if (TWL4030_GPIO_IRQ_END > TWL6040_CODEC_IRQ_END)
-#define TWL_IRQ_END 		TWL4030_GPIO_IRQ_END
-#else
-#define TWL_IRQ_END		TWL6040_CODEC_IRQ_END
-#endif
-
 /* GPMC related */
-#define OMAP_GPMC_IRQ_BASE	(TWL_IRQ_END)
+#define OMAP_GPMC_IRQ_BASE	(TWL6040_CODEC_IRQ_END)
 #define OMAP_GPMC_NR_IRQS	8
 #define OMAP_GPMC_IRQ_END	(OMAP_GPMC_IRQ_BASE + OMAP_GPMC_NR_IRQS)
 
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index 3993477..f0728b1 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -560,7 +560,6 @@ struct twl4030_bci_platform_data {
 /* TWL4030_GPIO_MAX (18) GPIOs, with interrupts */
 struct twl4030_gpio_platform_data {
 	int		gpio_base;
-	unsigned	irq_base, irq_end;
 
 	/* package the two LED signals as output-only GPIOs? */
 	bool		use_leds;
@@ -683,7 +682,6 @@ struct twl4030_audio_data {
 };
 
 struct twl4030_platform_data {
-	unsigned				irq_base, irq_end;
 	struct twl4030_clock_init_data		*clock;
 	struct twl4030_bci_platform_data	*bci;
 	struct twl4030_gpio_platform_data	*gpio;
-- 
1.7.10.3


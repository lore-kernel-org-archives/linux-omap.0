From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 6/7] ARM: OMAP3: Use .teardown of twl4030-gpio to clean board requests
Date: Thu, 23 Feb 2012 17:10:46 +0530
Message-ID: <1329997247-27342-7-git-send-email-rnayak@ti.com>
References: <1329997247-27342-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44790 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753489Ab2BWLlE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Feb 2012 06:41:04 -0500
In-Reply-To: <1329997247-27342-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

All OMAP3 boards which register a .setup function with twl4030
gpio driver do not seem to have a .teardown hook implemented.
.setup mainly requests a few gpios and also in most cases
does a omap_hsmmc_deferred_add(). Have a .teardown do a gpio_free()
and of the requested gpios and also do a omap_hsmmc_deferred_del().
This helps in case the twl4030 gpio driver is built as a module and
added and removed multiple times. Without the .teardown a multiple
insmod/rmmod can result in gpio request failues and also WARN messages
stating addition of already registered mmc devices.

Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c          |   10 ++++++++++
 arch/arm/mach-omap2/board-cm-t35.c           |    8 ++++++++
 arch/arm/mach-omap2/board-devkit8000.c       |   10 ++++++++++
 arch/arm/mach-omap2/board-igep0020.c         |   14 ++++++++++++++
 arch/arm/mach-omap2/board-ldp.c              |    9 +++++++++
 arch/arm/mach-omap2/board-omap3beagle.c      |   12 ++++++++++++
 arch/arm/mach-omap2/board-omap3evm.c         |   10 ++++++++++
 arch/arm/mach-omap2/board-omap3pandora.c     |    9 +++++++++
 arch/arm/mach-omap2/board-omap3stalker.c     |   11 +++++++++++
 arch/arm/mach-omap2/board-omap3touchbook.c   |   10 ++++++++++
 arch/arm/mach-omap2/board-overo.c            |    8 ++++++++
 arch/arm/mach-omap2/board-rx51-peripherals.c |    8 ++++++++
 arch/arm/mach-omap2/board-zoom-peripherals.c |    9 +++++++++
 arch/arm/mach-omap2/hsmmc.c                  |   11 +++++++++++
 arch/arm/mach-omap2/hsmmc.h                  |    4 ++++
 15 files changed, 143 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index f93bb84..c1ddbb7 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -259,6 +259,15 @@ static int sdp3430_twl_gpio_setup(struct device *dev,
 	return 0;
 }
 
+static int sdp3430_twl_gpio_teardown(struct device *dev,
+		unsigned gpio, unsigned ngpio)
+{
+	omap_hsmmc_deferred_del(mmc);
+	gpio_free(gpio + 7);
+	gpio_free(gpio + 15);
+	return 0;
+}
+
 static struct twl4030_gpio_platform_data sdp3430_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
 	.irq_base	= TWL4030_GPIO_IRQ_BASE,
@@ -266,6 +275,7 @@ static struct twl4030_gpio_platform_data sdp3430_gpio_data = {
 	.pulldowns	= BIT(2) | BIT(6) | BIT(8) | BIT(13)
 				| BIT(16) | BIT(17),
 	.setup		= sdp3430_twl_gpio_setup,
+	.teardown	= sdp3430_twl_gpio_teardown,
 };
 
 /* regulator consumer mappings */
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 14df109..55e0180 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -475,11 +475,19 @@ static int cm_t35_twl_gpio_setup(struct device *dev, unsigned gpio,
 	return 0;
 }
 
+static int cm_t35_twl_gpio_teardown(struct device *dev, unsigned gpio,
+				 unsigned ngpio)
+{
+	omap_hsmmc_deferred_del(mmc);
+	gpio_free(gpio + 2);
+	return 0;
+}
 static struct twl4030_gpio_platform_data cm_t35_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
 	.irq_base	= TWL4030_GPIO_IRQ_BASE,
 	.irq_end	= TWL4030_GPIO_IRQ_END,
 	.setup          = cm_t35_twl_gpio_setup,
+	.teardown	= cm_t35_twl_gpio_teardown,
 };
 
 static struct twl4030_platform_data cm_t35_twldata = {
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 6b99a5e..2903dd1 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -254,6 +254,15 @@ static int devkit8000_twl_gpio_setup(struct device *dev,
 	return 0;
 }
 
+static int devkit8000_twl_gpio_teardown(struct device *dev,
+		unsigned gpio, unsigned ngpio)
+{
+	omap_hsmmc_deferred_del(mmc);
+	gpio_free(gpio + TWL4030_GPIO_MAX + 0);
+	gpio_free(gpio + 7);
+	return 0;
+}
+
 static struct twl4030_gpio_platform_data devkit8000_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
 	.irq_base	= TWL4030_GPIO_IRQ_BASE,
@@ -262,6 +271,7 @@ static struct twl4030_gpio_platform_data devkit8000_gpio_data = {
 	.pulldowns	= BIT(1) | BIT(2) | BIT(6) | BIT(8) | BIT(13)
 				| BIT(15) | BIT(16) | BIT(17),
 	.setup		= devkit8000_twl_gpio_setup,
+	.teardown	= devkit8000_twl_gpio_teardown,
 };
 
 static struct regulator_consumer_supply devkit8000_vpll1_supplies[] = {
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 11a6aa4..1d0850f 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -435,12 +435,26 @@ static int igep_twl_gpio_setup(struct device *dev,
 	return 0;
 };
 
+static int igep_twl_gpio_teardown(struct device *dev,
+		unsigned gpio, unsigned ngpio)
+{
+	omap_hsmmc_deferred_del(mmc);
+	gpio_free(gpio + TWL4030_GPIO_MAX + 1);
+	if (machine_is_igep0030())
+		return 0;
+
+	gpio_free(gpio + 1);
+	gpio_free(gpio + TWL4030_GPIO_MAX);
+	return 0;
+}
+
 static struct twl4030_gpio_platform_data igep_twl4030_gpio_pdata = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
 	.irq_base	= TWL4030_GPIO_IRQ_BASE,
 	.irq_end	= TWL4030_GPIO_IRQ_END,
 	.use_leds	= true,
 	.setup		= igep_twl_gpio_setup,
+	.teardown	= igep_twl_gpio_teardown,
 };
 
 static int igep2_enable_dvi(struct omap_dss_device *dssdev)
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index b5bc9b2..279ef18 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -274,11 +274,20 @@ static int ldp_twl_gpio_setup(struct device *dev, unsigned gpio, unsigned ngpio)
 	return 0;
 }
 
+static int ldp_twl_gpio_teardown(struct device *dev, unsigned gpio,
+							 unsigned ngpio)
+{
+	gpio_free(gpio + 7);
+	gpio_free(gpio + 15);
+	return 0;
+}
+
 static struct twl4030_gpio_platform_data ldp_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
 	.irq_base	= TWL4030_GPIO_IRQ_BASE,
 	.irq_end	= TWL4030_GPIO_IRQ_END,
 	.setup		= ldp_twl_gpio_setup,
+	.teardown	= ldp_twl_gpio_teardown,
 };
 
 static struct regulator_consumer_supply ldp_vmmc1_supply[] = {
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index e219b7d..08749a5 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -321,6 +321,17 @@ static int beagle_twl_gpio_setup(struct device *dev,
 	return 0;
 }
 
+static int beagle_twl_gpio_teardown(struct device *dev,
+		unsigned gpio, unsigned ngpio)
+{
+	omap_hsmmc_deferred_del(mmc);
+	gpio_free(gpio + 1);
+	if (cpu_is_omap3630())
+		gpio_free(gpio + 2);
+	gpio_free(gpio + TWL4030_GPIO_MAX);
+	return 0;
+}
+
 static struct twl4030_gpio_platform_data beagle_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
 	.irq_base	= TWL4030_GPIO_IRQ_BASE,
@@ -330,6 +341,7 @@ static struct twl4030_gpio_platform_data beagle_gpio_data = {
 	.pulldowns	= BIT(2) | BIT(6) | BIT(7) | BIT(8) | BIT(13)
 				| BIT(15) | BIT(16) | BIT(17),
 	.setup		= beagle_twl_gpio_setup,
+	.teardown	= beagle_twl_gpio_teardown,
 };
 
 /* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT3 (20 mA, plus card == max 220 mA) */
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index b736c4d..2fa7d06 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -388,12 +388,22 @@ static int omap3evm_twl_gpio_setup(struct device *dev,
 	return 0;
 }
 
+static int omap3evm_twl_gpio_teardown(struct device *dev,
+		unsigned gpio, unsigned ngpio)
+{
+	omap_hsmmc_deferred_del(mmc);
+	gpio_free(gpio + TWL4030_GPIO_MAX);
+	gpio_free(gpio + 7);
+	return 0;
+}
+
 static struct twl4030_gpio_platform_data omap3evm_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
 	.irq_base	= TWL4030_GPIO_IRQ_BASE,
 	.irq_end	= TWL4030_GPIO_IRQ_END,
 	.use_leds	= true,
 	.setup		= omap3evm_twl_gpio_setup,
+	.teardown	= omap3evm_twl_gpio_teardown,
 };
 
 static uint32_t board_keymap[] = {
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index d984048..828e58c 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -313,11 +313,20 @@ static int omap3pandora_twl_gpio_setup(struct device *dev,
 	return 0;
 }
 
+static int omap3pandora_twl_gpio_teardown(struct device *dev,
+		unsigned gpio, unsigned ngpio)
+{
+	omap_hsmmc_deferred_del(omap3pandora_mmc);
+	gpio_free(gpio + 13);
+	return 0;
+}
+
 static struct twl4030_gpio_platform_data omap3pandora_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
 	.irq_base	= TWL4030_GPIO_IRQ_BASE,
 	.irq_end	= TWL4030_GPIO_IRQ_END,
 	.setup		= omap3pandora_twl_gpio_setup,
+	.teardown	= omap3pandora_twl_gpio_teardown,
 };
 
 static struct regulator_consumer_supply pandora_vmmc1_supply[] = {
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index a2fb3e3..c6bab9a 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -306,12 +306,23 @@ omap3stalker_twl_gpio_setup(struct device *dev,
 	return 0;
 }
 
+static int
+omap3stalker_twl_gpio_teardown(struct device *dev,
+			    unsigned gpio, unsigned ngpio)
+{
+	omap_hsmmc_deferred_del(mmc);
+	gpio_free(gpio + TWL4030_GPIO_MAX);
+	gpio_free(gpio + 7);
+	return 0;
+}
+
 static struct twl4030_gpio_platform_data omap3stalker_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
 	.irq_base	= TWL4030_GPIO_IRQ_BASE,
 	.irq_end	= TWL4030_GPIO_IRQ_END,
 	.use_leds	= true,
 	.setup		= omap3stalker_twl_gpio_setup,
+	.teardown	= omap3stalker_twl_gpio_teardown,
 };
 
 static uint32_t board_keymap[] = {
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index b5ff46b..02c0a78 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -142,6 +142,15 @@ static int touchbook_twl_gpio_setup(struct device *dev,
 	return 0;
 }
 
+static int touchbook_twl_gpio_teardown(struct device *dev,
+		unsigned gpio, unsigned ngpio)
+{
+	omap_hsmmc_deferred_del(mmc);
+	gpio_free(gpio + 1);
+	gpio_free(gpio + TWL4030_GPIO_MAX);
+	return 0;
+}
+
 static struct twl4030_gpio_platform_data touchbook_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
 	.irq_base	= TWL4030_GPIO_IRQ_BASE,
@@ -151,6 +160,7 @@ static struct twl4030_gpio_platform_data touchbook_gpio_data = {
 	.pulldowns	= BIT(2) | BIT(6) | BIT(7) | BIT(8) | BIT(13)
 				| BIT(15) | BIT(16) | BIT(17),
 	.setup		= touchbook_twl_gpio_setup,
+	.teardown	= touchbook_twl_gpio_teardown,
 };
 
 static struct regulator_consumer_supply touchbook_vdac_supply[] = {
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 8b6065b..e1f496d 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -419,12 +419,20 @@ static int overo_twl_gpio_setup(struct device *dev,
 	return 0;
 }
 
+static int overo_twl_gpio_teardown(struct device *dev,
+		unsigned gpio, unsigned ngpio)
+{
+	omap_hsmmc_deferred_del(mmc);
+	return 0;
+}
+
 static struct twl4030_gpio_platform_data overo_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
 	.irq_base	= TWL4030_GPIO_IRQ_BASE,
 	.irq_end	= TWL4030_GPIO_IRQ_END,
 	.use_leds	= true,
 	.setup		= overo_twl_gpio_setup,
+	.teardown	= overo_twl_gpio_teardown,
 };
 
 static struct regulator_init_data overo_vmmc1 = {
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 0e9d89a..8aefbc0 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -702,6 +702,13 @@ static int rx51_twlgpio_setup(struct device *dev, unsigned gpio, unsigned n)
 	return 0;
 }
 
+static int rx51_twlgpio_teardown(struct device *dev, unsigned gpio, unsigned n)
+{
+	gpio_free(gpio + 6);
+	gpio_free(gpio + 7);
+	return 0;
+}
+
 static struct twl4030_gpio_platform_data rx51_gpio_data = {
 	.gpio_base		= OMAP_MAX_GPIO_LINES,
 	.irq_base		= TWL4030_GPIO_IRQ_BASE,
@@ -712,6 +719,7 @@ static struct twl4030_gpio_platform_data rx51_gpio_data = {
 				| BIT(12) | BIT(13) | BIT(14) | BIT(15)
 				| BIT(16) | BIT(17) ,
 	.setup			= rx51_twlgpio_setup,
+	.teardown		= rx51_twlgpio_teardown,
 };
 
 static struct twl4030_ins sleep_on_seq[] __initdata = {
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index f99284f..bd1c487 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -246,6 +246,14 @@ static int zoom_twl_gpio_setup(struct device *dev,
 	return ret;
 }
 
+static int zoom_twl_gpio_teardown(struct device *dev,
+		unsigned gpio, unsigned ngpio)
+{
+	omap_hsmmc_deferred_del(mmc);
+	gpio_free(LCD_PANEL_ENABLE_GPIO);
+	return 0;
+}
+
 /* EXTMUTE callback function */
 static void zoom2_set_hs_extmute(int mute)
 {
@@ -257,6 +265,7 @@ static struct twl4030_gpio_platform_data zoom_gpio_data = {
 	.irq_base	= TWL4030_GPIO_IRQ_BASE,
 	.irq_end	= TWL4030_GPIO_IRQ_END,
 	.setup		= zoom_twl_gpio_setup,
+	.teardown	= zoom_twl_gpio_teardown,
 };
 
 static struct twl4030_platform_data zoom_twldata = {
diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 51e3a2d..0f256ca 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -541,6 +541,17 @@ void omap_hsmmc_deferred_add(struct omap2_hsmmc_info *controllers)
 	}
 }
 
+void omap_hsmmc_deferred_del(struct omap2_hsmmc_info *controllers)
+{
+	struct platform_device *pdev;
+	for (; controllers->mmc; controllers++) {
+		if (!controllers->deferred)
+			continue;
+		pdev = controllers->pdev;
+		omap_device_unregister(pdev);
+	}
+}
+
 void omap_hsmmc_init(struct omap2_hsmmc_info *controllers)
 {
 	u32 reg;
diff --git a/arch/arm/mach-omap2/hsmmc.h b/arch/arm/mach-omap2/hsmmc.h
index 75d57fb..2c1c580 100644
--- a/arch/arm/mach-omap2/hsmmc.h
+++ b/arch/arm/mach-omap2/hsmmc.h
@@ -38,6 +38,7 @@ struct omap2_hsmmc_info {
 
 void omap_hsmmc_init(struct omap2_hsmmc_info *);
 void omap_hsmmc_deferred_add(struct omap2_hsmmc_info *);
+void omap_hsmmc_deferred_del(struct omap2_hsmmc_info *);
 
 #else
 
@@ -49,4 +50,7 @@ static inline void omap_hsmmc_deferred_add(struct omap2_hsmmc_info *info)
 {
 }
 
+static inline void omap_hsmmc_deferred_del(struct omap2_hsmmc_info *info)
+{
+}
 #endif
-- 
1.7.1


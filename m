From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 6/6] ARM: OMAP3: Use .teardown of twl4030-gpio to clean board requests
Date: Fri, 24 Feb 2012 15:28:57 +0530
Message-ID: <1330077537-19618-7-git-send-email-rnayak@ti.com>
References: <1330077537-19618-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60396 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756627Ab2BXJ7T (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Feb 2012 04:59:19 -0500
In-Reply-To: <1330077537-19618-1-git-send-email-rnayak@ti.com>
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
 arch/arm/mach-omap2/board-3430sdp.c          |   13 +++++++++++++
 arch/arm/mach-omap2/board-cm-t35.c           |   12 ++++++++++++
 arch/arm/mach-omap2/board-devkit8000.c       |   13 +++++++++++++
 arch/arm/mach-omap2/board-igep0020.c         |   15 +++++++++++++++
 arch/arm/mach-omap2/board-ldp.c              |   13 +++++++++++++
 arch/arm/mach-omap2/board-omap3beagle.c      |   15 +++++++++++++++
 arch/arm/mach-omap2/board-omap3evm.c         |   13 +++++++++++++
 arch/arm/mach-omap2/board-omap3pandora.c     |   11 +++++++++++
 arch/arm/mach-omap2/board-omap3stalker.c     |   14 ++++++++++++++
 arch/arm/mach-omap2/board-omap3touchbook.c   |   13 +++++++++++++
 arch/arm/mach-omap2/board-rx51-peripherals.c |   11 +++++++++++
 arch/arm/mach-omap2/board-zoom-peripherals.c |   10 ++++++++++
 12 files changed, 153 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 2eef653..e5afbdd 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -262,6 +262,18 @@ static int sdp3430_twl_gpio_setup(struct device *dev,
 	return 0;
 }
 
+static int sdp3430_twl_gpio_teardown(struct device *dev,
+		unsigned gpio, unsigned ngpio)
+{
+	omap_hsmmc_deferred_del(mmc);
+	/* gpio + 7 is "sub_lcd_en_bkl" (output/PWM1) */
+	gpio_free(gpio + 7);
+	/* gpio + 15 is "sub_lcd_nRST" (output) */
+	gpio_free(gpio + 15);
+
+	return 0;
+}
+
 static struct twl4030_gpio_platform_data sdp3430_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
 	.irq_base	= TWL4030_GPIO_IRQ_BASE,
@@ -269,6 +281,7 @@ static struct twl4030_gpio_platform_data sdp3430_gpio_data = {
 	.pulldowns	= BIT(2) | BIT(6) | BIT(8) | BIT(13)
 				| BIT(16) | BIT(17),
 	.setup		= sdp3430_twl_gpio_setup,
+	.teardown	= sdp3430_twl_gpio_teardown,
 };
 
 /* regulator consumer mappings */
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 28e7117..953824b 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -476,11 +476,23 @@ static int cm_t35_twl_gpio_setup(struct device *dev, unsigned gpio,
 	return 0;
 }
 
+static int cm_t35_twl_gpio_teardown(struct device *dev, unsigned gpio,
+				 unsigned ngpio)
+{
+	int wlan_rst = gpio + 2;
+
+	omap_hsmmc_deferred_del(mmc);
+	gpio_free(wlan_rst);
+
+	return 0;
+}
+
 static struct twl4030_gpio_platform_data cm_t35_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
 	.irq_base	= TWL4030_GPIO_IRQ_BASE,
 	.irq_end	= TWL4030_GPIO_IRQ_END,
 	.setup          = cm_t35_twl_gpio_setup,
+	.teardown	= cm_t35_twl_gpio_teardown,
 };
 
 static struct twl4030_platform_data cm_t35_twldata = {
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 373ba75..fe93cbc 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -255,6 +255,18 @@ static int devkit8000_twl_gpio_setup(struct device *dev,
 	return 0;
 }
 
+static int devkit8000_twl_gpio_teardown(struct device *dev,
+		unsigned gpio, unsigned ngpio)
+{
+	omap_hsmmc_deferred_del(mmc);
+	/* TWL4030_GPIO_MAX + 0 is "LCD_PWREN" (out, active high) */
+	gpio_free(gpio + TWL4030_GPIO_MAX + 0);
+	/* gpio + 7 is "DVI_PD" (out, active low) */
+	gpio_free(gpio + 7);
+
+	return 0;
+}
+
 static struct twl4030_gpio_platform_data devkit8000_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
 	.irq_base	= TWL4030_GPIO_IRQ_BASE,
@@ -263,6 +275,7 @@ static struct twl4030_gpio_platform_data devkit8000_gpio_data = {
 	.pulldowns	= BIT(1) | BIT(2) | BIT(6) | BIT(8) | BIT(13)
 				| BIT(15) | BIT(16) | BIT(17),
 	.setup		= devkit8000_twl_gpio_setup,
+	.teardown	= devkit8000_twl_gpio_teardown,
 };
 
 static struct regulator_consumer_supply devkit8000_vpll1_supplies[] = {
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index fb94fdc..5d47932 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -436,12 +436,27 @@ static int igep_twl_gpio_setup(struct device *dev,
 	return 0;
 };
 
+static int igep_twl_gpio_teardown(struct device *dev,
+		unsigned gpio, unsigned ngpio)
+{
+	omap_hsmmc_deferred_del(mmc);
+	/* TWL4030_GPIO_MAX + 1 == ledB (out, active low LED) */
+	gpio_free(gpio + TWL4030_GPIO_MAX + 1);
+	if (machine_is_igep0030())
+		return 0;
+
+	gpio_free_array(igep2_twl_gpios, ARRAY_SIZE(igep2_twl_gpios));
+
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
index b5bc9b2..b41add4 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -274,11 +274,24 @@ static int ldp_twl_gpio_setup(struct device *dev, unsigned gpio, unsigned ngpio)
 	return 0;
 }
 
+static int ldp_twl_gpio_teardown(struct device *dev, unsigned gpio,
+							 unsigned ngpio)
+{
+	struct gpio gpios[] = {
+		{gpio + 7 , GPIOF_OUT_INIT_LOW, "LCD ENABLE"},
+		{gpio + 15, GPIOF_OUT_INIT_LOW, "LCD BACKLIGHT"},
+	};
+	gpio_free_array(gpios, ARRAY_SIZE(gpios));
+
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
index 2ec7bae..cbfe87e 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -320,6 +320,20 @@ static int beagle_twl_gpio_setup(struct device *dev,
 	return 0;
 }
 
+static int beagle_twl_gpio_teardown(struct device *dev,
+		unsigned gpio, unsigned ngpio)
+{
+	omap_hsmmc_deferred_del(mmc);
+	/* gpio + 1 is used for differently on beagle and beagle-Xm boards */
+	gpio_free(gpio + 1);
+	if (cpu_is_omap3630())
+		/* gpio + 2 is used only on Xm */
+		gpio_free(gpio + 2);
+	gpio_free(gpio + TWL4030_GPIO_MAX);
+
+	return 0;
+}
+
 static struct twl4030_gpio_platform_data beagle_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
 	.irq_base	= TWL4030_GPIO_IRQ_BASE,
@@ -329,6 +343,7 @@ static struct twl4030_gpio_platform_data beagle_gpio_data = {
 	.pulldowns	= BIT(2) | BIT(6) | BIT(7) | BIT(8) | BIT(13)
 				| BIT(15) | BIT(16) | BIT(17),
 	.setup		= beagle_twl_gpio_setup,
+	.teardown	= beagle_twl_gpio_teardown,
 };
 
 /* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT3 (20 mA, plus card == max 220 mA) */
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 47a9159..ae7e921 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -388,12 +388,25 @@ static int omap3evm_twl_gpio_setup(struct device *dev,
 	return 0;
 }
 
+static int omap3evm_twl_gpio_teardown(struct device *dev,
+		unsigned gpio, unsigned ngpio)
+{
+	omap_hsmmc_deferred_del(mmc);
+	/* gpio + TWL4030_GPIO_MAX used for ledA, LCD Backlight control */
+	gpio_free(gpio + TWL4030_GPIO_MAX);
+	/* gpio + 7 used for DVI Enable */
+	gpio_free(gpio + 7);
+
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
index faea4c8..9637bbb 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -315,11 +315,22 @@ static int omap3pandora_twl_gpio_setup(struct device *dev,
 	return 0;
 }
 
+static int omap3pandora_twl_gpio_teardown(struct device *dev,
+		unsigned gpio, unsigned ngpio)
+{
+	omap_hsmmc_deferred_del(omap3pandora_mmc);
+	/* gpio + 13 drives 32kHz buffer for wifi module */
+	gpio_free(gpio + 13);
+
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
index 1cad225..5c73750 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -307,12 +307,26 @@ omap3stalker_twl_gpio_setup(struct device *dev,
 	return 0;
 }
 
+static int
+omap3stalker_twl_gpio_teardown(struct device *dev,
+			    unsigned gpio, unsigned ngpio)
+{
+	omap_hsmmc_deferred_del(mmc);
+	/* gpio + TWL4030_GPIO_MAX used for ledA, LCD Backlight control */
+	gpio_free(gpio + TWL4030_GPIO_MAX);
+	/* gpio + 7 used for DVI Enable */
+	gpio_free(gpio + 7);
+
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
index 932ac8e..d3752f2 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -137,6 +137,18 @@ static int touchbook_twl_gpio_setup(struct device *dev,
 	return 0;
 }
 
+static int touchbook_twl_gpio_teardown(struct device *dev,
+		unsigned gpio, unsigned ngpio)
+{
+	omap_hsmmc_deferred_del(mmc);
+	/* gpio + 1 used for EHCI_nOC */
+	gpio_free(gpio + 1);
+	/* gpio + TWL4030_GPIO_MAX used for ledA, EHCI nEN_USB_PWR */
+	gpio_free(gpio + TWL4030_GPIO_MAX);
+
+	return 0;
+}
+
 static struct twl4030_gpio_platform_data touchbook_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
 	.irq_base	= TWL4030_GPIO_IRQ_BASE,
@@ -146,6 +158,7 @@ static struct twl4030_gpio_platform_data touchbook_gpio_data = {
 	.pulldowns	= BIT(2) | BIT(6) | BIT(7) | BIT(8) | BIT(13)
 				| BIT(15) | BIT(16) | BIT(17),
 	.setup		= touchbook_twl_gpio_setup,
+	.teardown	= touchbook_twl_gpio_teardown,
 };
 
 static struct regulator_consumer_supply touchbook_vdac_supply[] = {
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 0e9d89a..e900d40 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -702,6 +702,16 @@ static int rx51_twlgpio_setup(struct device *dev, unsigned gpio, unsigned n)
 	return 0;
 }
 
+static int rx51_twlgpio_teardown(struct device *dev, unsigned gpio, unsigned n)
+{
+	/* gpio + 6 used for backlight_pwm */
+	gpio_free(gpio + 6);
+	/* gpio + 7 used for speaker_en */
+	gpio_free(gpio + 7);
+
+	return 0;
+}
+
 static struct twl4030_gpio_platform_data rx51_gpio_data = {
 	.gpio_base		= OMAP_MAX_GPIO_LINES,
 	.irq_base		= TWL4030_GPIO_IRQ_BASE,
@@ -712,6 +722,7 @@ static struct twl4030_gpio_platform_data rx51_gpio_data = {
 				| BIT(12) | BIT(13) | BIT(14) | BIT(15)
 				| BIT(16) | BIT(17) ,
 	.setup			= rx51_twlgpio_setup,
+	.teardown		= rx51_twlgpio_teardown,
 };
 
 static struct twl4030_ins sleep_on_seq[] __initdata = {
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index 1c200ee..a5fd25a 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -245,6 +245,15 @@ static int zoom_twl_gpio_setup(struct device *dev,
 	return ret;
 }
 
+static int zoom_twl_gpio_teardown(struct device *dev,
+		unsigned gpio, unsigned ngpio)
+{
+	omap_hsmmc_deferred_del(mmc);
+	gpio_free(LCD_PANEL_ENABLE_GPIO);
+
+	return 0;
+}
+
 /* EXTMUTE callback function */
 static void zoom2_set_hs_extmute(int mute)
 {
@@ -256,6 +265,7 @@ static struct twl4030_gpio_platform_data zoom_gpio_data = {
 	.irq_base	= TWL4030_GPIO_IRQ_BASE,
 	.irq_end	= TWL4030_GPIO_IRQ_END,
 	.setup		= zoom_twl_gpio_setup,
+	.teardown	= zoom_twl_gpio_teardown,
 };
 
 static struct twl4030_platform_data zoom_twldata = {
-- 
1.7.1


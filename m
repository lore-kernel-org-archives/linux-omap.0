From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 5/6] ARM: OMAP3: Modify omap_hsmmc_late_init to handle deleting mmc devices
Date: Fri, 24 Feb 2012 15:28:56 +0530
Message-ID: <1330077537-19618-6-git-send-email-rnayak@ti.com>
References: <1330077537-19618-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60393 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750792Ab2BXJ7P (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Feb 2012 04:59:15 -0500
In-Reply-To: <1330077537-19618-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

omap_hsmmc_late_init() adds deferred (if any) mmc devices which are
dependent on twl4030-gpio device to be available.
If twl4030-gpio is built as a module and inserted and deleted multiple
times, the mmc devices also should be added and deleted accordingly.
Split omap_hsmmc_late_init() into omap_hsmmc_deferred_add() and
omap_hsmmc_deferred_del() to handle this.
The .setup board hook for twl4030-gpio handles the runtime adding
on deferred mmc devices. Similarly a .teardown board hook for twl4030-gpio
should handle the runtime deletion by calling omap_hsmmc_deferred_del().
This is done for all existing omap3 boards in subsequent patches.

Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c          |    2 +-
 arch/arm/mach-omap2/board-cm-t35.c           |    2 +-
 arch/arm/mach-omap2/board-devkit8000.c       |    2 +-
 arch/arm/mach-omap2/board-igep0020.c         |    2 +-
 arch/arm/mach-omap2/board-omap3beagle.c      |    2 +-
 arch/arm/mach-omap2/board-omap3evm.c         |    2 +-
 arch/arm/mach-omap2/board-omap3pandora.c     |    2 +-
 arch/arm/mach-omap2/board-omap3stalker.c     |    2 +-
 arch/arm/mach-omap2/board-omap3touchbook.c   |    2 +-
 arch/arm/mach-omap2/board-zoom-peripherals.c |    2 +-
 arch/arm/mach-omap2/hsmmc.c                  |   93 ++++++++++++--------------
 arch/arm/mach-omap2/hsmmc.h                  |    9 ++-
 12 files changed, 61 insertions(+), 61 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index da75f23..2eef653 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -251,7 +251,7 @@ static int sdp3430_twl_gpio_setup(struct device *dev,
 	 */
 	mmc[0].gpio_cd = gpio + 0;
 	mmc[1].gpio_cd = gpio + 1;
-	omap_hsmmc_late_init(mmc);
+	omap_hsmmc_deferred_add(mmc);
 
 	/* gpio + 7 is "sub_lcd_en_bkl" (output/PWM1) */
 	gpio_request_one(gpio + 7, GPIOF_OUT_INIT_LOW, "sub_lcd_en_bkl");
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 49e6405..28e7117 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -471,7 +471,7 @@ static int cm_t35_twl_gpio_setup(struct device *dev, unsigned gpio,
 
 	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
 	mmc[0].gpio_cd = gpio + 0;
-	omap_hsmmc_late_init(mmc);
+	omap_hsmmc_deferred_add(mmc);
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 11cd2a8..373ba75 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -229,7 +229,7 @@ static int devkit8000_twl_gpio_setup(struct device *dev,
 
 	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
 	mmc[0].gpio_cd = gpio + 0;
-	omap_hsmmc_late_init(mmc);
+	omap_hsmmc_deferred_add(mmc);
 
 	/* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
 	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index e558800..fb94fdc 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -403,7 +403,7 @@ static int igep_twl_gpio_setup(struct device *dev,
 
 	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
 	mmc[0].gpio_cd = gpio + 0;
-	omap_hsmmc_late_init(mmc);
+	omap_hsmmc_deferred_add(mmc);
 
 	/* TWL4030_GPIO_MAX + 1 == ledB (out, active low LED) */
 #if !defined(CONFIG_LEDS_GPIO) && !defined(CONFIG_LEDS_GPIO_MODULE)
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 7be8d65..2ec7bae 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -276,7 +276,7 @@ static int beagle_twl_gpio_setup(struct device *dev,
 	mmc[0].gpio_wp = beagle_config.mmc1_gpio_wp;
 	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
 	mmc[0].gpio_cd = gpio + 0;
-	omap_hsmmc_late_init(mmc);
+	omap_hsmmc_deferred_add(mmc);
 
 	/*
 	 * TWL4030_GPIO_MAX + 0 == ledA, EHCI nEN_USB_PWR (out, XM active
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 6b77ad9..47a9159 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -363,7 +363,7 @@ static int omap3evm_twl_gpio_setup(struct device *dev,
 
 	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
 	mmc[0].gpio_cd = gpio + 0;
-	omap_hsmmc_late_init(mmc);
+	omap_hsmmc_deferred_add(mmc);
 
 	/*
 	 * Most GPIOs are for USB OTG.  Some are mostly sent to
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index ace466b..faea4c8 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -302,7 +302,7 @@ static int omap3pandora_twl_gpio_setup(struct device *dev,
 	/* gpio + {0,1} is "mmc{0,1}_cd" (input/IRQ) */
 	omap3pandora_mmc[0].gpio_cd = gpio + 0;
 	omap3pandora_mmc[1].gpio_cd = gpio + 1;
-	omap_hsmmc_late_init(omap3pandora_mmc);
+	omap_hsmmc_deferred_add(omap3pandora_mmc);
 
 	/* gpio + 13 drives 32kHz buffer for wifi module */
 	gpio_32khz = gpio + 13;
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index 6410043..1cad225 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -284,7 +284,7 @@ omap3stalker_twl_gpio_setup(struct device *dev,
 {
 	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
 	mmc[0].gpio_cd = gpio + 0;
-	omap_hsmmc_late_init(mmc);
+	omap_hsmmc_deferred_add(mmc);
 
 	/*
 	 * Most GPIOs are for USB OTG.  Some are mostly sent to
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 8842e04..932ac8e 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -120,7 +120,7 @@ static int touchbook_twl_gpio_setup(struct device *dev,
 {
 	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
 	mmc[0].gpio_cd = gpio + 0;
-	omap_hsmmc_late_init(mmc);
+	omap_hsmmc_deferred_add(mmc);
 
 	/* REVISIT: need ehci-omap hooks for external VBUS
 	 * power switch and overcurrent detect
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index 3d39cdb..1c200ee 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -234,7 +234,7 @@ static int zoom_twl_gpio_setup(struct device *dev,
 
 	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
 	mmc[0].gpio_cd = gpio + 0;
-	omap_hsmmc_late_init(mmc);
+	omap_hsmmc_deferred_add(mmc);
 
 	ret = gpio_request_one(LCD_PANEL_ENABLE_GPIO, GPIOF_OUT_INIT_LOW,
 			       "lcd enable");
diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index a97876d..bd47f5c 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -43,6 +43,9 @@ static int hsmmc_get_context_loss(struct device *dev)
 #define hsmmc_get_context_loss NULL
 #endif
 
+static void omap_hsmmc_init_one(struct omap2_hsmmc_info *hsmmcinfo,
+					int ctrl_nr, int deferred);
+
 static void omap_hsmmc1_before_set_reg(struct device *dev, int slot,
 				  int power_on, int vdd)
 {
@@ -428,45 +431,24 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 	return 0;
 }
 
-static int omap_hsmmc_done;
-
-void omap_hsmmc_late_init(struct omap2_hsmmc_info *c)
+void omap_hsmmc_deferred_add(struct omap2_hsmmc_info *c)
 {
-	struct platform_device *pdev;
-	struct omap_mmc_platform_data *mmc_pdata;
-	int res;
-
-	if (omap_hsmmc_done != 1)
-		return;
-
-	omap_hsmmc_done++;
-
-	for (; c->mmc; c++) {
-		if (!c->deferred)
-			continue;
-
-		pdev = c->pdev;
-		if (!pdev)
-			continue;
-
-		mmc_pdata = pdev->dev.platform_data;
-		if (!mmc_pdata)
-			continue;
-
-		mmc_pdata->slots[0].switch_pin = c->gpio_cd;
-		mmc_pdata->slots[0].gpio_wp = c->gpio_wp;
+	for (; c->mmc; c++)
+		if (c->deferred)
+			omap_hsmmc_init_one(c, c->mmc, 0);
+}
 
-		res = omap_device_register(pdev);
-		if (res)
-			pr_err("Could not late init MMC %s\n",
-			       c->name);
-	}
+void omap_hsmmc_deferred_del(struct omap2_hsmmc_info *c)
+{
+	for (; c->mmc; c++)
+		if (c->deferred)
+			omap_device_unregister(c->pdev);
 }
 
 #define MAX_OMAP_MMC_HWMOD_NAME_LEN		16
 
 static void omap_hsmmc_init_one(struct omap2_hsmmc_info *hsmmcinfo,
-					int ctrl_nr)
+					int ctrl_nr, int deferred)
 {
 	struct omap_hwmod *oh;
 	struct omap_hwmod *ohs[1];
@@ -478,18 +460,38 @@ static void omap_hsmmc_init_one(struct omap2_hsmmc_info *hsmmcinfo,
 	char *name;
 	int res;
 
-	mmc_data = kzalloc(sizeof(struct omap_mmc_platform_data), GFP_KERNEL);
-	if (!mmc_data) {
-		pr_err("Cannot allocate memory for mmc device!\n");
-		return;
+	if (!hsmmcinfo->mmc_data) {
+		mmc_data = kzalloc(sizeof(*mmc_data), GFP_KERNEL);
+		if (!mmc_data) {
+			pr_err("Cannot allocate memory for mmc device!\n");
+			return;
+		}
+
+		res = omap_hsmmc_pdata_init(hsmmcinfo, mmc_data);
+		if (res < 0)
+			goto free_mmc;
+
+		omap_hsmmc_mux(mmc_data, (ctrl_nr - 1));
+		hsmmcinfo->mmc_data = kmemdup(mmc_data, sizeof(*mmc_data),
+								 GFP_KERNEL);
+		if (!hsmmcinfo->mmc_data) {
+			pr_err("Cannot allocate memory for mmc device!\n");
+			goto free_mmc;
+		}
+	} else	{
+		mmc_data = kmemdup(hsmmcinfo->mmc_data, sizeof(*mmc_data),
+								 GFP_KERNEL);
+		if (!mmc_data) {
+			pr_err("Cannot allocate memory for mmc device!\n");
+			return;
+		}
+		mmc_data->slots[0].switch_pin = hsmmcinfo->gpio_cd;
+		mmc_data->slots[0].gpio_wp = hsmmcinfo->gpio_wp;
 	}
 
-	res = omap_hsmmc_pdata_init(hsmmcinfo, mmc_data);
-	if (res < 0)
+	if (deferred)
 		goto free_mmc;
 
-	omap_hsmmc_mux(mmc_data, (ctrl_nr - 1));
-
 	name = "omap_hsmmc";
 	res = snprintf(oh_name, MAX_OMAP_MMC_HWMOD_NAME_LEN,
 		     "mmc%d", ctrl_nr);
@@ -529,9 +531,6 @@ static void omap_hsmmc_init_one(struct omap2_hsmmc_info *hsmmcinfo,
 
 	hsmmcinfo->pdev = pdev;
 
-	if (hsmmcinfo->deferred)
-		goto free_mmc;
-
 	res = omap_device_register(pdev);
 	if (res) {
 		pr_err("Could not register od for %s\n", name);
@@ -557,11 +556,6 @@ void __init omap_hsmmc_init(struct omap2_hsmmc_info *controllers)
 {
 	u32 reg;
 
-	if (omap_hsmmc_done)
-		return;
-
-	omap_hsmmc_done = 1;
-
 	if (!cpu_is_omap44xx()) {
 		if (cpu_is_omap2430()) {
 			control_pbias_offset = OMAP243X_CONTROL_PBIAS_LITE;
@@ -586,7 +580,8 @@ void __init omap_hsmmc_init(struct omap2_hsmmc_info *controllers)
 	}
 
 	for (; controllers->mmc; controllers++)
-		omap_hsmmc_init_one(controllers, controllers->mmc);
+		omap_hsmmc_init_one(controllers, controllers->mmc,
+						 controllers->deferred);
 
 }
 
diff --git a/arch/arm/mach-omap2/hsmmc.h b/arch/arm/mach-omap2/hsmmc.h
index 07831cc..2c1c580 100644
--- a/arch/arm/mach-omap2/hsmmc.h
+++ b/arch/arm/mach-omap2/hsmmc.h
@@ -31,12 +31,14 @@ struct omap2_hsmmc_info {
 	void (*remux)(struct device *dev, int slot, int power_on);
 	/* init some special card */
 	void (*init_card)(struct mmc_card *card);
+	struct omap_mmc_platform_data *mmc_data;
 };
 
 #if defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
 
 void omap_hsmmc_init(struct omap2_hsmmc_info *);
-void omap_hsmmc_late_init(struct omap2_hsmmc_info *);
+void omap_hsmmc_deferred_add(struct omap2_hsmmc_info *);
+void omap_hsmmc_deferred_del(struct omap2_hsmmc_info *);
 
 #else
 
@@ -44,8 +46,11 @@ static inline void omap_hsmmc_init(struct omap2_hsmmc_info *info)
 {
 }
 
-static inline void omap_hsmmc_late_init(struct omap2_hsmmc_info *info)
+static inline void omap_hsmmc_deferred_add(struct omap2_hsmmc_info *info)
 {
 }
 
+static inline void omap_hsmmc_deferred_del(struct omap2_hsmmc_info *info)
+{
+}
 #endif
-- 
1.7.1


From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 7/7] ARM: OMAP2+: Mark omap_hsmmc_init and omap_mux related functions as __init
Date: Thu, 23 Feb 2012 17:10:47 +0530
Message-ID: <1329997247-27342-8-git-send-email-rnayak@ti.com>
References: <1329997247-27342-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35345 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753656Ab2BWLlK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Feb 2012 06:41:10 -0500
In-Reply-To: <1329997247-27342-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <rmk+kernel@arm.linux.org.uk>, Rajendra Nayak <rnayak@ti.com>

From: Tony Lindgren <tony@atomide.com>

Now that omap hsmmc init is split into two functions, it's safe
to mark omap_hsmmc_init and omap_mux related functions to __init.

This basically reverts the following fixes for the case where
TWL was compiled as a module:

a98f77b (ARM: omap: fix section mismatch warning for sdp3430_twl_gpio_setup())
8930b4e (ARM: omap: fix section mismatch warnings in mux.c caused by hsmmc.c)

Additionally it fixes up the remaining section warnings for
all callers of omap_mux functions.

Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/board-flash.c          |    2 +-
 arch/arm/mach-omap2/board-omap3beagle.c    |    6 ++++--
 arch/arm/mach-omap2/board-omap3evm.c       |    3 ++-
 arch/arm/mach-omap2/board-omap3stalker.c   |    3 ++-
 arch/arm/mach-omap2/board-omap3touchbook.c |   13 +++++++------
 arch/arm/mach-omap2/board-omap4panda.c     |    2 +-
 arch/arm/mach-omap2/display.c              |    8 ++++----
 arch/arm/mach-omap2/hsmmc.c                |    4 ++--
 arch/arm/mach-omap2/mux.c                  |   14 +++++++-------
 9 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-omap2/board-flash.c b/arch/arm/mach-omap2/board-flash.c
index 30a6f52..0349fd2 100644
--- a/arch/arm/mach-omap2/board-flash.c
+++ b/arch/arm/mach-omap2/board-flash.c
@@ -189,7 +189,7 @@ unmap:
  *
  * @return - void.
  */
-void board_flash_init(struct flash_partitions partition_info[],
+void __init board_flash_init(struct flash_partitions partition_info[],
 			char chip_sel_board[][GPMC_CS_NUM], int nand_type)
 {
 	u8		cs = 0;
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 08749a5..916167e 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -274,8 +274,6 @@ static int beagle_twl_gpio_setup(struct device *dev,
 {
 	int r;
 
-	if (beagle_config.mmc1_gpio_wp != -EINVAL)
-		omap_mux_init_gpio(beagle_config.mmc1_gpio_wp, OMAP_PIN_INPUT);
 	mmc[0].gpio_wp = beagle_config.mmc1_gpio_wp;
 	omap_hsmmc_deferred_add(mmc);
 
@@ -533,7 +531,11 @@ static void __init omap3_beagle_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap3_beagle_init_rev();
+
+	if (beagle_config.mmc1_gpio_wp != -EINVAL)
+		omap_mux_init_gpio(beagle_config.mmc1_gpio_wp, OMAP_PIN_INPUT);
 	omap_hsmmc_init(mmc);
+
 	omap3_beagle_i2c_init();
 
 	gpio_buttons[0].gpio = beagle_config.usr_button_gpio;
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 2fa7d06..47336c2 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -362,7 +362,6 @@ static int omap3evm_twl_gpio_setup(struct device *dev,
 {
 	int r, lcd_bl_en;
 
-	omap_mux_init_gpio(63, OMAP_PIN_INPUT);
 	omap_hsmmc_deferred_add(mmc);
 
 	/*
@@ -654,7 +653,9 @@ static void __init omap3_evm_init(void)
 	omap_board_config = omap3_evm_config;
 	omap_board_config_size = ARRAY_SIZE(omap3_evm_config);
 
+	omap_mux_init_gpio(63, OMAP_PIN_INPUT);
 	omap_hsmmc_init(mmc);
+
 	omap3_evm_i2c_init();
 
 	omap_display_init(&omap3_evm_dss_data);
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index c6bab9a..b11700d 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -282,7 +282,6 @@ static int
 omap3stalker_twl_gpio_setup(struct device *dev,
 			    unsigned gpio, unsigned ngpio)
 {
-	omap_mux_init_gpio(23, OMAP_PIN_INPUT);
 	omap_hsmmc_deferred_add(mmc);
 
 	/*
@@ -435,7 +434,9 @@ static void __init omap3_stalker_init(void)
 	omap_board_config = omap3_stalker_config;
 	omap_board_config_size = ARRAY_SIZE(omap3_stalker_config);
 
+	omap_mux_init_gpio(23, OMAP_PIN_INPUT);
 	omap_hsmmc_init(mmc);
+
 	omap3_stalker_i2c_init();
 
 	platform_add_devices(omap3_stalker_devices,
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 02c0a78..a66e592 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -119,12 +119,6 @@ static struct gpio_led gpio_leds[];
 static int touchbook_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
-	if (system_rev >= 0x20 && system_rev <= 0x34301000) {
-		omap_mux_init_gpio(23, OMAP_PIN_INPUT);
-		mmc[0].gpio_wp = 23;
-	} else {
-		omap_mux_init_gpio(29, OMAP_PIN_INPUT);
-	}
 	omap_hsmmc_deferred_add(mmc);
 
 	/* REVISIT: need ehci-omap hooks for external VBUS
@@ -361,7 +355,14 @@ static void __init omap3_touchbook_init(void)
 
 	pm_power_off = omap3_touchbook_poweroff;
 
+	if (system_rev >= 0x20 && system_rev <= 0x34301000) {
+		omap_mux_init_gpio(23, OMAP_PIN_INPUT);
+		mmc[0].gpio_wp = 23;
+	} else {
+		omap_mux_init_gpio(29, OMAP_PIN_INPUT);
+	}
 	omap_hsmmc_init(mmc);
+
 	omap3_touchbook_i2c_init();
 	platform_add_devices(omap3_touchbook_devices,
 			ARRAY_SIZE(omap3_touchbook_devices));
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index bcc563c..7ca7a5c 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -461,7 +461,7 @@ static struct omap_dss_board_info omap4_panda_dss_data = {
 	.default_device	= &omap4_panda_dvi_device,
 };
 
-void omap4_panda_display_init(void)
+void __init omap4_panda_display_init(void)
 {
 	int r;
 
diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 3677b1f..62e133c 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -124,7 +124,7 @@ static void omap4_hdmi_mux_pads(enum omap_hdmi_flags flags)
 	}
 }
 
-static int omap4_dsi_mux_pads(int dsi_id, unsigned lanes)
+static int __init omap4_dsi_mux_pads(int dsi_id, unsigned lanes)
 {
 	u32 enable_mask, enable_shift;
 	u32 pipd_mask, pipd_shift;
@@ -157,7 +157,7 @@ static int omap4_dsi_mux_pads(int dsi_id, unsigned lanes)
 	return 0;
 }
 
-int omap_hdmi_init(enum omap_hdmi_flags flags)
+int __init omap_hdmi_init(enum omap_hdmi_flags flags)
 {
 	if (cpu_is_omap44xx())
 		omap4_hdmi_mux_pads(flags);
@@ -165,7 +165,7 @@ int omap_hdmi_init(enum omap_hdmi_flags flags)
 	return 0;
 }
 
-static int omap_dsi_enable_pads(int dsi_id, unsigned lane_mask)
+static int __init omap_dsi_enable_pads(int dsi_id, unsigned lane_mask)
 {
 	if (cpu_is_omap44xx())
 		return omap4_dsi_mux_pads(dsi_id, lane_mask);
@@ -173,7 +173,7 @@ static int omap_dsi_enable_pads(int dsi_id, unsigned lane_mask)
 	return 0;
 }
 
-static void omap_dsi_disable_pads(int dsi_id, unsigned lane_mask)
+static void __init omap_dsi_disable_pads(int dsi_id, unsigned lane_mask)
 {
 	if (cpu_is_omap44xx())
 		omap4_dsi_mux_pads(dsi_id, 0);
diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 0f256ca..b30dbb8 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -293,7 +293,7 @@ static inline void omap_hsmmc_mux(struct omap_mmc_platform_data *mmc_controller,
 	}
 }
 
-static int omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
+static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 				 struct omap_mmc_platform_data *mmc)
 {
 	char *hc_name;
@@ -552,7 +552,7 @@ void omap_hsmmc_deferred_del(struct omap2_hsmmc_info *controllers)
 	}
 }
 
-void omap_hsmmc_init(struct omap2_hsmmc_info *controllers)
+void __init omap_hsmmc_init(struct omap2_hsmmc_info *controllers)
 {
 	u32 reg;
 
diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index fb8bc9f..f26b2fa 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -100,8 +100,8 @@ void omap_mux_write_array(struct omap_mux_partition *partition,
 
 static char *omap_mux_options;
 
-static int _omap_mux_init_gpio(struct omap_mux_partition *partition,
-			       int gpio, int val)
+static int __init _omap_mux_init_gpio(struct omap_mux_partition *partition,
+				      int gpio, int val)
 {
 	struct omap_mux_entry *e;
 	struct omap_mux *gpio_mux = NULL;
@@ -145,7 +145,7 @@ static int _omap_mux_init_gpio(struct omap_mux_partition *partition,
 	return 0;
 }
 
-int omap_mux_init_gpio(int gpio, int val)
+int __init omap_mux_init_gpio(int gpio, int val)
 {
 	struct omap_mux_partition *partition;
 	int ret;
@@ -159,9 +159,9 @@ int omap_mux_init_gpio(int gpio, int val)
 	return -ENODEV;
 }
 
-static int _omap_mux_get_by_name(struct omap_mux_partition *partition,
-				 const char *muxname,
-				 struct omap_mux **found_mux)
+static int __init _omap_mux_get_by_name(struct omap_mux_partition *partition,
+					const char *muxname,
+					struct omap_mux **found_mux)
 {
 	struct omap_mux *mux = NULL;
 	struct omap_mux_entry *e;
@@ -240,7 +240,7 @@ omap_mux_get_by_name(const char *muxname,
 	return -ENODEV;
 }
 
-int omap_mux_init_signal(const char *muxname, int val)
+int __init omap_mux_init_signal(const char *muxname, int val)
 {
 	struct omap_mux_partition *partition = NULL;
 	struct omap_mux *mux = NULL;
-- 
1.7.1


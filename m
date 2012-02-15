From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/3] ARM: OMAP2+: Mark omap_hsmmc_init and omap_mux related
 functions as __init
Date: Wed, 15 Feb 2012 10:28:30 -0800
Message-ID: <20120215182829.18884.69168.stgit@kaulin.local>
References: <20120215182355.18884.18682.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:57311 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752628Ab2BOS2c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Feb 2012 13:28:32 -0500
In-Reply-To: <20120215182355.18884.18682.stgit@kaulin.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, linux-omap@vger.kernel.org

Now that omap hsmmc init is split into two functions, it's safe
to mark omap_hsmmc_init and omap_mux related functions to __init.

This basically reverts the following fixes for the case where
TWL was compiled as a module:

e3958f (ARM: omap: fix section mismatch error for omap_4430sdp_display_init())
27d8d3 (ARM: omap: fix section mismatch warning in mux.c)
d5de63 (ARM: omap: preemptively fix section mismatch in omap4_sdp4430_wifi_mux_init())
e3958f (ARM: omap: fix section mismatch error for omap_4430sdp_display_init())
a98f77 (ARM: omap: fix section mismatch warning for sdp3430_twl_gpio_setup())
8930b4 (ARM: omap: fix section mismatch warnings in mux.c caused by hsmmc.c)

Additionally it fixes up the remaining section warnings for
all callers of omap_mux functions.

Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-4430sdp.c        |    2 +-
 arch/arm/mach-omap2/board-flash.c          |    2 +-
 arch/arm/mach-omap2/board-omap3beagle.c    |    6 ++++--
 arch/arm/mach-omap2/board-omap3evm.c       |    3 ++-
 arch/arm/mach-omap2/board-omap3stalker.c   |    3 ++-
 arch/arm/mach-omap2/board-omap3touchbook.c |   13 +++++++------
 arch/arm/mach-omap2/board-omap4panda.c     |    2 +-
 arch/arm/mach-omap2/display.c              |    8 ++++----
 arch/arm/mach-omap2/hsmmc.c                |    6 +++---
 arch/arm/mach-omap2/mux.c                  |   22 +++++++++++-----------
 10 files changed, 36 insertions(+), 31 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 09ae257..ece9e3a 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -851,7 +851,7 @@ static struct omap_board_mux board_mux[] __initdata = {
 #define board_mux	NULL
  #endif
 
-static void __init omap4_sdp4430_wifi_mux_init(void)
+static void omap4_sdp4430_wifi_mux_init(void)
 {
 	omap_mux_init_gpio(GPIO_WIFI_IRQ, OMAP_PIN_INPUT |
 				OMAP_PIN_OFF_WAKEUPENABLE);
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
index 78bfcd5..7be8d65 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -273,8 +273,6 @@ static int beagle_twl_gpio_setup(struct device *dev,
 {
 	int r;
 
-	if (beagle_config.mmc1_gpio_wp != -EINVAL)
-		omap_mux_init_gpio(beagle_config.mmc1_gpio_wp, OMAP_PIN_INPUT);
 	mmc[0].gpio_wp = beagle_config.mmc1_gpio_wp;
 	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
 	mmc[0].gpio_cd = gpio + 0;
@@ -522,7 +520,11 @@ static void __init omap3_beagle_init(void)
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
index db0aa27..0f9a983 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -363,7 +363,6 @@ static int omap3evm_twl_gpio_setup(struct device *dev,
 	int r, lcd_bl_en;
 
 	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
-	omap_mux_init_gpio(63, OMAP_PIN_INPUT);
 	mmc[0].gpio_cd = gpio + 0;
 	omap_hsmmc_late_init(mmc);
 
@@ -646,7 +645,9 @@ static void __init omap3_evm_init(void)
 	omap_board_config = omap3_evm_config;
 	omap_board_config_size = ARRAY_SIZE(omap3_evm_config);
 
+	omap_mux_init_gpio(63, OMAP_PIN_INPUT);
 	omap_hsmmc_init(mmc);
+
 	omap3_evm_i2c_init();
 
 	omap_display_init(&omap3_evm_dss_data);
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index 8eee993..6410043 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -283,7 +283,6 @@ omap3stalker_twl_gpio_setup(struct device *dev,
 			    unsigned gpio, unsigned ngpio)
 {
 	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
-	omap_mux_init_gpio(23, OMAP_PIN_INPUT);
 	mmc[0].gpio_cd = gpio + 0;
 	omap_hsmmc_late_init(mmc);
 
@@ -426,7 +425,9 @@ static void __init omap3_stalker_init(void)
 	omap_board_config = omap3_stalker_config;
 	omap_board_config_size = ARRAY_SIZE(omap3_stalker_config);
 
+	omap_mux_init_gpio(23, OMAP_PIN_INPUT);
 	omap_hsmmc_init(mmc);
+
 	omap3_stalker_i2c_init();
 
 	platform_add_devices(omap3_stalker_devices,
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index ba9c118..8842e04 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -118,12 +118,6 @@ static struct gpio_led gpio_leds[];
 static int touchbook_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
-	if (system_rev >= 0x20 && system_rev <= 0x34301000) {
-		omap_mux_init_gpio(23, OMAP_PIN_INPUT);
-		mmc[0].gpio_wp = 23;
-	} else {
-		omap_mux_init_gpio(29, OMAP_PIN_INPUT);
-	}
 	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
 	mmc[0].gpio_cd = gpio + 0;
 	omap_hsmmc_late_init(mmc);
@@ -352,7 +346,14 @@ static void __init omap3_touchbook_init(void)
 
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
index 0f774e5..59c3ee4 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -293,8 +293,8 @@ static inline void omap_hsmmc_mux(struct omap_mmc_platform_data *mmc_controller,
 	}
 }
 
-static int omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
-				 struct omap_mmc_platform_data *mmc)
+static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
+					struct omap_mmc_platform_data *mmc)
 {
 	char *hc_name;
 
@@ -540,7 +540,7 @@ free_mmc:
 	kfree(mmc_data);
 }
 
-void omap_hsmmc_init(struct omap2_hsmmc_info *controllers)
+void __init omap_hsmmc_init(struct omap2_hsmmc_info *controllers)
 {
 	u32 reg;
 
diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index fb8bc9f..e1cc75d 100644
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
@@ -1094,8 +1094,8 @@ static void omap_mux_init_package(struct omap_mux *superset,
 		omap_mux_package_init_balls(package_balls, superset);
 }
 
-static void __init omap_mux_init_signals(struct omap_mux_partition *partition,
-					 struct omap_board_mux *board_mux)
+static void omap_mux_init_signals(struct omap_mux_partition *partition,
+				  struct omap_board_mux *board_mux)
 {
 	omap_mux_set_cmdline_signals();
 	omap_mux_write_array(partition, board_mux);
@@ -1109,8 +1109,8 @@ static void omap_mux_init_package(struct omap_mux *superset,
 {
 }
 
-static void __init omap_mux_init_signals(struct omap_mux_partition *partition,
-					 struct omap_board_mux *board_mux)
+static void omap_mux_init_signals(struct omap_mux_partition *partition,
+				  struct omap_board_mux *board_mux)
 {
 }
 


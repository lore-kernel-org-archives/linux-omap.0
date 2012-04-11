From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v4 01/12] ARM: OMAP2+: declare file-local functions as static
Date: Tue, 10 Apr 2012 18:35:21 -0600
Message-ID: <20120411003516.27059.99477.stgit@dusk>
References: <20120411003454.27059.37500.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43911 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759885Ab2DKAiT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Apr 2012 20:38:19 -0400
In-Reply-To: <20120411003454.27059.37500.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Govindraj R <govindraj.raja@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, David Anders <x0132446@ti.com>

Several function declarations used only in the files in which they're
declared should include the static keyboard, but don't:

    arch/arm/mach-omap2/serial.c:248:6: warning: symbol 'cmdline_find_option' was not declared. Should it be static?
    arch/arm/mach-omap2/omap-wakeupgen.c:259:6: warning: symbol 'irq_sar_clear' was not declared. Should it be static?
    arch/arm/mach-omap2/board-rx51-peripherals.c:878:27: warning: symbol 'rx51_vibra_data' was not declared. Should it be static?
    arch/arm/mach-omap2/board-rx51-peripherals.c:882:27: warning: symbol 'rx51_audio_data' was not declared. Should it be static?
    arch/arm/mach-omap2/board-omap4panda.c:201:29: warning: symbol 'omap_panda_wlan_data' was not declared. Should it be static?
    arch/arm/mach-omap2/board-omap4panda.c:393:24: warning: symbol 'omap4_panda_dvi_device' was not declared. Should it be static?
    arch/arm/mach-omap2/board-omap4panda.c:403:12: warning: symbol 'omap4_panda_dvi_init' was not declared. Should it be static?
    arch/arm/mach-omap2/board-omap4panda.c:464:6: warning: symbol 'omap4_panda_display_init' was not declared. Should it be static?
    arch/arm/mach-omap2/hsmmc.c:434:6: warning: symbol 'omap_init_hsmmc' was not declared. Should it be static?
    arch/arm/mach-omap2/hwspinlock.c:31:12: warning: symbol 'hwspinlocks_init' was not declared. Should it be static?
    arch/arm/mach-omap1/timer.c:58:12: warning: symbol 'omap1_dm_timer_init' was not declared. Should it be static?
    arch/arm/mach-omap1/fpga.c:90:6: warning: symbol 'innovator_fpga_IRQ_demux' was not declared. Should it be static?

Mark all of these as static.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Govindraj R <govindraj.raja@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: David Anders <x0132446@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap1/fpga.c                   |    2 +-
 arch/arm/mach-omap1/timer.c                  |    3 +--
 arch/arm/mach-omap2/board-omap4panda.c       |    8 ++++----
 arch/arm/mach-omap2/board-rx51-peripherals.c |    4 ++--
 arch/arm/mach-omap2/hwspinlock.c             |    2 +-
 arch/arm/mach-omap2/omap-wakeupgen.c         |    2 +-
 arch/arm/mach-omap2/serial.c                 |    2 +-
 7 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap1/fpga.c b/arch/arm/mach-omap1/fpga.c
index 76c67b3..29ec50f 100644
--- a/arch/arm/mach-omap1/fpga.c
+++ b/arch/arm/mach-omap1/fpga.c
@@ -87,7 +87,7 @@ static void fpga_mask_ack_irq(struct irq_data *d)
 	fpga_ack_irq(d);
 }
 
-void innovator_fpga_IRQ_demux(unsigned int irq, struct irq_desc *desc)
+static void innovator_fpga_IRQ_demux(unsigned int irq, struct irq_desc *desc)
 {
 	u32 stat;
 	int fpga_irq;
diff --git a/arch/arm/mach-omap1/timer.c b/arch/arm/mach-omap1/timer.c
index 6e90665..5536e04 100644
--- a/arch/arm/mach-omap1/timer.c
+++ b/arch/arm/mach-omap1/timer.c
@@ -54,8 +54,7 @@ static int omap1_dm_timer_set_src(struct platform_device *pdev,
 	return 0;
 }
 
-
-int __init omap1_dm_timer_init(void)
+static int __init omap1_dm_timer_init(void)
 {
 	int i;
 	int ret;
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index d8c0e89..f864065 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -230,7 +230,7 @@ static struct platform_device omap_vwlan_device = {
 	},
 };
 
-struct wl12xx_platform_data omap_panda_wlan_data  __initdata = {
+static struct wl12xx_platform_data omap_panda_wlan_data  __initdata = {
 	/* PANDA ref clock is 38.4 MHz */
 	.board_ref_clock = 2,
 };
@@ -439,7 +439,7 @@ static struct panel_dvi_platform_data omap4_dvi_panel = {
 	.i2c_bus_num = 3,
 };
 
-struct omap_dss_device omap4_panda_dvi_device = {
+static struct omap_dss_device omap4_panda_dvi_device = {
 	.type			= OMAP_DISPLAY_TYPE_DPI,
 	.name			= "dvi",
 	.driver_name		= "dvi",
@@ -449,7 +449,7 @@ struct omap_dss_device omap4_panda_dvi_device = {
 	.channel		= OMAP_DSS_CHANNEL_LCD2,
 };
 
-int __init omap4_panda_dvi_init(void)
+static int __init omap4_panda_dvi_init(void)
 {
 	int r;
 
@@ -510,7 +510,7 @@ static struct omap_dss_board_info omap4_panda_dss_data = {
 	.default_device	= &omap4_panda_dvi_device,
 };
 
-void __init omap4_panda_display_init(void)
+static void __init omap4_panda_display_init(void)
 {
 	int r;
 
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index d87ee06..ae957c9 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -872,11 +872,11 @@ static struct twl4030_power_data rx51_t2scripts_data __initdata = {
 	.resource_config = twl4030_rconfig,
 };
 
-struct twl4030_vibra_data rx51_vibra_data __initdata = {
+static struct twl4030_vibra_data rx51_vibra_data __initdata = {
 	.coexist	= 0,
 };
 
-struct twl4030_audio_data rx51_audio_data __initdata = {
+static struct twl4030_audio_data rx51_audio_data __initdata = {
 	.audio_mclk	= 26000000,
 	.vibra		= &rx51_vibra_data,
 };
diff --git a/arch/arm/mach-omap2/hwspinlock.c b/arch/arm/mach-omap2/hwspinlock.c
index 454dfce..8763c85 100644
--- a/arch/arm/mach-omap2/hwspinlock.c
+++ b/arch/arm/mach-omap2/hwspinlock.c
@@ -28,7 +28,7 @@ static struct hwspinlock_pdata omap_hwspinlock_pdata __initdata = {
 	.base_id = 0,
 };
 
-int __init hwspinlocks_init(void)
+static int __init hwspinlocks_init(void)
 {
 	int retval = 0;
 	struct omap_hwmod *oh;
diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
index 42cd7fb..d811c77 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -259,7 +259,7 @@ static void irq_save_context(void)
 /*
  * Clear WakeupGen SAR backup status.
  */
-void irq_sar_clear(void)
+static void irq_sar_clear(void)
 {
 	u32 val;
 	val = __raw_readl(sar_base + SAR_BACKUP_STATUS_OFFSET);
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 0cdd359..8d22e29d 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -243,7 +243,7 @@ static void omap_serial_fill_default_pads(struct omap_board_data *bdata)
 static void omap_serial_fill_default_pads(struct omap_board_data *bdata) {}
 #endif
 
-char *cmdline_find_option(char *str)
+static char *cmdline_find_option(char *str)
 {
 	extern char *saved_command_line;
 



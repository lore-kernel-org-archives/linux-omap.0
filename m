From: Bryan Wu <bryan.wu@canonical.com>
Subject: [PATCH 3/3] OMAP: use dummy panel driver in board files
Date: Tue,  2 Nov 2010 12:13:10 -0400
Message-ID: <1288714390-6159-4-git-send-email-bryan.wu@canonical.com>
References: <1288714390-6159-1-git-send-email-bryan.wu@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1288714390-6159-1-git-send-email-bryan.wu@canonical.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tomi.valkeinen@nokia.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Introduce some fields in struct panel, which will be used to match the right
panel configurations in dummy driver.

Still keep sharp_ls_panel, since the sharp_ls_panel driver contains blacklight
control driver code which will be moved out later. Then we can use dummy driver
for sharp_ls_panel.

Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
---
 arch/arm/mach-omap2/board-3430sdp.c       |    3 ++-
 arch/arm/mach-omap2/board-am3517evm.c     |    6 ++++--
 arch/arm/mach-omap2/board-cm-t35.c        |    6 ++++--
 arch/arm/mach-omap2/board-devkit8000.c    |    6 ++++--
 arch/arm/mach-omap2/board-igep0020.c      |    3 ++-
 arch/arm/mach-omap2/board-omap3beagle.c   |    3 ++-
 arch/arm/mach-omap2/board-omap3evm.c      |    3 ++-
 arch/arm/mach-omap2/board-omap3stalker.c  |    6 ++++--
 arch/arm/plat-omap/include/plat/display.h |   28 +++++++++++++++++++---------
 9 files changed, 43 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 4e3742c..0e4598d 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -272,7 +272,8 @@ static struct omap_dss_device sdp3430_lcd_device = {
 
 static struct omap_dss_device sdp3430_dvi_device = {
 	.name			= "dvi",
-	.driver_name		= "generic_panel",
+	.driver_name		= "dummy_panel",
+	.panel.name		= "generic",
 	.type			= OMAP_DISPLAY_TYPE_DPI,
 	.phy.dpi.data_lines	= 24,
 	.platform_enable	= sdp3430_panel_enable_dvi,
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 0739950..88c9b76 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -306,7 +306,8 @@ static void am3517_evm_panel_disable_lcd(struct omap_dss_device *dssdev)
 static struct omap_dss_device am3517_evm_lcd_device = {
 	.type			= OMAP_DISPLAY_TYPE_DPI,
 	.name			= "lcd",
-	.driver_name		= "sharp_lq_panel",
+	.driver_name		= "dummy_panel",
+	.panel.name		= "sharp_lq",
 	.phy.dpi.data_lines 	= 16,
 	.platform_enable	= am3517_evm_panel_enable_lcd,
 	.platform_disable	= am3517_evm_panel_disable_lcd,
@@ -349,7 +350,8 @@ static void am3517_evm_panel_disable_dvi(struct omap_dss_device *dssdev)
 static struct omap_dss_device am3517_evm_dvi_device = {
 	.type			= OMAP_DISPLAY_TYPE_DPI,
 	.name			= "dvi",
-	.driver_name		= "generic_panel",
+	.driver_name		= "dummy_panel",
+	.panel.name		= "generic",
 	.phy.dpi.data_lines	= 24,
 	.platform_enable	= am3517_evm_panel_enable_dvi,
 	.platform_disable	= am3517_evm_panel_disable_dvi,
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 63f764e..a0c555d 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -353,7 +353,8 @@ static void cm_t35_panel_disable_tv(struct omap_dss_device *dssdev)
 
 static struct omap_dss_device cm_t35_lcd_device = {
 	.name			= "lcd",
-	.driver_name		= "toppoly_tdo35s_panel",
+	.driver_name		= "dummy_panel",
+	.panel.name		= "toppoly_tdo35s",
 	.type			= OMAP_DISPLAY_TYPE_DPI,
 	.phy.dpi.data_lines	= 18,
 	.platform_enable	= cm_t35_panel_enable_lcd,
@@ -362,7 +363,8 @@ static struct omap_dss_device cm_t35_lcd_device = {
 
 static struct omap_dss_device cm_t35_dvi_device = {
 	.name			= "dvi",
-	.driver_name		= "generic_panel",
+	.driver_name		= "dummy_panel",
+	.panel.name		= "generic",
 	.type			= OMAP_DISPLAY_TYPE_DPI,
 	.phy.dpi.data_lines	= 24,
 	.platform_enable	= cm_t35_panel_enable_dvi,
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 067f437..ce5be9c 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -151,7 +151,8 @@ static struct regulator_consumer_supply devkit8000_vio_supply =
 
 static struct omap_dss_device devkit8000_lcd_device = {
 	.name                   = "lcd",
-	.driver_name            = "generic_panel",
+	.driver_name		= "dummy_panel",
+	.panel.name		= "generic",
 	.type                   = OMAP_DISPLAY_TYPE_DPI,
 	.phy.dpi.data_lines     = 24,
 	.reset_gpio             = -EINVAL, /* will be replaced */
@@ -160,7 +161,8 @@ static struct omap_dss_device devkit8000_lcd_device = {
 };
 static struct omap_dss_device devkit8000_dvi_device = {
 	.name                   = "dvi",
-	.driver_name            = "generic_panel",
+	.driver_name		= "dummy_panel",
+	.panel.name		= "generic",
 	.type                   = OMAP_DISPLAY_TYPE_DPI,
 	.phy.dpi.data_lines     = 24,
 	.reset_gpio             = -EINVAL, /* will be replaced */
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 5e035a5..f9a3d03 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -436,7 +436,8 @@ static void igep2_disable_dvi(struct omap_dss_device *dssdev)
 static struct omap_dss_device igep2_dvi_device = {
 	.type			= OMAP_DISPLAY_TYPE_DPI,
 	.name			= "dvi",
-	.driver_name		= "generic_panel",
+	.driver_name		= "dummy_panel",
+	.panel.name		= "generic",
 	.phy.dpi.data_lines	= 24,
 	.platform_enable	= igep2_enable_dvi,
 	.platform_disable	= igep2_disable_dvi,
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 14f4224..11592bf 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -197,7 +197,8 @@ static void beagle_disable_dvi(struct omap_dss_device *dssdev)
 static struct omap_dss_device beagle_dvi_device = {
 	.type = OMAP_DISPLAY_TYPE_DPI,
 	.name = "dvi",
-	.driver_name = "generic_panel",
+	.driver_name = "dummy_panel",
+	.panel.name = "generic",
 	.phy.dpi.data_lines = 24,
 	.reset_gpio = 170,
 	.platform_enable = beagle_enable_dvi,
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index b04365c..b7ff779 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -303,7 +303,8 @@ static void omap3_evm_disable_dvi(struct omap_dss_device *dssdev)
 
 static struct omap_dss_device omap3_evm_dvi_device = {
 	.name			= "dvi",
-	.driver_name		= "generic_panel",
+	.driver_name		= "dummy_panel",
+	.panel.name		= "generic",
 	.type			= OMAP_DISPLAY_TYPE_DPI,
 	.phy.dpi.data_lines	= 24,
 	.platform_enable	= omap3_evm_enable_dvi,
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index f252721..19a8fd8 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -162,7 +162,8 @@ static void omap3_stalker_disable_lcd(struct omap_dss_device *dssdev)
 
 static struct omap_dss_device omap3_stalker_lcd_device = {
 	.name			= "lcd",
-	.driver_name		= "generic_panel",
+	.driver_name		= "dummy_panel",
+	.panel.name		= "generic",
 	.phy.dpi.data_lines	= 24,
 	.type			= OMAP_DISPLAY_TYPE_DPI,
 	.platform_enable	= omap3_stalker_enable_lcd,
@@ -210,7 +211,8 @@ static void omap3_stalker_disable_dvi(struct omap_dss_device *dssdev)
 
 static struct omap_dss_device omap3_stalker_dvi_device = {
 	.name			= "dvi",
-	.driver_name		= "generic_panel",
+	.driver_name		= "dummy_panel",
+	.panel.name		= "generic",
 	.type			= OMAP_DISPLAY_TYPE_DPI,
 	.phy.dpi.data_lines	= 24,
 	.platform_enable	= omap3_stalker_enable_dvi,
diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index c915a66..a49c458 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -346,6 +346,24 @@ struct omap_overlay_manager {
 	int (*disable)(struct omap_overlay_manager *mgr);
 };
 
+struct omap_display_panel {
+	struct omap_video_timings timings;
+
+	int acbi;	/* ac-bias pin transitions per interrupt */
+	/* Unit: line clocks */
+	int acb;	/* ac-bias pin frequency */
+
+	enum omap_panel_config config;
+
+	int power_on_delay;
+	int power_off_delay;
+	/*
+	 * Used to match device to panel configuration
+	 * when use dummy panel driver
+	 */
+	const char *name;
+};
+
 struct omap_dss_device {
 	struct device dev;
 
@@ -395,15 +413,7 @@ struct omap_dss_device {
 		} venc;
 	} phy;
 
-	struct {
-		struct omap_video_timings timings;
-
-		int acbi;	/* ac-bias pin transitions per interrupt */
-		/* Unit: line clocks */
-		int acb;	/* ac-bias pin frequency */
-
-		enum omap_panel_config config;
-	} panel;
+	struct omap_display_panel panel;
 
 	struct {
 		u8 pixel_size;
-- 
1.7.1

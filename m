From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/5] ARM: OMAP2+: Add DT init code for DPI displays and make
 omap3 LDP to use it
Date: Fri, 15 Nov 2013 16:36:05 -0800
Message-ID: <1384562167-14725-4-git-send-email-tony@atomide.com>
References: <1384562167-14725-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1384562167-14725-1-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
List-Id: linux-omap@vger.kernel.org

In order to make the remaining omap3 boards usable with device
tree, we need to initialize the DPI based displays using pdata
until we have the DSS bindings in place.

At least board-am3517evm.c, board-cm-t35.c, board-devkit8000.c,
board-ldp.c and board-overo.c all use fairly similar DPI setup,
so let's add generic code for it. And let's make omap3 LDP to
use it and also initialize the ads7846 until we have a binding
for it.

Note that at least LDP needs the TWL bug fix posted as
"gpio: twl4030: Fix regression for twl gpio output" for the
LCD backlight to power.

Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/dss-common.c   | 67 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/dss-common.h   |  1 +
 arch/arm/mach-omap2/pdata-quirks.c | 15 +++++++++
 3 files changed, 83 insertions(+)

diff --git a/arch/arm/mach-omap2/dss-common.c b/arch/arm/mach-omap2/dss-common.c
index 365bfd3..86e98c5 100644
--- a/arch/arm/mach-omap2/dss-common.c
+++ b/arch/arm/mach-omap2/dss-common.c
@@ -257,3 +257,70 @@ void __init omap3_igep2_display_init_of(void)
 	platform_device_register(&omap3_igep2_tfp410_device);
 	platform_device_register(&omap3_igep2_dvi_connector_device);
 }
+
+/* Systems with DPI LCD */
+
+static struct panel_dpi_platform_data dpi_lcd = {
+	.name                   = "lcd",
+	.source                 = "dpi.0",
+	.enable_gpio		= -1,
+	.backlight_gpio		= -1,
+};
+
+static struct platform_device dpi_lcd_device = {
+	.name                   = "panel-dpi",
+	.id                     = 0,
+	.dev.platform_data      = &dpi_lcd,
+};
+
+static struct omap_dss_board_info dpi_dss_data = {
+	.default_display_name = "lcd",
+};
+
+static void dpi_display_init(void)
+{
+	platform_device_register(&dpi_lcd_device);
+	omap_display_init(&dpi_dss_data);
+}
+
+/* DPI on omap3 LDP */
+
+static const struct display_timing ldp_lcd_videomode = {
+	.pixelclock	= { 0, 5400000, 0 },
+
+	.hactive = { 0, 240, 0 },
+	.hfront_porch = { 0, 3, 0 },
+	.hback_porch = { 0, 39, 0 },
+	.hsync_len = { 0, 3, 0 },
+
+	.vactive = { 0, 320, 0 },
+	.vfront_porch = { 0, 2, 0 },
+	.vback_porch = { 0, 7, 0 },
+	.vsync_len = { 0, 1, 0 },
+
+	.flags = DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_LOW |
+		DISPLAY_FLAGS_DE_HIGH | DISPLAY_FLAGS_PIXDATA_POSEDGE,
+};
+
+void __init omap3_ldp_display_init_of(int gpio_bl, int gpio_en)
+{
+	int r;
+
+	static struct gpio gpios[] = {
+		{ 55, GPIOF_OUT_INIT_HIGH, "LCD RESET" },
+		{ 56, GPIOF_OUT_INIT_HIGH, "LCD QVGA" },
+	};
+
+	r = gpio_request_array(gpios, ARRAY_SIZE(gpios));
+	if (r) {
+		pr_err("Cannot request LCD GPIOs, error %d\n", r);
+		return;
+	}
+
+	dpi_lcd.data_lines = 18;
+	dpi_lcd.display_timing = &ldp_lcd_videomode;
+	dpi_lcd.enable_gpio = gpio_en;
+	dpi_lcd.backlight_gpio = gpio_bl;
+
+	dpi_display_init();
+}
diff --git a/arch/arm/mach-omap2/dss-common.h b/arch/arm/mach-omap2/dss-common.h
index a9becf0..bc9921c 100644
--- a/arch/arm/mach-omap2/dss-common.h
+++ b/arch/arm/mach-omap2/dss-common.h
@@ -9,5 +9,6 @@
 void __init omap4_panda_display_init_of(void);
 void __init omap_4430sdp_display_init_of(void);
 void __init omap3_igep2_display_init_of(void);
+void omap3_ldp_display_init_of(int gpio_bl, int gpio_en);
 
 #endif
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index f2fc072..97f200f 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -100,6 +100,20 @@ static void __init omap3_evm_legacy_init(void)
 	legacy_init_wl12xx(WL12XX_REFCLOCK_38, 0, 149);
 }
 
+/* Pass enable and backlight GPIO to DSS code */
+int __init ldp_twl_gpio_setup(struct device *dev, unsigned gpio, unsigned ngpio)
+{
+	omap3_ldp_display_init_of(gpio + 7, gpio + 15);
+	omap_ads7846_init(1, 54, 310, NULL);
+
+	return 0;
+}
+
+static void __init omap3_ldp_legacy_init(void)
+{
+	twl_gpio_auxdata.setup = ldp_twl_gpio_setup;
+}
+
 static void __init omap3_zoom_legacy_init(void)
 {
 	legacy_init_wl12xx(WL12XX_REFCLOCK_26, 0, 162);
@@ -190,6 +204,7 @@ static struct pdata_init pdata_quirks[] __initdata = {
 	{ "nokia,omap3-n950", hsmmc2_internal_input_clk, },
 	{ "isee,omap3-igep0020", omap3_igep0020_legacy_init, },
 	{ "ti,omap3-evm-37xx", omap3_evm_legacy_init, },
+	{ "ti,omap3-ldp", omap3_ldp_legacy_init, },
 	{ "ti,omap3-zoom3", omap3_zoom_legacy_init, },
 #endif
 #ifdef CONFIG_ARCH_OMAP4
-- 
1.8.1.1

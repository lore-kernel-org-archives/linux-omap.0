From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] ARM: OMAP3EVM: Marking omap3_evm_display_init() with
 CONFIG_BROKEN
Date: Mon, 22 Jul 2013 05:29:35 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1307220523380.4804@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: stable@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, rnayak@ti.com, lokeshvutla@ti.com
List-Id: linux-omap@vger.kernel.org

From: Lokesh Vutla <lokeshvutla@ti.com>

On 37xx EVM non-dt boot fails with current mainline,
because of broken GPIO numbering in the board file
that uses hardcoded GPIOs.

So marking omap3_evm_display_init() with CONFIG_BROKEN
for now as suggested by Tony as per the below link:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg90399.html

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Tested-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

---

Hi -stablers,

OMAP37xx EVM does not boot on v3.10 without this patch, so please consider 
it for the v3.10 stable releases.  It is upstream already as commit ID 
8fb61e8d84e673eebf31e564a83bb71a50b1ed48.  Perhaps if I had managed to 
test it sooner, we could have gotten it up during v3.10-rc, but, alas, 
stable it is...

 arch/arm/mach-omap2/board-omap3evm.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index f76d0de..278bf25 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -174,6 +174,7 @@ static struct panel_sharp_ls037v7dw01_data omap3_evm_lcd_data = {
 	.ud_gpio = OMAP3EVM_LCD_PANEL_UD,
 };
 
+#ifdef CONFIG_BROKEN
 static void __init omap3_evm_display_init(void)
 {
 	int r;
@@ -193,6 +194,7 @@ static void __init omap3_evm_display_init(void)
 	else
 		gpio_set_value_cansleep(OMAP3EVM_LCD_PANEL_BKLIGHT_GPIO, 1);
 }
+#endif
 
 static struct omap_dss_device omap3_evm_lcd_device = {
 	.name			= "lcd",
@@ -715,7 +717,9 @@ static void __init omap3_evm_init(void)
 
 	omap_ads7846_init(1, OMAP3_EVM_TS_GPIO, 310, NULL);
 	omap3evm_init_smsc911x();
+#ifdef CONFIG_BROKEN
 	omap3_evm_display_init();
+#endif
 	omap3_evm_wl12xx_init();
 	omap_twl4030_audio_init("omap3evm", NULL);
 }
-- 
1.7.9.5


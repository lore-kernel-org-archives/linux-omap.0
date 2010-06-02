From: Thomas Weber <weber@corscience.de>
Subject: [PATCHv2 08/11] OMAP2: Devkit8000: Using the REGULATOR_SUPPLY macro
Date: Wed,  2 Jun 2010 13:37:48 +0200
Message-ID: <1275478671-24563-9-git-send-email-weber@corscience.de>
References: <1275478671-24563-1-git-send-email-weber@corscience.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1275478671-24563-1-git-send-email-weber@corscience.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Thomas Weber <weber@corscience.de>, Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Replacing supplies with the REGULATOR_SUPPLY macro.

Signed-off-by: Thomas Weber <weber@corscience.de>
---
 arch/arm/mach-omap2/board-devkit8000.c |   33 ++++++++++++-------------------
 1 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 095dc7a..3da88c8 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -158,14 +158,13 @@ static void devkit8000_panel_disable_dvi(struct omap_dss_device *dssdev)
 		gpio_set_value(dssdev->reset_gpio, 0);
 }
 
-static struct regulator_consumer_supply devkit8000_vmmc1_supply = {
-	.supply			= "vmmc",
-};
+static struct regulator_consumer_supply devkit8000_vmmc1_supply =
+	REGULATOR_SUPPLY("vmmc", "mmci-omap-hs.0");
+
 
 /* ads7846 on SPI */
-static struct regulator_consumer_supply devkit8000_vio_supplies[] = {
-	REGULATOR_SUPPLY("vcc", "spi2.0")
-};
+static struct regulator_consumer_supply devkit8000_vio_supply =
+	REGULATOR_SUPPLY("vcc", "spi2.0");
 
 static struct omap_dss_device devkit8000_lcd_device = {
 	.name                   = "lcd",
@@ -214,10 +213,8 @@ static struct platform_device devkit8000_dss_device = {
 	},
 };
 
-static struct regulator_consumer_supply devkit8000_vdda_dac_supply = {
-	.supply = "vdda_dac",
-	.dev	= &devkit8000_dss_device.dev,
-};
+static struct regulator_consumer_supply devkit8000_vdda_dac_supply =
+	REGULATOR_SUPPLY("vdda_dac", "omapdss");
 
 static int board_keymap[] = {
 	KEY(0, 0, KEY_1),
@@ -294,12 +291,8 @@ static struct twl4030_gpio_platform_data devkit8000_gpio_data = {
 	.setup		= devkit8000_twl_gpio_setup,
 };
 
-static struct regulator_consumer_supply devkit8000_vpll1_supplies[] = {
-	{
-	.supply		= "vdds_dsi",
-	.dev		= &devkit8000_dss_device.dev,
-	}
-};
+static struct regulator_consumer_supply devkit8000_vpll1_supply =
+	REGULATOR_SUPPLY("vdds_dsi", "omapdss");
 
 /* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT3 (20 mA, plus card == max 220 mA) */
 static struct regulator_init_data devkit8000_vmmc1 = {
@@ -340,8 +333,8 @@ static struct regulator_init_data devkit8000_vpll1 = {
 		.valid_ops_mask		= REGULATOR_CHANGE_MODE
 					| REGULATOR_CHANGE_STATUS,
 	},
-	.num_consumer_supplies	= ARRAY_SIZE(devkit8000_vpll1_supplies),
-	.consumer_supplies	= devkit8000_vpll1_supplies,
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &devkit8000_vpll1_supply,
 };
 
 /* VAUX4 for ads7846 and nubs */
@@ -355,8 +348,8 @@ static struct regulator_init_data devkit8000_vio = {
 		.valid_ops_mask         = REGULATOR_CHANGE_MODE
 			| REGULATOR_CHANGE_STATUS,
 	},
-	.num_consumer_supplies  = ARRAY_SIZE(devkit8000_vio_supplies),
-	.consumer_supplies      = devkit8000_vio_supplies,
+	.num_consumer_supplies  = 1,
+	.consumer_supplies      = &devkit8000_vio_supply,
 };
 
 static struct twl4030_usb_data devkit8000_usb_data = {
-- 
1.7.1

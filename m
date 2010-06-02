From: Thomas Weber <weber@corscience.de>
Subject: [PATCHv2 06/11] OMAP2: Devkit8000: Remove non existing vsim supply
Date: Wed,  2 Jun 2010 13:37:46 +0200
Message-ID: <1275478671-24563-7-git-send-email-weber@corscience.de>
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

The Devkit8000 uses the cost reduced variant tps65930 of the twl4030.
The TPS65930 only has vdd1, vdd2, vpll1, vio, vmmc1, vdac and vaux2.

vaux2 is not used on Devkit8000.

Signed-off-by: Thomas Weber <weber@corscience.de>
---
 arch/arm/mach-omap2/board-devkit8000.c |   22 ----------------------
 1 files changed, 0 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 8cc8c3b..59877b1 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -168,15 +168,10 @@ static void devkit8000_panel_disable_tv(struct omap_dss_device *dssdev)
 {
 }
 
-
 static struct regulator_consumer_supply devkit8000_vmmc1_supply = {
 	.supply			= "vmmc",
 };
 
-static struct regulator_consumer_supply devkit8000_vsim_supply = {
-	.supply			= "vmmc_aux",
-};
-
 /* ads7846 on SPI */
 static struct regulator_consumer_supply devkit8000_vio_supplies[] = {
 	REGULATOR_SUPPLY("vcc", "spi2.0")
@@ -281,7 +276,6 @@ static int devkit8000_twl_gpio_setup(struct device *dev,
 
 	/* link regulators to MMC adapters */
 	devkit8000_vmmc1_supply.dev = mmc[0].dev;
-	devkit8000_vsim_supply.dev = mmc[0].dev;
 
 	/* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
 	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
@@ -334,21 +328,6 @@ static struct regulator_init_data devkit8000_vmmc1 = {
 	.consumer_supplies	= &devkit8000_vmmc1_supply,
 };
 
-/* VSIM for MMC1 pins DAT4..DAT7 (2 mA, plus card == max 50 mA) */
-static struct regulator_init_data devkit8000_vsim = {
-	.constraints = {
-		.min_uV			= 1800000,
-		.max_uV			= 3000000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-	},
-	.num_consumer_supplies	= 1,
-	.consumer_supplies	= &devkit8000_vsim_supply,
-};
-
 /* VDAC for DSS driving S-Video (8 mA unloaded, max 65 mA) */
 static struct regulator_init_data devkit8000_vdac = {
 	.constraints = {
@@ -414,7 +393,6 @@ static struct twl4030_platform_data devkit8000_twldata = {
 	.gpio		= &devkit8000_gpio_data,
 	.codec		= &devkit8000_codec_data,
 	.vmmc1		= &devkit8000_vmmc1,
-	.vsim		= &devkit8000_vsim,
 	.vdac		= &devkit8000_vdac,
 	.vpll1		= &devkit8000_vpll1,
 	.vio		= &devkit8000_vio,
-- 
1.7.1

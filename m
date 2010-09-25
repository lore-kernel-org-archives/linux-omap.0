From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCH 6/6] omap3: Remove VMMC2 regulator on IGEP v2 because it's not
	used.
Date: Sat, 25 Sep 2010 20:19:06 +0200
Message-ID: <1285438746-7311-7-git-send-email-eballetbo@gmail.com>
References: <1285438746-7311-1-git-send-email-eballetbo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1285438746-7311-1-git-send-email-eballetbo@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
---
 arch/arm/mach-omap2/board-igep0020.c |   26 +++-----------------------
 1 files changed, 3 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index c5eaa43..fa450b1 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -260,10 +260,6 @@ static struct regulator_consumer_supply igep2_vmmc1_supply = {
 	.supply		= "vmmc",
 };
 
-static struct regulator_consumer_supply igep2_vmmc2_supply = {
-	.supply		= "vmmc",
-};
-
 /* VMMC1 for OMAP VDD_MMC1 (i/o) and MMC1 card */
 static struct regulator_init_data igep2_vmmc1 = {
 	.constraints = {
@@ -279,21 +275,6 @@ static struct regulator_init_data igep2_vmmc1 = {
 	.consumer_supplies      = &igep2_vmmc1_supply,
 };
 
-/* VMMC2 for OMAP VDD_MMC2 (i/o) and MMC2 WIFI */
-static struct regulator_init_data igep2_vmmc2 = {
-	.constraints = {
-		.min_uV			= 1850000,
-		.max_uV			= 3150000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-	},
-	.num_consumer_supplies  = 1,
-	.consumer_supplies      = &igep2_vmmc2_supply,
-};
-
 static struct omap2_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
@@ -390,11 +371,11 @@ static int igep2_twl_gpio_setup(struct device *dev,
 	mmc[0].gpio_cd = gpio + 0;
 	omap2_hsmmc_init(mmc);
 
-	/* link regulators to MMC adapters ... we "know" the
+	/*
+	 * link regulators to MMC adapters ... we "know" the
 	 * regulators will be set up only *after* we return.
-	*/
+	 */
 	igep2_vmmc1_supply.dev = mmc[0].dev;
-	igep2_vmmc2_supply.dev = mmc[1].dev;
 
 	/*
 	 * REVISIT: need ehci-omap hooks for external VBUS
@@ -534,7 +515,6 @@ static struct twl4030_platform_data igep2_twldata = {
 	.codec		= &igep2_codec_data,
 	.gpio		= &igep2_twl4030_gpio_pdata,
 	.vmmc1          = &igep2_vmmc1,
-	.vmmc2		= &igep2_vmmc2,
 	.vpll2		= &igep2_vpll2,
 
 };
-- 
1.7.0.4

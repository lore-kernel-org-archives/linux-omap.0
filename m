From: Marc Zyngier <maz@misterjones.org>
Subject: [PATCH] Fix IGEPv2 second MMC channel power supply
Date: Sun, 14 Nov 2010 11:34:12 +0000
Message-ID: <1289734452-31625-1-git-send-email-maz@misterjones.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
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
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Commit 72f381ba056 removed an unused regulator entry, but left
the second MMC channel (used by the Libertas WLAN mudule) without
link to power regulator. This causes the SDIO module to fail being
detected.

This patch adds a second supply to the existing MMC1 regulator,
and let MMC2 hang off it. With that patch, the second channel is
properly detected.

Tested on an IGEPv2 Rev-B.

Signed-off-by: Marc Zyngier <maz@misterjones.org>
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>
---
Note that this doesn't fix WLAN itself on 2.6.37-rc1...

 arch/arm/mach-omap2/board-igep0020.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 5e035a5..b66d114 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -257,8 +257,9 @@ static inline void __init igep2_init_smsc911x(void) { }
 static struct omap_board_config_kernel igep2_config[] __initdata = {
 };
 
-static struct regulator_consumer_supply igep2_vmmc1_supply = {
-	.supply		= "vmmc",
+static struct regulator_consumer_supply igep2_vmmc1_supplies[] = {
+	[0] = { .supply		= "vmmc", },
+	[1] = { .supply		= "vmmc", },
 };
 
 /* VMMC1 for OMAP VDD_MMC1 (i/o) and MMC1 card */
@@ -272,8 +273,8 @@ static struct regulator_init_data igep2_vmmc1 = {
 					| REGULATOR_CHANGE_MODE
 					| REGULATOR_CHANGE_STATUS,
 	},
-	.num_consumer_supplies  = 1,
-	.consumer_supplies      = &igep2_vmmc1_supply,
+	.num_consumer_supplies  = 2,
+	.consumer_supplies      = igep2_vmmc1_supplies,
 };
 
 static struct omap2_hsmmc_info mmc[] = {
@@ -376,7 +377,8 @@ static int igep2_twl_gpio_setup(struct device *dev,
 	 * link regulators to MMC adapters ... we "know" the
 	 * regulators will be set up only *after* we return.
 	 */
-	igep2_vmmc1_supply.dev = mmc[0].dev;
+	igep2_vmmc1_supplies[0].dev = mmc[0].dev;
+	igep2_vmmc1_supplies[1].dev = mmc[1].dev;
 
 	/*
 	 * REVISIT: need ehci-omap hooks for external VBUS
-- 
1.7.3.2

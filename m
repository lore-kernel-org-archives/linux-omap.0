From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 07/28] omap: Fix n8x0 mmc_mmc_init compile warnings and typos
Date: Fri, 23 Apr 2010 16:11:20 -0700
Message-ID: <20100423231120.31953.45582.stgit@baageli.muru.com>
References: <20100423230829.31953.17334.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56703 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754896Ab0DWXLT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Apr 2010 19:11:19 -0400
In-Reply-To: <20100423230829.31953.17334.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Fix warning: 'return' with a value, in function returning void
in n8x0_mmc_init. Also fix a search and replace typo.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-n8x0.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index da9bcb8..3ccc34e 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -216,7 +216,7 @@ static void __init n8x0_onenand_init(void) {}
  */
 #define N8X0_SLOT_SWITCH_GPIO	96
 #define N810_EMMC_VSD_GPIO	23
-#define NN810_EMMC_VIO_GPIO	9
+#define N810_EMMC_VIO_GPIO	9
 
 static int n8x0_mmc_switch_slot(struct device *dev, int slot)
 {
@@ -304,10 +304,10 @@ static void n810_set_power_emmc(struct device *dev,
 	if (power_on) {
 		gpio_set_value(N810_EMMC_VSD_GPIO, 1);
 		msleep(1);
-		gpio_set_value(NN810_EMMC_VIO_GPIO, 1);
+		gpio_set_value(N810_EMMC_VIO_GPIO, 1);
 		msleep(1);
 	} else {
-		gpio_set_value(NN810_EMMC_VIO_GPIO, 0);
+		gpio_set_value(N810_EMMC_VIO_GPIO, 0);
 		msleep(50);
 		gpio_set_value(N810_EMMC_VSD_GPIO, 0);
 		msleep(50);
@@ -468,7 +468,7 @@ static void n8x0_mmc_cleanup(struct device *dev)
 
 	if (machine_is_nokia_n810()) {
 		gpio_free(N810_EMMC_VSD_GPIO);
-		gpio_free(NN810_EMMC_VIO_GPIO);
+		gpio_free(N810_EMMC_VIO_GPIO);
 	}
 }
 
@@ -529,7 +529,7 @@ void __init n8x0_mmc_init(void)
 
 	err = gpio_request(N8X0_SLOT_SWITCH_GPIO, "MMC slot switch");
 	if (err)
-		return err;
+		return;
 
 	gpio_direction_output(N8X0_SLOT_SWITCH_GPIO, 0);
 
@@ -537,17 +537,17 @@ void __init n8x0_mmc_init(void)
 		err = gpio_request(N810_EMMC_VSD_GPIO, "MMC slot 2 Vddf");
 		if (err) {
 			gpio_free(N8X0_SLOT_SWITCH_GPIO);
-			return err;
+			return;
 		}
 		gpio_direction_output(N810_EMMC_VSD_GPIO, 0);
 
-		err = gpio_request(NN810_EMMC_VIO_GPIO, "MMC slot 2 Vdd");
+		err = gpio_request(N810_EMMC_VIO_GPIO, "MMC slot 2 Vdd");
 		if (err) {
 			gpio_free(N8X0_SLOT_SWITCH_GPIO);
 			gpio_free(N810_EMMC_VSD_GPIO);
-			return err;
+			return;
 		}
-		gpio_direction_output(NN810_EMMC_VIO_GPIO, 0);
+		gpio_direction_output(N810_EMMC_VIO_GPIO, 0);
 	}
 
 	mmc_data[0] = &mmc1_data;


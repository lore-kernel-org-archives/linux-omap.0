From: Zumeng Chen <zumeng.chen@windriver.com>
Subject: [PATCH 5/5] ARM: OMAP3530evm: set pendown_state and debounce time for ads7846
Date: Wed, 20 Jun 2012 17:14:53 +0800
Message-ID: <1340183693-3195-6-git-send-email-zumeng.chen@windriver.com>
References: <1340183693-3195-1-git-send-email-zumeng.chen@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:60467 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754656Ab2FTJPf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jun 2012 05:15:35 -0400
In-Reply-To: <1340183693-3195-1-git-send-email-zumeng.chen@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jon-hunter@ti.com, mike@compulab.co.il, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, khilman@ti.com, hvaibhav@ti.com, ajay.gupta@ti.com

Currently most ads7846 config definitions for OMAP3 series boards have
been moved to common-board-devices.c, and it is transparent for init.
And it's no very proper to do gpio_request based on get_pendown_state
since omap_ads7846_init knows everything about ads7846_config.

So it's more fit to request gpio according to the right gpio_pendown
and set debounce time conditionally. If we don't set proper debouce
time, there are flooded interrupt counters of ads7846 responding to
one time touch on screen, then the driver couldn't work very well.

This patch has been validated on 3530evm.

Signed-off-by: Zumeng Chen <zumeng.chen@windriver.com>
---
 arch/arm/mach-omap2/board-omap3evm.c       |    1 -
 arch/arm/mach-omap2/common-board-devices.c |   18 ++++++++++++++++--
 arch/arm/mach-omap2/common-board-devices.h |    1 +
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 02d8047..834cfc0 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -58,7 +58,6 @@
 #include "hsmmc.h"
 #include "common-board-devices.h"
 
-#define OMAP3_EVM_TS_GPIO	175
 #define OMAP3_EVM_EHCI_VBUS	22
 #define OMAP3_EVM_EHCI_SELECT	61
 
diff --git a/arch/arm/mach-omap2/common-board-devices.c b/arch/arm/mach-omap2/common-board-devices.c
index 1706ebc..4ba070e 100644
--- a/arch/arm/mach-omap2/common-board-devices.c
+++ b/arch/arm/mach-omap2/common-board-devices.c
@@ -35,6 +35,16 @@ static struct omap2_mcspi_device_config ads7846_mcspi_config = {
 	.turbo_mode	= 0,
 };
 
+/*
+ * ADS7846 driver maybe request a gpio according to the value
+ * of pdata->get_pendown_state, but we have done this. So set
+ * get_pendown_state to avoid twice gpio requesting.
+ */
+static int omap3_get_pendown_state(void)
+{
+	return !gpio_get_value(OMAP3_EVM_TS_GPIO);
+}
+
 static struct ads7846_platform_data ads7846_config = {
 	.x_max			= 0x0fff,
 	.y_max			= 0x0fff,
@@ -45,6 +55,7 @@ static struct ads7846_platform_data ads7846_config = {
 	.debounce_rep		= 1,
 	.gpio_pendown		= -EINVAL,
 	.keep_vref_on		= 1,
+	.get_pendown_state	= &omap3_get_pendown_state,
 };
 
 static struct spi_board_info ads7846_spi_board_info __initdata = {
@@ -63,14 +74,17 @@ void __init omap_ads7846_init(int bus_num, int gpio_pendown, int gpio_debounce,
 	struct spi_board_info *spi_bi = &ads7846_spi_board_info;
 	int err;
 
-	if (board_pdata && board_pdata->get_pendown_state) {
+	if (gpio_pendown) {
 		err = gpio_request_one(gpio_pendown, GPIOF_IN, "TSPenDown");
 		if (err) {
 			pr_err("Couldn't obtain gpio for TSPenDown: %d\n", err);
 			return;
 		}
-		gpio_export(gpio_pendown, 0);
 
+		/* TS GPIOPendown doesn't allow user to change the direction */
+		gpio_export(gpio_pendown, false);
+
+		/* Set proper debouce time for ads7846. */
 		if (gpio_debounce)
 			gpio_set_debounce(gpio_pendown, gpio_debounce);
 	}
diff --git a/arch/arm/mach-omap2/common-board-devices.h b/arch/arm/mach-omap2/common-board-devices.h
index a0b4a428..4c4ef6a 100644
--- a/arch/arm/mach-omap2/common-board-devices.h
+++ b/arch/arm/mach-omap2/common-board-devices.h
@@ -4,6 +4,7 @@
 #include "twl-common.h"
 
 #define NAND_BLOCK_SIZE	SZ_128K
+#define OMAP3_EVM_TS_GPIO	175
 
 struct mtd_partition;
 struct ads7846_platform_data;
-- 
1.7.5.4


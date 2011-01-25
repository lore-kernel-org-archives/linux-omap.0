From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH 2/5] OMAP3EVM: Add vio regulator supply required for ads7846 TSC driver
Date: Tue, 25 Jan 2011 23:07:38 +0530
Message-ID: <1295977061-11086-3-git-send-email-hvaibhav@ti.com>
References: <1295977061-11086-1-git-send-email-hvaibhav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48289 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753057Ab1AYRht (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Jan 2011 12:37:49 -0500
In-Reply-To: <1295977061-11086-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>

Add vio regulator supply, needed for ads7846 touchscreen controller
driver.

Tested on OMAP3 (ES3.1 Si) RevG version of EVM.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 8d2e413..dcef454 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -571,6 +571,25 @@ static struct regulator_init_data omap3_evm_vpll2 = {
 	.consumer_supplies	= &omap3_evm_vpll2_supply,
 };
 
+/* ads7846 on SPI */
+static struct regulator_consumer_supply omap3evm_vio_supply =
+	REGULATOR_SUPPLY("vcc", "spi1.0");
+
+/* VIO for ads7846 */
+static struct regulator_init_data omap3evm_vio = {
+	.constraints = {
+		.min_uV			= 1800000,
+		.max_uV			= 1800000,
+		.apply_uV		= true,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &omap3evm_vio_supply,
+};
+
 static struct twl4030_platform_data omap3evm_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
@@ -583,6 +602,7 @@ static struct twl4030_platform_data omap3evm_twldata = {
 	.codec		= &omap3evm_codec_data,
 	.vdac		= &omap3_evm_vdac,
 	.vpll2		= &omap3_evm_vpll2,
+	.vio		= &omap3evm_vio,
 };
 
 static struct i2c_board_info __initdata omap3evm_i2c_boardinfo[] = {
-- 
1.6.2.4


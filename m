From: hvaibhav@ti.com
Subject: [PATCH] OMAP3EVM: Add vio regulator supply required for ads7846 TSC driver
Date: Mon, 24 Jan 2011 20:02:45 +0530
Message-ID: <1295879565-13144-1-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60950 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753006Ab1AXOcu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Jan 2011 09:32:50 -0500
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, Vaibhav Hiremath <hvaibhav@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>


Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index a158d21..ed0311c 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -538,6 +538,25 @@ static struct regulator_init_data omap3_evm_vpll2 = {
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
@@ -550,6 +569,7 @@ static struct twl4030_platform_data omap3evm_twldata = {
 	.codec		= &omap3evm_codec_data,
 	.vdac		= &omap3_evm_vdac,
 	.vpll2		= &omap3_evm_vpll2,
+	.vio		= &omap3evm_vio,
 };
 
 static struct i2c_board_info __initdata omap3evm_i2c_boardinfo[] = {
-- 
1.6.2.4


From: Deepthy Ravi <deepthy.ravi@ti.com>
Subject: [PATCH 1/5] omap3evm: Enable regulators for camera interface
Date: Tue, 20 Sep 2011 20:26:48 +0530
Message-ID: <1316530612-23075-2-git-send-email-deepthy.ravi@ti.com>
References: <1316530612-23075-1-git-send-email-deepthy.ravi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1316530612-23075-1-git-send-email-deepthy.ravi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: laurent.pinchart@ideasonboard.com, mchehab@infradead.org, tony@atomide.com, hvaibhav@ti.com, linux-media@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.i
Cc: linux-omap@vger.kernel.org, Deepthy Ravi <deepthy.ravi@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Vaibhav Hiremath <hvaibhav@ti.com>

Enabled 1v8 and 2v8 regulator output, which is being used by
camera module.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Signed-off-by: Deepthy Ravi <deepthy.ravi@ti.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index c452b3f..cf30fff 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -273,6 +273,25 @@ static struct omap_dss_board_info omap3_evm_dss_data = {
 	.default_device	= &omap3_evm_lcd_device,
 };
 
+static struct regulator_consumer_supply omap3evm_vaux3_supply[] = {
+	REGULATOR_SUPPLY("cam_2v8", NULL),
+};
+
+/* VAUX3 for CAM_2V8 */
+static struct regulator_init_data omap3evm_vaux3 = {
+	.constraints = {
+		.min_uV                 = 2800000,
+		.max_uV                 = 2800000,
+		.apply_uV               = true,
+		.valid_modes_mask       = REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask         = REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+		},
+	.num_consumer_supplies  = ARRAY_SIZE(omap3evm_vaux3_supply),
+	.consumer_supplies      = omap3evm_vaux3_supply,
+};
+
 static struct regulator_consumer_supply omap3evm_vmmc1_supply[] = {
 	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0"),
 };
@@ -433,6 +452,7 @@ static struct twl4030_keypad_data omap3evm_kp_data = {
 /* ads7846 on SPI */
 static struct regulator_consumer_supply omap3evm_vio_supply[] = {
 	REGULATOR_SUPPLY("vcc", "spi1.0"),
+	REGULATOR_SUPPLY("vio_1v8", NULL),
 };
 
 /* VIO for ads7846 */
@@ -499,6 +519,7 @@ static struct twl4030_platform_data omap3evm_twldata = {
 	.vio		= &omap3evm_vio,
 	.vmmc1		= &omap3evm_vmmc1,
 	.vsim		= &omap3evm_vsim,
+	.vaux3          = &omap3evm_vaux3,
 };
 
 static int __init omap3_evm_i2c_init(void)
-- 
1.7.0.4

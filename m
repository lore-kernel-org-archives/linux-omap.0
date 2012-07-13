From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2] ARM: OMAP4: twl-common: Support for additional devices on i2c1 bus
Date: Fri, 13 Jul 2012 10:38:02 +0200
Message-ID: <1342168682-15888-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:59161 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756182Ab2GMIhw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jul 2012 04:37:52 -0400
Received: by obbeh20 with SMTP id eh20so4717750obb.24
        for <linux-omap@vger.kernel.org>; Fri, 13 Jul 2012 01:37:50 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On OMAP4 the i2c1 bus is dedicated for the PMIC and audio related devices.
Manufacturers can opt to use different codec than twl6040 and also can add
audio related IC to the bus (external amplifier for example on SDP4430).

Make it possible to add differnet set of additional devices to i2c1 bus on
OMAP4 boards.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---

Changes since v1:
Generated against l-o/master

Regards,
Peter

 arch/arm/mach-omap2/board-4430sdp.c    |   12 +++++++++-
 arch/arm/mach-omap2/board-omap4panda.c |   12 +++++++++-
 arch/arm/mach-omap2/twl-common.c       |   35 +++++++++----------------------
 arch/arm/mach-omap2/twl-common.h       |    3 +-
 4 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index ad8a7d9..26466f2 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -547,6 +547,14 @@ static struct twl6040_platform_data twl6040_data = {
 	.irq_base	= TWL6040_CODEC_IRQ_BASE,
 };
 
+static struct i2c_board_info __initdata sdp4430_i2c_1_boardinfo[] = {
+	{
+		I2C_BOARD_INFO("twl6040", 0x4b),
+		.irq = OMAP44XX_IRQ_SYS_2N,
+		.platform_data = &twl6040_data,
+	},
+};
+
 static struct twl4030_platform_data sdp4430_twldata = {
 	/* Regulators */
 	.vusim		= &sdp4430_vusim,
@@ -580,8 +588,8 @@ static int __init omap4_i2c_init(void)
 			TWL_COMMON_REGULATOR_CLK32KG |
 			TWL_COMMON_REGULATOR_V1V8 |
 			TWL_COMMON_REGULATOR_V2V1);
-	omap4_pmic_init("twl6030", &sdp4430_twldata,
-			&twl6040_data, OMAP44XX_IRQ_SYS_2N);
+	omap4_pmic_init("twl6030", &sdp4430_twldata, sdp4430_i2c_1_boardinfo,
+			ARRAY_SIZE(sdp4430_i2c_1_boardinfo));
 	omap_register_i2c_bus(2, 400, NULL, 0);
 	omap_register_i2c_bus(3, 400, sdp4430_i2c_3_boardinfo,
 				ARRAY_SIZE(sdp4430_i2c_3_boardinfo));
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index b627cdc..5becba2 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -266,6 +266,14 @@ static struct twl6040_platform_data twl6040_data = {
 	.irq_base	= TWL6040_CODEC_IRQ_BASE,
 };
 
+static struct i2c_board_info __initdata panda_i2c_1_boardinfo[] = {
+	{
+		I2C_BOARD_INFO("twl6040", 0x4b),
+		.irq = OMAP44XX_IRQ_SYS_2N,
+		.platform_data = &twl6040_data,
+	},
+};
+
 /* Panda board uses the common PMIC configuration */
 static struct twl4030_platform_data omap4_panda_twldata;
 
@@ -293,8 +301,8 @@ static int __init omap4_panda_i2c_init(void)
 			TWL_COMMON_REGULATOR_CLK32KG |
 			TWL_COMMON_REGULATOR_V1V8 |
 			TWL_COMMON_REGULATOR_V2V1);
-	omap4_pmic_init("twl6030", &omap4_panda_twldata,
-			&twl6040_data, OMAP44XX_IRQ_SYS_2N);
+	omap4_pmic_init("twl6030", &omap4_panda_twldata, panda_i2c_1_boardinfo,
+			ARRAY_SIZE(panda_i2c_1_boardinfo));
 	omap_register_i2c_bus(2, 400, NULL, 0);
 	/*
 	 * Bus 3 is attached to the DVI port where devices like the pico DLP
diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
index 3882f3c..d52be85 100644
--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -39,16 +39,6 @@ static struct i2c_board_info __initdata pmic_i2c_board_info = {
 	.flags		= I2C_CLIENT_WAKE,
 };
 
-static struct i2c_board_info __initdata omap4_i2c1_board_info[] = {
-	{
-		.addr		= 0x48,
-		.flags		= I2C_CLIENT_WAKE,
-	},
-	{
-		I2C_BOARD_INFO("twl6040", 0x4b),
-	},
-};
-
 #if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
 static int twl_set_voltage(void *data, int target_uV)
 {
@@ -77,30 +67,25 @@ void __init omap_pmic_init(int bus, u32 clkrate,
 
 void __init omap4_pmic_init(const char *pmic_type,
 		    struct twl4030_platform_data *pmic_data,
-		    struct twl6040_platform_data *twl6040_data, int twl6040_irq)
+		    struct i2c_board_info *devices, int nr_devices)
 {
 	/* PMIC part*/
 	omap_mux_init_signal("sys_nirq1", OMAP_PIN_INPUT_PULLUP | OMAP_PIN_OFF_WAKEUPENABLE);
-	strncpy(omap4_i2c1_board_info[0].type, pmic_type,
-		sizeof(omap4_i2c1_board_info[0].type));
-	omap4_i2c1_board_info[0].irq = OMAP44XX_IRQ_SYS_1N;
-	omap4_i2c1_board_info[0].platform_data = pmic_data;
-
-	/* TWL6040 audio IC part */
-	omap4_i2c1_board_info[1].irq = twl6040_irq;
-	omap4_i2c1_board_info[1].platform_data = twl6040_data;
-
-	omap_register_i2c_bus(1, 400, omap4_i2c1_board_info, 2);
+	omap_pmic_init(1, 400, pmic_type, OMAP44XX_IRQ_SYS_1N, pmic_data);
 
+	/* Register additional devices on i2c1 bus if needed */
+	if (devices)
+		i2c_register_board_info(1, devices, nr_devices);
 }
 
 void __init omap_pmic_late_init(void)
 {
 	/* Init the OMAP TWL parameters (if PMIC has been registerd) */
-	if (pmic_i2c_board_info.irq)
-		omap3_twl_init();
-	if (omap4_i2c1_board_info[0].irq)
-		omap4_twl_init();
+	if (!pmic_i2c_board_info.irq)
+		return;
+
+	omap3_twl_init();
+	omap4_twl_init();
 }
 
 #if defined(CONFIG_ARCH_OMAP3)
diff --git a/arch/arm/mach-omap2/twl-common.h b/arch/arm/mach-omap2/twl-common.h
index 8fe71cf..de062c7 100644
--- a/arch/arm/mach-omap2/twl-common.h
+++ b/arch/arm/mach-omap2/twl-common.h
@@ -32,6 +32,7 @@
 
 struct twl4030_platform_data;
 struct twl6040_platform_data;
+struct i2c_board_info;
 
 void omap_pmic_init(int bus, u32 clkrate, const char *pmic_type, int pmic_irq,
 		    struct twl4030_platform_data *pmic_data);
@@ -51,7 +52,7 @@ static inline void omap3_pmic_init(const char *pmic_type,
 
 void omap4_pmic_init(const char *pmic_type,
 		    struct twl4030_platform_data *pmic_data,
-		    struct twl6040_platform_data *audio_data, int twl6040_irq);
+		    struct i2c_board_info *devices, int nr_devices);
 
 void omap3_pmic_get_config(struct twl4030_platform_data *pmic_data,
 			   u32 pdata_flags, u32 regulators_flags);
-- 
1.7.8.6


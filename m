From: balajitk-l0cyMroinI0@public.gmane.org
Subject: [PATCH]i2c-omap: pass scll, sclh through board file for Errata i585
Date: Fri,  7 May 2010 12:05:05 +0530
Message-ID: <1273214105-22894-1-git-send-email-balajitk@ti.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>

Errata ID: i535 - I2C1 to 3 SCL low period is shorter in FS mode
Due to IO cell influence, I2C1 to 3 SCL low period can be shorter than expected.
As a result, I2C AC timing (SCL minimum low period) in FS mode may not meet
the timing configured by software.

I2C1 to 3, SCL low period is programmable and proper adjustments
to the SCLL/HSSCLL values can avoid the issue.

This patch provides flexibility to control tLOW, tHIGH for different boards.
scll, sclh values are to be provide in board data
for differents modes (standard, fast and high speed mode)
as the scl rate (I2C bus speed) can be changed by bootargs.

If scll, sclh values are not provided, scll and sclh values will be computed
for duty cycle tHIGH:tLOW of 1:2 (for HS, FS) and 1:1 for Standard as before

>From TRM table : HS I2C tLOW and thighValues of the I2C Clock

F/S, SCCB, or HS first phase
I2Ci_INTERNAL_CLK  = I2Ci_FCLK / (I2Ci.I2C_PSC[7:0] PSC field + 1)
tlow = (I2Ci.I2C_SCLL[7:0]SCLL field value + 7) * I2Ci_INTERNAL_CLK period
thigh = (I2Ci.I2C_SCLH[7:0]SCLH field value + 5) * I2Ci_INTERNAL_CLK period

HS second phase
tlow = (I2Ci.I2C_SCLL[15:8]HSSCLL field value + 7) * I2Ci_FCLK period
thigh = (I2Ci.I2C_SCLH[15:8]HSSCLH field value + 5) * I2Ci_FCLK period

i2c bus rate = 1/(tlow + thigh)

Split tLOW and thigh to meet minimum tLOW and tHIGH I2C spec.

Actual tlow and thigh periods may vary depending on board (the
load capacitance on the SCL signal). If necessary, any adjustments to the
SCLL/SCLH/HSSCLL/HSSCLH values must be determined by measurements of actual SCL
signal on the board

Tested with omap3_defconfig on 3430 SDP

Signed-off-by: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap1/board-ams-delta.c        |    2 +-
 arch/arm/mach-omap1/board-fsample.c          |    2 +-
 arch/arm/mach-omap1/board-generic.c          |    2 +-
 arch/arm/mach-omap1/board-h2.c               |    2 +-
 arch/arm/mach-omap1/board-h3.c               |    2 +-
 arch/arm/mach-omap1/board-innovator.c        |    2 +-
 arch/arm/mach-omap1/board-nokia770.c         |    2 +-
 arch/arm/mach-omap1/board-osk.c              |    2 +-
 arch/arm/mach-omap1/board-palmte.c           |    2 +-
 arch/arm/mach-omap1/board-palmtt.c           |    2 +-
 arch/arm/mach-omap1/board-palmz71.c          |    2 +-
 arch/arm/mach-omap1/board-perseus2.c         |    2 +-
 arch/arm/mach-omap1/board-sx1.c              |    2 +-
 arch/arm/mach-omap1/board-voiceblue.c        |    2 +-
 arch/arm/mach-omap2/board-2430sdp.c          |    4 +-
 arch/arm/mach-omap2/board-3430sdp.c          |   18 ++++++++--
 arch/arm/mach-omap2/board-am3517evm.c        |    6 ++--
 arch/arm/mach-omap2/board-cm-t35.c           |    2 +-
 arch/arm/mach-omap2/board-devkit8000.c       |    4 +-
 arch/arm/mach-omap2/board-igep0020.c         |    4 +-
 arch/arm/mach-omap2/board-ldp.c              |    6 ++--
 arch/arm/mach-omap2/board-n8x0.c             |    2 +-
 arch/arm/mach-omap2/board-omap3beagle.c      |    4 +-
 arch/arm/mach-omap2/board-omap3evm.c         |    6 ++--
 arch/arm/mach-omap2/board-omap3pandora.c     |    4 +-
 arch/arm/mach-omap2/board-omap3touchbook.c   |    4 +-
 arch/arm/mach-omap2/board-overo.c            |    4 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c |    6 ++--
 arch/arm/mach-omap2/board-zoom-peripherals.c |    6 ++--
 arch/arm/plat-omap/i2c.c                     |   12 +++++++
 arch/arm/plat-omap/include/plat/i2c.h        |   21 ++++++++++++
 drivers/i2c/busses/i2c-omap.c                |   46 +++++++++++++++++++++----
 include/linux/i2c-omap.h                     |   10 ++++++
 33 files changed, 141 insertions(+), 56 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 7fc11c3..fad4205 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -228,7 +228,7 @@ static void __init ams_delta_init(void)
 	omap_board_config = ams_delta_config;
 	omap_board_config_size = ARRAY_SIZE(ams_delta_config);
 	omap_serial_init();
-	omap_register_i2c_bus(1, 100, NULL, 0);
+	omap_register_i2c_bus(1, 100, NULL, NULL, 0);
 
 	/* Clear latch2 (NAND, LCD, modem enable) */
 	ams_delta_latch2_write(~0, 0);
diff --git a/arch/arm/mach-omap1/board-fsample.c b/arch/arm/mach-omap1/board-fsample.c
index 096f2ed..3eba5ac 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -297,7 +297,7 @@ static void __init omap_fsample_init(void)
 	omap_board_config = fsample_config;
 	omap_board_config_size = ARRAY_SIZE(fsample_config);
 	omap_serial_init();
-	omap_register_i2c_bus(1, 100, NULL, 0);
+	omap_register_i2c_bus(1, 100, NULL, NULL, 0);
 }
 
 static void __init fsample_init_smc91x(void)
diff --git a/arch/arm/mach-omap1/board-generic.c b/arch/arm/mach-omap1/board-generic.c
index e1195a3..f20a50d 100644
--- a/arch/arm/mach-omap1/board-generic.c
+++ b/arch/arm/mach-omap1/board-generic.c
@@ -84,7 +84,7 @@ static void __init omap_generic_init(void)
 	omap_board_config = generic_config;
 	omap_board_config_size = ARRAY_SIZE(generic_config);
 	omap_serial_init();
-	omap_register_i2c_bus(1, 100, NULL, 0);
+	omap_register_i2c_bus(1, 100, NULL, NULL, 0);
 }
 
 static void __init omap_generic_map_io(void)
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index d1100e4..2308d02 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -450,7 +450,7 @@ static void __init h2_init(void)
 	omap_board_config = h2_config;
 	omap_board_config_size = ARRAY_SIZE(h2_config);
 	omap_serial_init();
-	omap_register_i2c_bus(1, 100, h2_i2c_board_info,
+	omap_register_i2c_bus(1, 100, NULL, h2_i2c_board_info,
 			      ARRAY_SIZE(h2_i2c_board_info));
 	omap_usb_init(&h2_usb_config);
 	h2_mmc_init();
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index a53ab82..46016e8 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -403,7 +403,7 @@ static void __init h3_init(void)
 	omap_board_config = h3_config;
 	omap_board_config_size = ARRAY_SIZE(h3_config);
 	omap_serial_init();
-	omap_register_i2c_bus(1, 100, h3_i2c_board_info,
+	omap_register_i2c_bus(1, 100, NULL, h3_i2c_board_info,
 			      ARRAY_SIZE(h3_i2c_board_info));
 	omap_usb_init(&h3_usb_config);
 	h3_mmc_init();
diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index 5d12fd3..168390e 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -435,7 +435,7 @@ static void __init innovator_init(void)
 	omap_board_config = innovator_config;
 	omap_board_config_size = ARRAY_SIZE(innovator_config);
 	omap_serial_init();
-	omap_register_i2c_bus(1, 100, NULL, 0);
+	omap_register_i2c_bus(1, 100, NULL, NULL, 0);
 	innovator_mmc_init();
 }
 
diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index fb3ecb9..d804946 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -410,7 +410,7 @@ static void __init omap_nokia770_init(void)
 				ARRAY_SIZE(nokia770_spi_board_info));
 	omap_gpio_init();
 	omap_serial_init();
-	omap_register_i2c_bus(1, 100, NULL, 0);
+	omap_register_i2c_bus(1, 100, NULL, NULL, 0);
 	omap_dsp_init();
 	hwa742_dev_init();
 	ads7846_dev_init();
diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index 80d8620..c6b0231 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -568,7 +568,7 @@ static void __init osk_init(void)
 		gpio_direction_input(OMAP_MPUIO(1));
 
 	omap_serial_init();
-	omap_register_i2c_bus(1, 400, osk_i2c_board_info,
+	omap_register_i2c_bus(1, 400, NULL, osk_i2c_board_info,
 			      ARRAY_SIZE(osk_i2c_board_info));
 	osk_mistral_init();
 }
diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index 569b4c9..d2067ca 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -360,7 +360,7 @@ static void __init omap_palmte_init(void)
 	palmte_misc_gpio_setup();
 	omap_serial_init();
 	omap_usb_init(&palmte_usb_config);
-	omap_register_i2c_bus(1, 100, NULL, 0);
+	omap_register_i2c_bus(1, 100, NULL, NULL, 0);
 }
 
 static void __init omap_palmte_map_io(void)
diff --git a/arch/arm/mach-omap1/board-palmtt.c b/arch/arm/mach-omap1/board-palmtt.c
index 6ad49a2..a5f5fed 100644
--- a/arch/arm/mach-omap1/board-palmtt.c
+++ b/arch/arm/mach-omap1/board-palmtt.c
@@ -308,7 +308,7 @@ static void __init omap_palmtt_init(void)
 	spi_register_board_info(palmtt_boardinfo,ARRAY_SIZE(palmtt_boardinfo));
 	omap_serial_init();
 	omap_usb_init(&palmtt_usb_config);
-	omap_register_i2c_bus(1, 100, NULL, 0);
+	omap_register_i2c_bus(1, 100, NULL, NULL, 0);
 }
 
 static void __init omap_palmtt_map_io(void)
diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
index 6641de9..6749ade 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -327,7 +327,7 @@ omap_palmz71_init(void)
 				ARRAY_SIZE(palmz71_boardinfo));
 	omap_usb_init(&palmz71_usb_config);
 	omap_serial_init();
-	omap_register_i2c_bus(1, 100, NULL, 0);
+	omap_register_i2c_bus(1, 100, NULL, NULL, 0);
 	palmz71_gpio_setup(0);
 }
 
diff --git a/arch/arm/mach-omap1/board-perseus2.c b/arch/arm/mach-omap1/board-perseus2.c
index e854d57..7117371 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -265,7 +265,7 @@ static void __init omap_perseus2_init(void)
 	omap_board_config = perseus2_config;
 	omap_board_config_size = ARRAY_SIZE(perseus2_config);
 	omap_serial_init();
-	omap_register_i2c_bus(1, 100, NULL, 0);
+	omap_register_i2c_bus(1, 100, NULL, NULL, 0);
 }
 
 static void __init perseus2_init_smc91x(void)
diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index 2fb1e5f..44193b7 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -391,7 +391,7 @@ static void __init omap_sx1_init(void)
 	omap_board_config = sx1_config;
 	omap_board_config_size = ARRAY_SIZE(sx1_config);
 	omap_serial_init();
-	omap_register_i2c_bus(1, 100, NULL, 0);
+	omap_register_i2c_bus(1, 100, NULL, NULL, 0);
 	omap_usb_init(&sx1_usb_config);
 	sx1_mmc_init();
 
diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
index 87b9436..b5e36b4 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -199,7 +199,7 @@ static void __init voiceblue_init(void)
 	omap_board_config_size = ARRAY_SIZE(voiceblue_config);
 	omap_serial_init();
 	omap_usb_init(&voiceblue_usb_config);
-	omap_register_i2c_bus(1, 100, NULL, 0);
+	omap_register_i2c_bus(1, 100, NULL, NULL, 0);
 
 	/* There is a good chance board is going up, so enable power LED
 	 * (it is connected through invertor) */
diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 01d113f..b19a74b 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -176,8 +176,8 @@ static struct i2c_board_info __initdata sdp2430_i2c_boardinfo[] = {
 
 static int __init omap2430_i2c_init(void)
 {
-	omap_register_i2c_bus(1, 400, NULL, 0);
-	omap_register_i2c_bus(2, 2600, sdp2430_i2c_boardinfo,
+	omap_register_i2c_bus(1, 400, NULL, NULL, 0);
+	omap_register_i2c_bus(2, 2600, NULL, sdp2430_i2c_boardinfo,
 			ARRAY_SIZE(sdp2430_i2c_boardinfo));
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 5822bcf..a9e62cb 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -594,6 +594,17 @@ static struct twl4030_platform_data sdp3430_twldata = {
 	.vpll2		= &sdp3430_vpll2,
 };
 
+static struct omap_i2c_scl_data __initdata sdp3430_i2c1_scl_data = {
+	.standard_scll	= 20,	/* For 100Khz */
+	.standard_sclh	= 20,	/* For 100Khz */
+	.fast_mode_scll	= 16,	/* For 400Khz */
+	.fast_mode_sclh	= 8,	/* For 400Khz */
+	.hs_phase1_scll	= 32,	/* For 2600Khz */
+	.hs_phase1_sclh	= 16,	/* For 2600Khz */
+	.hs_phase2_scll	= 24,	/* For 2600Khz */
+	.hs_phase2_sclh	= 12,	/* For 2600Khz */
+};
+
 static struct i2c_board_info __initdata sdp3430_i2c_boardinfo[] = {
 	{
 		I2C_BOARD_INFO("twl4030", 0x48),
@@ -606,12 +617,13 @@ static struct i2c_board_info __initdata sdp3430_i2c_boardinfo[] = {
 static int __init omap3430_i2c_init(void)
 {
 	/* i2c1 for PMIC only */
-	omap_register_i2c_bus(1, 2600, sdp3430_i2c_boardinfo,
+	omap_register_i2c_bus(1, 2600, &sdp3430_i2c1_scl_data,
+			sdp3430_i2c_boardinfo,
 			ARRAY_SIZE(sdp3430_i2c_boardinfo));
 	/* i2c2 on camera connector (for sensor control) and optional isp1301 */
-	omap_register_i2c_bus(2, 400, NULL, 0);
+	omap_register_i2c_bus(2, 400, NULL, NULL, 0);
 	/* i2c3 on display connector (for DVI, tfp410) */
-	omap_register_i2c_bus(3, 400, NULL, 0);
+	omap_register_i2c_bus(3, 400, NULL, NULL, 0);
 	return 0;
 }
 
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index c1c4389..f96e594 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -107,10 +107,10 @@ static struct i2c_board_info __initdata am3517evm_ui_tca6416_info[] = {
 
 static int __init am3517_evm_i2c_init(void)
 {
-	omap_register_i2c_bus(1, 400, NULL, 0);
-	omap_register_i2c_bus(2, 400, am3517evm_tca6416_info_0,
+	omap_register_i2c_bus(1, 400, NULL, NULL, 0);
+	omap_register_i2c_bus(2, 400, NULL, am3517evm_tca6416_info_0,
 			ARRAY_SIZE(am3517evm_tca6416_info_0));
-	omap_register_i2c_bus(3, 400, am3517evm_ui_tca6416_info,
+	omap_register_i2c_bus(3, 400, NULL, am3517evm_ui_tca6416_info,
 			ARRAY_SIZE(am3517evm_ui_tca6416_info));
 
 	return 0;
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index e679a2c..016b40d 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -690,7 +690,7 @@ static struct i2c_board_info __initdata cm_t35_i2c_boardinfo[] = {
 
 static void __init cm_t35_init_i2c(void)
 {
-	omap_register_i2c_bus(1, 2600, cm_t35_i2c_boardinfo,
+	omap_register_i2c_bus(1, 2600, NULL, cm_t35_i2c_boardinfo,
 			      ARRAY_SIZE(cm_t35_i2c_boardinfo));
 }
 
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 47e3af2..e3bad22 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -391,11 +391,11 @@ static struct i2c_board_info __initdata devkit8000_i2c_boardinfo[] = {
 
 static int __init devkit8000_i2c_init(void)
 {
-	omap_register_i2c_bus(1, 2600, devkit8000_i2c_boardinfo,
+	omap_register_i2c_bus(1, 2600, NULL, devkit8000_i2c_boardinfo,
 			ARRAY_SIZE(devkit8000_i2c_boardinfo));
 	/* Bus 3 is attached to the DVI port where devices like the pico DLP
 	 * projector don't work reliably with 400kHz */
-	omap_register_i2c_bus(3, 400, NULL, 0);
+	omap_register_i2c_bus(3, 400, NULL, NULL, 0);
 	return 0;
 }
 
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index d55c57b..debda56 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -443,11 +443,11 @@ static struct i2c_board_info __initdata igep2_i2c_boardinfo[] = {
 
 static int __init igep2_i2c_init(void)
 {
-	omap_register_i2c_bus(1, 2600, igep2_i2c_boardinfo,
+	omap_register_i2c_bus(1, 2600, NULL, igep2_i2c_boardinfo,
 			ARRAY_SIZE(igep2_i2c_boardinfo));
 	/* Bus 3 is attached to the DVI port where devices like the pico DLP
 	 * projector don't work reliably with 400kHz */
-	omap_register_i2c_bus(3, 100, NULL, 0);
+	omap_register_i2c_bus(3, 100, NULL, NULL, 0);
 	return 0;
 }
 
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 5fcb52e..894dfba 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -352,10 +352,10 @@ static struct i2c_board_info __initdata ldp_i2c_boardinfo[] = {
 
 static int __init omap_i2c_init(void)
 {
-	omap_register_i2c_bus(1, 2600, ldp_i2c_boardinfo,
+	omap_register_i2c_bus(1, 2600, NULL, ldp_i2c_boardinfo,
 			ARRAY_SIZE(ldp_i2c_boardinfo));
-	omap_register_i2c_bus(2, 400, NULL, 0);
-	omap_register_i2c_bus(3, 400, NULL, 0);
+	omap_register_i2c_bus(2, 400, NULL, NULL, 0);
+	omap_register_i2c_bus(3, 400, NULL, NULL, 0);
 	return 0;
 }
 
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index 131ce3c..973c1c5 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -655,7 +655,7 @@ static struct menelaus_platform_data n8x0_menelaus_platform_data = {
 static void __init n8x0_menelaus_init(void)
 {
 	n8x0_i2c_board_info_1[0].platform_data = &n8x0_menelaus_platform_data;
-	omap_register_i2c_bus(1, 400, n8x0_i2c_board_info_1,
+	omap_register_i2c_bus(1, 400, NULL, n8x0_i2c_board_info_1,
 			      ARRAY_SIZE(n8x0_i2c_board_info_1));
 }
 
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 962d377..4b9dbba 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -288,11 +288,11 @@ static struct i2c_board_info __initdata beagle_i2c_boardinfo[] = {
 
 static int __init omap3_beagle_i2c_init(void)
 {
-	omap_register_i2c_bus(1, 2600, beagle_i2c_boardinfo,
+	omap_register_i2c_bus(1, 2600, NULL, beagle_i2c_boardinfo,
 			ARRAY_SIZE(beagle_i2c_boardinfo));
 	/* Bus 3 is attached to the DVI port where devices like the pico DLP
 	 * projector don't work reliably with 400kHz */
-	omap_register_i2c_bus(3, 100, NULL, 0);
+	omap_register_i2c_bus(3, 100, NULL, NULL, 0);
 	return 0;
 }
 
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 017bb2f..c33c140 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -566,10 +566,10 @@ static int __init omap3_evm_i2c_init(void)
 	omap3evm_twldata.vmmc1 = &omap3evm_vmmc1;
 	omap3evm_twldata.vsim = &omap3evm_vsim;
 
-	omap_register_i2c_bus(1, 2600, omap3evm_i2c_boardinfo,
+	omap_register_i2c_bus(1, 2600, NULL, omap3evm_i2c_boardinfo,
 			ARRAY_SIZE(omap3evm_i2c_boardinfo));
-	omap_register_i2c_bus(2, 400, NULL, 0);
-	omap_register_i2c_bus(3, 400, NULL, 0);
+	omap_register_i2c_bus(2, 400, NULL, NULL, 0);
+	omap_register_i2c_bus(3, 400, NULL, NULL, 0);
 	return 0;
 }
 
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 395d049..9ed3c2e 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -468,10 +468,10 @@ static struct i2c_board_info __initdata omap3pandora_i2c3_boardinfo[] = {
 
 static int __init omap3pandora_i2c_init(void)
 {
-	omap_register_i2c_bus(1, 2600, omap3pandora_i2c_boardinfo,
+	omap_register_i2c_bus(1, 2600, NULL, omap3pandora_i2c_boardinfo,
 			ARRAY_SIZE(omap3pandora_i2c_boardinfo));
 	/* i2c2 pins are not connected */
-	omap_register_i2c_bus(3, 100, omap3pandora_i2c3_boardinfo,
+	omap_register_i2c_bus(3, 100, NULL, omap3pandora_i2c3_boardinfo,
 			ARRAY_SIZE(omap3pandora_i2c3_boardinfo));
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 2504d41..82614fd 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -309,11 +309,11 @@ static struct i2c_board_info __initdata touchBook_i2c_boardinfo[] = {
 static int __init omap3_touchbook_i2c_init(void)
 {
 	/* Standard TouchBook bus */
-	omap_register_i2c_bus(1, 2600, touchbook_i2c_boardinfo,
+	omap_register_i2c_bus(1, 2600, NULL, touchbook_i2c_boardinfo,
 			ARRAY_SIZE(touchbook_i2c_boardinfo));
 
 	/* Additional TouchBook bus */
-	omap_register_i2c_bus(3, 100, touchBook_i2c_boardinfo,
+	omap_register_i2c_bus(3, 100, NULL, touchBook_i2c_boardinfo,
 			ARRAY_SIZE(touchBook_i2c_boardinfo));
 
 	return 0;
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 8848c7c..a9ebb2b 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -360,10 +360,10 @@ static struct i2c_board_info __initdata overo_i2c_boardinfo[] = {
 
 static int __init overo_i2c_init(void)
 {
-	omap_register_i2c_bus(1, 2600, overo_i2c_boardinfo,
+	omap_register_i2c_bus(1, 2600, NULL, overo_i2c_boardinfo,
 			ARRAY_SIZE(overo_i2c_boardinfo));
 	/* i2c2 pins are used for gpio */
-	omap_register_i2c_bus(3, 400, NULL, 0);
+	omap_register_i2c_bus(3, 400, NULL, NULL, 0);
 	return 0;
 }
 
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 4377a4c..debc490 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -638,10 +638,10 @@ static int __init rx51_i2c_init(void)
 		rx51_twldata.vaux3 = &rx51_vaux3_cam;
 		rx51_twldata.vmmc2 = &rx51_vmmc2;
 	}
-	omap_register_i2c_bus(1, 2200, rx51_peripherals_i2c_board_info_1,
+	omap_register_i2c_bus(1, 2200, NULL, rx51_peripherals_i2c_board_info_1,
 			ARRAY_SIZE(rx51_peripherals_i2c_board_info_1));
-	omap_register_i2c_bus(2, 100, NULL, 0);
-	omap_register_i2c_bus(3, 400, NULL, 0);
+	omap_register_i2c_bus(2, 100, NULL, NULL, 0);
+	omap_register_i2c_bus(3, 400, NULL, NULL, 0);
 	return 0;
 }
 
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index 6b39849..0e4ccc2 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -257,10 +257,10 @@ static struct i2c_board_info __initdata zoom_i2c_boardinfo[] = {
 
 static int __init omap_i2c_init(void)
 {
-	omap_register_i2c_bus(1, 2400, zoom_i2c_boardinfo,
+	omap_register_i2c_bus(1, 2400, NULL, zoom_i2c_boardinfo,
 			ARRAY_SIZE(zoom_i2c_boardinfo));
-	omap_register_i2c_bus(2, 400, NULL, 0);
-	omap_register_i2c_bus(3, 400, NULL, 0);
+	omap_register_i2c_bus(2, 400, NULL, NULL, 0);
+	omap_register_i2c_bus(3, 400, NULL, NULL, 0);
 	return 0;
 }
 
diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index f044b59..adfa3c2 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -198,6 +198,7 @@ subsys_initcall(omap_register_i2c_bus_cmdline);
  * Returns 0 on success or an error code.
  */
 int __init omap_register_i2c_bus(int bus_id, u32 clkrate,
+			  struct omap_i2c_scl_data *pdata,
 			  struct i2c_board_info const *info,
 			  unsigned len)
 {
@@ -216,5 +217,16 @@ int __init omap_register_i2c_bus(int bus_id, u32 clkrate,
 
 	i2c_pdata[bus_id - 1].clkrate &= ~OMAP_I2C_CMDLINE_SETUP;
 
+	if (pdata != NULL) {
+		i2c_pdata[bus_id - 1].standard.scll = pdata->standard_scll;
+		i2c_pdata[bus_id - 1].standard.sclh = pdata->standard_sclh;
+		i2c_pdata[bus_id - 1].fast.scll = pdata->fast_mode_scll;
+		i2c_pdata[bus_id - 1].fast.sclh = pdata->fast_mode_sclh;
+		i2c_pdata[bus_id - 1].hs_phase1.scll = pdata->hs_phase1_scll;
+		i2c_pdata[bus_id - 1].hs_phase1.sclh = pdata->hs_phase1_sclh;
+		i2c_pdata[bus_id - 1].hs_phase2.scll = pdata->hs_phase2_scll;
+		i2c_pdata[bus_id - 1].hs_phase2.sclh = pdata->hs_phase2_sclh;
+	}
+
 	return omap_i2c_add_bus(bus_id);
 }
diff --git a/arch/arm/plat-omap/include/plat/i2c.h b/arch/arm/plat-omap/include/plat/i2c.h
index 87f6bf2..6a60fc3 100644
--- a/arch/arm/plat-omap/include/plat/i2c.h
+++ b/arch/arm/plat-omap/include/plat/i2c.h
@@ -21,12 +21,33 @@
 
 #include <linux/i2c.h>
 
+struct omap_i2c_scl_data {
+	unsigned short standard_scll;	/* For < 100KHz */
+	unsigned short standard_sclh;	/* For < 100KHz */
+	unsigned short fast_mode_scll;	/* For < 400KHz */
+	unsigned short fast_mode_sclh;	/* For < 400KHz */
+	unsigned short hs_phase1_scll;	/* For > 400KHz */
+	unsigned short hs_phase1_sclh;	/* For > 400KHz */
+	unsigned short hs_phase2_scll;	/* For > 400KHz */
+	unsigned short hs_phase2_sclh;	/* For > 400KHz */
+	/*
+	 * scll + sclh = (internal clk in KHz / rate in KHz)
+	 * internal clk should be assumed to be
+	 * 4000 KHz for standard mode
+	 * 9600 KHz for fast mode
+	 * 19200 KHz for phase1 of high speed mode and rate should be 400 KHz
+	 * fclk_rate for phase2 of high speed mode
+	 */
+};
+
 #if defined(CONFIG_I2C_OMAP) || defined(CONFIG_I2C_OMAP_MODULE)
 extern int omap_register_i2c_bus(int bus_id, u32 clkrate,
+				 struct omap_i2c_scl_data *pdata,
 				 struct i2c_board_info const *info,
 				 unsigned len);
 #else
 static inline int omap_register_i2c_bus(int bus_id, u32 clkrate,
+				 struct omap_i2c_scl_data *pdata,
 				 struct i2c_board_info const *info,
 				 unsigned len)
 {
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index ef73483..2bf46f4 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -40,6 +40,8 @@
 #include <linux/slab.h>
 #include <linux/i2c-omap.h>
 
+#include <plat/i2c.h>
+
 /* I2C controller revisions */
 #define OMAP_I2C_REV_2			0x20
 
@@ -347,12 +349,17 @@ static void omap_i2c_idle(struct omap_i2c_dev *dev)
 
 static int omap_i2c_init(struct omap_i2c_dev *dev)
 {
+	struct platform_device *pdev;
+	struct omap_i2c_bus_platform_data *pdata;
 	u16 psc = 0, scll = 0, sclh = 0, buf = 0;
 	u16 fsscll = 0, fssclh = 0, hsscll = 0, hssclh = 0;
 	unsigned long fclk_rate = 12000000;
 	unsigned long timeout;
 	unsigned long internal_clk = 0;
 
+	pdev = container_of(dev->dev, struct platform_device, dev);
+	pdata = pdev->dev.platform_data;
+
 	if (dev->rev >= OMAP_I2C_REV_2) {
 		/* Disable I2C controller before soft reset */
 		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG,
@@ -451,24 +458,47 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 
 			/* For first phase of HS mode */
 			scl = internal_clk / 400;
-			fsscll = scl - (scl / 3) - 7;
-			fssclh = (scl / 3) - 5;
+			if ((pdata->hs_phase1.scll > 7) &&
+					(pdata->hs_phase1.sclh > 5)) {
+				fsscll = pdata->hs_phase1.scll - 7;
+				fssclh = pdata->hs_phase1.sclh - 5;
+			} else {
+				fsscll = scl - (scl / 3) - 7;
+				fssclh = (scl / 3) - 5;
+			}
 
 			/* For second phase of HS mode */
 			scl = fclk_rate / dev->speed;
-			hsscll = scl - (scl / 3) - 7;
-			hssclh = (scl / 3) - 5;
+			if ((pdata->hs_phase2.scll > 7) &&
+					(pdata->hs_phase2.sclh > 5)) {
+				hsscll = pdata->hs_phase2.scll - 7;
+				hssclh = pdata->hs_phase2.sclh - 5;
+			} else {
+				hsscll = scl - (scl / 3) - 7;
+				hssclh = (scl / 3) - 5;
+			}
 		} else if (dev->speed > 100) {
 			unsigned long scl;
 
 			/* Fast mode */
 			scl = internal_clk / dev->speed;
-			fsscll = scl - (scl / 3) - 7;
-			fssclh = (scl / 3) - 5;
+			if ((pdata->fast.scll > 7) && (pdata->fast.sclh > 5)) {
+				fsscll = pdata->fast.scll - 7;
+				fssclh = pdata->fast.sclh - 5;
+			} else {
+				fsscll = scl - (scl / 3) - 7;
+				fssclh = (scl / 3) - 5;
+			}
 		} else {
 			/* Standard mode */
-			fsscll = internal_clk / (dev->speed * 2) - 7;
-			fssclh = internal_clk / (dev->speed * 2) - 5;
+			if ((pdata->standard.scll > 7) &&
+					(pdata->standard.sclh > 5)) {
+				fsscll = pdata->standard.scll - 7;
+				fssclh = pdata->standard.sclh - 5;
+			} else {
+				fsscll = internal_clk / (dev->speed * 2) - 7;
+				fssclh = internal_clk / (dev->speed * 2) - 5;
+			}
 		}
 		scll = (hsscll << OMAP_I2C_SCLL_HSSCLL) | fsscll;
 		sclh = (hssclh << OMAP_I2C_SCLH_HSSCLH) | fssclh;
diff --git a/include/linux/i2c-omap.h b/include/linux/i2c-omap.h
index 78ebf50..9137d66 100644
--- a/include/linux/i2c-omap.h
+++ b/include/linux/i2c-omap.h
@@ -1,8 +1,18 @@
 #ifndef __I2C_OMAP_H__
 #define __I2C_OMAP_H__
 
+struct scl_nclk {
+	unsigned short	scll;
+	unsigned short	sclh;
+};
+
 struct omap_i2c_bus_platform_data {
 	u32		clkrate;
+	struct scl_nclk	standard;
+	struct scl_nclk	fast;
+	struct scl_nclk	hs_phase1;
+	struct scl_nclk	hs_phase2;
+
 	void		(*set_mpu_wkup_lat)(struct device *dev, long set);
 };
 
-- 
1.5.4.7

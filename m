From: balajitk@ti.com
Subject: [RFC][PATCH] [I2C]pass scll, sclh through board file for Errata i585
Date: Mon, 19 Apr 2010 20:33:28 +0530
Message-ID: <1271689408-2397-1-git-send-email-balajitk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44462 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754388Ab0DSPDd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Apr 2010 11:03:33 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o3JF3U6n028552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 19 Apr 2010 10:03:32 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Balaji T K <balajitk@ti.com>

From: Balaji T K <balajitk@ti.com>

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

Other board file changes are yet to be done.
	arch/arm/mach-omap1/board-ams-delta.c
	arch/arm/mach-omap1/board-fsample.c
	arch/arm/mach-omap1/board-generic.c
	arch/arm/mach-omap1/board-h2.c
	arch/arm/mach-omap1/board-h3.c
	arch/arm/mach-omap1/board-innovator.c
	arch/arm/mach-omap1/board-nokia770.c
	arch/arm/mach-omap1/board-osk.c
	arch/arm/mach-omap1/board-palmte.c
	arch/arm/mach-omap1/board-palmtt.c
	arch/arm/mach-omap1/board-palmz71.c
	arch/arm/mach-omap1/board-perseus2.c
	arch/arm/mach-omap1/board-sx1.c
	arch/arm/mach-omap1/board-voiceblue.c
	arch/arm/mach-omap2/board-2430sdp.c 
	arch/arm/mach-omap2/board-3430sdp.c
	arch/arm/mach-omap2/board-am3517evm.c
	arch/arm/mach-omap2/board-cm-t35.c
	arch/arm/mach-omap2/board-devkit8000.c
	arch/arm/mach-omap2/board-igep0020.c
	arch/arm/mach-omap2/board-ldp.c
	arch/arm/mach-omap2/board-n8x0.c
	arch/arm/mach-omap2/board-omap3beagle.c
	arch/arm/mach-omap2/board-omap3evm.c
	arch/arm/mach-omap2/board-omap3pandora.c
	arch/arm/mach-omap2/board-omap3touchbook.c
	arch/arm/mach-omap2/board-overo.c
	arch/arm/mach-omap2/board-rx51-peripherals.c
	arch/arm/mach-omap2/board-zoom-peripherals.c

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c   |   26 ++++++++++++++--
 arch/arm/plat-omap/i2c.c              |   38 +++++++++++++++---------
 arch/arm/plat-omap/include/plat/i2c.h |   37 ++++++++++++++++++++++-
 drivers/i2c/busses/i2c-omap.c         |   52 ++++++++++++++++++++++++++------
 4 files changed, 124 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 5822bcf..839306e 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -594,6 +594,26 @@ static struct twl4030_platform_data sdp3430_twldata = {
 	.vpll2		= &sdp3430_vpll2,
 };
 
+static struct omap_i2c_scl_data __initdata sdp3430_i2c1_scl_data = {
+	.rate	= 2600,
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
+static struct omap_i2c_scl_data __initdata sdp3430_i2c2_scl_data = {
+	.rate	= 400,
+};
+
+static struct omap_i2c_scl_data __initdata sdp3430_i2c3_scl_data = {
+	.rate	= 400,
+};
+
 static struct i2c_board_info __initdata sdp3430_i2c_boardinfo[] = {
 	{
 		I2C_BOARD_INFO("twl4030", 0x48),
@@ -606,12 +626,12 @@ static struct i2c_board_info __initdata sdp3430_i2c_boardinfo[] = {
 static int __init omap3430_i2c_init(void)
 {
 	/* i2c1 for PMIC only */
-	omap_register_i2c_bus(1, 2600, sdp3430_i2c_boardinfo,
+	omap_register_i2c_bus(1, &sdp3430_i2c1_scl_data, sdp3430_i2c_boardinfo,
 			ARRAY_SIZE(sdp3430_i2c_boardinfo));
 	/* i2c2 on camera connector (for sensor control) and optional isp1301 */
-	omap_register_i2c_bus(2, 400, NULL, 0);
+	omap_register_i2c_bus(2, &sdp3430_i2c2_scl_data, NULL, 0);
 	/* i2c3 on display connector (for DVI, tfp410) */
-	omap_register_i2c_bus(3, 400, NULL, 0);
+	omap_register_i2c_bus(3, &sdp3430_i2c3_scl_data, NULL, 0);
 	return 0;
 }
 
diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index 624e262..81c9d3e 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -70,14 +70,14 @@ static struct resource i2c_resources[][2] = {
 		},					\
 	}
 
-static u32 i2c_rate[ARRAY_SIZE(i2c_resources)];
+static struct omap_i2c_platform_data i2c_pdata[ARRAY_SIZE(i2c_resources)];
 static struct platform_device omap_i2c_devices[] = {
-	I2C_DEV_BUILDER(1, i2c_resources[0], &i2c_rate[0]),
+	I2C_DEV_BUILDER(1, i2c_resources[0], &i2c_pdata[0]),
 #if	defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
-	I2C_DEV_BUILDER(2, i2c_resources[1], &i2c_rate[1]),
+	I2C_DEV_BUILDER(2, i2c_resources[1], &i2c_pdata[1]),
 #endif
 #if	defined(CONFIG_ARCH_OMAP3)
-	I2C_DEV_BUILDER(3, i2c_resources[2], &i2c_rate[2]),
+	I2C_DEV_BUILDER(3, i2c_resources[2], &i2c_pdata[2]),
 #endif
 };
 
@@ -146,8 +146,8 @@ static int __init omap_i2c_bus_setup(char *str)
 	get_options(str, 3, ints);
 	if (ints[0] < 2 || ints[1] < 1 || ints[1] > ports)
 		return 0;
-	i2c_rate[ints[1] - 1] = ints[2];
-	i2c_rate[ints[1] - 1] |= OMAP_I2C_CMDLINE_SETUP;
+	i2c_pdata[ints[1] - 1].rate = ints[2];
+	i2c_pdata[ints[1] - 1].rate |= OMAP_I2C_CMDLINE_SETUP;
 
 	return 1;
 }
@@ -161,9 +161,9 @@ static int __init omap_register_i2c_bus_cmdline(void)
 {
 	int i, err = 0;
 
-	for (i = 0; i < ARRAY_SIZE(i2c_rate); i++)
-		if (i2c_rate[i] & OMAP_I2C_CMDLINE_SETUP) {
-			i2c_rate[i] &= ~OMAP_I2C_CMDLINE_SETUP;
+	for (i = 0; i < ARRAY_SIZE(i2c_pdata); i++)
+		if (i2c_pdata[i].rate & OMAP_I2C_CMDLINE_SETUP) {
+			i2c_pdata[i].rate &= ~OMAP_I2C_CMDLINE_SETUP;
 			err = omap_i2c_add_bus(i + 1);
 			if (err)
 				goto out;
@@ -183,7 +183,7 @@ subsys_initcall(omap_register_i2c_bus_cmdline);
  *
  * Returns 0 on success or an error code.
  */
-int __init omap_register_i2c_bus(int bus_id, u32 clkrate,
+int __init omap_register_i2c_bus(int bus_id, struct omap_i2c_scl_data *pdata,
 			  struct i2c_board_info const *info,
 			  unsigned len)
 {
@@ -196,10 +196,20 @@ int __init omap_register_i2c_bus(int bus_id, u32 clkrate,
 		if (err)
 			return err;
 	}
-
-	if (!i2c_rate[bus_id - 1])
-		i2c_rate[bus_id - 1] = clkrate;
-	i2c_rate[bus_id - 1] &= ~OMAP_I2C_CMDLINE_SETUP;
+	if (pdata != NULL) {
+		if (!i2c_pdata[bus_id - 1].rate)
+			i2c_pdata[bus_id - 1].rate = pdata->rate;
+		i2c_pdata[bus_id - 1].rate &= ~OMAP_I2C_CMDLINE_SETUP;
+
+		i2c_pdata[bus_id - 1].standard.scll = pdata->standard_scll;
+		i2c_pdata[bus_id - 1].standard.sclh = pdata->standard_sclh;
+		i2c_pdata[bus_id - 1].fast.scll = pdata->fast_mode_scll;
+		i2c_pdata[bus_id - 1].fast.sclh = pdata->fast_mode_sclh;
+		i2c_pdata[bus_id - 1].hs_phase1.scll = pdata->hs_phase1_scll;
+		i2c_pdata[bus_id - 1].hs_phase1.sclh = pdata->hs_phase1_sclh;
+		i2c_pdata[bus_id - 1].hs_phase2.scll = pdata->hs_phase2_scll;
+		i2c_pdata[bus_id - 1].hs_phase2.sclh = pdata->hs_phase2_sclh;
+	}
 
 	return omap_i2c_add_bus(bus_id);
 }
diff --git a/arch/arm/plat-omap/include/plat/i2c.h b/arch/arm/plat-omap/include/plat/i2c.h
index 87f6bf2..a09bbcf 100644
--- a/arch/arm/plat-omap/include/plat/i2c.h
+++ b/arch/arm/plat-omap/include/plat/i2c.h
@@ -20,13 +20,46 @@
  */
 
 #include <linux/i2c.h>
+struct scl_nclk {
+	unsigned short	scll;
+	unsigned short	sclh;
+};
+
+struct omap_i2c_platform_data {
+	u32		rate;
+	struct scl_nclk	standard;
+	struct scl_nclk	fast;
+	struct scl_nclk	hs_phase1;
+	struct scl_nclk	hs_phase2;
+};
+
+struct omap_i2c_scl_data {
+	u32	rate;
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
 
 #if defined(CONFIG_I2C_OMAP) || defined(CONFIG_I2C_OMAP_MODULE)
-extern int omap_register_i2c_bus(int bus_id, u32 clkrate,
+extern int omap_register_i2c_bus(int bus_id, struct omap_i2c_scl_data *pdata,
 				 struct i2c_board_info const *info,
 				 unsigned len);
 #else
-static inline int omap_register_i2c_bus(int bus_id, u32 clkrate,
+static inline int omap_register_i2c_bus(int bus_id,
+				 struct omap_i2c_scl_data *pdata,
 				 struct i2c_board_info const *info,
 				 unsigned len)
 {
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index f2019d2..63de5b5 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -38,6 +38,8 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
+#include <plat/i2c.h>
+
 /* I2C controller revisions */
 #define OMAP_I2C_REV_2			0x20
 
@@ -342,12 +344,17 @@ static void omap_i2c_idle(struct omap_i2c_dev *dev)
 
 static int omap_i2c_init(struct omap_i2c_dev *dev)
 {
+	struct platform_device *pdev;
+	struct omap_i2c_platform_data *pdata;
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
@@ -446,24 +453,47 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 
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
@@ -926,6 +956,7 @@ omap_i2c_probe(struct platform_device *pdev)
 	struct omap_i2c_dev	*dev;
 	struct i2c_adapter	*adap;
 	struct resource		*mem, *irq, *ioarea;
+	struct omap_i2c_platform_data *pdata;
 	irq_handler_t isr;
 	int r;
 	u32 speed = 0;
@@ -954,9 +985,10 @@ omap_i2c_probe(struct platform_device *pdev)
 		r = -ENOMEM;
 		goto err_release_region;
 	}
+	pdata = pdev->dev.platform_data;
 
-	if (pdev->dev.platform_data != NULL)
-		speed = *(u32 *)pdev->dev.platform_data;
+	if (pdata != NULL && pdata->rate)
+		speed = pdata->rate;
 	else
 		speed = 100;	/* Defualt speed */
 
-- 
1.5.4.7


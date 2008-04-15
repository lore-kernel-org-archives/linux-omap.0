From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 01/19] Update audio driver for H2 board
Date: Tue, 15 Apr 2008 10:02:05 -0400
Message-ID: <1208268143-8789-2-git-send-email-edubezval@gmail.com>
References: <1208268143-8789-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:64928 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762077AbYDOOFM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Apr 2008 10:05:12 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3FE0A6p029135
	for <linux-omap@vger.kernel.org>; Tue, 15 Apr 2008 09:04:48 -0500
In-Reply-To: <1208268143-8789-1-git-send-email-edubezval@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Eduardo Valentin <eduardo.valentin@indt.org.br>

From: Eduardo Valentin <eduardo.valentin@indt.org.br>

This patch updates the audio driver based on tsc2101 chip
for H2 board. tsc2101 driver was updated against new spi
framework, but its audio driver for H2 wasn't.

Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
---
 arch/arm/mach-omap1/board-h2.c           |   72 +++++++++++++++---------------
 sound/arm/omap/omap-alsa-tsc2101-mixer.c |    7 ++-
 sound/arm/omap/omap-alsa-tsc2101-mixer.h |    2 +
 sound/arm/omap/omap-alsa-tsc2101.c       |   28 +++++++++--
 sound/arm/omap/omap-alsa-tsc2101.h       |    5 ++
 5 files changed, 71 insertions(+), 43 deletions(-)

diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index aa1f8af..a576b5b 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -320,6 +320,41 @@ static void h2_lcd_dev_init(struct spi_device *tsc2101)
 	platform_device_register(&h2_lcd_device);
 }
 
+static struct omap_mcbsp_reg_cfg mcbsp_regs = {
+	.spcr2 = FREE | FRST | GRST | XRST | XINTM(3),
+	.spcr1 = RINTM(3) | RRST,
+	.rcr2  = RPHASE | RFRLEN2(OMAP_MCBSP_WORD_8) |
+                RWDLEN2(OMAP_MCBSP_WORD_16) | RDATDLY(1),
+	.rcr1  = RFRLEN1(OMAP_MCBSP_WORD_8) | RWDLEN1(OMAP_MCBSP_WORD_16),
+	.xcr2  = XPHASE | XFRLEN2(OMAP_MCBSP_WORD_8) |
+                XWDLEN2(OMAP_MCBSP_WORD_16) | XDATDLY(1) | XFIG,
+	.xcr1  = XFRLEN1(OMAP_MCBSP_WORD_8) | XWDLEN1(OMAP_MCBSP_WORD_16),
+	.srgr1 = FWID(15),
+	.srgr2 = GSYNC | CLKSP | FSGM | FPER(31),
+
+	.pcr0  = CLKXM | CLKRM | FSXP | FSRP | CLKXP | CLKRP,
+	/*.pcr0 = CLKXP | CLKRP,*/        /* mcbsp: slave */
+};
+
+static struct omap_alsa_codec_config alsa_config = {
+	.name                   = "H2 TSC2101",
+	.mcbsp_regs_alsa        = &mcbsp_regs,
+};
+
+static struct platform_device h2_mcbsp1_device = {
+	.name	= "omap_alsa_mcbsp",
+	.id	= 1,
+	.dev = {
+		.platform_data	= &alsa_config,
+	},
+};
+
+static void h2_audio_dev_init(struct spi_device *tsc2101)
+{
+	h2_mcbsp1_device.dev.platform_data = tsc2101;
+	platform_device_register(&h2_mcbsp1_device);
+}
+
 static int h2_tsc2101_init(struct spi_device *spi)
 {
 	int r;
@@ -344,6 +379,7 @@ static int h2_tsc2101_init(struct spi_device *spi)
 	omap_cfg_reg(N15_1610_UWIRE_CS1);
 
 	h2_lcd_dev_init(spi);
+	h2_audio_dev_init(spi);
 
 	return 0;
 err:
@@ -386,48 +422,12 @@ static struct spi_board_info h2_spi_board_info[] __initdata = {
 	},
 };
 
-static struct omap_mcbsp_reg_cfg mcbsp_regs = {
-	.spcr2 = FREE | FRST | GRST | XRST | XINTM(3),
-	.spcr1 = RINTM(3) | RRST,
-	.rcr2  = RPHASE | RFRLEN2(OMAP_MCBSP_WORD_8) |
-                RWDLEN2(OMAP_MCBSP_WORD_16) | RDATDLY(1),
-	.rcr1  = RFRLEN1(OMAP_MCBSP_WORD_8) | RWDLEN1(OMAP_MCBSP_WORD_16),
-	.xcr2  = XPHASE | XFRLEN2(OMAP_MCBSP_WORD_8) |
-                XWDLEN2(OMAP_MCBSP_WORD_16) | XDATDLY(1) | XFIG,
-	.xcr1  = XFRLEN1(OMAP_MCBSP_WORD_8) | XWDLEN1(OMAP_MCBSP_WORD_16),
-	.srgr1 = FWID(15),
-	.srgr2 = GSYNC | CLKSP | FSGM | FPER(31),
-
-	.pcr0  = CLKXM | CLKRM | FSXP | FSRP | CLKXP | CLKRP,
-	/*.pcr0 = CLKXP | CLKRP,*/        /* mcbsp: slave */
-};
-
-static struct omap_alsa_codec_config alsa_config = {
-	.name                   = "H2 TSC2101",
-	.mcbsp_regs_alsa        = &mcbsp_regs,
-	.codec_configure_dev    = NULL, /* tsc2101_configure, */
-	.codec_set_samplerate   = NULL, /* tsc2101_set_samplerate, */
-	.codec_clock_setup      = NULL, /* tsc2101_clock_setup, */
-	.codec_clock_on         = NULL, /* tsc2101_clock_on, */
-	.codec_clock_off        = NULL, /* tsc2101_clock_off, */
-	.get_default_samplerate = NULL, /* tsc2101_get_default_samplerate, */
-};
-
-static struct platform_device h2_mcbsp1_device = {
-	.name	= "omap_alsa_mcbsp",
-	.id	= 1,
-	.dev = {
-		.platform_data	= &alsa_config,
-	},
-};
-
 static struct platform_device *h2_devices[] __initdata = {
 	&h2_nor_device,
 	&h2_nand_device,
 	&h2_smc91x_device,
 	&h2_irda_device,
 	&h2_kp_device,
-	&h2_mcbsp1_device,
 };
 
 static void __init h2_init_smc91x(void)
diff --git a/sound/arm/omap/omap-alsa-tsc2101-mixer.c b/sound/arm/omap/omap-alsa-tsc2101-mixer.c
index 8faba95..09257d7 100644
--- a/sound/arm/omap/omap-alsa-tsc2101-mixer.c
+++ b/sound/arm/omap/omap-alsa-tsc2101-mixer.c
@@ -43,6 +43,7 @@
 #include "omap-alsa-tsc2101.h"
 #include "omap-alsa-tsc2101-mixer.h"
 
+#include <linux/spi/tsc2101.h>
 #include <linux/types.h>
 #include <sound/initval.h>
 #include <sound/control.h>
@@ -68,7 +69,8 @@ static int current_rec_src 		= REC_SRC_SINGLE_ENDED_MICIN_HED;
  */
 inline void omap_tsc2101_audio_write(u8 address, u16 data)
 {
-	omap_tsc2101_write(PAGE2_AUDIO_CODEC_REGISTERS, address, data);
+	tsc2101_write_sync(mcbsp_dev.tsc2101_dev, PAGE2_AUDIO_CODEC_REGISTERS,
+				address, data);
 }
 
 /* 
@@ -76,7 +78,8 @@ inline void omap_tsc2101_audio_write(u8 address, u16 data)
  */
 inline u16 omap_tsc2101_audio_read(u8 address)
 {
-	return (omap_tsc2101_read(PAGE2_AUDIO_CODEC_REGISTERS, address));
+	return (tsc2101_read_sync(mcbsp_dev.tsc2101_dev,
+					PAGE2_AUDIO_CODEC_REGISTERS, address));
 }
 
 /*
diff --git a/sound/arm/omap/omap-alsa-tsc2101-mixer.h b/sound/arm/omap/omap-alsa-tsc2101-mixer.h
index 513614c..b110b36 100644
--- a/sound/arm/omap/omap-alsa-tsc2101-mixer.h
+++ b/sound/arm/omap/omap-alsa-tsc2101-mixer.h
@@ -76,4 +76,6 @@
 
 #define TSC2101_AUDIO_CODEC_REGISTERS_PAGE2     (2)
 
+extern struct mcbsp_dev_info mcbsp_dev;
+
 #endif /*OMAPALSATSC2101MIXER_H_*/
diff --git a/sound/arm/omap/omap-alsa-tsc2101.c b/sound/arm/omap/omap-alsa-tsc2101.c
index 88ed046..9d056ad 100644
--- a/sound/arm/omap/omap-alsa-tsc2101.c
+++ b/sound/arm/omap/omap-alsa-tsc2101.c
@@ -22,6 +22,7 @@
 #include <linux/soundcard.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
+#include <linux/spi/tsc2101.h>
 #include <asm/io.h>
 #include <asm/arch/mcbsp.h>
 
@@ -38,6 +39,8 @@
 #include <asm/arch/omap-alsa.h>
 #include "omap-alsa-tsc2101.h"
 
+struct mcbsp_dev_info mcbsp_dev;
+
 static struct clk *tsc2101_mclk = 0;
 
 //#define DUMP_TSC2101_AUDIO_REGISTERS
@@ -143,7 +146,8 @@ static struct snd_pcm_hardware tsc2101_snd_omap_alsa_capture = {
  */
 inline void tsc2101_audio_write(u8 address, u16 data)
 {
-	omap_tsc2101_write(PAGE2_AUDIO_CODEC_REGISTERS, address, data);
+	tsc2101_write_sync(mcbsp_dev.tsc2101_dev, PAGE2_AUDIO_CODEC_REGISTERS,
+				address, data);
 }
 
 /* 
@@ -151,7 +155,8 @@ inline void tsc2101_audio_write(u8 address, u16 data)
  */
 inline u16 tsc2101_audio_read(u8 address)
 {
-	return (omap_tsc2101_read(PAGE2_AUDIO_CODEC_REGISTERS, address));
+	return (tsc2101_read_sync(mcbsp_dev.tsc2101_dev, PAGE2_AUDIO_CODEC_REGISTERS,
+					address));
 }
 
 #ifdef DUMP_TSC2101_AUDIO_REGISTERS
@@ -341,9 +346,9 @@ int tsc2101_clock_on(void)
 	       err);
 
 	// Now turn the audio on
-	omap_tsc2101_write(PAGE2_AUDIO_CODEC_REGISTERS,
-			TSC2101_CODEC_POWER_CTRL,
-			0x0000);	
+	tsc2101_write_sync(mcbsp_dev.tsc2101_dev, PAGE2_AUDIO_CODEC_REGISTERS,
+				TSC2101_CODEC_POWER_CTRL,
+				0x0000);
 	return 0;	
 }
 
@@ -382,9 +387,22 @@ int tsc2101_get_default_samplerate(void)
 
 static int __devinit snd_omap_alsa_tsc2101_probe(struct platform_device *pdev)
 {
+	struct spi_device *tsc2101;
 	int	ret;
 	struct	omap_alsa_codec_config *codec_cfg;
 	
+	tsc2101 = dev_get_drvdata(&pdev->dev);
+	if (tsc2101 == NULL) {
+		dev_err(&pdev->dev, "no platform data\n");
+		return -ENODEV;
+	}
+	if (strncmp(tsc2101->modalias, "tsc2101", 8) != 0) {
+		dev_err(&pdev->dev, "tsc2101 not found\n");
+		return -EINVAL;
+	}
+	mcbsp_dev.mcbsp_dev = pdev;
+	mcbsp_dev.tsc2101_dev = tsc2101;
+
 	codec_cfg = pdev->dev.platform_data;
 	if (codec_cfg != NULL) {
 		codec_cfg->hw_constraints_rates	= &tsc2101_hw_constraints_rates;
diff --git a/sound/arm/omap/omap-alsa-tsc2101.h b/sound/arm/omap/omap-alsa-tsc2101.h
index 85dccbb..73999a0 100644
--- a/sound/arm/omap/omap-alsa-tsc2101.h
+++ b/sound/arm/omap/omap-alsa-tsc2101.h
@@ -42,6 +42,11 @@
 
 #define PAGE2_AUDIO_CODEC_REGISTERS	(2)
 
+struct mcbsp_dev_info {
+	struct platform_device *mcbsp_dev;
+	struct spi_device *tsc2101_dev;
+};
+
 struct tsc2101_samplerate_reg_info {
 	u16 sample_rate;
 	u8 divisor;
-- 
1.5.5-rc3.GIT


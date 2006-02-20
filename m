From: "Daniel Petrini" <d.pensator@gmail.com>
Subject: [PATCH] Alsa modularisations and support for tsc2101 2/7
Date: Mon, 20 Feb 2006 13:47:34 -0400
Message-ID: <9268368b0602200947g57ed39d6y28d4612ed4278cda@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_Part_94_26436482.1140457654181"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

------=_Part_94_26436482.1140457654181
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

ALSA Omap Patch

This patch moves codec files to mach-omap1 file and adds supports in
makefile for this

signed-off by Daniel Petrini <d.pensator@gmail.com>
signed-off by Mika Laitio <lamikr@cc.jyu.fi>

Daniel
--
INdT - Manaus - Brazil

------=_Part_94_26436482.1140457654181
Content-Type: text/x-patch; name=alsa2-20060214.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ejx2kur7
Content-Disposition: attachment; filename="alsa2-20060214.patch"

ALSA Omap Patch

This patch moves codec files to mach-omap1 file and adds supports in makefile for this

signed-off by Daniel Petrini <d.pensator@gmail.com>
signed-off by Mika Laitio <lamikr@cc.jyu.fi>

Index: linux-omap-2.6.git-q/arch/arm/mach-omap1/Makefile
===================================================================
--- linux-omap-2.6.git-q.orig/arch/arm/mach-omap1/Makefile	2006-02-14 10:33:48.000000000 -0400
+++ linux-omap-2.6.git-q/arch/arm/mach-omap1/Makefile	2006-02-14 10:36:39.000000000 -0400
@@ -35,3 +35,6 @@ led-$(CONFIG_MACH_OMAP_PERSEUS2)	+= leds
 led-$(CONFIG_MACH_OMAP_OSK)		+= leds-osk.o
 obj-$(CONFIG_LEDS)			+= $(led-y)
 
+#ALSA codec files
+obj-$(CONFIG_MACH_OMAP_H2) += omap-alsa-tsc2101.o
+obj-$(CONFIG_MACH_OMAP_OSK) += omap-alsa-aic23.o
Index: linux-omap-2.6.git-q/arch/arm/mach-omap1/omap-alsa-aic23.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-omap-2.6.git-q/arch/arm/mach-omap1/omap-alsa-aic23.c	2006-02-14 15:03:38.000000000 -0400
@@ -0,0 +1,221 @@
+/*
+ * arch/arm/mach-omap1/omap-alsa-aic23.c
+ * 
+ * Alsa codec Driver for AIC23 chip on OSK5912 platform board
+ *
+ * Copyright (C) 2005 Instituto Nokia de Tecnologia - INdT - Manaus Brazil
+ * Written by Daniel Petrini, David Cohen, Anderson Briglia
+ *            {daniel.petrini, david.cohen, anderson.briglia}@indt.org.br
+ * 
+ * Based in former alsa driver for osk and oss driver
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * History:
+ *
+ * 2006-02-07   Daniel Petrini  - Codec specific function separated. File 
+ *                                renamed to omap-alsa-aic23.c
+ * 2006-02-10	Mika Laitio	  Unified the implementation so that the samplerates available
+ * 				  are now in the aic23_samplerate_reg_info structure.
+ */
+
+#ifdef CONFIG_SND
+
+#include <sound/driver.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/initval.h>
+#include <sound/control.h>
+#include <linux/clk.h>
+#include <asm/arch/clock.h>
+#include <asm/arch/aic23.h>
+
+#include <asm/arch/omap-alsa.h>
+#include "omap-alsa-aic23.h"
+
+static struct clk *aic23_mclk = 0;
+
+/* aic23 related */
+static const struct aic23_samplerate_reg_info
+ rate_reg_info[NUMBER_SAMPLE_RATES_SUPPORTED] = {
+	{4000, 0x06, 1},		/*  4000 */
+	{8000, 0x06, 0},		/*  8000 */
+	{16000, 0x0C, 1},		/* 16000 */
+	{22050, 0x11, 1},               /* 22050 */
+	{24000, 0x00, 1},		/* 24000 */
+	{32000, 0x0C, 0},		/* 32000 */
+	{44100, 0x11, 0},		/* 44100 */
+	{48000, 0x00, 0},		/* 48000 */
+	{88200, 0x1F, 0},		/* 88200 */
+	{96000, 0x0E, 0},		/* 96000 */
+};
+/*
+ * Codec/mcbsp init and configuration section
+ * codec dependent code.
+ */
+
+extern int tlv320aic23_write_value(u8 reg, u16 value);
+
+/* TLV320AIC23 is a write only device */
+void audio_aic23_write(u8 address, u16 data)
+{
+	tlv320aic23_write_value(address, data);
+}
+EXPORT_SYMBOL_GPL(audio_aic23_write);
+
+/*
+ * Sample rate changing
+ */
+void aic23_set_samplerate(long rate)
+{
+	u8 count = 0;
+	u16 data = 0;
+
+	/* Fix the rate if it has a wrong value */
+	if (rate >= 96000)
+		rate = 96000;
+	else if (rate >= 88200)
+		rate = 88200;
+	else if (rate >= 48000)
+		rate = 48000;
+	else if (rate >= 44100)
+		rate = 44100;
+	else if (rate >= 32000)
+		rate = 32000;
+	else if (rate >= 24000)
+		rate = 24000;
+	else if (rate >= 22050)
+		rate = 22050;
+	else if (rate >= 16000)
+		rate = 16000;
+	else if (rate >= 8000)
+		rate = 8000;
+	else
+		rate = 4000;
+
+	/* Search for the right sample rate */
+	/* Verify what happens if the rate is not supported
+	 * now it goes to 96Khz */
+	while ((rate_reg_info[count].sample_rate != rate) &&
+	       (count < (NUMBER_SAMPLE_RATES_SUPPORTED - 1))) {
+		count++;
+	}
+
+	data = (rate_reg_info[count].divider << CLKIN_SHIFT) |
+	    (rate_reg_info[count].control << BOSR_SHIFT) | USB_CLK_ON;
+
+	audio_aic23_write(SAMPLE_RATE_CONTROL_ADDR, data);
+}
+
+inline void aic23_configure(void)
+{
+	/* Reset codec */
+	audio_aic23_write(RESET_CONTROL_ADDR, 0);
+
+	/* Initialize the AIC23 internal state */
+
+	/* Analog audio path control, DAC selected, delete INSEL_MIC for line in */
+	audio_aic23_write(ANALOG_AUDIO_CONTROL_ADDR, DEFAULT_ANALOG_AUDIO_CONTROL);
+
+	/* Digital audio path control, de-emphasis control 44.1kHz */
+	audio_aic23_write(DIGITAL_AUDIO_CONTROL_ADDR, DEEMP_44K);
+
+	/* Digital audio interface, master/slave mode, I2S, 16 bit */
+#ifdef AIC23_MASTER
+	audio_aic23_write(DIGITAL_AUDIO_FORMAT_ADDR,
+			  MS_MASTER | IWL_16 | FOR_DSP);
+#else
+	audio_aic23_write(DIGITAL_AUDIO_FORMAT_ADDR, IWL_16 | FOR_DSP);
+#endif
+
+	/* Enable digital interface */
+	audio_aic23_write(DIGITAL_INTERFACE_ACT_ADDR, ACT_ON);
+}
+
+/*
+ *  Omap MCBSP clock configuration and Power Management
+ *  
+ *  Here we have some functions that allows clock to be enabled and
+ *   disabled only when needed. Besides doing clock configuration 
+ *   it allows turn on/turn off audio when necessary. 
+ */
+/*
+ * Do clock framework mclk search
+ */
+void aic23_clock_setup(void)
+{
+	aic23_mclk = clk_get(0, "mclk");
+}
+
+/*
+ * Do some sanity check, set clock rate, starts it and
+ *  turn codec audio on 
+ */
+int aic23_clock_on(void)
+{
+	if (clk_get_usecount(aic23_mclk) > 0) {
+		/* MCLK is already in use */
+		printk(KERN_WARNING
+		       "MCLK in use at %d Hz. We change it to %d Hz\n",
+		       (uint) clk_get_rate(aic23_mclk),
+		       CODEC_CLOCK);
+	}
+	
+	if (clk_set_rate(aic23_mclk, CODEC_CLOCK)) {
+		printk(KERN_ERR
+		       "Cannot set MCLK for AIC23 CODEC\n");
+		return -ECANCELED;
+	}
+
+	clk_enable(aic23_mclk);
+
+	printk(KERN_DEBUG
+		"MCLK = %d [%d], usecount = %d\n",
+	       (uint) clk_get_rate(aic23_mclk), CODEC_CLOCK,
+	       clk_get_usecount(aic23_mclk));
+
+	/* Now turn the audio on */
+	audio_aic23_write(POWER_DOWN_CONTROL_ADDR, 
+			  ~DEVICE_POWER_OFF & ~OUT_OFF & ~DAC_OFF &
+			  ~ADC_OFF & ~MIC_OFF & ~LINE_OFF);	
+	return 0;
+}
+/*
+ * Do some sanity check, turn clock off and then turn
+ *  codec audio off
+ */
+int aic23_clock_off(void)
+{
+	if  (clk_get_usecount(aic23_mclk) > 0) { 
+		if (clk_get_rate(aic23_mclk) != CODEC_CLOCK) {
+			printk(KERN_WARNING
+			       "MCLK for audio should be %d Hz. But is %d Hz\n",
+			       (uint) clk_get_rate(aic23_mclk),
+			       CODEC_CLOCK);
+		}
+
+		clk_disable(aic23_mclk);
+	}
+	
+	audio_aic23_write(POWER_DOWN_CONTROL_ADDR,
+			  DEVICE_POWER_OFF | OUT_OFF | DAC_OFF |
+			  ADC_OFF | MIC_OFF | LINE_OFF);	
+	return 0;
+}
+
+int aic23_get_default_samplerate(void)
+{
+	return DEFAULT_SAMPLE_RATE;
+}
+
+#else
+void aic23_configure(void){}
+void aic23_set_samplerate(long rate){};
+void aic23_clock_setup(void){}
+int  aic23_clock_on(void){return 0;}
+int  aic23_clock_off(void){return 0;}
+void aic23_get_default_samplerate(void){}
+#endif
Index: linux-omap-2.6.git-q/arch/arm/mach-omap1/omap-alsa-aic23.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-omap-2.6.git-q/arch/arm/mach-omap1/omap-alsa-aic23.h	2006-02-14 10:36:39.000000000 -0400
@@ -0,0 +1,76 @@
+/*
+ * sound/arm/omap-alsa-aic23.h
+ * 
+ * Alsa Driver for AIC23 codec on OSK5912 platform board
+ *
+ * Copyright (C) 2005 Instituto Nokia de Tecnologia - INdT - Manaus Brazil
+ * Written by Daniel Petrini, David Cohen, Anderson Briglia
+ *            {daniel.petrini, david.cohen, anderson.briglia}@indt.org.br
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ *  History
+ *  -------
+ *
+ *  2006/02/08 INdT - Daniel Petrini - Alsa driver for omap osk, codec
+ *                                     modularisation. File creation.
+ *  2006/02/10 Mika Laitio	     - aic23_samplerate_reg_info structure moved to here
+ * 				       and contains now the samplerate parameter.
+ *  					
+ */
+
+#ifndef __OMAP_ALSA_AIC23_H
+#define __OMAP_ALSA_AIC23_H
+
+#include <sound/driver.h>
+#include <asm/arch/dma.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <asm/arch/mcbsp.h>
+
+/* Define to set the AIC23 as the master w.r.t McBSP */
+#define AIC23_MASTER
+
+#define NUMBER_SAMPLE_RATES_SUPPORTED 10
+
+/*
+ * AUDIO related MACROS
+ */
+#define DEFAULT_BITPERSAMPLE          16
+#define DEFAULT_SAMPLE_RATE	      44100
+#define CODEC_CLOCK                   12000000
+#define AUDIO_MCBSP                   OMAP_MCBSP1
+
+#define DEFAULT_OUTPUT_VOLUME         0x60
+#define DEFAULT_INPUT_VOLUME          0x00	/* 0 ==> mute line in */
+
+#define OUTPUT_VOLUME_MIN             LHV_MIN
+#define OUTPUT_VOLUME_MAX             LHV_MAX
+#define OUTPUT_VOLUME_RANGE           (OUTPUT_VOLUME_MAX - OUTPUT_VOLUME_MIN)
+#define OUTPUT_VOLUME_MASK            OUTPUT_VOLUME_MAX
+
+#define INPUT_VOLUME_MIN 	      LIV_MIN
+#define INPUT_VOLUME_MAX 	      LIV_MAX
+#define INPUT_VOLUME_RANGE 	      (INPUT_VOLUME_MAX - INPUT_VOLUME_MIN)
+#define INPUT_VOLUME_MASK 	      INPUT_VOLUME_MAX
+
+#define SIDETONE_MASK                 0x1c0
+#define SIDETONE_0                    0x100
+#define SIDETONE_6                    0x000
+#define SIDETONE_9                    0x040
+#define SIDETONE_12                   0x080
+#define SIDETONE_18                   0x0c0
+
+#define DEFAULT_ANALOG_AUDIO_CONTROL  DAC_SELECTED | STE_ENABLED | BYPASS_ON | INSEL_MIC | MICB_20DB
+
+struct aic23_samplerate_reg_info {
+	u32 sample_rate;
+	u8 control;		/* SR3, SR2, SR1, SR0 and BOSR */
+	u8 divider;		/* if 0 CLKIN = MCLK, if 1 CLKIN = MCLK/2 */
+};
+
+#endif
+

------=_Part_94_26436482.1140457654181
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_94_26436482.1140457654181--

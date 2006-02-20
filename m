From: lamikr <lamikr@cc.jyu.fi>
Subject: [PATCH] Alsa modularisations and support for tsc2101 6/7
Date: Mon, 20 Feb 2006 20:28:11 +0200
Message-ID: <43FA0A3B.7070303@cc.jyu.fi>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040704080704020405070002"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------040704080704020405070002
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

ALSA Omap Patch

This patch creates support for tsc2101 codec for alsa omap. Tested with
boards H2 and iPAQ h6300.

signed-off by Mika Laitio <lamikr@cc.jyu.fi>
signed-off by Daniel Petrini <d.pensator@gmail.com>

----------------
Mika Laitio

--------------040704080704020405070002
Content-Type: text/x-patch;
 name="alsa6-20060214.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa6-20060214.patch"

ALSA Omap Patch

This patch only creates support for tsc2101 codec for alsa omap. Tested with 
boards H2 and iPAQ h6300.

signed-off by Mika Laitio <lamikr@cc.jyu.fi>
signed-off by Daniel Petrini <d.pensator@gmail.com>

Index: linux-omap-2.6.git-q/sound/arm/Kconfig
===================================================================
--- linux-omap-2.6.git-q.orig/sound/arm/Kconfig	2006-02-16 08:51:16.000000000 -0400
+++ linux-omap-2.6.git-q/sound/arm/Kconfig	2006-02-16 08:52:45.000000000 -0400
@@ -44,5 +44,19 @@ config SND_OMAP_AIC23
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-omap-aic23.
+	  
+config SND_OMAP_TSC2101
+ 	tristate "OMAP TSC2101 alsa driver"
+ 	depends on ARCH_OMAP && SND
+ 	select SND_PCM
+         select OMAP_TSC2101
+         select OMAP_UWIRE if ARCH_OMAP
+ 	help
+ 	  Say Y here if you have a OMAP platform board
+ 	  and want to use its TSC2101 audio chip. Driver has
+ 	  been tested with H2 and iPAQ h6300.
+ 
+ 	  To compile this driver as a module, choose M here: the module
+ 	  will be called snd-omap-tsc2101.
 
 endmenu
Index: linux-omap-2.6.git-q/arch/arm/mach-omap1/omap-alsa-tsc2101.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-omap-2.6.git-q/arch/arm/mach-omap1/omap-alsa-tsc2101.c	2006-02-16 08:57:48.000000000 -0400
@@ -0,0 +1,346 @@
+/*
+ * arch/arm/mach-omap1/omap-alsa-tsc2101.c
+ * 
+ * Alsa codec Driver for TSC2101 chip for OMAP platform boards. 
+ * Code obtained from oss omap drivers
+ *
+ * Copyright (C) 2004 Texas Instruments, Inc.
+ * 	Written by Nishanth Menon and Sriram Kannan
+ * 	
+ * Copyright (C) 2006 Instituto Nokia de Tecnologia - INdT - Manaus Brazil
+ * 	Alsa modularization by Daniel Petrini (d.pensator@gmail.com)
+ * 
+ * Copyright (C) 2006 Mika Laitio (lamikr@cc.jyu.fi)
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * History:
+ *
+ * 2006-02-08 - Daniel Petrini - File creation. Support file for ALSA wrt codec
+ * 				 tsc2101 that populates H2 and H3.
+ * 2006-02-10	Mika Laitio    - Clock on/clock off routines fixed.
+ * 				 tsc2101_set_samplerate() does not take samplerates
+ * 				 that are acceptable as a parameter.
+ */
+/* routines extracted from file oss/omap-audio-tsc2101.c
+ * or called from drivers/ssi/omap-tsc2101.c */
+
+#ifdef CONFIG_SND
+
+#include <linux/delay.h>
+#include <linux/soundcard.h>
+#include <linux/clk.h>
+#include <asm/io.h>
+#include <asm/arch/mcbsp.h>
+
+#include <linux/slab.h>
+#ifdef CONFIG_PM
+#include <linux/pm.h>
+#endif
+#include <asm/mach-types.h>
+#include <asm/arch/dma.h>
+#include <asm/arch/clock.h>
+
+#include <asm/hardware/tsc2101.h>
+#include <../drivers/ssi/omap-tsc2101.h>
+
+#include <asm/arch/omap-alsa.h>
+#include "omap-alsa-tsc2101.h"
+
+static struct clk *tsc2101_mclk = 0;
+
+//#define DUMP_TSC2101_AUDIO_REGISTERS
+#undef DUMP_TSC2101_AUDIO_REGISTERS
+
+static const struct tsc2101_samplerate_reg_info
+    rate_reg_info[NUMBER_SAMPLE_RATES_SUPPORTED] = {
+	/* Div 1 */
+	{48000, 0, 0},
+	{44100, 0, 1},
+	/* Div 1.5 */
+	{32000, 1, 0},
+	{29400, 1, 1},
+	/* Div 2 */
+	{24000, 2, 0},
+	{22050, 2, 1},
+	/* Div 3 */
+	{16000, 3, 0},
+	{14700, 3, 1},
+	/* Div 4 */
+	{12000, 4, 0},
+	{11025, 4, 1},
+	/* Div 5 */
+	{9600, 5, 0},
+	{8820, 5, 1},
+	/* Div 5.5 */
+	{8727, 6, 0},
+	{8018, 6, 1},
+	/* Div 6 */
+	{8000, 7, 0},
+	{7350, 7, 1},
+};
+
+/* 
+ * Simplified write for tsc Audio
+ */
+inline void tsc2101_audio_write(u8 address, u16 data)
+{
+	omap_tsc2101_write(PAGE2_AUDIO_CODEC_REGISTERS, address, data);
+}
+
+/* 
+ * Simplified read for tsc  Audio
+ */
+inline u16 tsc2101_audio_read(u8 address)
+{
+	return (omap_tsc2101_read(PAGE2_AUDIO_CODEC_REGISTERS, address));
+}
+
+#ifdef DUMP_TSC2101_AUDIO_REGISTERS
+void dump_tsc2101_audio_reg(void) {
+	printk("TSC2101_AUDIO_CTRL_1 = 0x%04x\n",	tsc2101_audio_read(TSC2101_AUDIO_CTRL_1));
+	printk("TSC2101_HEADSET_GAIN_CTRL = 0x%04x\n",	tsc2101_audio_read(TSC2101_HEADSET_GAIN_CTRL));
+	printk("TSC2101_DAC_GAIN_CTRL = 0x%04x\n", tsc2101_audio_read(TSC2101_DAC_GAIN_CTRL));
+	printk("TSC2101_MIXER_PGA_CTRL = 0x%04x\n",	tsc2101_audio_read(TSC2101_MIXER_PGA_CTRL));
+	printk("TSC2101_AUDIO_CTRL_2 = 0x%04x\n",	tsc2101_audio_read(TSC2101_AUDIO_CTRL_2));
+	printk("TSC2101_CODEC_POWER_CTRL = 0x%04x\n",	tsc2101_audio_read(TSC2101_CODEC_POWER_CTRL));
+	printk("TSC2101_AUDIO_CTRL_3 = 0x%04x\n",	tsc2101_audio_read(TSC2101_AUDIO_CTRL_3));
+	printk("TSC2101_LCH_BASS_BOOST_N0 = 0x%04x\n",	tsc2101_audio_read(TSC2101_LCH_BASS_BOOST_N0));
+	printk("TSC2101_LCH_BASS_BOOST_N1 = 0x%04x\n",	tsc2101_audio_read(TSC2101_LCH_BASS_BOOST_N1));
+	printk("TSC2101_LCH_BASS_BOOST_N2 = 0x%04x\n",	tsc2101_audio_read(TSC2101_LCH_BASS_BOOST_N2));
+	printk("TSC2101_LCH_BASS_BOOST_N3 = 0x%04x\n",	tsc2101_audio_read(TSC2101_LCH_BASS_BOOST_N3));
+	printk("TSC2101_LCH_BASS_BOOST_N4 = 0x%04x\n",	tsc2101_audio_read(TSC2101_LCH_BASS_BOOST_N4));
+	printk("TSC2101_LCH_BASS_BOOST_N5 = 0x%04x\n",	tsc2101_audio_read(TSC2101_LCH_BASS_BOOST_N5));
+	printk("TSC2101_LCH_BASS_BOOST_D1 = 0x%04x\n",	tsc2101_audio_read(TSC2101_LCH_BASS_BOOST_D1));
+	printk("TSC2101_LCH_BASS_BOOST_D2 = 0x%04x\n",	tsc2101_audio_read(TSC2101_LCH_BASS_BOOST_D2));
+	printk("TSC2101_LCH_BASS_BOOST_D4 = 0x%04x\n",	tsc2101_audio_read(TSC2101_LCH_BASS_BOOST_D4));
+	printk("TSC2101_LCH_BASS_BOOST_D5 = 0x%04x\n",	tsc2101_audio_read(TSC2101_LCH_BASS_BOOST_D5));
+	
+	printk("TSC2101_RCH_BASS_BOOST_N0 = 0x%04x\n",	tsc2101_audio_read(TSC2101_RCH_BASS_BOOST_N0));
+	printk("TSC2101_RCH_BASS_BOOST_N1 = 0x%04x\n",	tsc2101_audio_read(TSC2101_RCH_BASS_BOOST_N1));
+	printk("TSC2101_RCH_BASS_BOOST_N2 = 0x%04x\n",	tsc2101_audio_read(TSC2101_RCH_BASS_BOOST_N2));
+	printk("TSC2101_RCH_BASS_BOOST_N3 = 0x%04x\n",	tsc2101_audio_read(TSC2101_RCH_BASS_BOOST_N3));
+	printk("TSC2101_RCH_BASS_BOOST_N4 = 0x%04x\n",	tsc2101_audio_read(TSC2101_RCH_BASS_BOOST_N4));
+	printk("TSC2101_RCH_BASS_BOOST_N5 = 0x%04x\n",	tsc2101_audio_read(TSC2101_RCH_BASS_BOOST_N5));
+	printk("TSC2101_RCH_BASS_BOOST_D1 = 0x%04x\n",	tsc2101_audio_read(TSC2101_RCH_BASS_BOOST_D1));
+	printk("TSC2101_RCH_BASS_BOOST_D2 = 0x%04x\n",	tsc2101_audio_read(TSC2101_RCH_BASS_BOOST_D2));
+	printk("TSC2101_RCH_BASS_BOOST_D4 = 0x%04x\n",	tsc2101_audio_read(TSC2101_RCH_BASS_BOOST_D4));
+	printk("TSC2101_RCH_BASS_BOOST_D5 = 0x%04x\n",	tsc2101_audio_read(TSC2101_RCH_BASS_BOOST_D5));
+					
+	printk("TSC2101_PLL_PROG_1 = 0x%04x\n",	tsc2101_audio_read(TSC2101_PLL_PROG_1));
+	printk("TSC2101_PLL_PROG_1 = 0x%04x\n",	tsc2101_audio_read(TSC2101_PLL_PROG_2));
+	printk("TSC2101_AUDIO_CTRL_4 = 0x%04x\n",	tsc2101_audio_read(TSC2101_AUDIO_CTRL_4));
+	printk("TSC2101_HANDSET_GAIN_CTRL = 0x%04x\n",	tsc2101_audio_read(TSC2101_HANDSET_GAIN_CTRL));
+	printk("TSC2101_BUZZER_GAIN_CTRL = 0x%04x\n",	tsc2101_audio_read(TSC2101_BUZZER_GAIN_CTRL));
+	printk("TSC2101_AUDIO_CTRL_5 = 0x%04x\n",	tsc2101_audio_read(TSC2101_AUDIO_CTRL_5));
+	printk("TSC2101_AUDIO_CTRL_6 = 0x%04x\n",	tsc2101_audio_read(TSC2101_AUDIO_CTRL_6));
+	printk("TSC2101_AUDIO_CTRL_7 = 0x%04x\n",	tsc2101_audio_read(TSC2101_AUDIO_CTRL_7));
+	printk("TSC2101_GPIO_CTRL = 0x%04x\n",	tsc2101_audio_read(TSC2101_GPIO_CTRL));
+	printk("TSC2101_AGC_CTRL = 0x%04x\n",	tsc2101_audio_read(TSC2101_AGC_CTRL));
+	printk("TSC2101_POWERDOWN_STS = 0x%04x\n",	tsc2101_audio_read(TSC2101_POWERDOWN_STS));
+	printk("TSC2101_MIC_AGC_CONTROL = 0x%04x\n",	tsc2101_audio_read(TSC2101_MIC_AGC_CONTROL));
+	printk("TSC2101_CELL_AGC_CONTROL = 0x%04x\n",	tsc2101_audio_read(TSC2101_CELL_AGC_CONTROL));
+}
+#endif
+
+/*
+ * ALSA operations according to board file
+ */
+
+/*
+ * Sample rate changing
+ */
+void tsc2101_set_samplerate(long sample_rate)
+{
+	u8 count = 0;
+	u16 data = 0;
+	int clkgdv = 0;
+
+	u16 srgr1, srgr2;
+	/* wait for any frame to complete */
+	udelay(125);
+	ADEBUG();
+
+	sample_rate	= sample_rate;
+	/* Search for the right sample rate */
+	while ((rate_reg_info[count].sample_rate != sample_rate) &&
+	       (count < NUMBER_SAMPLE_RATES_SUPPORTED)) {
+		count++;
+	}
+	if (count == NUMBER_SAMPLE_RATES_SUPPORTED) {
+		printk(KERN_ERR "Invalid Sample Rate %d requested\n",
+		       (int) sample_rate);
+		return;		// -EPERM;
+	}
+
+	/* Set AC1 */
+	data	= tsc2101_audio_read(TSC2101_AUDIO_CTRL_1);
+	/* Clear prev settings */
+	data	&= ~(AC1_DACFS(0x07) | AC1_ADCFS(0x07));
+	data	|= AC1_DACFS(rate_reg_info[count].divisor) | 
+			AC1_ADCFS(rate_reg_info[count].divisor);
+	tsc2101_audio_write(TSC2101_AUDIO_CTRL_1, data);
+
+	/* Set the AC3 */
+	data	= tsc2101_audio_read(TSC2101_AUDIO_CTRL_3);
+	/*Clear prev settings */
+	data	&= ~(AC3_REFFS | AC3_SLVMS);
+	data	|= (rate_reg_info[count].fs_44kHz) ? AC3_REFFS : 0;
+#ifdef TSC_MASTER
+	data	|= AC3_SLVMS;
+#endif				/* #ifdef TSC_MASTER */
+	tsc2101_audio_write(TSC2101_AUDIO_CTRL_3, data);
+
+	/* program the PLLs */
+	if (rate_reg_info[count].fs_44kHz) {
+		/* 44.1 khz - 12 MHz Mclk */
+		tsc2101_audio_write(TSC2101_PLL_PROG_1, PLL1_PLLSEL |
+				PLL1_PVAL(1) | PLL1_I_VAL(7));	/* PVAL 1; I_VAL 7 */
+		tsc2101_audio_write(TSC2101_PLL_PROG_2, PLL2_D_VAL(0x1490));	/* D_VAL 5264 */
+	} else {
+		/* 48 khz - 12 Mhz Mclk */
+		tsc2101_audio_write(TSC2101_PLL_PROG_1, PLL1_PLLSEL |
+			       PLL1_PVAL(1) | PLL1_I_VAL(8));	/* PVAL 1; I_VAL 8 */
+		tsc2101_audio_write(TSC2101_PLL_PROG_2, PLL2_D_VAL(0x780));	/* D_VAL 1920 */
+	}
+
+	/* Set the sample rate */
+#ifndef TSC_MASTER
+	clkgdv	= CODEC_CLOCK / (sample_rate * (DEFAULT_BITPERSAMPLE * 2 - 1));
+	if (clkgdv)
+		srgr1 = (FWID(DEFAULT_BITPERSAMPLE - 1) | CLKGDV(clkgdv));
+	else
+		return (1);
+
+	/* Stereo Mode */
+	srgr2 = (CLKSM | FSGM | FPER(DEFAULT_BITPERSAMPLE * 2 - 1));
+#else
+	srgr1 = (FWID(DEFAULT_BITPERSAMPLE - 1) | CLKGDV(clkgdv));
+	srgr2 = ((GSYNC | CLKSP | FSGM | FPER(DEFAULT_BITPERSAMPLE * 2 - 1)));
+
+#endif				/* end of #ifdef TSC_MASTER */
+	OMAP_MCBSP_WRITE(OMAP1610_MCBSP1_BASE, SRGR2, srgr2);
+	OMAP_MCBSP_WRITE(OMAP1610_MCBSP1_BASE, SRGR1, srgr1);
+}
+
+void tsc2101_configure(void)
+{
+	//snd_omap_init_mixer();
+}
+
+/*
+ *  Omap MCBSP clock and Power Management configuration
+ *  
+ *  Here we have some functions that allows clock to be enabled and
+ *   disabled only when needed. Besides doing clock configuration 
+ *   it allows turn on/turn off audio when necessary. 
+ */
+ 
+/*
+ * Do clock framework mclk search
+ */
+void tsc2101_clock_setup(void)
+{
+	tsc2101_mclk = clk_get(0, "mclk");
+}
+
+/*
+ * Do some sanity check, set clock rate, starts it and
+ *  turn codec audio on 
+ */
+int tsc2101_clock_on(void) 
+{
+	int	curUseCount;
+	uint	curRate;
+	int	err;
+
+	curUseCount	= clk_get_usecount(tsc2101_mclk);
+	DPRINTK("clock use count = %d\n", curUseCount);
+	if (curUseCount > 0) {
+		// MCLK is already in use
+		printk(KERN_WARNING
+		       "MCLK already in use at %d Hz. We change it to %d Hz\n",
+		       (uint) clk_get_rate(tsc2101_mclk),
+		       CODEC_CLOCK);
+	}
+	curRate	= (uint)clk_get_rate(tsc2101_mclk);
+	DPRINTK("old clock rate = %d\n", curRate);
+	if (curRate != CODEC_CLOCK) {
+		err	= clk_set_rate(tsc2101_mclk, CODEC_CLOCK);
+		if (err) {
+			printk(KERN_ERR
+			       "Cannot set MCLK clock rate for TSC2101 CODEC, error code = %d\n", err);
+			return -ECANCELED;
+		}
+	}
+	else
+	{
+		printk(KERN_INFO
+		       "omap_alsa_tsc2101_clock_on(), no need to change rate, no need to change clock rate, rate already %d Hz.\n",
+		       CODEC_CLOCK);
+	}
+	err		= clk_enable(tsc2101_mclk);
+	curRate		= (uint)clk_get_rate(tsc2101_mclk);
+	curUseCount	= clk_get_usecount(tsc2101_mclk);
+	DPRINTK("MCLK = %d [%d], usecount = %d, clk_enable retval = %d\n",
+	       curRate, 
+	       CODEC_CLOCK,
+	       curUseCount,
+	       err);
+
+	// Now turn the audio on
+	omap_tsc2101_write(PAGE2_AUDIO_CODEC_REGISTERS,
+			TSC2101_CODEC_POWER_CTRL,
+			0x0000);	
+	return 0;	
+}
+
+/*
+ * Do some sanity check, turn clock off and then turn
+ *  codec audio off
+ */
+int tsc2101_clock_off(void) 
+{
+	int curUseCount;
+	int curRate;
+
+	curUseCount	= clk_get_usecount(tsc2101_mclk);
+	DPRINTK("clock use count = %d\n", curUseCount);
+	if  (curUseCount > 0) {
+		curRate	= clk_get_rate(tsc2101_mclk);
+		DPRINTK("clock rate = %d\n", curRate);
+		if (curRate != CODEC_CLOCK) {
+			printk(KERN_WARNING
+			       "MCLK for audio should be %d Hz. But is %d Hz\n",
+			       (uint) clk_get_rate(tsc2101_mclk),
+			       CODEC_CLOCK);
+		}
+		clk_disable(tsc2101_mclk);
+		DPRINTK("clock disabled\n");
+	}
+	tsc2101_audio_write(TSC2101_CODEC_POWER_CTRL,
+			    ~(CPC_SP1PWDN | CPC_SP2PWDN | CPC_BASSBC));
+	DPRINTK("audio codec off\n");
+#ifdef DUMP_TSC2101_AUDIO_REGISTERS
+	printk("tsc2101_clock_off()\n");
+	dump_tsc2101_audio_reg();
+#endif	
+	return 0;	
+}
+
+int tsc2101_get_default_samplerate(void)
+{
+	return DEFAULT_SAMPLE_RATE;
+}
+
+#else
+void tsc2101_configure(void){}
+void tsc2101_set_samplerate(long rate){};
+void tsc2101_clock_setup(void){}
+int  tsc2101_clock_on(void){return 0;}
+int  tsc2101_clock_off(void){return 0;}
+void tsc2101_get_default_samplerate(void){}
+#endif
Index: linux-omap-2.6.git-q/arch/arm/mach-omap1/omap-alsa-tsc2101.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-omap-2.6.git-q/arch/arm/mach-omap1/omap-alsa-tsc2101.h	2006-02-16 09:02:46.000000000 -0400
@@ -0,0 +1,53 @@
+/*
+ * arch/arc/mach-omap1/omap-alsa-tsc2101.h
+ * 
+ * Alsa Driver for TSC2101 codec for OMAP platform boards.
+ *
+ * Based on former omap-aic23.h and tsc2101 OSS drivers.
+ * Copyright (C) 2004 Texas Instruments, Inc.
+ * 	Written by Nishanth Menon and Sriram Kannan
+ *
+ * Copyright (C) 2006 Instituto Nokia de Tecnologia - INdT - Manaus Brazil
+ *          Alsa modularization by Daniel Petrini (d.pensator@gmail.com)
+ * 
+ * Copyright (C) 2006 Mika Laitio (lamikr@cc.jyu.fi)
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * History:
+ *
+ * 2006-02-08   File creation. Support file for codec tsc2101 that populates
+ *              H2 and H3.
+ * 2006-02-10	Cleaned unneed variables, moved sample rate reg-info to here.
+ */
+
+#ifndef OMAP_ALSA_TSC2101_H_
+#define OMAP_ALSA_TSC2101_H_
+
+#include <linux/types.h>
+
+/* Define to set the tsc as the master w.r.t McBSP */
+#define TSC_MASTER
+
+#define NUMBER_SAMPLE_RATES_SUPPORTED	16
+
+/*
+ * AUDIO related MACROS
+ */
+#define DEFAULT_BITPERSAMPLE		16
+#define DEFAULT_SAMPLE_RATE		44100
+#define CODEC_CLOCK 			12000000
+#define AUDIO_MCBSP        		OMAP_MCBSP1
+
+#define PAGE2_AUDIO_CODEC_REGISTERS	(2)
+
+struct tsc2101_samplerate_reg_info {
+	u16 sample_rate;
+	u8 divisor;
+	u8 fs_44kHz;	/* if 0 48 khz, if 1 44.1 khz fsref */
+};
+
+#endif /*OMAP_ALSA_TSC2101_H_*/


--------------040704080704020405070002
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------040704080704020405070002--

From: lamikr <lamikr@cc.jyu.fi>
Subject: [PATCH] Alsa modularisations and support for tsc2101 3/3 (round 2)
Date: Mon, 06 Mar 2006 22:35:12 +0200
Message-ID: <440C9D00.7060902@cc.jyu.fi>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050005070300010604030308"
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

This is a multi-part message in MIME format.
--------------050005070300010604030308
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

OMAP Alsa Patch (3/3)

This 3/3 patch adds the tsc2101 alsa driver support for the omap-h2.
Just like the aic23 alsa driver, the codec
specific functionality is separated from the common alsa driver
functionality that is in the omap-alsa.c.
tsc2101 mixer supports currently the playback selection between
loudspeaker and headset/handset.
Addon of others input and targets should be possible to do afterwards.

In addition it should be possible to add later the support for the
dynamic clocks on top of this series of patches, as discussed
in the omap-linux mailing list.

Signed-off-by: Mika Laitio <lamikr@cc.jyu.fi>
Signed-off-by: Daniel Petrini <d.pensator@gmail.com>



--------------050005070300010604030308
Content-Type: text/x-patch;
 name="0003_omap_alsa_tsc2101.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0003_omap_alsa_tsc2101.patch"

OMAP Alsa Patch (3/3)

This 3/3 patch adds the tsc2101 alsa driver support for the omap-h2. Just like the aic23 alsa driver, the codec
specific functionality is separated from the common alsa driver functionality that is in the omap-alsa.c.
tsc2101 mixer supports currently the playback selection between loudspeaker and headset/handset.
Addon of others input and targets should be possible to do afterwards.

In addition it should be possible to add later the support for the dynamic clocks on top of this series of patches, as discussed 
in the omap-linux mailing list.

Signed-off-by: Mika Laitio <lamikr@cc.jyu.fi>
Signed-off-by: Daniel Petrini <d.pensator@gmail.com>


---

 arch/arm/mach-omap1/board-h2.c           |   45 +-
 sound/arm/Kconfig                        |   14 
 sound/arm/omap/Makefile                  |    3 
 sound/arm/omap/omap-alsa-tsc2101-mixer.c |  864 ++++++++++++++++++++++++++++++
 sound/arm/omap/omap-alsa-tsc2101-mixer.h |   79 +++
 sound/arm/omap/omap-alsa-tsc2101.c       |  439 +++++++++++++++
 sound/arm/omap/omap-alsa-tsc2101.h       |   61 ++
 7 files changed, 1498 insertions(+), 7 deletions(-)
 create mode 100644 sound/arm/omap/omap-alsa-tsc2101-mixer.c
 create mode 100644 sound/arm/omap/omap-alsa-tsc2101-mixer.h
 create mode 100644 sound/arm/omap/omap-alsa-tsc2101.c
 create mode 100644 sound/arm/omap/omap-alsa-tsc2101.h

a3af5691d0cdc9090242363c4276c76bf2d6cfdf
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index 4364d51..da64711 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -40,8 +40,9 @@
 #include <asm/arch/irda.h>
 #include <asm/arch/usb.h>
 #include <asm/arch/keypad.h>
-#include <asm/arch/dma.h>
 #include <asm/arch/common.h>
+#include <asm/arch/mcbsp.h>
+#include <asm/arch/omap-alsa.h>
 
 extern int omap_gpio_init(void);
 
@@ -255,12 +256,6 @@ static int h2_transceiver_mode(struct de
 
 static struct omap_irda_config h2_irda_data = {
 	.transceiver_cap	= IR_SIRMODE | IR_MIRMODE | IR_FIRMODE,
-	.rx_channel		= OMAP_DMA_UART3_RX,
-	.tx_channel		= OMAP_DMA_UART3_TX,
-	.dest_start		= UART3_THR,
-	.src_start		= UART3_RHR,
-	.tx_trigger		= 0,
-	.rx_trigger		= 0,
 };
 
 static struct resource h2_irda_resources[] = {
@@ -285,6 +280,41 @@ static struct platform_device h2_lcd_dev
 	.id		= -1,
 };
 
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
+	//.pcr0 = CLKXP | CLKRP,        /* mcbsp: slave */
+};
+ 
+static struct omap_alsa_codec_config alsa_config = {
+	.name                   = "H2 TSC2101",
+	.mcbsp_regs_alsa        = &mcbsp_regs,
+	.codec_configure_dev    = NULL, // tsc2101_configure,
+	.codec_set_samplerate   = NULL, // tsc2101_set_samplerate,
+	.codec_clock_setup      = NULL, // tsc2101_clock_setup,
+	.codec_clock_on         = NULL, // tsc2101_clock_on,
+	.codec_clock_off        = NULL, // tsc2101_clock_off,
+	.get_default_samplerate = NULL, // tsc2101_get_default_samplerate,
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
 static struct platform_device *h2_devices[] __initdata = {
 	&h2_nor_device,
 	&h2_nand_device,
@@ -292,6 +322,7 @@ static struct platform_device *h2_device
 	&h2_irda_device,
 	&h2_kp_device,
 	&h2_lcd_device,
+	&h2_mcbsp1_device,
 };
 
 static void __init h2_init_smc91x(void)
diff --git a/sound/arm/Kconfig b/sound/arm/Kconfig
index cf07154..cccdf23 100644
--- a/sound/arm/Kconfig
+++ b/sound/arm/Kconfig
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
diff --git a/sound/arm/omap/Makefile b/sound/arm/omap/Makefile
index 74160da..354c7b4 100644
--- a/sound/arm/omap/Makefile
+++ b/sound/arm/omap/Makefile
@@ -4,3 +4,6 @@
 #
 obj-$(CONFIG_SND_OMAP_AIC23) += snd-omap-alsa-aic23.o
 snd-omap-alsa-aic23-objs := omap-alsa.o omap-alsa-dma.o omap-alsa-aic23.o omap-alsa-aic23-mixer.o
+
+obj-$(CONFIG_SND_OMAP_TSC2101) += snd-omap-alsa-tsc2101.o
+snd-omap-alsa-tsc2101-objs := omap-alsa.o omap-alsa-dma.o omap-alsa-tsc2101.o omap-alsa-tsc2101-mixer.o
diff --git a/sound/arm/omap/omap-alsa-tsc2101-mixer.c b/sound/arm/omap/omap-alsa-tsc2101-mixer.c
new file mode 100644
index 0000000..9dfaea8
--- /dev/null
+++ b/sound/arm/omap/omap-alsa-tsc2101-mixer.c
@@ -0,0 +1,864 @@
+/*
+ * sound/arm/omap/omap-alsa-tsc2101-mixer.c
+ * 
+ * Alsa Driver for TSC2101 codec for OMAP platform boards.
+ *
+ * Copyright (C) 2005 Mika Laitio <lamikr@cc.jyu.fi> and 
+ * 		     Everett Coleman II <gcc80x86@fuzzyneural.net>
+ *
+ * Board initialization code is based on the code in TSC2101 OSS driver.
+ * Copyright (C) 2004 Texas Instruments, Inc.
+ * 	Written by Nishanth Menon and Sriram Kannan
+ * 
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
+ * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the  GNU General Public License along
+ * with this program; if not, write  to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * History:
+ *
+ * 2006-03-01   Mika Laitio - Mixer for the tsc2101 driver used in omap boards.
+ * 		Can switch between headset and loudspeaker playback, 
+ * 		mute and unmute dgc, set dgc volume. Record source switch,
+ * 		keyclick, buzzer and headset volume and handset volume control 
+ * 		are still missing.
+ * 		
+ */
+ 
+#include "omap-alsa-tsc2101.h"
+#include "omap-alsa-tsc2101-mixer.h"
+
+#include <linux/types.h>
+#include <sound/initval.h>
+#include <sound/control.h>
+
+//#define M_DPRINTK(ARGS...)  printk(KERN_INFO "<%s>: ",__FUNCTION__);printk(ARGS)
+#define M_DPRINTK(ARGS...)  		/* nop */
+
+#define DGC_DALVL_EXTRACT(ARG) ((ARG & 0x7f00) >> 8)
+#define DGC_DARVL_EXTRACT(ARG) ((ARG & 0x007f))
+#define GET_DGC_DALMU_BIT_VALUE(ARG)  (((ARG) & TSC2101_BIT(15)) >> 15)
+#define GET_DGC_DARMU_BIT_VALUE(ARG)  (((ARG) & TSC2101_BIT(7)) >> 7)
+#define IS_DGC_DALMU_UNMUTED(ARG)  (((GET_DGC_DALMU_BIT_VALUE(ARG)) == 0))
+#define IS_DGC_DARMU_UNMUTED(ARG) (((GET_DGC_DARMU_BIT_VALUE(ARG)) == 0))
+
+#define HGC_ADPGA_HED_EXTRACT(ARG) ((ARG & 0x7f00) >> 8)
+#define GET_DGC_HGCMU_BIT_VALUE(ARG) (((ARG) & TSC2101_BIT(15)) >> 15)
+#define IS_DGC_HGCMU_UNMUTED(ARG) (((GET_DGC_HGCMU_BIT_VALUE(ARG)) == 0))
+
+#define HNGC_ADPGA_HND_EXTRACT(ARG) ((ARG & 0x7f00) >> 8)
+#define GET_DGC_HNGCMU_BIT_VALUE(ARG) (((ARG) & TSC2101_BIT(15)) >> 15)
+#define IS_DGC_HNGCMU_UNMUTED(ARG) (((GET_DGC_HNGCMU_BIT_VALUE(ARG)) == 0))
+
+static int current_playback_target	= PLAYBACK_TARGET_LOUDSPEAKER;
+static int current_rec_src 		= REC_SRC_SINGLE_ENDED_MICIN_HED;
+
+/*
+ * Used for switching between TSC2101 recourd sources.
+ * Logic is adjusted from the TSC2101 OSS code.
+ */
+static int set_record_source(int val)
+{
+	u16	data;
+	int	maskedVal;
+	
+	FN_IN;
+	maskedVal	= 0xe0 & val;	
+
+	data	= omap_tsc2101_read(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, 
+				TSC2101_MIXER_PGA_CTRL);
+	data	&= ~MPC_MICSEL(7); /* clear all MICSEL bits */
+	data	|= maskedVal;
+	omap_tsc2101_write(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2,
+				TSC2101_MIXER_PGA_CTRL,
+				data);
+	current_rec_src	= val;
+
+	FN_OUT(0);
+	return 0;
+}
+
+/*
+ * Converts the Alsa mixer volume (0 - 100) to real 
+ * Digital Gain Control (DGC) value that can be written
+ * or read from the TSC2101 registry.
+ * 
+ * Note that the number "OUTPUT_VOLUME_MAX" is smaller than OUTPUT_VOLUME_MIN
+ * because DGC works as a volume decreaser. (The more bigger value is put
+ * to DGC, the more the volume of controlled channel is decreased)
+ * 
+ * In addition the TCS2101 chip would allow the maximum volume reduction be 63.5 DB
+ * but according to some tests user can not hear anything with this chip
+ * when the volume is set to be less than 25 db.
+ * Therefore this function will return a value that means 38.5 db (63.5 db - 25 db) 
+ * reduction in the channel volume, when mixer is set to 0.
+ * For mixer value 100, this will return a value that means 0 db volume reduction.
+ * ([mute_left_bit]0000000[mute_right_bit]0000000)
+*/
+int get_mixer_volume_as_dac_gain_control_volume(int vol)
+{
+	u16 retVal;
+
+	/* Convert 0 -> 100 volume to 0x7F(min) -> y(max) volume range */
+	retVal	= ((vol * OUTPUT_VOLUME_RANGE) / 100) + OUTPUT_VOLUME_MAX;
+	/* invert the value for getting the proper range 0 min and 100 max */
+	retVal	= OUTPUT_VOLUME_MIN - retVal;
+	
+	return retVal;
+}
+
+/*
+ * Converts the Alsa mixer volume (0 - 100) to TSC2101 
+ * Digital Gain Control (DGC) volume. Alsa mixer volume 0
+ * is converted to value meaning the volume reduction of -38.5 db
+ * and Alsa mixer volume 100 is converted to value meaning the
+ * reduction of 0 db.
+ */
+int set_mixer_volume_as_dac_gain_control_volume(int mixerVolL, int mixerVolR) 
+{
+	u16 val;
+	int retVal;
+	int volL;
+	int volR;
+	
+	if ((mixerVolL < 0) || 
+	    (mixerVolL > 100) ||
+	    (mixerVolR < 0) ||
+	    (mixerVolR > 100)) {
+		printk(KERN_ERR "Trying a bad mixer volume as dac gain control volume value, left (%d), right (%d)!\n", mixerVolL, mixerVolR);
+		return -EPERM;
+	}
+	M_DPRINTK("mixer volume left = %d, right = %d\n", mixerVolL, mixerVolR);	
+	volL	= get_mixer_volume_as_dac_gain_control_volume(mixerVolL);
+	volR	= get_mixer_volume_as_dac_gain_control_volume(mixerVolR);
+	
+	val	= omap_tsc2101_read(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, TSC2101_DAC_GAIN_CTRL);
+	/* keep the old mute bit settings */
+	val	&= ~(DGC_DALVL(OUTPUT_VOLUME_MIN) | DGC_DARVL(OUTPUT_VOLUME_MIN));
+	val	|= DGC_DALVL(volL) | DGC_DARVL(volR);
+	retVal	= 2;
+	if (retVal) {
+		omap_tsc2101_write(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, 
+				TSC2101_DAC_GAIN_CTRL, 
+				val);
+	}
+	M_DPRINTK("to registry: left = %d, right = %d, total = %d\n", DGC_DALVL_EXTRACT(val), DGC_DARVL_EXTRACT(val), val);
+	return retVal;
+}
+
+int dac_gain_control_unmute_control(int muteLeft, int muteRight)
+{
+	u16 val;
+	int count;
+
+	count	= 0;
+	val	= omap_tsc2101_read(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, TSC2101_DAC_GAIN_CTRL);
+	/* in alsa mixer 1 --> on, 0 == off. In tsc2101 registry 1 --> off, 0 --> on
+	 * so if values are same, it's time to change the registry value.
+	 */
+	if (muteLeft == GET_DGC_DALMU_BIT_VALUE(val)) {
+		if (muteLeft == 0) {
+			/* mute --> turn bit on */
+			val	= val | DGC_DALMU;
+		}
+		else {
+			/* unmute --> turn bit off */
+			val	= val & ~DGC_DALMU;
+		}
+		count++;
+	} /* L */
+	if (muteRight == GET_DGC_DARMU_BIT_VALUE(val)) {
+		if (muteRight == 0) {
+			/* mute --> turn bit on */
+			val	= val | DGC_DARMU;
+		}
+		else {
+			/* unmute --> turn bit off */
+			val	= val & ~DGC_DARMU;
+		}		
+		count++;
+	} /* R */
+	if (count) {
+		omap_tsc2101_write(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, TSC2101_DAC_GAIN_CTRL, val);
+		M_DPRINTK("changed value, is_unmuted left = %d, right = %d\n", 
+			IS_DGC_DALMU_UNMUTED(val),
+			IS_DGC_DARMU_UNMUTED(val));
+	}
+	return count;	
+}
+
+/*
+ * Converts the DGC registry value read from the TSC2101 registry to 
+ * Alsa mixer volume format (0 - 100).
+ */
+int get_dac_gain_control_volume_as_mixer_volume(u16 vol) 
+{
+	u16 retVal;	
+
+	retVal	= OUTPUT_VOLUME_MIN - vol;
+	retVal	= ((retVal - OUTPUT_VOLUME_MAX) * 100) / OUTPUT_VOLUME_RANGE;
+	/* fix scaling error */
+	if ((retVal > 0) && (retVal < 100)) {
+		retVal++;
+	}
+	return retVal;
+}
+
+/*
+ * Converts the headset gain control volume (0 - 63.5 db)
+ * to Alsa mixer volume (0 - 100)
+ */
+int get_headset_gain_control_volume_as_mixer_volume(u16 registerVal) 
+{
+	u16 retVal;
+	
+	retVal	= ((registerVal * 100) / INPUT_VOLUME_RANGE);
+	return retVal;
+}
+
+/*
+ * Converts the handset gain control volume (0 - 63.5 db)
+ * to Alsa mixer volume (0 - 100)
+ */
+int get_handset_gain_control_volume_as_mixer_volume(u16 registerVal) 
+{
+	return get_headset_gain_control_volume_as_mixer_volume(registerVal);
+}
+
+/*
+ * Converts the Alsa mixer volume (0 - 100) to 
+ * headset gain control volume (0 - 63.5 db)
+ */
+int get_mixer_volume_as_headset_gain_control_volume(u16 mixerVal) 
+{
+	u16 retVal;
+	
+	retVal	= ((mixerVal * INPUT_VOLUME_RANGE) / 100) + INPUT_VOLUME_MIN;	
+	return retVal;
+}
+
+/*
+ * Writes Alsa mixer volume (0 - 100) to TSC2101 headset volume registry in
+ * a TSC2101 format. (0 - 63.5 db)
+ * In TSC2101 OSS driver this functionality was controlled with "SET_LINE" parameter.
+ */
+int set_mixer_volume_as_headset_gain_control_volume(int mixerVol) 
+{
+	int volume;
+	int retVal;
+	u16 val;
+
+	if (mixerVol < 0 || mixerVol > 100) {
+		M_DPRINTK("Trying a bad headset mixer volume value(%d)!\n", mixerVol);
+		return -EPERM;
+	}
+	M_DPRINTK("mixer volume = %d\n", mixerVol);
+	/* Convert 0 -> 100 volume to 0x0(min) -> 0x7D(max) volume range */
+	/* NOTE: 0 is minimum volume and not mute */
+	volume	= get_mixer_volume_as_headset_gain_control_volume(mixerVol);	
+	val	= omap_tsc2101_read(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, 
+				TSC2101_HEADSET_GAIN_CTRL);
+	/* preserve the old mute settings */
+	val	&= ~(HGC_ADPGA_HED(INPUT_VOLUME_MAX));
+	val	|= HGC_ADPGA_HED(volume);
+	omap_tsc2101_write(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, 
+			TSC2101_HEADSET_GAIN_CTRL,
+			val);	
+	retVal	= 1;
+	
+	M_DPRINTK("to registry = %d\n", val);	
+	return retVal;
+}
+
+/*
+ * Writes Alsa mixer volume (0 - 100) to TSC2101 handset volume registry in
+ * a TSC2101 format. (0 - 63.5 db)
+ * In TSC2101 OSS driver this functionality was controlled with "SET_MIC" parameter.
+ */
+int set_mixer_volume_as_handset_gain_control_volume(int mixerVol) 
+{
+	int volume;
+	int retVal;
+	u16 val;	
+
+	if (mixerVol < 0 || mixerVol > 100) {
+		M_DPRINTK("Trying a bad mic mixer volume value(%d)!\n", mixerVol);
+		return -EPERM;
+	}
+	M_DPRINTK("mixer volume = %d\n", mixerVol);
+	/* Convert 0 -> 100 volume to 0x0(min) -> 0x7D(max) volume range
+	 * NOTE: 0 is minimum volume and not mute 
+	 */
+	volume	= get_mixer_volume_as_headset_gain_control_volume(mixerVol);
+	val	= omap_tsc2101_read(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, TSC2101_HANDSET_GAIN_CTRL);
+	/* preserve the old mute settigns */
+	val	&= ~(HNGC_ADPGA_HND(INPUT_VOLUME_MAX));
+	val	|= HNGC_ADPGA_HND(volume);
+	omap_tsc2101_write(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, 
+			TSC2101_HANDSET_GAIN_CTRL,
+			val);
+	retVal	= 1;
+	
+	M_DPRINTK("to registry = %d\n", val);	
+	return retVal;
+}
+
+void init_record_sources(void)
+{
+	/* Mute Analog Sidetone
+	 * analog sidetone gain db?
+	 * Cell Phone In not connected to ADC
+	 * Input selected by MICSEL connected to ADC
+	 */
+	omap_tsc2101_write(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, 
+			  TSC2101_MIXER_PGA_CTRL,
+			  MPC_ASTMU | MPC_ASTG(0x40) | ~MPC_CPADC | MPC_MICADC);
+	/* Set record source, Select MIC_INHED input for headset */
+	set_record_source(REC_SRC_SINGLE_ENDED_MICIN_HED);	
+}
+
+void set_loudspeaker_to_playback_target(void)
+{
+	u16	val;
+
+	/* power down sp1, sp2 and loudspeaker */
+	omap_tsc2101_write(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2,
+			TSC2101_CODEC_POWER_CTRL,
+			CPC_SP1PWDN | CPC_SP2PWDN | CPC_LDAPWDF);	
+	/* ADC, DAC, Analog Sidetone, cellphone, buzzer softstepping enabled
+	 * 1dB AGC hysteresis
+	 * MICes bias 2V
+	 */
+	omap_tsc2101_write(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, 
+			TSC2101_AUDIO_CTRL_4, 
+			AC4_MB_HED(0));
+
+	/* DAC left and right routed to SPK1/SPK2
+	 * SPK1/SPK2 unmuted
+	 * keyclicks routed to SPK1/SPK2
+	 */
+	val	= AC5_DIFFIN |
+			AC5_DAC2SPK1(3) | AC5_AST2SPK1 | AC5_KCL2SPK1 |
+			AC5_DAC2SPK2(3) | AC5_AST2SPK2 | AC5_KCL2SPK2 |
+			AC5_HDSCPTC;
+	val	= val & ~AC5_HDSCPTC;
+	omap_tsc2101_write(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2,
+			TSC2101_AUDIO_CTRL_5,
+			val);
+	
+	/* powerdown spk1/out32n and spk2 */
+	val	= omap_tsc2101_read(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2,
+				TSC2101_POWERDOWN_STS);
+	val	= val & ~(~PS_SPK1FL | ~PS_HNDFL | PS_LSPKFL);
+	omap_tsc2101_write(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2,
+			TSC2101_POWERDOWN_STS,
+			val);
+
+	/* routing selected to SPK1 goes to OUT8P/OUT84 alsa. (loudspeaker)
+	 * analog sidetone routed to loudspeaker
+	 * buzzer pga routed to loudspeaker
+	 * keyclick routing to loudspeaker
+	 * cellphone input routed to loudspeaker
+	 * mic selection (control register 04h/page2) routed to cell phone output (CP_OUT)
+	 * routing selected for SPK1 goes also to cellphone output (CP_OUT)
+	 * OUT8P/OUT8N (loudspeakers) unmuted (0 = unmuted)
+	 * Cellphone output is not muted (0 = unmuted)
+	 * Enable loudspeaker short protection control (0 = enable protection)
+	 * VGND short protection control (0 = enable protection)
+	 */
+	omap_tsc2101_write(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2,
+			TSC2101_AUDIO_CTRL_6,
+			AC6_SPL2LSK | AC6_AST2LSK | AC6_BUZ2LSK | AC6_KCL2LSK |
+			AC6_CPI2LSK | AC6_MIC2CPO | AC6_SPL2CPO |
+			~AC6_MUTLSPK | ~AC6_MUTSPK2 | ~AC6_LDSCPTC | ~AC6_VGNDSCPTC);
+	current_playback_target	= PLAYBACK_TARGET_LOUDSPEAKER;
+}
+
+void set_headphone_to_playback_target(void)
+{
+	/* power down sp1, sp2 and loudspeaker */
+	omap_tsc2101_write(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2,
+			TSC2101_CODEC_POWER_CTRL,
+			CPC_SP1PWDN | CPC_SP2PWDN | CPC_LDAPWDF);
+	/* ADC, DAC, Analog Sidetone, cellphone, buzzer softstepping enabled */
+	/* 1dB AGC hysteresis */
+	/* MICes bias 2V */
+	omap_tsc2101_write(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2,
+				TSC2101_AUDIO_CTRL_4, 
+				AC4_MB_HED(0));
+
+	/* DAC left and right routed to SPK2 */
+	/* SPK1/2 unmuted */
+	omap_tsc2101_write(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2,
+			TSC2101_AUDIO_CTRL_5,
+			AC5_DAC2SPK1(3) | AC5_AST2SPK1 | AC5_KCL2SPK1 |
+			AC5_DAC2SPK2(3) | AC5_AST2SPK2 | AC5_KCL2SPK2 |
+			AC5_HDSCPTC);
+
+	/* OUT8P/N muted, CPOUT muted */
+	omap_tsc2101_write(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2,
+			TSC2101_AUDIO_CTRL_6,
+			AC6_MUTLSPK | AC6_MUTSPK2 | AC6_LDSCPTC |
+			AC6_VGNDSCPTC);
+	current_playback_target	= PLAYBACK_TARGET_HEADPHONE;
+}
+
+/*
+ * Checks whether the headset is detected.
+ * If headset is detected, the type is returned. Type can be
+ * 	0x01	= stereo headset detected
+ * 	0x02	= cellurar headset detected
+ * 	0x03	= stereo + cellurar headset detected
+ * If headset is not detected 0 is returned.
+ */
+u16 get_headset_detected(void)
+{
+	u16	curDetected;
+	u16	curType;
+	u16	curVal;
+	
+	curType	= 0;	/* not detected */
+	curVal	= omap_tsc2101_read(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, 
+					TSC2101_AUDIO_CTRL_7);
+	curDetected	= curVal & AC7_HDDETFL;
+	if (curDetected) {
+		printk("headset detected, checking type from %d \n", curVal);
+		curType	= ((curVal & 0x6000) >> 13);
+		printk("headset type detected = %d \n", curType);
+	}
+	else {
+		printk("headset not detected\n");
+	}
+	return curType;
+}
+
+void init_playback_targets(void)
+{
+	u16	val;
+
+	set_loudspeaker_to_playback_target();
+	/* Left line input volume control
+	 * = SET_LINE in the OSS driver
+	 */
+	set_mixer_volume_as_headset_gain_control_volume(DEFAULT_INPUT_VOLUME);
+
+	/* Set headset to be controllable by handset mixer
+	 * AGC enable for handset input
+	 * Handset input not muted
+	 */
+	val	= omap_tsc2101_read(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, 
+				TSC2101_HANDSET_GAIN_CTRL);
+	val	= val | HNGC_AGCEN_HND;	
+	val	= val & ~HNGC_ADMUT_HND;
+	omap_tsc2101_write(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, 
+			TSC2101_HANDSET_GAIN_CTRL,
+			val);	
+			
+	/* mic input volume control
+	 * SET_MIC in the OSS driver 
+	 */
+	set_mixer_volume_as_handset_gain_control_volume(DEFAULT_INPUT_VOLUME);
+
+	/* Left/Right headphone channel volume control
+	 * Zero-cross detect on
+	 */
+	set_mixer_volume_as_dac_gain_control_volume(DEFAULT_OUTPUT_VOLUME, DEFAULT_OUTPUT_VOLUME);	
+	/* unmute */
+	dac_gain_control_unmute_control(1, 1);
+}
+
+/*
+ * Initializes tsc2101 recourd source (to line) and playback target (to loudspeaker)
+ */
+void snd_omap_init_mixer(void)
+{	
+	FN_IN;
+	
+	/* Headset/Hook switch detect enabled */
+	omap_tsc2101_write(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2,
+			TSC2101_AUDIO_CTRL_7,
+			AC7_DETECT);
+
+	init_record_sources();
+	init_playback_targets();
+
+	FN_OUT(0);
+}
+
+static int __pcm_playback_target_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo) 
+{
+	static char *texts[PLAYBACK_TARGET_COUNT] = {
+        	"Loudspeaker", "Headphone"
+	};
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = PLAYBACK_TARGET_COUNT;
+	if (uinfo->value.enumerated.item > PLAYBACK_TARGET_COUNT - 1) {
+        	uinfo->value.enumerated.item = PLAYBACK_TARGET_COUNT - 1;
+	}
+	strcpy(uinfo->value.enumerated.name,
+       	texts[uinfo->value.enumerated.item]);
+	return 0;
+}
+
+static int __pcm_playback_target_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol) 
+{
+	ucontrol->value.integer.value[0] = current_playback_target;
+	return 0;
+}
+
+static int __pcm_playback_target_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol) 
+{
+	int	retVal;
+	int	curVal;
+	
+	retVal	= 0;
+	curVal	= ucontrol->value.integer.value[0];
+	if ((curVal >= 0) &&
+	    (curVal < PLAYBACK_TARGET_COUNT) &&
+	    (curVal != current_playback_target)) {		
+		if (curVal == 0) {
+			set_loudspeaker_to_playback_target();		
+		}
+		else {
+			set_headphone_to_playback_target();
+		}
+		retVal	= 1;
+	}
+	return retVal;
+}	
+
+static int __pcm_playback_volume_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo) 
+{
+	uinfo->type			= SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count			= 2;
+	uinfo->value.integer.min	= 0;
+	uinfo->value.integer.max	= 100;
+	return 0;
+}
+
+/*
+ * Alsa mixer interface function for getting the volume read from the DGC in a 
+ * 0 -100 alsa mixer format.
+ */
+static int __pcm_playback_volume_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol) 
+{
+	u16 volL;
+	u16 volR;	
+	u16 val;
+	
+	val	= omap_tsc2101_read(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, TSC2101_DAC_GAIN_CTRL);
+	M_DPRINTK("registry value = %d!\n", val);
+	volL	= DGC_DALVL_EXTRACT(val);
+	volR	= DGC_DARVL_EXTRACT(val);
+	/* make sure that other bits are not on */
+	volL	= volL & ~DGC_DALMU;
+	volR	= volR & ~DGC_DARMU;
+
+	volL	= get_dac_gain_control_volume_as_mixer_volume(volL);
+	volR	= get_dac_gain_control_volume_as_mixer_volume(volR);
+	
+	ucontrol->value.integer.value[0]	= volL; /* L */
+	ucontrol->value.integer.value[1]	= volR; /* R */
+	
+	M_DPRINTK("mixer volume left = %ld, right = %ld\n", ucontrol->value.integer.value[0], ucontrol->value.integer.value[1]);
+	return 0;
+}
+
+static int __pcm_playback_volume_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol) 
+{
+	return set_mixer_volume_as_dac_gain_control_volume(ucontrol->value.integer.value[0], 
+							ucontrol->value.integer.value[1]);
+}
+
+static int __pcm_playback_switch_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo) 
+{
+	uinfo->type			= SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count			= 2;
+	uinfo->value.integer.min	= 0;
+	uinfo->value.integer.max	= 1;
+	return 0;
+}
+
+/* 
+ * When DGC_DALMU (bit 15) is 1, the left channel is muted.
+ * When DGC_DALMU is 0, left channel is not muted.
+ * Same logic apply also for the right channel.
+ */
+static int __pcm_playback_switch_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol) 
+{
+	u16 val	= omap_tsc2101_read(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, TSC2101_DAC_GAIN_CTRL);
+	
+	ucontrol->value.integer.value[0]	= IS_DGC_DALMU_UNMUTED(val);
+	ucontrol->value.integer.value[1]	= IS_DGC_DARMU_UNMUTED(val);
+	return 0;
+}
+
+static int __pcm_playback_switch_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol) 
+{
+	return dac_gain_control_unmute_control(ucontrol->value.integer.value[0], 
+					ucontrol->value.integer.value[1]);
+}
+
+static int __headset_playback_volume_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo) 
+{
+	uinfo->type			= SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count			= 1;
+	uinfo->value.integer.min	= 0;
+	uinfo->value.integer.max	= 100;
+	return 0;
+}
+
+static int __headset_playback_volume_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol) 
+{
+	u16 val;
+	u16 vol;
+	
+	val	= omap_tsc2101_read(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, 
+				TSC2101_HEADSET_GAIN_CTRL);
+	M_DPRINTK("registry value = %d\n", val);
+	vol	= HGC_ADPGA_HED_EXTRACT(val);
+	vol	= vol & ~HGC_ADMUT_HED;
+
+	vol	= get_headset_gain_control_volume_as_mixer_volume(vol);
+	ucontrol->value.integer.value[0]	= vol;
+	
+	M_DPRINTK("mixer volume returned = %ld\n", ucontrol->value.integer.value[0]);
+	return 0;
+}
+
+static int __headset_playback_volume_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol) 
+{
+	return set_mixer_volume_as_headset_gain_control_volume(ucontrol->value.integer.value[0]);	
+}
+
+static int __headset_playback_switch_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo) 
+{
+	uinfo->type 			= SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count			= 1;
+	uinfo->value.integer.min	= 0;
+	uinfo->value.integer.max	= 1;
+	return 0;
+}
+
+/* When HGC_ADMUT_HED (bit 15) is 1, the headset is muted.
+ * When HGC_ADMUT_HED is 0, headset is not muted.
+ */
+static int __headset_playback_switch_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol) 
+{
+	u16 val = omap_tsc2101_read(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, 
+				TSC2101_HEADSET_GAIN_CTRL);
+	ucontrol->value.integer.value[0]	= IS_DGC_HGCMU_UNMUTED(val);
+	return 0;
+}
+
+static int __headset_playback_switch_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol) 
+{
+	int count = 0;
+	u16 val = omap_tsc2101_read(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, 
+				TSC2101_HEADSET_GAIN_CTRL);
+	/* in alsa mixer 1 --> on, 0 == off. In tsc2101 registry 1 --> off, 0 --> on
+	 * so if values are same, it's time to change the registry value...
+	 */
+	if (ucontrol->value.integer.value[0] == GET_DGC_HGCMU_BIT_VALUE(val)) {
+		if (ucontrol->value.integer.value[0] == 0) {
+			/* mute --> turn bit on */
+			val	= val | HGC_ADMUT_HED;
+		}
+		else {
+			/* unmute --> turn bit off */
+			val	= val & ~HGC_ADMUT_HED;
+		}
+		count++;
+		M_DPRINTK("changed value, is_unmuted = %d\n", IS_DGC_HGCMU_UNMUTED(val));
+	}
+	if (count) {
+		omap_tsc2101_write(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, 
+				TSC2101_HEADSET_GAIN_CTRL, 
+				val);
+	}
+	return count;
+}
+
+static int __handset_playback_volume_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo) 
+{
+	uinfo->type			= SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count			= 1;
+	uinfo->value.integer.min	= 0;
+	uinfo->value.integer.max	= 100;
+	return 0;
+}
+
+static int __handset_playback_volume_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol) 
+{
+	u16 val;
+	u16 vol;
+	
+	val	= omap_tsc2101_read(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, TSC2101_HANDSET_GAIN_CTRL);
+	M_DPRINTK("registry value = %d\n", val);
+	vol	= HNGC_ADPGA_HND_EXTRACT(val);
+	vol	= vol & ~HNGC_ADMUT_HND;
+	vol	= get_handset_gain_control_volume_as_mixer_volume(vol);
+	ucontrol->value.integer.value[0]	= vol;
+	
+	M_DPRINTK("mixer volume returned = %ld\n", ucontrol->value.integer.value[0]);
+	return 0;
+}
+
+static int __handset_playback_volume_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol) 
+{
+	return set_mixer_volume_as_handset_gain_control_volume(ucontrol->value.integer.value[0]);	
+}
+
+static int __handset_playback_switch_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo) 
+{
+	uinfo->type 			= SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count			= 1;
+	uinfo->value.integer.min	= 0;
+	uinfo->value.integer.max	= 1;
+	return 0;
+}
+
+/* When HNGC_ADMUT_HND (bit 15) is 1, the handset is muted.
+ * When HNGC_ADMUT_HND is 0, handset is not muted.
+ */
+static int __handset_playback_switch_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol) 
+{
+	u16 val = omap_tsc2101_read(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, TSC2101_HANDSET_GAIN_CTRL);
+	ucontrol->value.integer.value[0]	= IS_DGC_HNGCMU_UNMUTED(val);
+	return 0;
+}
+
+static int __handset_playback_switch_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol) 
+{
+	int count = 0;
+	u16 val = omap_tsc2101_read(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, TSC2101_HANDSET_GAIN_CTRL);
+	
+	/* in alsa mixer 1 --> on, 0 == off. In tsc2101 registry 1 --> off, 0 --> on
+	 * so if values are same, it's time to change the registry value...
+	 */
+	if (ucontrol->value.integer.value[0] == GET_DGC_HNGCMU_BIT_VALUE(val)) {
+		if (ucontrol->value.integer.value[0] == 0) {
+			/* mute --> turn bit on */
+			val	= val | HNGC_ADMUT_HND;
+		}
+		else {
+			/* unmute --> turn bit off */
+			val	= val & ~HNGC_ADMUT_HND;
+		}
+		M_DPRINTK("changed value, is_unmuted = %d\n", IS_DGC_HNGCMU_UNMUTED(val));
+		count++;
+	}
+	if (count) {
+		omap_tsc2101_write(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, 
+				TSC2101_HANDSET_GAIN_CTRL, 
+				val);
+	}
+	return count;
+}
+
+static snd_kcontrol_new_t tsc2101_control[] __devinitdata = {
+	{
+		.name  = "Playback Playback Route",
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.index = 0,
+		.access= SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info  = __pcm_playback_target_info,
+		.get   = __pcm_playback_target_get,
+		.put   = __pcm_playback_target_put,
+	}, {
+		.name  = "Master Playback Volume",
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.index = 0,
+		.access= SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info  = __pcm_playback_volume_info,
+		.get   = __pcm_playback_volume_get,
+		.put   = __pcm_playback_volume_put,
+	}, {
+		.name  = "Master Playback Switch",
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.index = 0,
+		.access= SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info  = __pcm_playback_switch_info,
+		.get   = __pcm_playback_switch_get,
+		.put   = __pcm_playback_switch_put,
+	}, {
+		.name  = "Headset Playback Volume",
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.index = 1,
+		.access= SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info  = __headset_playback_volume_info,
+		.get   = __headset_playback_volume_get,
+		.put   = __headset_playback_volume_put,
+	}, {
+		.name  = "Headset Playback Switch",
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.index = 1,
+		.access= SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info  = __headset_playback_switch_info,
+		.get   = __headset_playback_switch_get,
+		.put   = __headset_playback_switch_put,
+	}, {
+		.name  = "Handset Playback Volume",
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.index = 2,
+		.access= SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info  = __handset_playback_volume_info,
+		.get   = __handset_playback_volume_get,
+		.put   = __handset_playback_volume_put,
+	}, {
+		.name  = "Handset Playback Switch",
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.index = 2,
+		.access= SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info  = __handset_playback_switch_info,
+		.get   = __handset_playback_switch_get,
+		.put   = __handset_playback_switch_put,
+	}	
+};
+
+#ifdef CONFIG_PM
+
+void snd_omap_suspend_mixer(void)
+{
+}
+
+void snd_omap_resume_mixer(void)
+{
+	snd_omap_init_mixer();
+}
+#endif
+
+int snd_omap_mixer(struct snd_card_omap_codec *tsc2101) 
+{
+	int i=0;
+	int err=0;
+
+	if (!tsc2101) {
+		return -EINVAL;
+	}
+	for (i=0; i < ARRAY_SIZE(tsc2101_control); i++) {
+		if ((err = snd_ctl_add(tsc2101->card, 
+				snd_ctl_new1(&tsc2101_control[i], 
+				tsc2101->card))) < 0) {
+			return err;
+		}
+	}
+	return 0;
+}
diff --git a/sound/arm/omap/omap-alsa-tsc2101-mixer.h b/sound/arm/omap/omap-alsa-tsc2101-mixer.h
new file mode 100644
index 0000000..f68f33d
--- /dev/null
+++ b/sound/arm/omap/omap-alsa-tsc2101-mixer.h
@@ -0,0 +1,79 @@
+/*
+ * sound/arm/omap/omap-alsa-tsc2101-mixer.c
+ * 
+ * Alsa Driver for TSC2101 codec for OMAP platform boards.
+ *
+ * Copyright (C) 2005 Mika Laitio <lamikr@cc.jyu.fi> and 
+ * 		     Everett Coleman II <gcc80x86@fuzzyneural.net>
+ *
+ * Based on the ideas in omap-aic23.c and sa11xx-uda1341.c
+ * Copyright (C) 2005 Instituto Nokia de Tecnologia - INdT - Manaus Brazil
+ * Copyright (C) 2002 Tomas Kasparek <tomas.kasparek@seznam.cz>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
+ * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the  GNU General Public License along
+ * with this program; if not, write  to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * History:
+ *
+ * 2006-03-01   Mika Laitio - Mixer for the tsc2101 driver used in omap boards.
+ * 		Can switch between headset and loudspeaker playback, 
+ * 		mute and unmute dgc, set dgc volume. Record source switch,
+ * 		keyclick, buzzer and headset volume and handset volume control 
+ * 		are still missing.
+ */
+
+#ifndef OMAPALSATSC2101MIXER_H_
+#define OMAPALSATSC2101MIXER_H_
+
+#include <asm/hardware/tsc2101.h>
+#include <../drivers/ssi/omap-tsc2101.h>
+#include "omap-alsa-dma.h"
+
+/* tsc2101 DAC gain control volume specific  */
+#define OUTPUT_VOLUME_MIN		0x7F	// 1111111 = -63.5 DB
+#define OUTPUT_VOLUME_MAX		0x32	// 110010
+#define OUTPUT_VOLUME_RANGE		(OUTPUT_VOLUME_MIN - OUTPUT_VOLUME_MAX)
+
+/* use input vol of 75 for 0dB gain */
+#define INPUT_VOLUME_MIN 		0x0
+#define INPUT_VOLUME_MAX		0x7D
+#define INPUT_VOLUME_RANGE		(INPUT_VOLUME_MAX - INPUT_VOLUME_MIN)
+
+#define PLAYBACK_TARGET_COUNT		0x02
+#define PLAYBACK_TARGET_LOUDSPEAKER	0x00
+#define PLAYBACK_TARGET_HEADPHONE	0x01
+
+/* following are used for register 03h Mixer PGA control bits D7-D5 for selecting record source */
+#define REC_SRC_TARGET_COUNT		0x08
+#define REC_SRC_SINGLE_ENDED_MICIN_HED	MPC_MICSEL(0)	// oss code referred to MIXER_LINE
+#define REC_SRC_SINGLE_ENDED_MICIN_HND	MPC_MICSEL(1)	// oss code referred to MIXER_MIC
+#define REC_SRC_SINGLE_ENDED_AUX1	MPC_MICSEL(2)
+#define REC_SRC_SINGLE_ENDED_AUX2	MPC_MICSEL(3)
+#define REC_SRC_MICIN_HED_AND_AUX1	MPC_MICSEL(4)
+#define REC_SRC_MICIN_HED_AND_AUX2	MPC_MICSEL(5)
+#define REC_SRC_MICIN_HND_AND_AUX1	MPC_MICSEL(6)
+#define REC_SRC_MICIN_HND_AND_AUX2	MPC_MICSEL(7)
+
+#define DEFAULT_OUTPUT_VOLUME		90	// default output volume to dac dgc
+#define DEFAULT_INPUT_VOLUME		20	// default record volume
+
+#define TSC2101_AUDIO_CODEC_REGISTERS_PAGE2     (2)
+
+#endif /*OMAPALSATSC2101MIXER_H_*/
diff --git a/sound/arm/omap/omap-alsa-tsc2101.c b/sound/arm/omap/omap-alsa-tsc2101.c
new file mode 100644
index 0000000..a0096cb
--- /dev/null
+++ b/sound/arm/omap/omap-alsa-tsc2101.c
@@ -0,0 +1,439 @@
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
+ * Copyright (C) 2006 Mika Laitio <lamikr@cc.jyu.fi>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/delay.h>
+#include <linux/soundcard.h>
+#include <linux/platform_device.h>
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
+/*
+ * Hardware capabilities 
+ */
+
+/*
+ * DAC USB-mode sampling rates (MCLK = 12 MHz)
+ * The rates and rate_reg_into MUST be in the same order
+ */
+static unsigned int rates[] = {
+	7350, 8000, 8018, 8727,
+	8820, 9600, 11025, 12000,
+	14700, 16000, 22050, 24000,
+	29400, 32000, 44100, 48000,
+};
+
+static snd_pcm_hw_constraint_list_t tsc2101_hw_constraints_rates = {
+	.count = ARRAY_SIZE(rates),
+	.list = rates,
+	.mask = 0,
+};
+
+static const struct tsc2101_samplerate_reg_info
+    rate_reg_info[NUMBER_SAMPLE_RATES_SUPPORTED] = {
+	/* Div 6 */
+	{7350, 7, 1},
+	{8000, 7, 0},
+	/* Div 5.5 */
+	{8018, 6, 1},
+	{8727, 6, 0},
+	/* Div 5 */
+	{8820, 5, 1},
+	{9600, 5, 0},	
+	/* Div 4 */
+	{11025, 4, 1},
+	{12000, 4, 0},
+	/* Div 3 */
+	{14700, 3, 1},
+	{16000, 3, 0},
+	/* Div 2 */
+	{22050, 2, 1},
+	{24000, 2, 0},
+	/* Div 1.5 */
+	{29400, 1, 1},
+	{32000, 1, 0},
+	/* Div 1 */
+	{44100, 0, 1},
+	{48000, 0, 0},		
+};
+
+static snd_pcm_hardware_t tsc2101_snd_omap_alsa_playback = {
+	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
+		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID),	
+	.formats = (SNDRV_PCM_FMTBIT_S16_LE),
+	.rates = (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |
+		  SNDRV_PCM_RATE_16000 |
+		  SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 |
+		  SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
+		  SNDRV_PCM_RATE_KNOT),
+	.rate_min = 7350,
+	.rate_max = 48000,
+	.channels_min = 2,
+	.channels_max = 2,
+	.buffer_bytes_max = 128 * 1024,
+	.period_bytes_min = 32,
+	.period_bytes_max = 8 * 1024,
+	.periods_min = 16,
+	.periods_max = 255,
+	.fifo_size = 0,
+};
+
+static snd_pcm_hardware_t tsc2101_snd_omap_alsa_capture = {
+	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
+		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID),
+	.formats = (SNDRV_PCM_FMTBIT_S16_LE),
+	.rates = (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |
+		  SNDRV_PCM_RATE_16000 |
+		  SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 |
+		  SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
+		  SNDRV_PCM_RATE_KNOT),
+	.rate_min = 7350,
+	.rate_max = 48000,
+	.channels_min = 2,
+	.channels_max = 2,
+	.buffer_bytes_max = 128 * 1024,
+	.period_bytes_min = 32,
+	.period_bytes_max = 8 * 1024,
+	.periods_min = 16,
+	.periods_max = 255,
+	.fifo_size = 0,
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
+ * Do some sanity check, set clock rate, starts it and turn codec audio on
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
+			printk(KERN_WARNING
+			       "Cannot set MCLK clock rate for TSC2101 CODEC, error code = %d\n", err);
+			//return -ECANCELED;
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
+static int __init snd_omap_alsa_tsc2101_probe(struct platform_device *pdev)
+{
+	int	ret;
+	struct	omap_alsa_codec_config *codec_cfg;
+	
+	codec_cfg = pdev->dev.platform_data;
+	if (codec_cfg != NULL) {
+		codec_cfg->hw_constraints_rates	= &tsc2101_hw_constraints_rates;
+		codec_cfg->snd_omap_alsa_playback  = &tsc2101_snd_omap_alsa_playback;
+		codec_cfg->snd_omap_alsa_capture  = &tsc2101_snd_omap_alsa_capture;
+		codec_cfg->codec_configure_dev	= tsc2101_configure;
+		codec_cfg->codec_set_samplerate	= tsc2101_set_samplerate;
+		codec_cfg->codec_clock_setup	= tsc2101_clock_setup;
+		codec_cfg->codec_clock_on	= tsc2101_clock_on;
+		codec_cfg->codec_clock_off	= tsc2101_clock_off;
+		codec_cfg->get_default_samplerate = tsc2101_get_default_samplerate;
+		ret	= snd_omap_alsa_post_probe(pdev, codec_cfg);
+	}
+	else
+		ret = -ENODEV;
+	return ret;
+}
+
+static struct platform_driver omap_alsa_driver = {
+	.probe		= snd_omap_alsa_tsc2101_probe,
+	.remove 	= snd_omap_alsa_remove,
+	.suspend	= snd_omap_alsa_suspend,
+	.resume		= snd_omap_alsa_resume,
+	.driver	= {
+		.name =	"omap_alsa_mcbsp",
+	},
+};
+
+static int __init omap_alsa_tsc2101_init(void)
+{
+	int err;
+	
+	ADEBUG();
+	err = platform_driver_register(&omap_alsa_driver);
+
+	return err;
+}
+
+static void __exit omap_alsa_tsc2101_exit(void)
+{
+	ADEBUG();
+	platform_driver_unregister(&omap_alsa_driver);
+}
+
+module_init(omap_alsa_tsc2101_init);
+module_exit(omap_alsa_tsc2101_exit);
diff --git a/sound/arm/omap/omap-alsa-tsc2101.h b/sound/arm/omap/omap-alsa-tsc2101.h
new file mode 100644
index 0000000..803d215
--- /dev/null
+++ b/sound/arm/omap/omap-alsa-tsc2101.h
@@ -0,0 +1,61 @@
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
+ * Copyright (C) 2006 Mika Laitio <lamikr@cc.jyu.fi>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
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
+#ifndef DEFAULT_BITPERSAMPLE
+#define DEFAULT_BITPERSAMPLE		16
+#endif
+
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
+/*
+ * Defines codec specific functions pointers that can be used from the 
+ * common omap-alse base driver for all omap codecs. (tsc2101 and aic23)
+ */
+inline void tsc2101_configure(void);
+void tsc2101_set_samplerate(long rate);
+void tsc2101_clock_setup(void);
+int tsc2101_clock_on(void);
+int tsc2101_clock_off(void);
+int tsc2101_get_default_samplerate(void);
+
+#endif /*OMAP_ALSA_TSC2101_H_*/
-- 
1.2.2


--------------050005070300010604030308
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------050005070300010604030308--

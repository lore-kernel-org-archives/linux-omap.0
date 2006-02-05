From: lamikr <lamikr@cc.jyu.fi>
Subject: omap alsa tsc2101 driver
Date: Sun, 05 Feb 2006 23:24:06 +0200
Message-ID: <43E66CF6.8040600@cc.jyu.fi>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050200010407030104030303"
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------050200010407030104030303
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi

I have not seen anyone working with the tsc2101 Alsa driver, so attached
are the tsc2101 alsa driver sources I have been working for a while. The
patch should apply to the omap-driver head. Unfortunately it is still
non-functional at least with my omap 1510 based iPAQ h6340.

I can hear small start of the song but then nothing happens. I have
tried to debug the code and I can see that the the driver is able to get
one callback to sound_dma_irq_handler with DSCR_END_BLOCK set, but after
it does not continue with a next period of code.

Here is some info from the driver
- all code is located in /sound/arm/omap as I have wanted to mix it to
existing aic23 code until this one works
- based on to aic23 Alsa and tsc2101 OSS drivers. DMA code and driver
base taken from the aic, but hardware initialization taken from the
tsc2101 oss driver. (dma has only small changes like 16 bit mono to
capture params instead of 32 bit ones supported in the aic23)
- mixer code for DGC, headset and handset
- debug is mostly printed by using DPRINTK() function and can be enabled
by uncommenting "#define DEBUG 1" from the omap-alsa.h
- This is platform driver, so you need to register it to your board-code
in arch/arm/mach-omap1/board-* in a following way:
        static struct platform_device h6300_mcbsp1_device = {
                    .name        = "omap_tsc2101_mcbsp",
                    .id        = 1,
            };

        static struct platform_device *h6300_devices[] __initdata = {
                ...  
                &h6300_mcbsp1_device,
        };

I have only tested this with omap1510 based iPAQ h6300, so I would
appreciate if somebody else could test this with other
devices having tsc2101 chipset to find out whether this is just my hw
specific problem. (Fixes would ofcource also be nice :-)

For testing the driver I have plugged headset and listened the result of
following commands
- aplay song.wav (44100 hz 16 bit little endion format)
- "speaker-test -r 8000", "-r 44100", etc...

I have also tryed to change the audio_get_dma_pos() method to be like in
the sa11xx-uda1341.c driver. With implementation
based on to that, the speaker-test is able to produce somekind of
periodic "wuff <silence> wuff <silence> wuff..." sound.
(that method version is commented out in the omap-alsa-tsc2101.c)

In addition to sources, attached is the log from one play attempt.

Mika

root@h6300:~# aplay free_breakbeat.wav
Playing WAVE 'free_breakbeat.wav' : Signed 16 bit Little Endian, Rate
44100 Hz, Stereo
aplay: pcm_write:1146: write error: Input/output error
root@h6300:~# dmesg
XXX Alsa debug f:omap_alsa_tsc2101_init, l:1157
XXX Alsa debug f:snd_omap_alsa_tsc2101_probe, l:1077
XXX Alsa debug f:snd_card_omap_alsa_tsc2101_pcm, l:845
XXX Alsa debug f:omap_alsa_tsc2101_audio_init, l:350
XXX Alsa debug f:audio_dma_request, l:385
[omap_request_alsa_sound_dma]: start
[omap_request_alsa_sound_dma]: end(0)
XXX Alsa debug f:audio_dma_request, l:385
[omap_request_alsa_sound_dma]: start
[omap_request_alsa_sound_dma]: end(0)
[snd_omap_init_mixer]: start
[setRecordSource]: start
[setRecordSource]: end(0)
[snd_omap_init_mixer]: end(0)
OMAP_ALSA_TSC2101 audio support initialized
<omap_alsa_tsc2101_clock_on>: clock use count = 0
<omap_alsa_tsc2101_clock_on>: old clock rate = 12000000
omap_alsa_tsc2101_clock_on(), no need to change clock rate, rate already
12000000 Hz.
<omap_alsa_tsc2101_clock_on>: MCLK = 12000000 [12000000], usecount = 1,
clk_enable retval = 0
<snd_card_omap_alsa_tsc2101_open>: runtime->hw =
snd_omap_alsa_tsc2101_playback
<snd_omap_alsa_tsc2101_hw_params>: snd_omap_alsa_tsc2101_hw_params(),
size = 131072
XXX Alsa debug f:snd_omap_alsa_tsc2101_prepare, l:686
XXX Alsa debug f:omap_alsa_tsc2101_set_samplerate, l:248
<omap_alsa_tsc2101_set_samplerate>: selected 44.1khz PLL
<snd_omap_alsa_tsc2101_trigger>: cmd = 1
<audio_process_dma>: started,  offset = 0, dma_size = 8192, s->period =
0, s->periods = 0, s->dma_q_head = 0, s->offset = 0, rt->buffer_size =
32768, rt->period_size = 2048, rt->frame_bits = 32, runtime->dma_addr =
0, dma_ptr = -1042022400
[omap_start_alsa_sound_dma]: start
<omap_start_alsa_sound_dma>: stream_id = playback, dma_ptr =
-1042022400, dma_size = 8192
[audio_set_dma_params_play]: start
[audio_set_dma_params_play]: end(0)
[audio_start_dma_chain]: start
XXX Alsa debug f:audio_ifc_stop, l:229
XXX Alsa debug f:audio_ifc_start, l:222
[audio_start_dma_chain]: end(0)
[omap_start_alsa_sound_dma]: end(0)
<audio_process_dma>: done, offset = 0, dma_size = 8192, s->period = 0,
s->periods = 1, s->dma_q_head = 0, s->offset = 0, rt->buffer_size =
32768, rt->period_size = 2048, rt->frame_bits = 32, runtime->dma_addr =
0, dma_ptr = -1042022400
<audio_get_dma_pos>: count = 6150, s->dma_q_head = 0, s->offset = 0,
s->period = 1, s->periods = 1, rt->buffer_size = 32768, rt->period_size
= 2048, rt->frame_bits = 32, runtime->dma_addr = 0, offset = -1537,
dma_ptr = -1042023937
<audio_get_dma_pos>: offsetFrame= 0, countFrame = 1537
<audio_get_dma_pos>: warning, resetted offset to 0, old offset val = 0
<sound_dma_irq_handler>: started, lch = 0, status = 0x20, dma_status =
32, data = c0b0608c
<sound_dma_irq_handler>: status = DCSR_END_BLOCK, calling
audio_dma_callback()
<audio_dma_callback>: s->active, calling snd_pcm_period_elapsed
<audio_get_dma_pos>: count = 6150, s->dma_q_head = 0, s->offset = 0,
s->period = 1, s->periods = 1, rt->buffer_size = 32768, rt->period_size
= 2048, rt->frame_bits = 32, runtime->dma_addr = 0, offset = -1537,
dma_ptr = -1042023937
<audio_get_dma_pos>: offsetFrame= 0, countFrame = 1537
<audio_get_dma_pos>: warning, resetted offset to 0, old offset val = 0
<audio_process_dma>: started,  offset = 8192, dma_size = 8192, s->period
= 1, s->periods = 0, s->dma_q_head = 0, s->offset = 0, rt->buffer_size =
32768, rt->period_size = 2048, rt->frame_bits = 32, runtime->dma_addr =
0, dma_ptr = -1042014208
[omap_start_alsa_sound_dma]: start
<omap_start_alsa_sound_dma>: stream_id = playback, dma_ptr =
-1042014208, dma_size = 8192
[audio_set_dma_params_play]: start
[audio_set_dma_params_play]: end(0)
[audio_start_dma_chain]: start
[audio_start_dma_chain]: end(0)
[omap_start_alsa_sound_dma]: end(0)
<audio_process_dma>: done, offset = 8192, dma_size = 8192, s->period =
1, s->periods = 1, s->dma_q_head = 0, s->offset = 8192, rt->buffer_size
= 32768, rt->period_size = 2048, rt->frame_bits = 32, runtime->dma_addr
= 0, dma_ptr = -1042014208
<sound_dma_irq_handler>: done
ALSA
/home/lamikr/own/h6300/git/linux-omap-h6300-2.6/sound/core/pcm_lib.c:2231:
playback write error (DMA or IRQ trouble?)
<snd_omap_alsa_tsc2101_trigger>: cmd = 0
XXX Alsa debug f:audio_stop_dma, l:488
[omap_alsa_audio_stop_dma]: start
[omap_alsa_audio_stop_dma]: end(0)
[omap_clear_alsa_sound_dma]: start
[omap_clear_alsa_sound_dma]: end(0)
XXX Alsa debug f:snd_card_omap_alsa_tsc2101_close, l:785
<omap_alsa_tsc2101_clock_off>: clock use count = 1
<omap_alsa_tsc2101_clock_off>: clock rate = 12000000
<omap_alsa_tsc2101_clock_off>: clock disabled
<omap_alsa_tsc2101_clock_off>: audio codec off


--------------050200010407030104030303
Content-Type: text/x-patch;
 name="omap_alsa_tsc2101.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="omap_alsa_tsc2101.patch"

diff -Naur linux-omap-2.6/sound/arm/Kconfig linux-omap-h6300-2.6/sound/arm/Kconfig
--- linux-omap-2.6/sound/arm/Kconfig	2006-02-04 16:20:13.000000000 +0200
+++ linux-omap-h6300-2.6/sound/arm/Kconfig	2006-02-04 22:17:41.000000000 +0200
@@ -45,4 +45,14 @@
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-omap-aic23.
 
+config SND_OMAP_ALSA_TSC2101
+	tristate "TSC2101 driver for OMAP boards which has TSC2101 chip."
+	depends ARCH_OMAP1
+	select SND_PCM
+	help
+	  Say Y here if you have a OMAP platform board (iPAQ H63xx for example)
+	  and want to use its TSC2101 audio chip.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called snd-omap-alsa-tsc2101.
 endmenu
diff -Naur linux-omap-2.6/sound/arm/Makefile linux-omap-h6300-2.6/sound/arm/Makefile
--- linux-omap-2.6/sound/arm/Makefile	2006-02-04 16:20:13.000000000 +0200
+++ linux-omap-h6300-2.6/sound/arm/Makefile	2006-02-04 22:13:16.000000000 +0200
@@ -16,3 +16,5 @@
 
 obj-$(CONFIG_SND_OMAP_AIC23) += snd-omap-aic23.o
 snd-omap-aic23-objs := omap-aic23.o omap-alsa-dma.o omap-alsa-mixer.o
+
+obj-$(CONFIG_SND) += omap/
diff -Naur linux-omap-2.6/sound/arm/omap/Makefile linux-omap-h6300-2.6/sound/arm/omap/Makefile
--- linux-omap-2.6/sound/arm/omap/Makefile	1970-01-01 02:00:00.000000000 +0200
+++ linux-omap-h6300-2.6/sound/arm/omap/Makefile	2006-02-04 22:06:37.000000000 +0200
@@ -0,0 +1,8 @@
+#
+# Makefile for ALSA
+#
+
+snd-omap-alsa-tsc2101-objs := omap-alsa-tsc2101.o omap-alsa-tsc2101-dma.o omap-alsa-tsc2101-mixer.o
+
+# Toplevel Module Dependency
+obj-$(CONFIG_SND_OMAP_ALSA_TSC2101)   += snd-omap-alsa-tsc2101.o
diff -Naur linux-omap-2.6/sound/arm/omap/omap-alsa.h linux-omap-h6300-2.6/sound/arm/omap/omap-alsa.h
--- linux-omap-2.6/sound/arm/omap/omap-alsa.h	1970-01-01 02:00:00.000000000 +0200
+++ linux-omap-h6300-2.6/sound/arm/omap/omap-alsa.h	2006-02-05 21:33:41.000000000 +0200
@@ -0,0 +1,88 @@
+/*
+ * sound/arm/omap/omap-alsa.h
+ * 
+ * Alsa Driver for TSC2101 codec for OMAP platform boards.
+ *
+ * Copyright (C) 2005 Mika Laitio <lamikr@cc.jyu.fi> and 
+ * 		     Everett Coleman II <gcc80x86@fuzzyneural.net>
+ *
+ * Based on omap-aic23.h and tsc2101 OSS drivers.
+ * Copyright (C) 2005 Instituto Nokia de Tecnologia - INdT - Manaus Brazil
+ * Copyright (C) 2004 Texas Instruments, Inc.
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
+ * 2006-02-04   Mika Laitio - Alsa driver startup for omap boards. 
+ * 		Still a work in progress as at least with h6300 the DMA is somehow
+ * 		not working. (Producess only a start of the sound)
+ */
+
+#ifndef OMAPALSA_H_
+#define OMAPALSA_H_
+
+#include <sound/driver.h>
+#include <asm/arch/dma.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+
+//#define DEBUG 1
+#undef DEBUG
+
+#ifdef DEBUG
+#define DPRINTK(ARGS...)  printk(KERN_INFO "<%s>: ",__FUNCTION__);printk(ARGS)
+#define ADEBUG() printk("XXX Alsa debug f:%s, l:%d\n", __FUNCTION__, __LINE__)
+#define FN_IN printk(KERN_INFO "[%s]: start\n", __FUNCTION__)
+#define FN_OUT(n) printk(KERN_INFO "[%s]: end(%u)\n",__FUNCTION__, n)
+#else
+#define DPRINTK(ARGS...)	/* nop */
+#define ADEBUG()		/* nop */
+#define FN_IN			/* nop */
+#define FN_OUT(n)		/* nop */
+#endif
+
+#define ERR(ARGS...) printk(KERN_ERR "{%s}-ERROR: ", __FUNCTION__);printk(ARGS);
+
+/*
+ * Buffer management for alsa and dma
+ */
+struct audio_stream {
+	char *id;		/* identification string */
+	int stream_id;		/* numeric identification */
+	int dma_dev;		/* dma number of that device */
+	int *lch;		/* Chain of channels this stream is linked to */
+	char started;		/* to store if the chain was started or not */
+	int dma_q_head;		/* DMA Channel Q Head */
+	int dma_q_tail;		/* DMA Channel Q Tail */
+	char dma_q_count;	/* DMA Channel Q Count */
+	int active:1;		/* we are using this stream for transfer now */
+	int period;		/* current transfer period */
+	int periods;		/* current count of periods registerd in the DMA engine */
+	spinlock_t dma_lock;	/* for locking in DMA operations */
+	snd_pcm_substream_t *stream;	/* the pcm stream */
+	unsigned linked:1;	/* dma channels linked */
+	int offset;		/* store start position of the last period in the alsa buffer */
+	int (*hw_start)(void);  /* interface to start HW interface, e.g. McBSP */
+	int (*hw_stop)(void);   /* interface to stop HW interface, e.g. McBSP */
+};
+
+#endif /*OMAPALSA_H_*/
diff -Naur linux-omap-2.6/sound/arm/omap/omap-alsa-tsc2101.c linux-omap-h6300-2.6/sound/arm/omap/omap-alsa-tsc2101.c
--- linux-omap-2.6/sound/arm/omap/omap-alsa-tsc2101.c	1970-01-01 02:00:00.000000000 +0200
+++ linux-omap-h6300-2.6/sound/arm/omap/omap-alsa-tsc2101.c	2006-02-05 21:37:29.000000000 +0200
@@ -0,0 +1,1170 @@
+/*
+ * sound/arm/omap/omap-alsa-tsc2101.c
+ * 
+ * Alsa Driver for TSC2101 codec for OMAP platform boards.
+ *
+ * Copyright (C) 2005 Mika Laitio <lamikr@cc.jyu.fi> and 
+ * 		     Everett Coleman II <gcc80x86@fuzzyneural.net>
+ *
+ * Based on omap-aic23.c, sa11xx-uda1341.c and omap tsc2101 OSS drivers.
+ * Copyright (C) 2005 Instituto Nokia de Tecnologia - INdT - Manaus Brazil
+ * 	Written by Daniel Petrini, David Cohen, Anderson Briglia
+ *            {daniel.petrini, david.cohen, anderson.briglia}@indt.org.br
+ * Copyright (C) 2004 Texas Instruments, Inc.
+ * 	Written by Nishanth Menon and Sriram Kannan
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
+ * 2006-02-04   Mika Laitio - Alsa driver startup for omap boards. 
+ * 		Still a work in progress as at least with h6300 the DMA is somehow
+ * 		not working. (Producess only a start of the sound)
+ */
+
+#include <linux/config.h>
+#include <sound/driver.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/ioctl.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/clk.h>
+
+#ifdef CONFIG_PM
+#include <linux/pm.h>
+#endif
+
+#include <asm/hardware.h>
+#include <asm/mach-types.h>
+#include <asm/arch/dma.h>
+#include <asm/arch/mcbsp.h>
+#include <asm/arch/clock.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/initval.h>
+#include <sound/memalloc.h>
+
+#include <asm/hardware.h>
+#include <asm/mach-types.h>
+#include <asm/arch/dma.h>
+
+#include "omap-alsa-tsc2101.h"
+#include "omap-alsa-tsc2101-dma.h"
+#include "omap-alsa-tsc2101-mixer.h"
+
+#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_MACH_OMAP_H6300)
+#include <../drivers/ssi/omap-uwire.h>
+#include <asm/arch/dsp_common.h>
+#elif defined(CONFIG_ARCH_OMAP24XX)
+#else
+#error "Unsupported configuration"
+#endif
+
+#include <asm/hardware/tsc2101.h>
+#include <../drivers/ssi/omap-tsc2101.h>
+
+/* Define to set the tsc2101 as the master w.r.t McBSP */
+#define TSC2101_MASTER
+#define CODEC_CLOCK                   12000000
+
+MODULE_AUTHOR("Mika Laitio");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("OMAP TSC2101 Alsa driver");
+MODULE_SUPPORTED_DEVICE("{{TSC2101,OMAP TSC2101}}");
+MODULE_ALIAS("omap tsc2101 mcbsp.1");
+
+static char *id = NULL;	
+MODULE_PARM_DESC(id, "OMAP OSK ALSA Driver for TSC2101 chip.");
+
+static struct snd_card_omap_alsa_tsc2101 *omap_tsc2101 = NULL;
+static struct clk *tsc2101_mclk = 0;
+
+struct sample_rate_reg_info {
+	u16 sample_rate;
+	u8  divisor;
+	u8  fs_44kHz;
+};
+
+/*
+ * DAC USB-mode sampling rates (MCLK = 12 MHz)
+ * The rates and rate_reg_into MUST be in the same order
+ */
+static unsigned int rates[] = {
+	7350,  8000,  8018,  8727,
+	8820,  9600,  11025, 12000,
+	14700, 16000, 22050, 24000,
+	29400, 32000, 44100, 48000
+};
+
+static const struct sample_rate_reg_info
+ reg_info[NUMBER_SAMPLE_RATES_SUPPORTED] = {
+	// Div 6
+	{7350, 7, 1},
+	{8000, 7, 0},
+	// Div 5.5
+	{8018, 6, 1},
+	{8727, 6, 0},
+	// Div 5
+	{8820, 5, 1},
+	{9600, 5, 0},
+	// Div 4
+	{11025, 4, 1},
+	{12000, 4, 0},
+	// Div 3
+	{14700, 3, 1},
+	{16000, 3, 0},
+	// Div 2
+	{22050, 2, 1},
+	{24000, 2, 0},
+	// Div 1.5
+	{29400, 1, 1},
+	{32000, 1, 0},
+	// Div 1
+	{44100, 0, 1},
+	{48000, 0, 0},
+};
+
+/*
+ *  mcbsp configuration structure
+ */
+static struct omap_mcbsp_reg_cfg initial_config_mcbsp = {
+#ifdef CONFIG_MACH_OMAP_H6300
+	.spcr2 = 0x0005,
+	.spcr1 = 0x0005,
+	.rcr2  = 0x8041,
+	.rcr1  = 0x8041,
+	.xcr2  = 0x00a1,
+	.xcr1  = 0x00a1,
+	.srgr2 = 0xb000,
+	.srgr1 = 0xb000,
+	.pcr0  = 0x0081,
+#else
+	.spcr2 = FREE | FRST | GRST | XRST | XINTM(3),
+	.spcr1 = RINTM(3) | RRST,
+	.rcr2  = RPHASE | RFRLEN2(OMAP_MCBSP_WORD_8) |
+	         RWDLEN2(OMAP_MCBSP_WORD_16) | RDATDLY(1),
+	.rcr1  = RFRLEN1(OMAP_MCBSP_WORD_8) | RWDLEN1(OMAP_MCBSP_WORD_16),
+	.xcr2  = XPHASE | XFRLEN2(OMAP_MCBSP_WORD_8) |
+	         XWDLEN2(OMAP_MCBSP_WORD_16) | XDATDLY(1) | XFIG,
+	.xcr1  = XFRLEN1(OMAP_MCBSP_WORD_8) | XWDLEN1(OMAP_MCBSP_WORD_16),
+	.srgr1 = FWID(15),
+	.srgr2 = GSYNC | CLKSP | FSGM | FPER(31),
+
+	/* platform specific initialization */
+# if defined(CONFIG_MACH_OMAP_H2)
+	.pcr0  = CLKXM | CLKRM | FSXP | FSRP | CLKXP | CLKRP,
+# elif defined(CONFIG_MACH_OMAP_H3)
+
+#  ifndef TSC2101_MASTER
+	.pcr0  = FSXM | FSRM | CLKXM | CLKRM | CLKXP | CLKRP,
+#  else
+	.pcr0  = CLKRM | SCLKME | FSXP | FSRP | CLKXP | CLKRP,
+#  endif /* !TSC2101_MASTER */
+# endif	/* CONFIG_MACH_OMAP_H2 */
+#endif /* CONFIG_MACH_H6300 */
+};
+
+static snd_pcm_hw_constraint_list_t hw_constraints_rates = {
+	.count = ARRAY_SIZE(rates),
+	.list = rates,
+	.mask = 0,
+};
+
+/*********************************************************************************
+ *
+ * Simplified write for tsc Audio
+ *
+ *********************************************************************************/
+static __inline__ void audio_tsc2101_write(u8 address, u16 data)
+{
+	omap_tsc2101_write(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, address, data);
+}
+
+/*********************************************************************************
+ *
+ * Simplified read for tsc  Audio
+ *
+ *********************************************************************************/
+static __inline__ u16 audio_tsc2101_read(u8 address)
+{
+	return (omap_tsc2101_read(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, address));
+}
+
+/*
+ * HW interface start and stop helper functions
+ */
+static int audio_ifc_start(void)
+{
+	ADEBUG();
+	omap_mcbsp_start(AUDIO_MCBSP);
+	return 0;
+}
+
+static int audio_ifc_stop(void)
+{
+	ADEBUG();
+	omap_mcbsp_stop(AUDIO_MCBSP);
+	return 0;
+}
+
+/*
+ * Codec/mcbsp init and configuration section
+ * codec dependent code.
+ */
+
+/*
+ * Sample rate changing
+ */
+static int omap_alsa_tsc2101_set_samplerate(struct snd_card_omap_alsa_tsc2101 *omap_tsc2101, long rate)
+{
+	u8 count = 0;
+	u16 data = 0;
+	int clkgdv = 0;
+
+	ADEBUG();
+	if (rate >= 48000)
+		rate = 48000;
+	else if (rate >= 44100)
+		rate = 44100;
+	else if (rate >= 32000)
+		rate = 32000;
+	else if (rate >= 29400)
+		rate = 29400;
+	else if (rate >= 24000)
+		rate = 24000;
+	else if (rate >= 22050)
+		rate = 22050;
+	else if (rate >= 16000)
+		rate = 16000;
+	else if (rate >= 14700)
+		rate = 14700;
+	else if (rate >= 12000)
+		rate = 12000;
+	else if (rate >= 11025)
+		rate = 11025;
+	else if (rate >= 9600)
+		rate = 9600;
+	else if (rate >= 8820)
+		rate = 8820;
+	else if (rate >= 8727)
+		rate = 8727;
+	else if (rate >= 8018)
+		rate = 8018;
+	else if (rate >= 8000)
+		rate = 8000;
+	else
+		rate = 7350;
+
+	/* wait for any frame to complete */
+	udelay(125);
+
+	/* Search for the right sample rate */
+	while ((reg_info[count].sample_rate != rate) &&
+	       (count < NUMBER_SAMPLE_RATES_SUPPORTED)) {
+		count++;
+	}
+	if (count == NUMBER_SAMPLE_RATES_SUPPORTED) {
+		printk(KERN_ERR "Invalid Sample Rate %d requested\n", (int)rate);
+		return -EPERM;
+	}
+	/* Set AC1 */
+	data = audio_tsc2101_read(TSC2101_AUDIO_CTRL_1);
+	/*Clear prev settings */
+	data &= ~(AC1_DACFS(0x07) | AC1_ADCFS(0x07));
+	data |= AC1_DACFS(reg_info[count].divisor) | 
+		AC1_ADCFS(reg_info[count].divisor);
+	audio_tsc2101_write(TSC2101_AUDIO_CTRL_1, data);
+
+	/* Set the AC3 */
+	data = audio_tsc2101_read(TSC2101_AUDIO_CTRL_3);
+	/*Clear prev settings */
+	data &= ~(AC3_REFFS | AC3_SLVMS);
+	data |= (reg_info[count].fs_44kHz) ? AC3_REFFS : 0;
+#ifdef TSC2101_MASTER
+	data |= AC3_SLVMS;
+#endif				/* #ifdef TSC2101_MASTER */
+	audio_tsc2101_write(TSC2101_AUDIO_CTRL_3, data);
+
+	/* program the PLLs */
+	if (reg_info[count].fs_44kHz) {
+		/* 44.1 khz - 12 MHz Mclk */
+		DPRINTK("selected 44.1khz PLL\n");
+		audio_tsc2101_write(TSC2101_PLL_PROG_1, PLL1_PLLSEL | PLL1_PVAL(1) | PLL1_I_VAL(7));	/* PVAL 1; I_VAL 7 */
+		audio_tsc2101_write(TSC2101_PLL_PROG_2, PLL2_D_VAL(0x1490));	/* D_VAL 5264 */
+	} else {
+		/* 48 khz - 12 Mhz Mclk */
+		DPRINTK("selected 48khz PLL\n");
+		audio_tsc2101_write(TSC2101_PLL_PROG_1, PLL1_PLLSEL | PLL1_PVAL(1) | PLL1_I_VAL(8));	/* PVAL 1; I_VAL 8 */
+		audio_tsc2101_write(TSC2101_PLL_PROG_2, PLL2_D_VAL(0x780));	/* D_VAL 1920 */
+	}
+
+	omap_tsc2101->samplerate = rate;
+
+	/* Set the sample rate */
+#ifndef TSC2101_MASTER
+	clkgdv = DEFAULT_MCBSP_CLOCK / (rate * (DEFAULT_BITPERSAMPLE * 2 - 1));
+	if (clkgdv) {
+		initial_config_mcbsp.srgr1 = (FWID(DEFAULT_BITPERSAMPLE - 1) | CLKGDV(clkgdv));
+	}
+	else {
+		return (1);
+	}
+
+	/* Stereo Mode */
+	initial_config_mcbsp.srgr2 = (CLKSM | FSGM | FPER(DEFAULT_BITPERSAMPLE * 2 - 1));
+#else
+	initial_config_mcbsp.srgr1 = (FWID(DEFAULT_BITPERSAMPLE - 1) | CLKGDV(clkgdv));
+	initial_config_mcbsp.srgr2 = ((GSYNC | CLKSP | FSGM | FPER(DEFAULT_BITPERSAMPLE * 2 - 1)));
+
+#endif				/* end of #ifdef TSC2101_MASTER */
+	omap_mcbsp_config(AUDIO_MCBSP, &initial_config_mcbsp);
+	return 0;
+}
+
+static void omap_alsa_tsc2101_audio_init(struct snd_card_omap_alsa_tsc2101 *omap_tsc2101)
+{
+	ADEBUG();
+	/* Setup DMA stuff */
+	omap_tsc2101->s[SNDRV_PCM_STREAM_PLAYBACK].id		= "Alsa TSC2101 out";
+	omap_tsc2101->s[SNDRV_PCM_STREAM_PLAYBACK].stream_id	= SNDRV_PCM_STREAM_PLAYBACK;
+	omap_tsc2101->s[SNDRV_PCM_STREAM_PLAYBACK].dma_dev	= OMAP_DMA_MCBSP1_TX;
+	omap_tsc2101->s[SNDRV_PCM_STREAM_PLAYBACK].hw_start	= audio_ifc_start;
+	omap_tsc2101->s[SNDRV_PCM_STREAM_PLAYBACK].hw_stop	= audio_ifc_stop;
+
+	omap_tsc2101->s[SNDRV_PCM_STREAM_CAPTURE].id		= "Alsa TSC2101 in";
+	omap_tsc2101->s[SNDRV_PCM_STREAM_CAPTURE].stream_id	= SNDRV_PCM_STREAM_CAPTURE;
+	omap_tsc2101->s[SNDRV_PCM_STREAM_CAPTURE].dma_dev	= OMAP_DMA_MCBSP1_RX;
+	omap_tsc2101->s[SNDRV_PCM_STREAM_CAPTURE].hw_start	= audio_ifc_start;
+	omap_tsc2101->s[SNDRV_PCM_STREAM_CAPTURE].hw_stop	= audio_ifc_stop;
+
+	/* configuring the McBSP */
+	omap_mcbsp_request(AUDIO_MCBSP);
+
+	/* if configured, then stop mcbsp */
+	omap_mcbsp_stop(AUDIO_MCBSP);
+
+	omap_mcbsp_config(AUDIO_MCBSP, &initial_config_mcbsp);
+	omap_mcbsp_start(AUDIO_MCBSP);
+}
+
+/* 
+ * DMA functions 
+ * Depends on omap-alsa-tsc2101-dma.c functions and (omap) dma.c
+ * 
+ */
+
+static int audio_dma_request(struct audio_stream *s,
+			     void (*callback) (void *))
+{
+	int err;
+
+	ADEBUG();
+	err = omap_request_alsa_sound_dma(s->dma_dev, 
+				s->id, 
+				s, 
+				&s->lch);
+	if (err < 0)
+		printk(KERN_ERR "unable to grab audio dma 0x%x\n", s->dma_dev);
+	return err;
+}
+
+static int audio_dma_free(struct audio_stream *s)
+{
+	int err = 0;
+
+	ADEBUG();
+	err = omap_free_alsa_sound_dma(s, &s->lch);
+	if (err < 0)
+		printk(KERN_ERR "Unable to free audio dma channels!\n");
+	return err;
+}
+
+/*
+ *  This function should calculate the current position of the dma in the
+ *  buffer. It will help alsa middle layer to continue update the buffer.
+ *  Its correctness is crucial for good functioning.
+ */
+static u_int audio_get_dma_pos(struct audio_stream *s)
+{
+	snd_pcm_substream_t *substream = s->stream;
+	snd_pcm_runtime_t *runtime = substream->runtime;
+	unsigned int offset;
+	unsigned long flags;
+	dma_addr_t count;
+	long offsetFrame;
+	long countFrame;
+	long dmaAddr;
+		
+	// this must be called w/ interrupts locked as requested in dma.c 
+	spin_lock_irqsave(&s->dma_lock, flags);
+	// For the current period let's see where we are
+	count	= omap_get_dma_src_addr_counter(s->lch[s->dma_q_head]);
+	dmaAddr	= runtime->dma_addr;
+	spin_unlock_irqrestore(&s->dma_lock, flags);
+	// Now, the position related to the end of that period
+	//dma_size	= frames_to_bytes(runtime, runtime->period_size);
+	//offsetFrame	= dma_size * s->period;
+	offsetFrame	= bytes_to_frames(runtime, s->offset);
+	countFrame	= bytes_to_frames(runtime, count);
+	offset		= offsetFrame - countFrame;
+	DPRINTK("count = %d, s->dma_q_head = %d, s->offset = %d, s->period = %d, s->periods = %d, rt->buffer_size = %ld, rt->period_size = %ld, rt->frame_bits = %d, runtime->dma_addr = %ld, offset = %d, dma_ptr = %d\n", 
+		count,
+		s->dma_q_head,
+		s->offset,
+		s->period,
+		s->periods,
+		runtime->buffer_size,
+		runtime->period_size,
+		runtime->frame_bits,
+		dmaAddr,
+		offset,
+		(dma_addr_t)runtime->dma_area + offset);
+	DPRINTK("offsetFrame= %ld, countFrame = %ld\n", offsetFrame, countFrame);
+	if ((offset >= runtime->buffer_size) || 
+	    (offset < 0))
+	{
+		offset = 0;
+		DPRINTK("warning, resetted offset to 0, old offset val = %d\n", offset);
+	}
+	return offset;
+}
+
+/*
+// a version from sa11xx-uda1341.c...
+static u_int audio_get_dma_pos(struct audio_stream *s)
+{
+	snd_pcm_substream_t * substream = s->stream;
+	snd_pcm_runtime_t *runtime = substream->runtime;
+	unsigned int offset;
+	unsigned long flags;
+	dma_addr_t addr;
+	
+	// this must be called w/ interrupts locked out see dma-sa1100.c in the kernel
+	spin_lock_irqsave(&s->dma_lock, flags);
+	//addr = sa1100_get_dma_pos((s)->dma_regs);
+	addr	= omap_get_dma_src_addr_counter(s->lch[s->dma_q_head]);
+	offset = addr - runtime->dma_addr;
+	spin_unlock_irqrestore(&s->dma_lock, flags);
+	
+	offset = bytes_to_frames(runtime, offset);
+	if (offset >= runtime->buffer_size)
+		offset = 0;
+
+	return offset;
+}
+*/
+
+/*
+ * this stops the dma and clears the dma ptrs
+ */
+static void audio_stop_dma(struct audio_stream *s)
+{
+	unsigned long flags;
+	
+	ADEBUG();
+	spin_lock_irqsave(&s->dma_lock, flags);
+	s->active	= 0;
+	s->period	= 0;
+	s->periods	= 0;
+
+	/* this stops the dma channel and clears the buffer ptrs */
+	omap_alsa_audio_stop_dma(s);
+	omap_clear_alsa_sound_dma(s);
+
+	spin_unlock_irqrestore(&s->dma_lock, flags);
+}
+
+/*
+ *  Main dma routine, requests dma according where you are in main alsa buffer
+ */
+static void audio_process_dma(struct audio_stream *s)
+{
+	snd_pcm_substream_t *substream = s->stream;
+	snd_pcm_runtime_t *runtime;
+	int period;
+	unsigned int dma_size;
+	unsigned int offset;
+	int ret;
+
+	runtime = substream->runtime;
+	if (s->active) {
+		dma_size= frames_to_bytes(runtime, runtime->period_size);
+		period	= s->period;
+		offset	= dma_size * period;
+		snd_assert(dma_size <= DMA_BUF_SIZE,);
+		DPRINTK("started,  offset = %u, dma_size = %u, s->period = %d, s->periods = %d, s->dma_q_head = %d, s->offset = %d, rt->buffer_size = %ld, rt->period_size = %ld, rt->frame_bits = %d, runtime->dma_addr = %u, dma_ptr = %d\n", 
+			offset,
+			dma_size,
+			period,
+			s->periods,
+			s->dma_q_head,
+			s->offset,
+			runtime->buffer_size,
+			runtime->period_size,
+			runtime->frame_bits,
+			runtime->dma_addr,
+			(dma_addr_t)runtime->dma_area + offset);
+		ret	= omap_start_alsa_sound_dma(s,
+						 (dma_addr_t)runtime->dma_area + offset, 
+						 dma_size);
+		if (ret) {
+			printk(KERN_ERR "audio_process_dma(): cannot queue DMA buffer (%i)\n", ret);
+			return;
+		}
+		s->period++;
+		s->period	%= runtime->periods;
+		s->periods++;
+		s->offset	= offset;
+		DPRINTK("done, offset = %d, dma_size = %u, s->period = %d, s->periods = %d, s->dma_q_head = %d, s->offset = %d, rt->buffer_size = %ld, rt->period_size = %ld, rt->frame_bits = %d, runtime->dma_addr = %u, dma_ptr = %d\n", 
+			offset,
+			dma_size,
+			period,
+			s->periods,
+			s->dma_q_head,
+			s->offset,
+			runtime->buffer_size,
+			runtime->period_size,
+			runtime->frame_bits,
+			runtime->dma_addr,
+			(dma_addr_t)runtime->dma_area + offset);
+	}
+	else {
+		DPRINTK("WARNING, stream not active.");
+	}
+}
+
+/*
+// a version from sa11xx-uda1341.c...
+static void audio_process_dma(struct audio_stream *s)
+{
+	snd_pcm_substream_t *substream = s->stream;
+	snd_pcm_runtime_t *runtime;
+	unsigned int dma_size;		
+	unsigned int offset;
+	int ret;
+                
+	// we are requested to process synchronization DMA transfer
+
+	if (s->tx_spin) {
+		snd_assert(s->stream_id == SNDRV_PCM_STREAM_PLAYBACK, return);
+		// fill the xmit dma buffers and return
+		while (1) {
+			ret = omap_start_alsa_sound_dma(s->dma_regs, 
+					FORCE_CLOCK_
+					ADDR, 
+					FORCE_CLOCK_SIZE);
+			if (ret)
+				return;   
+		}
+		return;
+	}
+	// must be set here - only valid for running streams, not for forced_clock dma fills
+	runtime = substream->runtime;
+	DPRINTK("s->active = %d, s->periods = %d, s->period = %d, runtime->periods = %d\n", s->active, s->periods, s->period, runtime->periods);
+	while (s->active && s->periods < runtime->periods) {
+		dma_size = frames_to_bytes(runtime, runtime->period_size);
+		if (s->old_offset) {
+			// a little trick, we need resume from old position
+			offset = frames_to_bytes(runtime, s->old_offset - 1);
+			s->old_offset = 0;
+			s->periods = 0;
+			s->period = offset / dma_size;
+			offset %= dma_size;
+			dma_size = dma_size - offset;
+			if (!dma_size)
+				continue;		// special case
+		} else {
+			offset = dma_size * s->period;
+			snd_assert(dma_size <= DMA_BUF_SIZE, );
+		}
+		ret = omap_start_alsa_sound_dma(s, //(s)->dma_regs, 
+					runtime->dma_area + offset, 
+					dma_size);
+		if (ret) {
+			printk(KERN_ERR "audio_process_dma: cannot queue DMA buffer (%i)\n", ret);
+			return;
+		}
+		s->period++;
+		s->period %= runtime->periods;
+		s->periods++;
+	}
+	DPRINTK("s->active = %d, s->periods = %d, s->period = %d, runtime->periods = %d\n", s->active, s->periods, s->period, runtime->periods);
+}
+*/
+
+/* 
+ *  This is called when dma IRQ occurs at the end of each transmited block
+ */
+void audio_dma_callback(void *data)
+{
+	struct audio_stream *s = data;
+
+	/* 
+	 * If we are getting a callback for an active stream then we inform
+	 * the PCM middle layer we've finished a period
+	 */
+	if (s->active) {
+		DPRINTK("s->active, calling snd_pcm_period_elapsed\n");
+		snd_pcm_period_elapsed(s->stream);
+	}
+	else {
+		DPRINTK("s->active == FALSE\n");
+	}
+	spin_lock(&s->dma_lock);
+	if (s->periods > 0) {
+		//DPRINTK("reducing periods\n");
+		s->periods--;
+	}
+	audio_process_dma(s);
+	spin_unlock(&s->dma_lock);
+}
+
+/* 
+ * Alsa section
+ * PCM settings and callbacks
+ */
+
+static int snd_omap_alsa_tsc2101_trigger(snd_pcm_substream_t * substream, int cmd)
+{
+	struct snd_card_omap_alsa_tsc2101 *chip = snd_pcm_substream_chip(substream);
+	int stream_id = substream->pstr->stream;
+	struct audio_stream *s = &chip->s[stream_id];
+	int err = 0;
+	
+	DPRINTK("cmd = %d\n", cmd);
+	/* note local interrupts are already disabled in the midlevel code */
+	spin_lock(&s->dma_lock);
+	switch (cmd) {
+		case SNDRV_PCM_TRIGGER_START:
+			/* requested stream startup */
+			s->active = 1;
+			audio_process_dma(s);
+			break;
+		case SNDRV_PCM_TRIGGER_STOP:
+			/* requested stream shutdown */
+			audio_stop_dma(s);
+			break;
+		default:
+			err = -EINVAL;
+			break;
+	}
+	spin_unlock(&s->dma_lock);
+	
+	return err;
+}
+
+static int snd_omap_alsa_tsc2101_prepare(snd_pcm_substream_t * substream)
+{
+	struct snd_card_omap_alsa_tsc2101 *chip = snd_pcm_substream_chip(substream);
+	snd_pcm_runtime_t *runtime = substream->runtime;
+	struct audio_stream *s = &chip->s[substream->pstr->stream];
+	
+	ADEBUG();
+	/* clock configuration, set set requested samplerate */
+	omap_alsa_tsc2101_set_samplerate(chip, runtime->rate);
+
+	s->period	= 0;
+	s->periods	= 0;
+
+	return 0;
+}
+
+static snd_pcm_uframes_t snd_omap_alsa_tsc2101_pointer(snd_pcm_substream_t *substream)
+{
+	struct snd_card_omap_alsa_tsc2101 *chip = snd_pcm_substream_chip(substream);
+	
+	return audio_get_dma_pos(&chip->s[substream->pstr->stream]);
+}
+
+/* Hardware capabilities */
+
+static snd_pcm_hardware_t snd_omap_alsa_tsc2101_capture =
+{
+	.info = (SNDRV_PCM_INFO_INTERLEAVED | 
+		 SNDRV_PCM_INFO_BLOCK_TRANSFER |
+		 SNDRV_PCM_INFO_MMAP | 
+		 SNDRV_PCM_INFO_MMAP_VALID),
+	.formats = (SNDRV_PCM_FMTBIT_S16_LE),
+	.rates = (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |
+		  SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 |
+		  SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
+		  SNDRV_PCM_RATE_KNOT),
+	.rate_min		= 8000,
+	.rate_max		= 48000,
+	.channels_min		= 2,
+	.channels_max		= 2,
+	.buffer_bytes_max	= 128 * 1024,
+	.period_bytes_min	= 32,
+	.period_bytes_max	= DMA_BUF_SIZE,
+	.periods_min		= 16,
+	.periods_max		= 255,
+	.fifo_size		= 0,
+};
+
+/* playback */
+static snd_pcm_hardware_t snd_omap_alsa_tsc2101_playback = {
+	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
+		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID),
+	.formats = (SNDRV_PCM_FMTBIT_S16_LE),
+	.rates = (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |
+		  SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 |
+		  SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
+		  SNDRV_PCM_RATE_KNOT),
+	.rate_min		= 8000,
+	.rate_max		= 48000,
+	.channels_min		= 2,
+	.channels_max		= 2,
+	.buffer_bytes_max	= 128 * 1024,
+	.period_bytes_min	= 32,
+	.period_bytes_max	= DMA_BUF_SIZE,
+	.periods_min		= 16,
+	.periods_max		= 255,
+	.fifo_size		= 0,	
+};
+
+static int snd_card_omap_alsa_tsc2101_open(snd_pcm_substream_t * substream)
+{
+	struct snd_card_omap_alsa_tsc2101 *chip = snd_pcm_substream_chip(substream);
+	snd_pcm_runtime_t *runtime = substream->runtime;
+	int stream_id = substream->pstr->stream;
+	int err;
+
+	chip->s[stream_id].stream = substream;	
+	omap_alsa_tsc2101_clock_on();
+	if (stream_id == SNDRV_PCM_STREAM_PLAYBACK) {
+		DPRINTK("runtime->hw = snd_omap_alsa_tsc2101_playback\n");
+		runtime->hw = snd_omap_alsa_tsc2101_playback;
+	}
+	else {
+		DPRINTK("runtime->hw = snd_omap_alsa_tsc2101_capture\n");
+		runtime->hw = snd_omap_alsa_tsc2101_capture;
+	}
+	if ((err = snd_pcm_hw_constraint_integer(runtime,
+					   SNDRV_PCM_HW_PARAM_PERIODS)) < 0) {
+		DPRINTK("ERROR snd_pcm_hw_constraint_integer failed, error-code = %d\n", err);
+		return err;
+	}
+	if ((err = snd_pcm_hw_constraint_list(runtime, 
+					0,
+					SNDRV_PCM_HW_PARAM_RATE,
+					&hw_constraints_rates)) < 0) {
+		DPRINTK("ERROR snd_pcm_hw_constraint_list failed, error-code = %d\n", err);
+		return err;
+	}
+	return 0;
+}
+
+static int snd_card_omap_alsa_tsc2101_close(snd_pcm_substream_t * substream)
+{
+	struct snd_card_omap_alsa_tsc2101 *chip = snd_pcm_substream_chip(substream);
+	
+	ADEBUG();	
+	omap_alsa_tsc2101_clock_off();
+	chip->s[substream->pstr->stream].stream = NULL;
+	
+	return 0;
+}
+
+/* HW params & free */
+
+static int snd_omap_alsa_tsc2101_hw_params(snd_pcm_substream_t * substream,
+				    snd_pcm_hw_params_t * hw_params)
+{
+	size_t	curSize;
+	
+	curSize	= params_buffer_bytes(hw_params);
+	DPRINTK("snd_omap_alsa_tsc2101_hw_params(), size = %d\n", curSize);
+	return snd_pcm_lib_malloc_pages(substream,
+					curSize);
+}
+
+static int snd_omap_alsa_tsc2101_hw_free(snd_pcm_substream_t * substream)
+{
+	return snd_pcm_lib_free_pages(substream);
+}
+
+/* pcm operations */
+
+static snd_pcm_ops_t snd_card_omap_alsa_tsc2101_playback_ops = {
+	.open =		snd_card_omap_alsa_tsc2101_open,
+	.close =	snd_card_omap_alsa_tsc2101_close,
+	.ioctl =	snd_pcm_lib_ioctl,
+	.hw_params =	snd_omap_alsa_tsc2101_hw_params,
+	.hw_free =	snd_omap_alsa_tsc2101_hw_free,
+	.prepare =	snd_omap_alsa_tsc2101_prepare,
+	.trigger =	snd_omap_alsa_tsc2101_trigger,
+	.pointer =	snd_omap_alsa_tsc2101_pointer,
+};
+
+static snd_pcm_ops_t snd_card_omap_alsa_tsc2101_capture_ops = {
+	.open =		snd_card_omap_alsa_tsc2101_open,
+	.close =	snd_card_omap_alsa_tsc2101_close,
+	.ioctl =	snd_pcm_lib_ioctl,
+	.hw_params =	snd_omap_alsa_tsc2101_hw_params,
+	.hw_free =	snd_omap_alsa_tsc2101_hw_free,
+	.prepare =	snd_omap_alsa_tsc2101_prepare,
+	.trigger =	snd_omap_alsa_tsc2101_trigger,
+	.pointer =	snd_omap_alsa_tsc2101_pointer,
+};
+
+/*
+ *  Alsa init and exit section
+ *  
+ *  Inits pcm alsa structures, allocate the alsa buffer, suspend, resume
+ */
+static int __init snd_card_omap_alsa_tsc2101_pcm(struct snd_card_omap_alsa_tsc2101 *omap_tsc2101, 
+						int device)
+{
+	snd_pcm_t *pcm;
+	int err;
+	
+	ADEBUG();
+	err = snd_pcm_new(omap_tsc2101->card, "TSC2101 PCM", device, 1, 1, &pcm);
+	if (err < 0)
+		return err;
+
+	/* sets up initial buffer with continuous allocation */
+	snd_pcm_lib_preallocate_pages_for_all(pcm,
+					      SNDRV_DMA_TYPE_CONTINUOUS,
+					      snd_dma_continuous_data
+					      (GFP_KERNEL),
+					      128 * 1024, 
+					      128 * 1024);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK,
+			&snd_card_omap_alsa_tsc2101_playback_ops);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE,
+			&snd_card_omap_alsa_tsc2101_capture_ops);
+	pcm->private_data = omap_tsc2101;
+	pcm->info_flags = 0;
+	strcpy(pcm->name, "omap tsc2101 pcm");
+
+	omap_alsa_tsc2101_audio_init(omap_tsc2101);
+
+	/* setup DMA controller */
+	audio_dma_request(&omap_tsc2101->s[SNDRV_PCM_STREAM_PLAYBACK],
+			  audio_dma_callback);
+	audio_dma_request(&omap_tsc2101->s[SNDRV_PCM_STREAM_CAPTURE],
+			  audio_dma_callback);
+	omap_tsc2101->pcm = pcm;
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+
+static int snd_omap_alsa_tsc2101_suspend(snd_card_t * card, pm_message_t state)
+{
+//	struct snd_card_omap_alsa_tsc2101 *chip = card->private_data;
+	ADEBUG();
+/*
+	if (chip->card->power_state != SNDRV_CTL_POWER_D3hot) {
+		snd_power_change_state(chip->card, SNDRV_CTL_POWER_D3hot);
+		snd_pcm_suspend_all(chip->pcm);
+		// Mutes and turn clock off
+		omap_alsa_tsc2101_clock_off();
+		snd_omap_suspend_mixer();
+	}
+*/
+	return 0;
+}
+
+/*
+ *  Prepare hardware for resume
+ */
+static int snd_omap_alsa_tsc2101_resume(snd_card_t * card)
+{
+//	struct snd_card_omap_alsa_tsc2101 *chip = card->private_data;
+	ADEBUG();
+/*	
+	if (chip->card->power_state != SNDRV_CTL_POWER_D0) {
+		snd_power_change_state(chip->card, SNDRV_CTL_POWER_D0);
+		omap_alsa_tsc2101_clock_on();
+		snd_omap_resume_mixer();
+	}
+*/
+	return 0;
+}
+
+/*
+ * Driver suspend/resume - calls alsa functions. Some hints from aaci.c
+ */
+static int omap_alsa_tsc2101_suspend(struct platform_device *pdev, pm_message_t state)
+{
+//	snd_card_t *card = platform_get_drvdata(pdev);
+	ADEBUG();
+/*
+	if (card->power_state != SNDRV_CTL_POWER_D3hot) {
+		snd_omap_alsa_tsc2101_suspend(card, PMSG_SUSPEND);
+	}
+*/	
+	return 0;
+}
+
+static int omap_alsa_tsc2101_resume(struct platform_device *pdev)
+{
+//	snd_card_t *card = platform_get_drvdata(pdev);
+	ADEBUG();
+/*
+	if (card->power_state != SNDRV_CTL_POWER_D0) {
+		snd_omap_alsa_tsc2101_resume(card);
+	}
+*/	
+	return 0;
+}
+
+#else
+#define snd_omap_alsa_tsc2101_suspend	NULL
+#define snd_omap_alsa_tsc2101_resume	NULL
+#define omap_alsa_tsc2101_suspend	NULL
+#define omap_alsa_tsc2101_resume	NULL
+
+#endif	/* CONFIG_PM */
+
+void snd_omap_alsa_tsc2101_free(snd_card_t * card) {
+	struct snd_card_omap_alsa_tsc2101 *chip = card->private_data;
+	ADEBUG();
+	
+	/*
+	 * Turn off codec after it is done.
+	 * Can't do it immediately, since it may still have
+	 * buffered data.
+	 */
+	set_current_state(TASK_INTERRUPTIBLE);
+	schedule_timeout(2);
+
+	omap_mcbsp_stop(AUDIO_MCBSP);
+	omap_mcbsp_free(AUDIO_MCBSP);
+/*
+	audio_tsc2101_write(RESET_CONTROL_ADDR, 0);
+	audio_tsc2101_write(POWER_DOWN_CONTROL_ADDR, 0xff);
+*/	
+
+	audio_dma_free(&chip->s[SNDRV_PCM_STREAM_PLAYBACK]);
+	audio_dma_free(&chip->s[SNDRV_PCM_STREAM_CAPTURE]);
+}
+
+/*
+ *  Omap MCBSP clock configuration
+ *  
+ *  Here we have some functions that allows clock to be enabled and
+ *   disabled only when needed. Besides doing clock configuration 
+ *   it allows turn on/turn off audio when necessary. 
+ */
+ 
+/*
+ * Do clock framework mclk search
+ */
+static __init void omap_alsa_tsc2101_clock_setup(void)
+{
+	tsc2101_mclk = clk_get(0, "mclk");
+} 
+
+/*
+ * Do some sanity check, set clock rate, starts it and
+ *  turn codec audio on 
+ */
+int omap_alsa_tsc2101_clock_on(void)
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
+		       "omap_alsa_tsc2101_clock_on(), no need to change clock rate, rate already %d Hz.\n",
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
+	omap_tsc2101_write(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2,
+			TSC2101_CODEC_POWER_CTRL,
+			0x0000);	
+	return 0;
+}
+
+/*
+ * Do some sanity check, turn clock off and then turn
+ *  codec audio off
+ */
+ // from omap-aic23.c
+int omap_alsa_tsc2101_clock_off(void)
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
+	audio_tsc2101_write(TSC2101_CODEC_POWER_CTRL,
+			    ~(CPC_SP1PWDN | CPC_SP2PWDN | CPC_BASSBC));
+	DPRINTK("audio codec off\n");
+	return 0;
+}
+
+/* module init & exit */
+
+/* 
+ *  Inits alsa soudcard structure
+ */
+static int __init snd_omap_alsa_tsc2101_probe(struct platform_device *pdev)
+{
+	int err = 0;
+	snd_card_t *card;
+	
+	ADEBUG();	
+	/* gets clock from clock framework */
+	omap_alsa_tsc2101_clock_setup();
+
+	/* register the soundcard */
+	card = snd_card_new(-1, id, THIS_MODULE, sizeof(omap_tsc2101));
+	if (card == NULL)
+		return -ENOMEM;
+
+	omap_tsc2101 = kcalloc(1, sizeof(*omap_tsc2101), GFP_KERNEL);
+	if (omap_tsc2101 == NULL)
+		return -ENOMEM;
+
+	card->private_data = (void *)omap_tsc2101;
+	card->private_free = snd_omap_alsa_tsc2101_free;
+
+	omap_tsc2101->card = card;
+	omap_tsc2101->samplerate = AUDIO_RATE_DEFAULT;
+
+	spin_lock_init(&omap_tsc2101->s[0].dma_lock);
+	spin_lock_init(&omap_tsc2101->s[1].dma_lock);
+
+	/* mixer */
+	if ((err = snd_omap_mixer(omap_tsc2101)) < 0) 
+		goto nodev;
+
+	/* PCM */
+	if ((err = snd_card_omap_alsa_tsc2101_pcm(omap_tsc2101, 0)) < 0)
+		goto nodev;
+
+	strcpy(card->driver, "OMAP_ALSA_TSC2101");
+	strcpy(card->shortname, "OMAP_ALSA_TSC2101");
+	sprintf(card->longname, "OMAP_ALSA_TSC2101 driver");
+
+	snd_omap_init_mixer();
+
+	snd_card_set_dev(card, &pdev->dev);
+
+	if ((err = snd_card_register(card)) == 0) {
+		printk(KERN_INFO "OMAP_ALSA_TSC2101 audio support initialized\n");
+		platform_set_drvdata(pdev, card);
+		return 0;
+	}
+	
+nodev:
+	snd_omap_alsa_tsc2101_free(card);
+	
+	return err;
+}
+
+static int snd_omap_alsa_tsc2101_remove(struct platform_device *pdev)
+{
+	snd_card_t *card = platform_get_drvdata(pdev);
+	struct snd_card_omap_alsa_tsc2101 *chip = card->private_data;
+	
+	snd_card_free(card);
+
+	omap_tsc2101		= NULL;
+	card->private_data	= NULL;
+	kfree(chip);
+	
+	platform_set_drvdata(pdev, NULL);
+	
+	return 0;
+}
+
+static struct platform_driver omap_alsa_driver = {
+	.probe =	snd_omap_alsa_tsc2101_probe,
+	.remove =	snd_omap_alsa_tsc2101_remove,
+	.suspend =	omap_alsa_tsc2101_suspend, 
+	.resume =	omap_alsa_tsc2101_resume, 
+	.driver = {
+		.name =	"omap_tsc2101_mcbsp",
+	},
+};
+
+static int __init omap_alsa_tsc2101_init(void)
+{
+	int err;
+	
+	ADEBUG();
+	err	= platform_driver_register(&omap_alsa_driver);
+	return err;
+}
+
+static void __exit omap_alsa_tsc2101_exit(void)
+{
+	ADEBUG();
+	
+	platform_driver_unregister(&omap_alsa_driver);
+}
+
+module_init(omap_alsa_tsc2101_init);
+module_exit(omap_alsa_tsc2101_exit);
diff -Naur linux-omap-2.6/sound/arm/omap/omap-alsa-tsc2101-dma.c linux-omap-h6300-2.6/sound/arm/omap/omap-alsa-tsc2101-dma.c
--- linux-omap-2.6/sound/arm/omap/omap-alsa-tsc2101-dma.c	1970-01-01 02:00:00.000000000 +0200
+++ linux-omap-h6300-2.6/sound/arm/omap/omap-alsa-tsc2101-dma.c	2006-02-05 19:37:47.000000000 +0200
@@ -0,0 +1,530 @@
+/*
+ * sound/arm/omap/omap-alsa-tsc2101-dma.c
+ *
+ * Common audio DMA handling for the OMAP processors
+ *
+ * Copyright (C) 2005 Instituto Nokia de Tecnologia - INdT - Manaus Brazil
+ * 
+ * Copyright (C) 2004 Texas Instruments, Inc.
+ *
+ * Copyright (C) 2000, 2001 Nicolas Pitre <nico@cam.org>
+ *
+ * This package is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
+ * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * History:
+ *
+ * 2004-06-07	Sriram Kannan	- Created new file from omap_audio_dma_intfc.c. This file
+ * 				  will contain only the DMA interface and buffer handling of OMAP
+ * 				  audio driver.
+ *
+ * 2004-06-22	Sriram Kannan	- removed legacy code (auto-init). Self-linking of DMA logical channel.
+ *
+ * 2004-08-12   Nishanth Menon  - Modified to integrate Audio requirements on 1610,1710 platforms
+ *
+ * 2004-11-01   Nishanth Menon  - 16xx platform code base modified to support multi channel chaining.
+ *
+ * 2004-12-15   Nishanth Menon  - Improved 16xx platform channel logic introduced - tasklets, queue handling updated
+ * 
+ * 2005-07-19	INdT Kernel Team - Alsa port. Creation of new file omap-alsa-dma.c based in
+ * 				   omap-audio-dma-intfc.c oss file. Support for aic23 codec.
+ * 				   Removal of buffer handling (Alsa does that), modifications
+ * 				   in dma handling and port to alsa structures.
+ *
+ * 2005-12-18   Dirk Behme      - Added L/R Channel Interchange fix as proposed by Ajaya Babu
+ * 2006-02-04   Mika Laitio	- Tryed to make work with the OMAP 1510 based iPAQ h6300 that has tsc2101 chipset. 
+ * 				  This work is still in progress.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/sched.h>
+#include <linux/poll.h>
+#include <linux/pm.h>
+#include <linux/errno.h>
+#include <linux/sound.h>
+#include <linux/soundcard.h>
+#include <linux/sysrq.h>
+#include <linux/interrupt.h>
+#include <linux/dma-mapping.h>
+
+#include <asm/uaccess.h>
+#include <asm/io.h>
+#include <asm/hardware.h>
+#include <asm/semaphore.h>
+
+#include <asm/arch/dma.h>
+#include <asm/arch/mcbsp.h>
+
+#include "omap-alsa-tsc2101-dma.h"
+#include "omap-alsa-tsc2101.h"
+
+/* Channel Queue Handling macros
+ * tail always points to the current free entry
+ * Head always points to the current entry being used
+ * end is either head or tail
+ */
+//lamikr: same
+#define AUDIO_QUEUE_INIT(s) s->dma_q_head = s->dma_q_tail = s->dma_q_count = 0;
+#define AUDIO_QUEUE_FULL(s) (nr_linked_channels == s->dma_q_count)
+#define AUDIO_QUEUE_LAST(s) (1 == s->dma_q_count)
+#define AUDIO_QUEUE_EMPTY(s) (0 == s->dma_q_count)
+#define __AUDIO_INCREMENT_QUEUE(end) ((end)=((end)+1) % nr_linked_channels)
+#define AUDIO_INCREMENT_HEAD(s) __AUDIO_INCREMENT_QUEUE(s->dma_q_head); s->dma_q_count--;
+#define AUDIO_INCREMENT_TAIL(s) __AUDIO_INCREMENT_QUEUE(s->dma_q_tail); s->dma_q_count++;
+
+/* TODO: To be moved to more appropriate location */
+/* DMA buffer fragmentation sizes */
+#define MAX_DMA_SIZE		0x1000000
+//lamikr: cut_dma_size is not used in the alsa version.
+#define CUT_DMA_SIZE		0x1000
+#define DCSR_ERROR		0x3
+
+// lamikr: missing from the oss version
+#define DCSR_END_BLOCK       (1 << 5)
+// lamikr: same than in in omap-alsa-dma.c and oss dma version
+#define DCSR_SYNC_SET        (1 << 6)
+
+#define DCCR_FS              (1 << 5)
+#define DCCR_PRIO            (1 << 6)
+#define DCCR_EN              (1 << 7)
+#define DCCR_AI              (1 << 8)
+#define DCCR_REPEAT          (1 << 9)
+/* if 0 the channel works in 3.1 compatible mode*/
+#define DCCR_N31COMP         (1 << 10)
+#define DCCR_EP              (1 << 11)
+#define DCCR_SRC_AMODE_BIT   12
+#define DCCR_SRC_AMODE_MASK  (0x3<<12)
+#define DCCR_DST_AMODE_BIT   14
+#define DCCR_DST_AMODE_MASK  (0x3<<14)
+#define AMODE_CONST          0x0
+#define AMODE_POST_INC       0x1
+#define AMODE_SINGLE_INDEX   0x2
+#define AMODE_DOUBLE_INDEX   0x3
+
+/**************************** DATA STRUCTURES *****************************************/
+//lamikr: both of these exist in omap-alsa-dma.c and oss dma.
+static spinlock_t dma_list_lock = SPIN_LOCK_UNLOCKED;
+
+static char nr_linked_channels = 1;
+
+/*********************************** MODULE SPECIFIC FUNCTIONS ***********************/
+
+static void sound_dma_irq_handler(int lch, u16 ch_status, void *data);
+static int audio_set_dma_params_play(int channel, dma_addr_t dma_ptr,
+				     u_int dma_size);
+static int audio_set_dma_params_capture(int channel, dma_addr_t dma_ptr,
+					u_int dma_size);
+static int audio_start_dma_chain(struct audio_stream * s);
+
+/***************************************************************************************
+ *
+ * DMA channel requests
+ *
+ **************************************************************************************/
+//lamikr:functionality same than with oss and omap-alsa-dma (except audio_stream datatype itself)
+static void omap_sound_dma_link_lch(void *data)
+{
+	struct audio_stream *s = (struct audio_stream *) data;
+	int *chan = s->lch;
+	int i;
+
+	FN_IN;
+	if (s->linked) {
+		FN_OUT(1);
+		return;
+	}
+	for (i = 0; i < nr_linked_channels; i++) {
+		int cur_chan = chan[i];
+		int nex_chan =
+		    ((nr_linked_channels - 1 ==
+		      i) ? chan[0] : chan[i + 1]);
+		omap_dma_link_lch(cur_chan, nex_chan);
+	}
+	s->linked = 1;
+	FN_OUT(0);
+}
+
+//lamikr: same in oma-alsa-dma.c and omap oss version of dma
+int omap_request_alsa_sound_dma(int device_id, 
+			const char *device_name,
+			void *data, 
+			int **channels)
+{
+	int i, err = 0;
+	int *chan = NULL;
+	FN_IN;
+	if (unlikely((NULL == channels) || (NULL == device_name))) {
+		BUG();
+		return -EPERM;
+	}
+	/* Try allocate memory for the num channels */
+	*channels = (int *)kmalloc(sizeof(int) * nr_linked_channels, GFP_KERNEL);
+	chan = *channels;
+	if (NULL == chan) {
+		ERR("No Memory for channel allocs!\n");
+		FN_OUT(-ENOMEM);
+		return -ENOMEM;
+	}
+	spin_lock(&dma_list_lock);
+	for (i = 0; i < nr_linked_channels; i++) {
+		err = omap_request_dma(device_id, 
+				device_name,
+				sound_dma_irq_handler,
+				data,
+				&chan[i]);
+		/* Handle Failure condition here */
+		if (err < 0) {
+			int j;
+			for (j = 0; j < i; j++) {
+				omap_free_dma(chan[j]);
+			}
+			spin_unlock(&dma_list_lock);
+			kfree(chan);
+			*channels = NULL;
+			ERR("Error in requesting channel %d=0x%x\n", i, err);
+			FN_OUT(err);
+			return err;
+		}
+	}
+	/* Chain the channels together */
+	if (!cpu_is_omap1510())
+	{
+		DPRINTK("calling omap_sound_dma_link_lch()\n");
+		omap_sound_dma_link_lch(data);
+	}
+	spin_unlock(&dma_list_lock);
+	FN_OUT(0);
+	return 0;
+}
+
+/***************************************************************************************
+ *
+ * DMA channel requests Freeing
+ *
+ **************************************************************************************/
+//lamikr:same than with oss and omap-alsa-dma (except audio_stream)
+static void omap_sound_dma_unlink_lch(void *data)
+{
+	struct audio_stream *s = (struct audio_stream *) data;
+	int *chan = s->lch;
+	int i;
+
+	FN_IN;
+	if (!s->linked) {
+		FN_OUT(1);
+		return;
+	}
+	for (i = 0; i < nr_linked_channels; i++) {
+		int cur_chan = chan[i];
+		int nex_chan = ((nr_linked_channels - 1 == i) ? chan[0] : chan[i + 1]);
+		omap_dma_unlink_lch(cur_chan, nex_chan);
+	}
+	s->linked = 0;
+	FN_OUT(0);
+}
+
+//lamikr:same than with oss and omap-alsa-dma
+int omap_free_alsa_sound_dma(void *data,
+			int **channels)
+{
+	int i;
+	int *chan = NULL;
+	FN_IN;
+	if (unlikely(NULL == channels)) {
+		BUG();
+		return -EPERM;
+	}
+	if (unlikely(NULL == *channels)) {
+		BUG();
+		return -EPERM;
+	}
+	chan = (*channels);
+
+	if (!cpu_is_omap1510())
+		omap_sound_dma_unlink_lch(data);
+	for (i = 0; i < nr_linked_channels; i++) {
+		int cur_chan = chan[i];
+		omap_stop_dma(cur_chan);
+		omap_free_dma(cur_chan);
+	}
+	kfree(*channels);
+	*channels = NULL;
+	FN_OUT(0);
+	return 0;
+}
+
+/***************************************************************************************
+ *
+ * Stop all the DMA channels of the stream
+ *
+ **************************************************************************************/
+void omap_alsa_audio_stop_dma(struct audio_stream *s)
+{
+	int *chan = s->lch;
+	int i;
+	FN_IN;
+	if (unlikely(NULL == chan)) {
+		BUG();
+		return;
+	}
+	for (i = 0; i < nr_linked_channels; i++) {
+		int cur_chan = chan[i];
+		omap_stop_dma(cur_chan);
+	}
+	s->started = 0;
+	FN_OUT(0);
+	return;
+}
+
+/***************************************************************************************
+ *
+ * Clear any pending transfers
+ *
+ **************************************************************************************/
+//oss and alsa has same version (except stream type)
+void omap_clear_alsa_sound_dma(struct audio_stream * s)
+{
+	FN_IN;
+	omap_clear_dma(s->lch[s->dma_q_head]);
+	FN_OUT(0);
+	return;
+}
+
+/***************************************************************************************
+ *
+ * DMA related functions
+ *
+ **************************************************************************************/
+static int audio_set_dma_params_play(int channel, 
+				dma_addr_t dma_ptr,
+				u_int dma_size)
+{
+	int dt;
+	int cen;
+	int cfn;
+	unsigned long dest_start;
+	int dest_port;
+	int sync_dev;
+
+	FN_IN;
+	dt	= OMAP_DMA_DATA_TYPE_S16;	/* data type 16 */
+	cen	= 32;				/* Stereo */
+	cfn	= dma_size / (2 * cen);
+	dest_start = AUDIO_MCBSP_DATAWRITE;
+	if (cpu_is_omap1510() || cpu_is_omap16xx()) {
+		dest_port	= OMAP_DMA_PORT_MPUI;
+		sync_dev	= 0;	
+	}
+	else if (cpu_is_omap24xx()) {
+		dest_port	= 0;
+		sync_dev	= AUDIO_DMA_TX;
+	}
+	else {
+		DPRINTK("uses default values purposed for omap1510 and omap1610\n");
+		dest_port	= OMAP_DMA_PORT_MPUI;
+		sync_dev	= 0;	
+	}
+	omap_set_dma_dest_params(channel,
+				dest_port,
+				OMAP_DMA_AMODE_CONSTANT,
+				dest_start,	// dma physically to
+				0,
+				0);				
+	omap_set_dma_src_params(channel,
+				0,
+				OMAP_DMA_AMODE_POST_INC,
+				dma_ptr,	// dma physically from
+				0,
+				0);
+	omap_set_dma_transfer_params(channel,
+				dt,	// datatype
+				cen,	// element count
+				cfn,	// frame count
+				OMAP_DMA_SYNC_ELEMENT,
+				sync_dev,
+				0);
+	FN_OUT(0);
+	return 0;
+}
+
+// lamikr: omap-alsa-dma.c for aic23 sets cen to 32 (=stereo) but tsc2101 supports only 16 bit capture. (see tsc2101 oss driver)
+static int audio_set_dma_params_capture(int channel, 
+					dma_addr_t dma_ptr,
+					u_int dma_size)
+{
+	int dt;		
+	int cen;
+	int cfn;
+	unsigned long src_start;
+	int src_port;
+	int sync_dev;
+	int src_sync;
+
+	FN_IN;
+	dt	= OMAP_DMA_DATA_TYPE_S16;	// data type 16
+	cen	= 16;		// mono  
+	cfn	= dma_size / (2 * cen);
+	src_start = AUDIO_MCBSP_DATAREAD;
+	if (cpu_is_omap1510() || cpu_is_omap16xx()) {
+		src_port = OMAP_DMA_PORT_MPUI;
+		sync_dev = 0;
+		src_sync = 0;
+	}
+	else if (cpu_is_omap24xx()) {
+		src_port = 0;
+		sync_dev = AUDIO_DMA_RX;
+		src_sync = 1;
+	}
+	else {
+		DPRINTK("uses default values purposed for omap1510 and omap1610\n");
+		src_port = OMAP_DMA_PORT_MPUI;
+		sync_dev = 0;
+		src_sync = 0;
+	}	
+	omap_set_dma_src_params(channel, 
+				src_port,
+				OMAP_DMA_AMODE_CONSTANT, 
+				src_start, 
+				0, 
+				0);
+	omap_set_dma_dest_params(channel, 
+				0, 
+				OMAP_DMA_AMODE_POST_INC, 
+				dma_ptr, 
+				0, 
+				0);
+	omap_set_dma_transfer_params(channel,
+				dt, 
+				cen,
+				cfn, 
+				OMAP_DMA_SYNC_ELEMENT, 
+				sync_dev, 
+				src_sync);
+	FN_OUT(0);
+	return 0;
+}
+
+//lamikr: same
+static int audio_start_dma_chain(struct audio_stream * s)
+{
+	int channel = s->lch[s->dma_q_head];
+	FN_IN;
+	if (!s->started) {
+		s->hw_stop();		/* stops McBSP Interface */
+		omap_start_dma(channel);
+		s->started = 1;
+		s->hw_start();		/* start McBSP interface */
+	}
+	/* else the dma itself will progress forward with out our help */
+	FN_OUT(0);
+	return 0;
+}
+
+/* Start DMA -
+ * Do the initial set of work to initialize all the channels as required.
+ * We shall then initate a transfer
+ */
+int omap_start_alsa_sound_dma(struct audio_stream *s, 
+			dma_addr_t dma_ptr,
+			u_int dma_size)
+{
+	int ret = -EPERM;
+
+	FN_IN;
+	if (unlikely(dma_size > MAX_DMA_SIZE)) {
+		ERR("DmaSoundDma: Start: overflowed %d-%d\n", dma_size,
+		    MAX_DMA_SIZE);
+		return -EOVERFLOW;
+	}
+/*	
+	if (AUDIO_QUEUE_FULL(s)) {	// lamikr:should this be removed from comment?
+		printk("KERN_ERR Warning, audio_queue is full!\n");
+		ret = -2;
+		goto sound_out;
+	}
+*/	
+
+	if (s->stream_id == SNDRV_PCM_STREAM_PLAYBACK) {
+		/*playback */
+		DPRINTK("stream_id = playback, dma_ptr = %d, dma_size = %d\n", dma_ptr, dma_size);
+		ret = audio_set_dma_params_play(s->lch[s->dma_q_tail],
+					      dma_ptr, 
+					      dma_size);
+	} else {
+		ret = audio_set_dma_params_capture(s->lch[s->dma_q_tail],
+						dma_ptr, 
+						dma_size);
+	}
+	if (ret != 0) {
+		printk(KERN_ERR "Error, audio_queue is full!\n");
+		ret = -3;	/* indicate queue full */
+		goto sound_out;
+	}
+	AUDIO_INCREMENT_TAIL(s);
+	ret = audio_start_dma_chain(s);
+	if (ret) {
+		ERR("dma start failed");
+	}
+      sound_out:
+	FN_OUT(ret);
+	return ret;
+}
+
+/* 
+ * ISRs have to be short and smart.. 
+ * Here we call alsa handling, after some error checking
+ */
+ //lamikr: this function is very different in the OSS version
+static void sound_dma_irq_handler(int sound_curr_lch,
+				u16 ch_status,
+				void *data)
+{
+	int dma_status = ch_status;
+	struct audio_stream *s = (struct audio_stream *)data;
+	
+	/*
+	 * some register checkings
+	 */ 
+	DPRINTK("started, lch = %d, status = 0x%x, dma_status = %d, data = %p\n",
+		sound_curr_lch,
+		ch_status,
+		dma_status,
+		data);
+	if (dma_status & (DCSR_ERROR)) {
+		OMAP_DMA_CCR_REG(sound_curr_lch) &= ~DCCR_EN;
+		ERR("DCSR_ERROR!\n");
+		FN_OUT(-1);
+		return;
+	}
+	if (ch_status & DCSR_END_BLOCK) {
+		DPRINTK("status = DCSR_END_BLOCK, calling audio_dma_callback()\n");
+		audio_dma_callback(s);
+	}
+	else
+	{
+		DPRINTK("ch_status != DCSR_END_BLOCK\n");
+	}
+	DPRINTK("done\n");
+	return;
+}
+
+MODULE_AUTHOR("Mika Laitio");
+MODULE_DESCRIPTION("DMA handling for TSC2101 sound driver on OMAP processors.");
+MODULE_LICENSE("GPL");
+
+EXPORT_SYMBOL(omap_start_alsa_sound_dma);
+EXPORT_SYMBOL(omap_clear_alsa_sound_dma);
+EXPORT_SYMBOL(omap_request_alsa_sound_dma);
+EXPORT_SYMBOL(omap_free_alsa_sound_dma);
+EXPORT_SYMBOL(omap_alsa_audio_stop_dma);
diff -Naur linux-omap-2.6/sound/arm/omap/omap-alsa-tsc2101-dma.h linux-omap-h6300-2.6/sound/arm/omap/omap-alsa-tsc2101-dma.h
--- linux-omap-2.6/sound/arm/omap/omap-alsa-tsc2101-dma.h	1970-01-01 02:00:00.000000000 +0200
+++ linux-omap-h6300-2.6/sound/arm/omap/omap-alsa-tsc2101-dma.h	2006-02-05 11:36:45.000000000 +0200
@@ -0,0 +1,61 @@
+/*  
+ * sound/arm/oma/omap-alsa-tsc2101-dma.h
+ *
+ * Common audio DMA handling for the OMAP processors
+ *
+ * Copyright (C) 2005 Instituto Nokia de Tecnologia - INdT - Manaus Brazil
+ * 
+ * Copyright (C) 2004 Texas Instruments, Inc.
+ *
+ * Copyright (C) 2000, 2001 Nicolas Pitre <nico@cam.org>
+ *
+ * This package is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
+ * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * History:
+ *
+ * 
+ * 2004/08/12  Nishanth Menon - Modified to integrate Audio requirements on 1610,1710 platforms
+ *
+ * 2005/07/25  INdT Kernel Team - Renamed to omap-alsa-dma.h. Ported to Alsa.
+ * 2006-02-04   Mika Laitio	- Tryed to make work with the OMAP 1510 based iPAQ h6300 that has tsc2101 chipset. 
+ * 				  This work is still in progress.
+ */
+
+#ifndef OMAPALSATSC2101DMA_H_
+#define OMAPALSATSC2101DMA_H_
+
+/************************** INCLUDES *************************************/
+
+#include "omap-alsa.h"
+
+/************************** GLOBAL MACROS *************************************/
+
+/* Provide the Macro interfaces common across platforms */
+#define DMA_REQUEST(e,s, cb)	{e=omap_request_sound_dma(s->dma_dev, s->id, s, &s->lch);}
+#define DMA_FREE(s)		omap_free_sound_dma(s, &s->lch)
+#define DMA_CLEAR(s)		omap_clear_sound_dma(s)
+
+/************************** GLOBAL DATA STRUCTURES *********************************/
+
+typedef void (*dma_callback_t) (int lch, u16 ch_status, void *data);
+
+/**************** ARCH SPECIFIC FUNCIONS *******************************************/
+
+void omap_clear_alsa_sound_dma(struct audio_stream * s);
+
+int omap_request_alsa_sound_dma(int device_id, const char *device_name,
+			   void *data, int **channels);
+int omap_free_alsa_sound_dma(void *data, int **channels);
+
+int omap_start_alsa_sound_dma(struct audio_stream *s, dma_addr_t dma_ptr,
+			 u_int dma_size);
+
+void omap_alsa_audio_stop_dma(struct audio_stream *s);
+
+#endif /*OMAPALSATSC2101DMA_H_*/
diff -Naur linux-omap-2.6/sound/arm/omap/omap-alsa-tsc2101.h linux-omap-h6300-2.6/sound/arm/omap/omap-alsa-tsc2101.h
--- linux-omap-2.6/sound/arm/omap/omap-alsa-tsc2101.h	1970-01-01 02:00:00.000000000 +0200
+++ linux-omap-h6300-2.6/sound/arm/omap/omap-alsa-tsc2101.h	2006-02-05 21:00:19.000000000 +0200
@@ -0,0 +1,75 @@
+/*
+ * sound/arm/omap/omap-alsa-tsc2101.h
+ * 
+ * Alsa Driver for TSC2101 codec for OMAP platform boards.
+ *
+ * Copyright (C) 2005 Mika Laitio <lamikr@cc.jyu.fi> and 
+ * 		     Everett Coleman II <gcc80x86@fuzzyneural.net>
+ *
+ * Based on omap-aic23.h and tsc2101 OSS drivers.
+ * Copyright (C) 2005 Instituto Nokia de Tecnologia - INdT - Manaus Brazil
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
+ * 2006-02-04   Mika Laitio - Alsa driver startup for omap boards. 
+ * 		Still a work in progress as at least with h6300 the DMA is somehow
+ * 		not working. (Producess only a start of the sound)
+ */
+
+#ifndef OMAPALSATSC2101_H_
+#define OMAPALSATSC2101_H_
+
+#include <sound/driver.h>
+#include <asm/arch/dma.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+
+#include "omap-alsa.h"
+
+#define DEFAULT_BITPERSAMPLE			16
+#define AUDIO_RATE_DEFAULT			44100
+#define AUDIO_MCBSP				OMAP_MCBSP1
+#define NUMBER_SAMPLE_RATES_SUPPORTED		16
+#define TSC2101_AUDIO_CODEC_REGISTERS_PAGE2	(2)
+
+#define DMA_BUF_SIZE				8 * 1024
+
+/*
+ * Alsa card structure for aic23
+ */
+struct snd_card_omap_alsa_tsc2101 {
+	snd_card_t *card;
+	snd_pcm_t *pcm;
+	long samplerate;
+	struct audio_stream s[2];	/* playback & capture */
+};
+
+void audio_dma_callback(void *);
+
+/* Clock functions */
+int omap_alsa_tsc2101_clock_on(void);
+int omap_alsa_tsc2101_clock_off(void);
+
+#endif /*OMAPALSATSC2101_H_*/
diff -Naur linux-omap-2.6/sound/arm/omap/omap-alsa-tsc2101-mixer.c linux-omap-h6300-2.6/sound/arm/omap/omap-alsa-tsc2101-mixer.c
--- linux-omap-2.6/sound/arm/omap/omap-alsa-tsc2101-mixer.c	1970-01-01 02:00:00.000000000 +0200
+++ linux-omap-h6300-2.6/sound/arm/omap/omap-alsa-tsc2101-mixer.c	2006-02-05 00:40:00.000000000 +0200
@@ -0,0 +1,645 @@
+/*
+ * sound/arm/omap/omap-alsa-tsc2101-mixer.c
+ * 
+ * Alsa Driver for TSC2101 codec for OMAP platform boards.
+ *
+ * Copyright (C) 2005 Mika Laitio <lamikr@cc.jyu.fi> and 
+ * 		     Everett Coleman II <gcc80x86@fuzzyneural.net>
+ *
+ * Board initialization code is based on to TSC2101 OSS driver.
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
+ * 2006-02-04   Mika Laitio - Alsa driver startup for omap boards. 
+ * 		Still a work in progress as at least with h6300 the DMA is somehow
+ * 		not working. (Producess only a start of the sound)
+ */
+#include "omap-alsa-tsc2101.h"
+#include "omap-alsa-tsc2101-mixer.h"
+#include <sound/initval.h>
+#include <sound/control.h>
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
+static int recsrc = SOUND_MASK_LINE;
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
+int getMixerVolumeAsDacGainControlVolume(int vol)
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
+int setMixerVolumeAsDacGainControlVolume(int mixerVolL, int mixerVolR) {
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
+	DPRINTK("mixer volume left = %d, right = %d\n", mixerVolL, mixerVolR);	
+	volL	= getMixerVolumeAsDacGainControlVolume(mixerVolL);
+	volR	= getMixerVolumeAsDacGainControlVolume(mixerVolR);
+	
+	val	= omap_tsc2101_read(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, TSC2101_DAC_GAIN_CTRL);
+	// keep the old mute bit settings
+	val	&= ~(DGC_DALVL(OUTPUT_VOLUME_MIN) | DGC_DARVL(OUTPUT_VOLUME_MIN));
+	val	|= DGC_DALVL(volL) | DGC_DARVL(volR);
+	retVal	= 2;
+	if (retVal) {
+		omap_tsc2101_write(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, 
+				TSC2101_DAC_GAIN_CTRL, 
+				val);
+	}
+	DPRINTK("to registry: left = %d, right = %d, total = %d\n", DGC_DALVL_EXTRACT(val), DGC_DARVL_EXTRACT(val), val);
+	return retVal;
+}
+
+/*
+ * Converts the DGC registry value read from the TSC2101 registry to 
+ * Alsa mixer volume format (0 - 100).
+ */
+int getDacGainControlVolumeAsMixerVolume(u16 vol) {
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
+int getHeadsetGainControlVolumeAsMixerVolume(u16 registerVal) {
+	u16 retVal;
+	
+	retVal = ((registerVal * 100) / INPUT_VOLUME_RANGE);
+	return retVal;
+}
+
+/*
+ * Converts the handset gain control volume (0 - 63.5 db)
+ * to Alsa mixer volume (0 - 100)
+ */
+int getHandsetGainControlVolumeAsMixerVolume(u16 registerVal) {
+	return getHeadsetGainControlVolumeAsMixerVolume(registerVal);
+}
+
+/*
+ * Converts the Alsa mixer volume (0 - 100) to 
+ * headset gain control volume (0 - 63.5 db)
+ */
+int getMixerVolumeAsHeadsetGainControlVolume(u16 mixerVal) {
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
+int setMixerVolumeAsHeadsetGainControlVolume(int mixerVol) {
+	int volume;
+	int retVal;
+	u16 val;
+
+	if (mixerVol < 0 || mixerVol > 100) {
+		DPRINTK("Trying a bad headset mixer volume value(%d)!\n", mixerVol);
+		return -EPERM;
+	}
+	DPRINTK("mixer volume = %d\n", mixerVol);
+	/* Convert 0 -> 100 volume to 0x0(min) -> 0x7D(max) volume range */
+	/* NOTE: 0 is minimum volume and not mute */
+	volume = getMixerVolumeAsHeadsetGainControlVolume(mixerVol);	
+
+	val	= omap_tsc2101_read(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, TSC2101_HEADSET_GAIN_CTRL);
+	// preserve the old mute settings
+	val	&= ~(HGC_ADPGA_HED(INPUT_VOLUME_MAX));
+	val	|= HGC_ADPGA_HED(volume);
+
+	omap_tsc2101_write(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, 
+			TSC2101_HEADSET_GAIN_CTRL,
+			val);	
+	retVal	= 1;
+	
+	DPRINTK("to registry = %d\n", val);	
+	return retVal;
+}
+
+/*
+ * Writes Alsa mixer volume (0 - 100) to TSC2101 handset volume registry in
+ * a TSC2101 format. (0 - 63.5 db)
+ * In TSC2101 OSS driver this functionality was controlled with "SET_MIC" parameter.
+ */
+int setMixerVolumeAsHandsetGainControlVolume(int mixerVol) {
+	int volume;
+	int retVal;
+	u16 val;	
+
+	if (mixerVol < 0 || mixerVol > 100) {
+		DPRINTK("Trying a bad mic mixer volume value(%d)!\n", mixerVol);
+		return -EPERM;
+	}
+	DPRINTK("mixer volume = %d\n", mixerVol);
+	/* Convert 0 -> 100 volume to 0x0(min) -> 0x7D(max) volume range */
+	/* NOTE: 0 is minimum volume and not mute */
+	volume = getMixerVolumeAsHeadsetGainControlVolume(mixerVol);
+
+	val	= omap_tsc2101_read(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, TSC2101_HEADSET_GAIN_CTRL);
+	// preserve the old mute settigns
+	val &= ~(HNGC_ADPGA_HND(INPUT_VOLUME_MAX));
+	val |= HNGC_ADPGA_HND(volume);
+
+	omap_tsc2101_write(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, 
+			TSC2101_HANDSET_GAIN_CTRL,
+			val);
+	DPRINTK("to registry = %d\n", val);
+	retVal	= 1;
+	return retVal;
+}
+
+static int __pcm_playback_volume_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo) {
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
+static int __pcm_playback_volume_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol) {
+	u16 volL;
+	u16 volR;	
+	u16 val;
+	
+	val	= omap_tsc2101_read(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, TSC2101_DAC_GAIN_CTRL);
+	DPRINTK("registry value = %d!\n", val);
+	volL	= DGC_DALVL_EXTRACT(val);
+	volR	= DGC_DARVL_EXTRACT(val);
+	volL	= volL & ~DGC_DALMU;	// make sure that other bits are not on
+	volR	= volR & ~DGC_DARMU;
+
+	volL	= getDacGainControlVolumeAsMixerVolume(volL);
+	volR	= getDacGainControlVolumeAsMixerVolume(volR);
+	
+	ucontrol->value.integer.value[0]	= volL; // L
+	ucontrol->value.integer.value[1]	= volR; // R	
+	
+	DPRINTK("mixer volume left = %ld, right = %ld\n", ucontrol->value.integer.value[0], ucontrol->value.integer.value[1]);
+	return 0;
+}
+
+static int __pcm_playback_volume_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol) {
+	return setMixerVolumeAsDacGainControlVolume(ucontrol->value.integer.value[0], 
+						ucontrol->value.integer.value[1]);
+}
+
+static int __pcm_playback_switch_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo) {
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
+static int __pcm_playback_switch_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol) {
+	u16 val=omap_tsc2101_read (TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, TSC2101_DAC_GAIN_CTRL);
+	
+	ucontrol->value.integer.value[0]	= IS_DGC_DALMU_UNMUTED(val);
+	ucontrol->value.integer.value[1]	= IS_DGC_DARMU_UNMUTED(val);
+	return 0;
+}
+
+static int __pcm_playback_switch_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol) {
+	u16 val=omap_tsc2101_read(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, TSC2101_DAC_GAIN_CTRL);
+	int count=0;
+
+	// in alsa mixer 1 --> on, 0 == off. In tsc2101 registry 1 --> off, 0 --> on
+	// so if values are same, it's time to change the registry value.
+	if (ucontrol->value.integer.value[0] == GET_DGC_DALMU_BIT_VALUE(val)) {
+		if (ucontrol->value.integer.value[0] == 0)
+		{
+			val	= val | DGC_DALMU;	// mute --> turn bit on
+		}
+		else
+		{
+			val	= val & ~DGC_DALMU;	// unmute --> turn bit off
+		}
+		count++;
+	} /* L */
+	if (ucontrol->value.integer.value[1] == GET_DGC_DARMU_BIT_VALUE(val)) {
+		if (ucontrol->value.integer.value[1] == 0)
+		{
+			val	= val | DGC_DARMU;	// mute --> turn bit on
+		}
+		else
+		{
+			val	= val & ~DGC_DARMU;	// unmute --> turn bit off
+		}		
+		count++;
+	} /* R */
+	if (count) {
+		omap_tsc2101_write(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, TSC2101_DAC_GAIN_CTRL, val);
+		DPRINTK("changed value, is_unmuted left = %d, right = %d\n", 
+			IS_DGC_DALMU_UNMUTED(val),
+			IS_DGC_DARMU_UNMUTED(val));
+	}
+	return count;
+}
+
+static int __headset_playback_volume_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo) {
+	uinfo->type			= SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count			= 1;
+	uinfo->value.integer.min	= 0;
+	uinfo->value.integer.max	= 100;
+	return 0;
+}
+
+static int __headset_playback_volume_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol) {
+	u16 val;
+	u16 vol;
+	
+	val	= omap_tsc2101_read(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, TSC2101_HEADSET_GAIN_CTRL);
+	DPRINTK("registry value = %d\n", val);
+	vol	= HGC_ADPGA_HED_EXTRACT(val);
+	vol	= vol & ~HGC_ADMUT_HED;
+
+	vol	= getHeadsetGainControlVolumeAsMixerVolume(vol);
+	ucontrol->value.integer.value[0]	= vol;
+	
+	DPRINTK("mixer volume returned = %ld\n", ucontrol->value.integer.value[0]);
+	return 0;
+}
+
+static int __headset_playback_volume_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol) {	
+	return setMixerVolumeAsHeadsetGainControlVolume(ucontrol->value.integer.value[0]);	
+}
+
+static int __headset_playback_switch_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo) {
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
+static int __headset_playback_switch_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol) {
+	u16 val = omap_tsc2101_read(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, TSC2101_HEADSET_GAIN_CTRL);
+	ucontrol->value.integer.value[0]	= IS_DGC_HGCMU_UNMUTED(val);
+	return 0;
+}
+
+static int __headset_playback_switch_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol) {
+	int count = 0;
+	u16 val = omap_tsc2101_read(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, TSC2101_HEADSET_GAIN_CTRL);
+	
+	// in alsa mixer 1 --> on, 0 == off. In tsc2101 registry 1 --> off, 0 --> on
+	// so if values are same, it's time to change the registry value...
+	if (ucontrol->value.integer.value[0] == GET_DGC_HGCMU_BIT_VALUE(val)) {
+		if (ucontrol->value.integer.value[0] == 0) {
+			val	= val | HGC_ADMUT_HED;	// mute --> turn bit on
+		}
+		else {
+			val	= val & ~HGC_ADMUT_HED;	// unmute --> turn bit off
+		}
+		count++;
+		DPRINTK("changed value, is_unmuted = %d\n", IS_DGC_HGCMU_UNMUTED(val));
+	}
+	if (count) {
+		omap_tsc2101_write(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, 
+				TSC2101_HEADSET_GAIN_CTRL, 
+				val);
+	}
+	return count;
+}
+
+static int __handset_playback_volume_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo) {
+	uinfo->type			= SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count			= 1;
+	uinfo->value.integer.min	= 0;
+	uinfo->value.integer.max	= 100;
+	return 0;
+}
+
+static int __handset_playback_volume_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol) {
+	u16 val;
+	u16 vol;
+	
+	val	= omap_tsc2101_read(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, TSC2101_HANDSET_GAIN_CTRL);
+	DPRINTK("registry value = %d\n", val);
+	vol	= HNGC_ADPGA_HND_EXTRACT(val);
+	vol	= vol & ~HNGC_ADMUT_HND;
+	vol	= getHandsetGainControlVolumeAsMixerVolume(vol);
+	ucontrol->value.integer.value[0]	= vol;
+	
+	DPRINTK("mixer volume returned = %ld\n", ucontrol->value.integer.value[0]);
+	return 0;
+}
+
+static int __handset_playback_volume_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol) {	
+	return setMixerVolumeAsHandsetGainControlVolume(ucontrol->value.integer.value[0]);	
+}
+
+static int __handset_playback_switch_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo) {
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
+static int __handset_playback_switch_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol) {
+	u16 val = omap_tsc2101_read(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, TSC2101_HANDSET_GAIN_CTRL);
+	ucontrol->value.integer.value[0]	= IS_DGC_HNGCMU_UNMUTED(val);
+	return 0;
+}
+
+static int __handset_playback_switch_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol) {
+	int count = 0;
+	u16 val = omap_tsc2101_read(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, TSC2101_HANDSET_GAIN_CTRL);
+	
+	// in alsa mixer 1 --> on, 0 == off. In tsc2101 registry 1 --> off, 0 --> on
+	// so if values are same, it's time to change the registry value...	
+	if (ucontrol->value.integer.value[0] == GET_DGC_HNGCMU_BIT_VALUE(val)) {
+		if (ucontrol->value.integer.value[0] == 0) {
+			val	= val | HNGC_ADMUT_HND;		// mute --> turn bit on
+		}
+		else {
+			val	= val & ~HNGC_ADMUT_HND;	// unmute --> turn bit off			
+		}
+		DPRINTK("changed value, is_unmuted = %d\n", IS_DGC_HNGCMU_UNMUTED(val));
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
+static snd_kcontrol_new_t tsc2101_control[] __devinitdata={
+	{
+		.name  = "PCM Playback Volume",
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.index = 0,
+		.access= SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info  = __pcm_playback_volume_info,
+		.get   = __pcm_playback_volume_get,
+		.put   = __pcm_playback_volume_put,
+	}, {
+		.name  = "PCM Playback Switch",
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
+int snd_omap_mixer(struct snd_card_omap_alsa_tsc2101 *tsc2101) {
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
+
+/*
+ * Used for switching between TSC2101 recourd sources.
+ * Logic is adjusted from the TSC2101 OSS code.
+ */
+static int setRecordSource(int val)
+{
+	u16 data;
+
+	FN_IN;
+	/*
+	 * If more than one recording device selected,
+	 * disable the device that is currently in use.
+	 */
+	if (hweight32(val) > 1)
+		val &= ~recsrc;
+	data = omap_tsc2101_read(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, TSC2101_MIXER_PGA_CTRL);
+	data &= ~MPC_MICSEL(7); /* clear all MICSEL bits */
+	if (val == SOUND_MASK_MIC) {
+		data |=  MPC_MICSEL(1);
+		omap_tsc2101_write(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2,
+				TSC2101_MIXER_PGA_CTRL,
+				data);
+	}
+	else if (val == SOUND_MASK_LINE) {
+		data |=  MPC_MICSEL(0);
+		omap_tsc2101_write(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2,
+				TSC2101_MIXER_PGA_CTRL,
+				data);
+	}
+	else {
+		printk(KERN_WARNING "omap-alsa-tsc2101-mixer setRecordSource(), Wrong RECSRC (%d) specified,\n", val);
+		return -EINVAL;
+	}
+	recsrc = val;
+
+	FN_OUT(0);
+	return 0;
+}
+
+/*
+ * Used for switching between TSC2101 recourd sources.
+ * Logic is adjusted from the TSC2101 OSS code.
+ */
+void snd_omap_init_mixer(void)
+{
+	FN_IN;
+	omap_tsc2101_write(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2,
+			TSC2101_CODEC_POWER_CTRL,
+			0x0000);
+			
+	/*Mute Analog Sidetone */
+	/*Select MIC_INHED input for headset */
+	/*Cell Phone In not connected */
+	omap_tsc2101_write(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, 
+			  TSC2101_MIXER_PGA_CTRL,
+			  MPC_ASTMU | MPC_ASTG(0x40) | MPC_MICADC);
+
+	/* Set record source */
+	setRecordSource(recsrc);
+
+	/* ADC, DAC, Analog Sidetone, cellphone, buzzer softstepping enabled */
+	/* 1dB AGC hysteresis */
+	/* MICes bias 2V */
+	omap_tsc2101_write(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, 
+			TSC2101_AUDIO_CTRL_4, 
+			AC4_MB_HED(0));
+
+	/* Set codec output volume */
+	omap_tsc2101_write(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2,
+			TSC2101_DAC_GAIN_CTRL, 
+			0x0000);
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
+			AC6_MUTLSPK | AC6_MUTSPK2 | AC6_LDSCPTC | AC6_VGNDSCPTC);
+
+	/* Headset/Hook switch detect disabled */
+	omap_tsc2101_write(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2,
+			TSC2101_AUDIO_CTRL_7,
+			0x0000);
+			
+	/* Left line input volume control */
+	// SET_LINE in the OSS driver
+	setMixerVolumeAsHeadsetGainControlVolume(DEFAULT_INPUT_VOLUME);
+
+	/* mic input volume control */
+	// SET_MIX in the OSS driver	
+	setMixerVolumeAsHandsetGainControlVolume(DEFAULT_INPUT_VOLUME);
+
+	/* Left/Right headphone channel volume control */
+	/* Zero-cross detect on */
+	// SET_VOLUME on OSS driver
+	setMixerVolumeAsDacGainControlVolume(DEFAULT_VOLUME, DEFAULT_VOLUME);
+	FN_OUT(0);
+}
diff -Naur linux-omap-2.6/sound/arm/omap/omap-alsa-tsc2101-mixer.h linux-omap-h6300-2.6/sound/arm/omap/omap-alsa-tsc2101-mixer.h
--- linux-omap-2.6/sound/arm/omap/omap-alsa-tsc2101-mixer.h	1970-01-01 02:00:00.000000000 +0200
+++ linux-omap-h6300-2.6/sound/arm/omap/omap-alsa-tsc2101-mixer.h	2006-02-05 00:38:59.000000000 +0200
@@ -0,0 +1,67 @@
+/*
+ * sound/arm/omap/omap-alsa-tsc2101-mixer.c
+ * 
+ * Alsa Driver for TSC2101 codec for OMAP platform boards.
+ *
+ * Copyright (C) 2005 Mika Laitio <lamikr@cc.jyu.fi> and 
+ * 		     Everett Coleman II <gcc80x86@fuzzyneural.net>
+ *
+ * Based on omap-aic23.c and sa11xx-uda1341.c
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
+ * 2006-02-04   Mika Laitio - Alsa driver startup for omap boards. 
+ * 		Still a work in progress as at least with h6300 the DMA is somehow
+ * 		not working. (Producess only a start of the sound)
+ */
+
+#ifndef OMAPALSATSC2101MIXER_H_
+#define OMAPALSATSC2101MIXER_H_
+
+#include "omap-alsa-tsc2101-dma.h"
+#include <asm/hardware/tsc2101.h>
+#include <../drivers/ssi/omap-tsc2101.h>
+
+int snd_omap_mixer(struct snd_card_omap_alsa_tsc2101 *);
+void snd_omap_init_mixer(void);
+
+// following definitions are from the TSC2101 OSS driver
+#define OUTPUT_VOLUME_MIN	0x7F	// 1111111 = -63.5 DB
+#define OUTPUT_VOLUME_MAX	0x32	// 110010
+#define OUTPUT_VOLUME_RANGE	(OUTPUT_VOLUME_MIN - OUTPUT_VOLUME_MAX)
+
+#define INPUT_VOLUME_MIN	0x0
+#define INPUT_VOLUME_MAX	0x7D
+#define INPUT_VOLUME_RANGE	(INPUT_VOLUME_MAX - INPUT_VOLUME_MIN)
+
+#define SOUND_MIXER_LINE	6
+#define SOUND_MASK_LINE		(1 << SOUND_MIXER_LINE)
+#define SOUND_MIXER_MIC		7
+#define SOUND_MASK_MIC		(1 << SOUND_MIXER_MIC)
+
+#define DEFAULT_VOLUME		93
+#define DEFAULT_INPUT_VOLUME	20	/* An minimal volume */
+
+#endif /*OMAPALSATSC2101MIXER_H_*/

--------------050200010407030104030303
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------050200010407030104030303--

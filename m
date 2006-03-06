From: lamikr <lamikr@cc.jyu.fi>
Subject: [PATCH] Alsa modularisations and support for tsc2101 2/3 (round 2)
Date: Mon, 06 Mar 2006 22:33:08 +0200
Message-ID: <440C9C84.3060604@cc.jyu.fi>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020705090209010105070509"
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
--------------020705090209010105070509
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Omap ALSA Patch (2/3)

This 2/3 patch moves omap alsa aic23 driver files to sound/arm/omap
directory.
In addition it adds cleaner separation of codec specific functionality
from the other functionality
so that the same code can also be used by the tsc2101 driver.

Structures required by the platform driver are now in
include/asm-arm/arch-omap/omap-alsa.h.
Unlike in the previous review, all other files required by this driver
are now
located in the sound/arm/omap directory. MCBSP settings required by the
alsa driver are now
initialized in the omap OSK board-code. Codec specific function pointers
are now initialized in the codec-file.
(omap-alsa-aic23.c)

Signed-off-by: Mika Laitio <lamikr@cc.jyu.fi>
Signed-off-by: Daniel Petrini <d.pensator@gmail.com>



--------------020705090209010105070509
Content-Type: text/x-patch;
 name="0002_omap_alsa_tsc2101.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0002_omap_alsa_tsc2101.patch"

Omap ALSA Patch (2/3)

This 2/3 patch moves omap alsa aic23 driver files to sound/arm/omap directory.
In addition it adds cleaner separation of codec specific functionality from the other functionality
so that the same code can also be used by the tsc2101 driver.

Structures required by the platform driver are now in include/asm-arm/arch-omap/omap-alsa.h.
Unlike in the previous review, all other files required by this driver are now
located in the sound/arm/omap directory. MCBSP settings required by the alsa driver are now
initialized in the omap OSK board-code. Codec specific function pointers are now initialized in the codec-file. 
(omap-alsa-aic23.c)

Signed-off-by: Mika Laitio <lamikr@cc.jyu.fi>
Signed-off-by: Daniel Petrini <d.pensator@gmail.com>

---

 arch/arm/mach-omap1/board-osk.c        |   37 +
 include/asm-arm/arch-omap/omap-alsa.h  |  144 +++++
 sound/arm/Makefile                     |    3 
 sound/arm/omap-aic23.c                 |  904 --------------------------------
 sound/arm/omap-aic23.h                 |  131 -----
 sound/arm/omap-alsa-dma.c              |  452 ----------------
 sound/arm/omap-alsa-dma.h              |   53 --
 sound/arm/omap-alsa-mixer.c            |  496 ------------------
 sound/arm/omap/Makefile                |    6 
 sound/arm/omap/omap-alsa-aic23-mixer.c |  485 +++++++++++++++++
 sound/arm/omap/omap-alsa-aic23.c       |  321 +++++++++++
 sound/arm/omap/omap-alsa-aic23.h       |   83 +++
 sound/arm/omap/omap-alsa-dma.c         |  443 ++++++++++++++++
 sound/arm/omap/omap-alsa-dma.h         |   53 ++
 sound/arm/omap/omap-alsa.c             |  579 ++++++++++++++++++++
 15 files changed, 2150 insertions(+), 2040 deletions(-)
 create mode 100644 include/asm-arm/arch-omap/omap-alsa.h
 delete mode 100644 sound/arm/omap-aic23.c
 delete mode 100644 sound/arm/omap-aic23.h
 delete mode 100644 sound/arm/omap-alsa-dma.c
 delete mode 100644 sound/arm/omap-alsa-dma.h
 delete mode 100644 sound/arm/omap-alsa-mixer.c
 create mode 100644 sound/arm/omap/Makefile
 create mode 100644 sound/arm/omap/omap-alsa-aic23-mixer.c
 create mode 100644 sound/arm/omap/omap-alsa-aic23.c
 create mode 100644 sound/arm/omap/omap-alsa-aic23.h
 create mode 100644 sound/arm/omap/omap-alsa-dma.c
 create mode 100644 sound/arm/omap/omap-alsa-dma.h
 create mode 100644 sound/arm/omap/omap-alsa.c

4b8a51dd5b9fa8d6d2ec33e98d6f17eeaab1d87c
diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index 56c8a4b..76248bb 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -47,6 +47,8 @@
 #include <asm/arch/tc.h>
 #include <asm/arch/keypad.h>
 #include <asm/arch/common.h>
+#include <asm/arch/mcbsp.h>
+#include <asm/arch/omap-alsa.h>
 
 static int osk_keymap[] = {
 	KEY(0, 0, KEY_F1),
@@ -149,9 +151,40 @@ static struct platform_device osk5912_cf
 	.resource	= osk5912_cf_resources,
 };
 
+#define DEFAULT_BITPERSAMPLE 16
+
+static struct omap_mcbsp_reg_cfg mcbsp_regs = { 
+	.spcr2 = FREE | FRST | GRST | XRST | XINTM(3),
+	.spcr1 = RINTM(3) | RRST,
+	.rcr2 = RPHASE | RFRLEN2(OMAP_MCBSP_WORD_8) |
+	    RWDLEN2(OMAP_MCBSP_WORD_16) | RDATDLY(0),
+	.rcr1 = RFRLEN1(OMAP_MCBSP_WORD_8) | RWDLEN1(OMAP_MCBSP_WORD_16),
+	.xcr2 = XPHASE | XFRLEN2(OMAP_MCBSP_WORD_8) |
+	    XWDLEN2(OMAP_MCBSP_WORD_16) | XDATDLY(0) | XFIG,
+	.xcr1 = XFRLEN1(OMAP_MCBSP_WORD_8) | XWDLEN1(OMAP_MCBSP_WORD_16),
+	.srgr1 = FWID(DEFAULT_BITPERSAMPLE - 1),
+	.srgr2 = GSYNC | CLKSP | FSGM | FPER(DEFAULT_BITPERSAMPLE * 2 - 1),
+	/*.pcr0 = FSXM | FSRM | CLKXM | CLKRM | CLKXP | CLKRP,*/ /* mcbsp: master */
+	.pcr0 = CLKXP | CLKRP,  /* mcbsp: slave */
+};
+
+static struct omap_alsa_codec_config alsa_config = {
+	.name			= "OSK AIC23",
+	.mcbsp_regs_alsa	= &mcbsp_regs,
+	.codec_configure_dev	= NULL, // aic23_configure,
+	.codec_set_samplerate	= NULL, // aic23_set_samplerate,
+	.codec_clock_setup	= NULL, // aic23_clock_setup,
+	.codec_clock_on		= NULL, // aic23_clock_on,
+	.codec_clock_off	= NULL, // aic23_clock_off,
+	.get_default_samplerate	= NULL, // aic23_get_default_samplerate,	
+};
+
 static struct platform_device osk5912_mcbsp1_device = {
-	.name		= "omap_mcbsp",
-	.id		= 1,
+	.name	= "omap_alsa_mcbsp",
+ 	.id	= 1,
+	.dev = {
+		.platform_data	= &alsa_config,
+	},
 };
 
 static struct resource osk5912_kp_resources[] = {
diff --git a/include/asm-arm/arch-omap/omap-alsa.h b/include/asm-arm/arch-omap/omap-alsa.h
new file mode 100644
index 0000000..b4ec45a
--- /dev/null
+++ b/include/asm-arm/arch-omap/omap-alsa.h
@@ -0,0 +1,144 @@
+/*
+ * linux/include/asm-arm/arch-omap/omap-alsa.h
+ * 
+ * Alsa Driver for AIC23 and TSC2101 codecs on OMAP platform boards.
+ *
+ * Copyright (C) 2006 Mika Laitio <lamikr@cc.jyu.fi>
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
+ *  History
+ *  -------
+ *
+ *  2005/07/25 INdT-10LE Kernel Team - 	Alsa driver for omap osk,
+ *  					original version based in sa1100 driver
+ *  					and omap oss driver.
+ */
+
+#ifndef __OMAP_ALSA_H
+#define __OMAP_ALSA_H
+
+#include <sound/driver.h>
+#include <asm/arch/dma.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <asm/arch/mcbsp.h>
+#include <linux/platform_device.h>
+/*
+ * Debug functions
+ */
+#undef DEBUG
+//#define DEBUG
+
+#define ERR(ARGS...) printk(KERN_ERR "{%s}-ERROR: ", __FUNCTION__);printk(ARGS);
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
+#define DMA_BUF_SIZE	(1024 * 8)
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
+/*
+ * Alsa card structure for aic23
+ */
+struct snd_card_omap_codec {
+	snd_card_t *card;
+	snd_pcm_t *pcm;
+	long samplerate;
+	struct audio_stream s[2];	/* playback & capture */
+};
+
+/* Codec specific information and function pointers. 
+ * Codec (omap-alsa-aic23.c and omap-alsa-tsc2101.c)
+ * are responsible for defining the function pointers.
+ */
+struct omap_alsa_codec_config {
+	char 	*name;
+	struct	omap_mcbsp_reg_cfg *mcbsp_regs_alsa;
+	snd_pcm_hw_constraint_list_t *hw_constraints_rates;
+	snd_pcm_hardware_t *snd_omap_alsa_playback;
+	snd_pcm_hardware_t *snd_omap_alsa_capture;
+	void	(*codec_configure_dev)(void);
+	void	(*codec_set_samplerate)(long);
+	void	(*codec_clock_setup)(void);
+	int	(*codec_clock_on)(void);
+	int 	(*codec_clock_off)(void);
+	int	(*get_default_samplerate)(void);
+};
+
+/*********** Mixer function prototypes *************************/
+int snd_omap_mixer(struct snd_card_omap_codec *);
+void snd_omap_init_mixer(void);
+
+#ifdef CONFIG_PM
+void snd_omap_suspend_mixer(void);
+void snd_omap_resume_mixer(void);
+#endif
+
+int snd_omap_alsa_post_probe(struct platform_device *pdev, struct omap_alsa_codec_config *config);
+int snd_omap_alsa_remove(struct platform_device *pdev);
+#ifdef CONFIG_PM
+int snd_omap_alsa_suspend(struct platform_device *pdev, pm_message_t state);
+int snd_omap_alsa_resume(struct platform_device *pdev);
+#else
+#define snd_omap_alsa_suspend	NULL
+#define snd_omap_alsa_resume	NULL
+#endif
+
+/*********** function prototype to function called from the dma interrupt handler ******/
+void callback_omap_alsa_sound_dma(void *);
+
+#endif
diff --git a/sound/arm/Makefile b/sound/arm/Makefile
index 019a9f0..bd12f53 100644
--- a/sound/arm/Makefile
+++ b/sound/arm/Makefile
@@ -14,5 +14,4 @@ snd-pxa2xx-pcm-objs		:= pxa2xx-pcm.o
 obj-$(CONFIG_SND_PXA2XX_AC97)	+= snd-pxa2xx-ac97.o
 snd-pxa2xx-ac97-objs		:= pxa2xx-ac97.o
 
-obj-$(CONFIG_SND_OMAP_AIC23) += snd-omap-aic23.o
-snd-omap-aic23-objs := omap-aic23.o omap-alsa-dma.o omap-alsa-mixer.o
+obj-$(CONFIG_SND) += omap/
diff --git a/sound/arm/omap-aic23.c b/sound/arm/omap-aic23.c
deleted file mode 100644
index bd2df14..0000000
--- a/sound/arm/omap-aic23.c
+++ /dev/null
@@ -1,904 +0,0 @@
-/*
- * sound/arm/omap-aic23.c
- * 
- * Alsa Driver for AIC23 codec on OSK5912 platform board
- *
- * Copyright (C) 2005 Instituto Nokia de Tecnologia - INdT - Manaus Brazil
- * Written by Daniel Petrini, David Cohen, Anderson Briglia
- *            {daniel.petrini, david.cohen, anderson.briglia}@indt.org.br
- *
- * Based on sa11xx-uda1341.c, 
- * Copyright (C) 2002 Tomas Kasparek <tomas.kasparek@seznam.cz>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation; either version 2 of the License, or (at your
- * option) any later version.
- *
- * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
- * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
- * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
- * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
- * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- * You should have received a copy of the  GNU General Public License along
- * with this program; if not, write  to the Free Software Foundation, Inc.,
- * 675 Mass Ave, Cambridge, MA 02139, USA.
- *
- * History:
- *
- * 2005-07-29   INdT Kernel Team - Alsa driver for omap osk. Creation of new 
- *                                 file omap-aic23.c
- *
- * 2005-12-18   Dirk Behme      - Added L/R Channel Interchange fix as proposed by Ajaya Babu
- */
-
-#include <linux/config.h>
-#include <sound/driver.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/moduleparam.h>
-#include <linux/init.h>
-#include <linux/errno.h>
-#include <linux/ioctl.h>
-#include <linux/delay.h>
-#include <linux/slab.h>
-#include <linux/clk.h>
-
-#ifdef CONFIG_PM
-#include <linux/pm.h>
-#endif
-
-#include <asm/hardware.h>
-#include <asm/mach-types.h>
-#include <asm/arch/dma.h>
-#include <asm/arch/aic23.h>
-#include <asm/arch/mcbsp.h>
-#include <asm/arch/clock.h>
-
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/initval.h>
-#include <sound/memalloc.h>
-
-#include "omap-alsa-dma.h"
-#include "omap-aic23.h"
-
-#undef DEBUG
-
-#ifdef DEBUG
-#define ADEBUG() printk("XXX Alsa debug f:%s, l:%d\n", __FUNCTION__, __LINE__)
-#else
-#define ADEBUG()		/* nop */
-#endif
-
-/* Define to set the AIC23 as the master w.r.t McBSP */
-#define AIC23_MASTER
-
-/*
- * AUDIO related MACROS
- */
-#define DEFAULT_BITPERSAMPLE          16
-#define AUDIO_RATE_DEFAULT	      44100
-#define AUDIO_MCBSP                   OMAP_MCBSP1
-#define NUMBER_SAMPLE_RATES_SUPPORTED 10
-
-
-MODULE_AUTHOR("Daniel Petrini, David Cohen, Anderson Briglia - INdT");
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("OMAP AIC23 driver for ALSA");
-MODULE_SUPPORTED_DEVICE("{{AIC23,OMAP AIC23}}");
-MODULE_ALIAS("omap_mcbsp.1");
-
-static char *id = NULL;	
-MODULE_PARM_DESC(id, "OMAP OSK ALSA Driver for AIC23 chip.");
-
-static struct snd_card_omap_codec *omap_aic23 = NULL;
-
-static struct clk *aic23_mclk = 0;
-
-struct sample_rate_rate_reg_info {
-	u8 control;		/* SR3, SR2, SR1, SR0 and BOSR */
-	u8 divider;		/* if 0 CLKIN = MCLK, if 1 CLKIN = MCLK/2 */
-};
-
-/*
- * DAC USB-mode sampling rates (MCLK = 12 MHz)
- * The rates and rate_reg_into MUST be in the same order
- */
-static unsigned int rates[] = {
-	4000, 8000, 16000, 22050,
-	24000, 32000, 44100,
-	48000, 88200, 96000,
-};
-static const struct sample_rate_rate_reg_info
- rate_reg_info[NUMBER_SAMPLE_RATES_SUPPORTED] = {
-	{0x06, 1},		/*  4000 */
-	{0x06, 0},		/*  8000 */
-	{0x0C, 1},		/* 16000 */
-	{0x11, 1},              /* 22050 */
-	{0x00, 1},		/* 24000 */
-	{0x0C, 0},		/* 32000 */
-	{0x11, 0},		/* 44100 */
-	{0x00, 0},		/* 48000 */
-	{0x1F, 0},		/* 88200 */
-	{0x0E, 0},		/* 96000 */
-};
-
-/*
- *  mcbsp configuration structure
- */
-static struct omap_mcbsp_reg_cfg initial_config_mcbsp = {
-	.spcr2 = FREE | FRST | GRST | XRST | XINTM(3),
-	.spcr1 = RINTM(3) | RRST,
-	.rcr2 = RPHASE | RFRLEN2(OMAP_MCBSP_WORD_8) |
-	    RWDLEN2(OMAP_MCBSP_WORD_16) | RDATDLY(0),
-	.rcr1 = RFRLEN1(OMAP_MCBSP_WORD_8) | RWDLEN1(OMAP_MCBSP_WORD_16),
-	.xcr2 = XPHASE | XFRLEN2(OMAP_MCBSP_WORD_8) |
-	    XWDLEN2(OMAP_MCBSP_WORD_16) | XDATDLY(0) | XFIG,
-	.xcr1 = XFRLEN1(OMAP_MCBSP_WORD_8) | XWDLEN1(OMAP_MCBSP_WORD_16),
-	.srgr1 = FWID(DEFAULT_BITPERSAMPLE - 1),
-	.srgr2 = GSYNC | CLKSP | FSGM | FPER(DEFAULT_BITPERSAMPLE * 2 - 1),
-#ifndef AIC23_MASTER
-	/* configure McBSP to be the I2S master */
-	.pcr0 = FSXM | FSRM | CLKXM | CLKRM | CLKXP | CLKRP,
-#else
-	/* configure McBSP to be the I2S slave */
-	.pcr0 = CLKXP | CLKRP,
-#endif				/* AIC23_MASTER */
-};
-
-static snd_pcm_hw_constraint_list_t hw_constraints_rates = {
-	.count = ARRAY_SIZE(rates),
-	.list = rates,
-	.mask = 0,
-};
-
-/*
- * HW interface start and stop helper functions
- */
-static int audio_ifc_start(void)
-{
-	omap_mcbsp_start(AUDIO_MCBSP);
-	return 0;
-}
-
-static int audio_ifc_stop(void)
-{
-	omap_mcbsp_stop(AUDIO_MCBSP);
-	return 0;
-}
-
-/*
- * Codec/mcbsp init and configuration section
- * codec dependent code.
- */
-
-/*
- * Sample rate changing
- */
-static void omap_aic23_set_samplerate(struct snd_card_omap_codec
-				      *omap_aic23, long rate)
-{
-	u8 count = 0;
-	u16 data = 0;
-
-	/* Fix the rate if it has a wrong value */
-	if (rate >= 96000)
-		rate = 96000;
-	else if (rate >= 88200)
-		rate = 88200;
-	else if (rate >= 48000)
-		rate = 48000;
-	else if (rate >= 44100)
-		rate = 44100;
-	else if (rate >= 32000)
-		rate = 32000;
-	else if (rate >= 24000)
-		rate = 24000;
-	else if (rate >= 22050)
-		rate = 22050;
-	else if (rate >= 16000)
-		rate = 16000;
-	else if (rate >= 8000)
-		rate = 8000;
-	else
-		rate = 4000;
-
-	/* Search for the right sample rate */
-	/* Verify what happens if the rate is not supported
-	 * now it goes to 96Khz */
-	while ((rates[count] != rate) &&
-	       (count < (NUMBER_SAMPLE_RATES_SUPPORTED - 1))) {
-		count++;
-	}
-
-	data = (rate_reg_info[count].divider << CLKIN_SHIFT) |
-	    (rate_reg_info[count].control << BOSR_SHIFT) | USB_CLK_ON;
-
-	audio_aic23_write(SAMPLE_RATE_CONTROL_ADDR, data);
-
-	omap_aic23->samplerate = rate;
-}
-
-static inline void aic23_configure(void)
-{
-	/* Reset codec */
-	audio_aic23_write(RESET_CONTROL_ADDR, 0);
-
-	/* Initialize the AIC23 internal state */
-
-	/* Analog audio path control, DAC selected, delete INSEL_MIC for line in */
-	audio_aic23_write(ANALOG_AUDIO_CONTROL_ADDR, DEFAULT_ANALOG_AUDIO_CONTROL);
-
-	/* Digital audio path control, de-emphasis control 44.1kHz */
-	audio_aic23_write(DIGITAL_AUDIO_CONTROL_ADDR, DEEMP_44K);
-
-	/* Digital audio interface, master/slave mode, I2S, 16 bit */
-#ifdef AIC23_MASTER
-	audio_aic23_write(DIGITAL_AUDIO_FORMAT_ADDR,
-			  MS_MASTER | IWL_16 | FOR_DSP);
-#else
-	audio_aic23_write(DIGITAL_AUDIO_FORMAT_ADDR, IWL_16 | FOR_DSP);
-#endif
-
-	/* Enable digital interface */
-	audio_aic23_write(DIGITAL_INTERFACE_ACT_ADDR, ACT_ON);
-
-}
-
-static void omap_aic23_audio_init(struct snd_card_omap_codec *omap_aic23)
-{
-	/* Setup DMA stuff */
-	omap_aic23->s[SNDRV_PCM_STREAM_PLAYBACK].id = "Alsa AIC23 out";
-	omap_aic23->s[SNDRV_PCM_STREAM_PLAYBACK].stream_id =
-	    SNDRV_PCM_STREAM_PLAYBACK;
-	omap_aic23->s[SNDRV_PCM_STREAM_PLAYBACK].dma_dev =
-	    OMAP_DMA_MCBSP1_TX;
-	omap_aic23->s[SNDRV_PCM_STREAM_PLAYBACK].hw_start =
-	    audio_ifc_start;
-	omap_aic23->s[SNDRV_PCM_STREAM_PLAYBACK].hw_stop =
-	    audio_ifc_stop;
-
-	omap_aic23->s[SNDRV_PCM_STREAM_CAPTURE].id = "Alsa AIC23 in";
-	omap_aic23->s[SNDRV_PCM_STREAM_CAPTURE].stream_id =
-	    SNDRV_PCM_STREAM_CAPTURE;
-	omap_aic23->s[SNDRV_PCM_STREAM_CAPTURE].dma_dev =
-	    OMAP_DMA_MCBSP1_RX;
-	omap_aic23->s[SNDRV_PCM_STREAM_CAPTURE].hw_start =
-	    audio_ifc_start;
-	omap_aic23->s[SNDRV_PCM_STREAM_CAPTURE].hw_stop =
-	    audio_ifc_stop;
-
-	/* configuring the McBSP */
-	omap_mcbsp_request(AUDIO_MCBSP);
-
-	/* if configured, then stop mcbsp */
-	omap_mcbsp_stop(AUDIO_MCBSP);
-
-	omap_mcbsp_config(AUDIO_MCBSP, &initial_config_mcbsp);
-	omap_mcbsp_start(AUDIO_MCBSP);
-	aic23_configure();
-}
-
-/* 
- * DMA functions 
- * Depends on omap-aic23-dma.c functions and (omap) dma.c
- * 
- */
-#define DMA_BUF_SIZE	1024 * 8
-
-static int audio_dma_request(struct audio_stream *s,
-			     void (*callback) (void *))
-{
-	int err;
-
-	err = omap_request_alsa_sound_dma(s->dma_dev, s->id, s, &s->lch);
-	if (err < 0)
-		printk(KERN_ERR "unable to grab audio dma 0x%x\n",
-		       s->dma_dev);
-	return err;
-}
-
-static int audio_dma_free(struct audio_stream *s)
-{
-	int err = 0;
-
-	err = omap_free_alsa_sound_dma(s, &s->lch);
-	if (err < 0)
-		printk(KERN_ERR "Unable to free audio dma channels!\n");
-	return err;
-}
-
-/*
- *  This function should calculate the current position of the dma in the
- *  buffer. It will help alsa middle layer to continue update the buffer.
- *  Its correctness is crucial for good functioning.
- */
-static u_int audio_get_dma_pos(struct audio_stream *s)
-{
-	snd_pcm_substream_t *substream = s->stream;
-	snd_pcm_runtime_t *runtime = substream->runtime;
-	unsigned int offset;
-	unsigned long flags;
-	dma_addr_t count;
-	ADEBUG();
-
-	/* this must be called w/ interrupts locked as requested in dma.c */
-	spin_lock_irqsave(&s->dma_lock, flags);
-
-	/* For the current period let's see where we are */
-	count = omap_get_dma_src_addr_counter(s->lch[s->dma_q_head]);
-
-	spin_unlock_irqrestore(&s->dma_lock, flags);
-
-	/* Now, the position related to the end of that period */
-	offset = bytes_to_frames(runtime, s->offset) - bytes_to_frames(runtime, count);
-
-	if (offset >= runtime->buffer_size || offset < 0)
-		offset = 0;
-
-	return offset;
-}
-
-/*
- * this stops the dma and clears the dma ptrs
- */
-static void audio_stop_dma(struct audio_stream *s)
-{
-	unsigned long flags;
-	ADEBUG();
-
-	spin_lock_irqsave(&s->dma_lock, flags);
-	s->active = 0;
-	s->period = 0;
-	s->periods = 0;
-
-	/* this stops the dma channel and clears the buffer ptrs */
-	/* this stops the dma channel and clears the buffer ptrs */
-	omap_stop_alsa_sound_dma(s);
-
-	omap_clear_alsa_sound_dma(s);
-
-	spin_unlock_irqrestore(&s->dma_lock, flags);
-}
-
-/*
- *  Main dma routine, requests dma according where you are in main alsa buffer
- */
-static void audio_process_dma(struct audio_stream *s)
-{
-	snd_pcm_substream_t *substream = s->stream;
-	snd_pcm_runtime_t *runtime;
-	unsigned int dma_size;
-	unsigned int offset;
-	int ret;
-
-	runtime = substream->runtime;
-	if (s->active) {
-		dma_size = frames_to_bytes(runtime, runtime->period_size);
-		offset = dma_size * s->period;
-		snd_assert(dma_size <= DMA_BUF_SIZE,);
-		ret = omap_start_alsa_sound_dma(s,
-					 (dma_addr_t) runtime->dma_area +
-					 offset, dma_size);
-		if (ret) {
-			printk(KERN_ERR
-			       "audio_process_dma: cannot queue DMA buffer (%i)\n",
-			       ret);
-			return;
-		}
-
-		s->period++;
-		s->period %= runtime->periods;
-		s->periods++;
-		s->offset = offset;
-	}
-}
-
-/* 
- *  This is called when dma IRQ occurs at the end of each transmited block
- */
-void callback_omap_alsa_sound_dma(void *data)
-{
-	struct audio_stream *s = data;
-
-	/* 
-	 * If we are getting a callback for an active stream then we inform
-	 * the PCM middle layer we've finished a period
-	 */
-	if (s->active)
-		snd_pcm_period_elapsed(s->stream);
-
-	spin_lock(&s->dma_lock);
-	if (s->periods > 0) {
-		s->periods--;
-	}
-	audio_process_dma(s);
-	spin_unlock(&s->dma_lock);
-}
-
-
-/* 
- * Alsa section
- * PCM settings and callbacks
- */
-
-static int snd_omap_alsa_trigger(snd_pcm_substream_t * substream, int cmd)
-{
-	struct snd_card_omap_codec *chip =
-	    snd_pcm_substream_chip(substream);
-	int stream_id = substream->pstr->stream;
-	struct audio_stream *s = &chip->s[stream_id];
-	int err = 0;
-	ADEBUG();
-
-	/* note local interrupts are already disabled in the midlevel code */
-	spin_lock(&s->dma_lock);
-	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_START:
-		/* requested stream startup */
-		s->active = 1;
-		audio_process_dma(s);
-		break;
-	case SNDRV_PCM_TRIGGER_STOP:
-		/* requested stream shutdown */
-		audio_stop_dma(s);
-		break;
-	default:
-		err = -EINVAL;
-		break;
-	}
-	spin_unlock(&s->dma_lock);
-	
-	return err;
-}
-
-static int snd_omap_alsa_prepare(snd_pcm_substream_t * substream)
-{
-	struct snd_card_omap_codec *chip =
-	    snd_pcm_substream_chip(substream);
-	snd_pcm_runtime_t *runtime = substream->runtime;
-	struct audio_stream *s = &chip->s[substream->pstr->stream];
-
-	/* set requested samplerate */
-	omap_aic23_set_samplerate(chip, runtime->rate);
-
-	s->period = 0;
-	s->periods = 0;
-
-	return 0;
-}
-
-static snd_pcm_uframes_t snd_omap_alsa_pointer(snd_pcm_substream_t *
-						substream)
-{
-	struct snd_card_omap_codec *chip =
-	    snd_pcm_substream_chip(substream);
-	
-	return audio_get_dma_pos(&chip->s[substream->pstr->stream]);
-}
-
-/* Hardware capabilities */
-
-static snd_pcm_hardware_t snd_omap_alsa_capture = {
-	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
-		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID),
-	.formats = (SNDRV_PCM_FMTBIT_S16_LE),
-	.rates = (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |
-		  SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 |
-		  SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
-		  SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000 |
-		  SNDRV_PCM_RATE_KNOT),
-	.rate_min = 8000,
-	.rate_max = 96000,
-	.channels_min = 2,
-	.channels_max = 2,
-	.buffer_bytes_max = 128 * 1024,
-	.period_bytes_min = 32,
-	.period_bytes_max = 8 * 1024,
-	.periods_min = 16,
-	.periods_max = 255,
-	.fifo_size = 0,
-};
-
-static snd_pcm_hardware_t snd_omap_alsa_playback = {
-	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
-		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID),	
-	.formats = (SNDRV_PCM_FMTBIT_S16_LE),
-	.rates = (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |
-		  SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 |
-		  SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
-		  SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000 |
-		  SNDRV_PCM_RATE_KNOT),
-	.rate_min = 8000,
-	.rate_max = 96000,
-	.channels_min = 2,
-	.channels_max = 2,
-	.buffer_bytes_max = 128 * 1024,
-	.period_bytes_min = 32,
-	.period_bytes_max = 8 * 1024,
-	.periods_min = 16,
-	.periods_max = 255,
-	.fifo_size = 0,
-};
-
-static int snd_card_omap_alsa_open(snd_pcm_substream_t * substream)
-{
-	struct snd_card_omap_codec *chip =
-	    snd_pcm_substream_chip(substream);
-	snd_pcm_runtime_t *runtime = substream->runtime;
-	int stream_id = substream->pstr->stream;
-	int err;
-	ADEBUG();
-
-	chip->s[stream_id].stream = substream;
-	
-	omap_aic23_clock_on();
-	
-	if (stream_id == SNDRV_PCM_STREAM_PLAYBACK)
-		runtime->hw = snd_omap_alsa_playback;
-	else
-		runtime->hw = snd_omap_alsa_capture;
-	if ((err =
-	     snd_pcm_hw_constraint_integer(runtime,
-					   SNDRV_PCM_HW_PARAM_PERIODS)) <
-	    0)
-		return err;
-	if ((err =
-	     snd_pcm_hw_constraint_list(runtime, 0,
-					SNDRV_PCM_HW_PARAM_RATE,
-					&hw_constraints_rates)) < 0)
-		return err;
-
-	return 0;
-}
-
-static int snd_card_omap_alsa_close(snd_pcm_substream_t * substream)
-{
-	struct snd_card_omap_codec *chip =
-	    snd_pcm_substream_chip(substream);
-	ADEBUG();
-	
-	omap_aic23_clock_off();
-	chip->s[substream->pstr->stream].stream = NULL;
-	
-	return 0;
-}
-
-/* HW params & free */
-
-static int snd_omap_alsa_hw_params(snd_pcm_substream_t * substream,
-				    snd_pcm_hw_params_t * hw_params)
-{
-	return snd_pcm_lib_malloc_pages(substream,
-					params_buffer_bytes(hw_params));
-}
-
-static int snd_omap_alsa_hw_free(snd_pcm_substream_t * substream)
-{
-	return snd_pcm_lib_free_pages(substream);
-}
-
-/* pcm operations */
-static snd_pcm_ops_t snd_card_omap_alsa_playback_ops = {
-	.open =		snd_card_omap_alsa_open,
-	.close =	snd_card_omap_alsa_close,
-	.ioctl =	snd_pcm_lib_ioctl,
-	.hw_params =	snd_omap_alsa_hw_params,
-	.hw_free =	snd_omap_alsa_hw_free,
-	.prepare =	snd_omap_alsa_prepare,
-	.trigger =	snd_omap_alsa_trigger,
-	.pointer =	snd_omap_alsa_pointer,
-};
-
-static snd_pcm_ops_t snd_card_omap_alsa_capture_ops = {
-	.open =		snd_card_omap_alsa_open,
-	.close =	snd_card_omap_alsa_close,
-	.ioctl =	snd_pcm_lib_ioctl,
-	.hw_params =	snd_omap_alsa_hw_params,
-	.hw_free =	snd_omap_alsa_hw_free,
-	.prepare =	snd_omap_alsa_prepare,
-	.trigger =	snd_omap_alsa_trigger,
-	.pointer =	snd_omap_alsa_pointer,
-};
-
-/*
- *  Alsa init and exit section
- *  
- *  Inits pcm alsa structures, allocate the alsa buffer, suspend, resume
- */
-static int __init snd_card_omap_alsa_pcm(struct snd_card_omap_codec *omap_alsa, 
-					int device)
-{
-	snd_pcm_t *pcm;
-	int err;
-	ADEBUG();
-
-	if ((err =
-	     snd_pcm_new(omap_aic23->card, "AIC23 PCM", device, 1, 1,
-			 &pcm)) < 0)
-		return err;
-
-	/* sets up initial buffer with continuous allocation */
-	snd_pcm_lib_preallocate_pages_for_all(pcm,
-					      SNDRV_DMA_TYPE_CONTINUOUS,
-					      snd_dma_continuous_data
-					      (GFP_KERNEL),
-					      128 * 1024, 128 * 1024);
-
-	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK,
-			&snd_card_omap_alsa_playback_ops);
-	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE,
-			&snd_card_omap_alsa_capture_ops);
-	pcm->private_data = omap_aic23;
-	pcm->info_flags = 0;
-	strcpy(pcm->name, "omap aic23 pcm");
-
-	omap_aic23_audio_init(omap_aic23);
-
-	/* setup DMA controller */
-	audio_dma_request(&omap_aic23->s[SNDRV_PCM_STREAM_PLAYBACK],
-			  callback_omap_alsa_sound_dma);
-	audio_dma_request(&omap_aic23->s[SNDRV_PCM_STREAM_CAPTURE],
-			  callback_omap_alsa_sound_dma);
-
-	omap_aic23->pcm = pcm;
-
-	return 0;
-}
-
-#ifdef CONFIG_PM
-/*
- * Driver suspend/resume - calls alsa functions. Some hints from aaci.c
- */
-int snd_omap_alsa_suspend(struct platform_device *pdev, pm_message_t state)
-{
-	struct snd_card_omap_codec *chip;
-	snd_card_t *card = platform_get_drvdata(pdev);
-	
-	if (card->power_state != SNDRV_CTL_POWER_D3hot) {
-		chip = card->private_data;
-		if (chip->card->power_state != SNDRV_CTL_POWER_D3hot) {
-			snd_power_change_state(chip->card, SNDRV_CTL_POWER_D3hot);
-			snd_pcm_suspend_all(chip->pcm);
-			/* Mutes and turn clock off */
-			omap_aic23_clock_off();
-			snd_omap_suspend_mixer();
-		}
-	}
-	return 0;
-}
-
-int snd_omap_alsa_resume(struct platform_device *pdev)
-{
-	struct snd_card_omap_codec *chip;
-	snd_card_t *card = platform_get_drvdata(pdev);
-
-	if (card->power_state != SNDRV_CTL_POWER_D0) {				
-		chip = card->private_data;
-		if (chip->card->power_state != SNDRV_CTL_POWER_D0) {
-			snd_power_change_state(chip->card, SNDRV_CTL_POWER_D0);
-			omap_aic23_clock_on();
-			snd_omap_resume_mixer();
-		}
-	}
-	return 0;
-}
-
-#else
-#define snd_omap_alsa_suspend	NULL
-#define snd_omap_alsa_resume	NULL
-#endif	/* CONFIG_PM */
-
-/* 
- */
-void snd_omap_alsa_free(snd_card_t * card)
-{
-	struct snd_card_omap_codec *chip = card->private_data;
-	ADEBUG();
-	
-	/*
-	 * Turn off codec after it is done.
-	 * Can't do it immediately, since it may still have
-	 * buffered data.
-	 */
-	set_current_state(TASK_INTERRUPTIBLE);
-	schedule_timeout(2);
-
-	omap_mcbsp_stop(AUDIO_MCBSP);
-	omap_mcbsp_free(AUDIO_MCBSP);
-
-	audio_aic23_write(RESET_CONTROL_ADDR, 0);
-	audio_aic23_write(POWER_DOWN_CONTROL_ADDR, 0xff);
-
-	audio_dma_free(&chip->s[SNDRV_PCM_STREAM_PLAYBACK]);
-	audio_dma_free(&chip->s[SNDRV_PCM_STREAM_CAPTURE]);
-}
-
-/*
- *  Omap MCBSP clock configuration
- *  
- *  Here we have some functions that allows clock to be enabled and
- *   disabled only when needed. Besides doing clock configuration 
- *   it allows turn on/turn off audio when necessary. 
- */
-#define CODEC_CLOCK                   12000000
-#define AUDIO_RATE_DEFAULT	      44100
-
-/*
- * Do clock framework mclk search
- */
-static __init void omap_aic23_clock_setup(void)
-{
-	aic23_mclk = clk_get(0, "mclk");
-}
-
-/*
- * Do some sanity check, set clock rate, starts it and
- *  turn codec audio on 
- */
-int omap_aic23_clock_on(void)
-{
-	if (clk_get_usecount(aic23_mclk) > 0) {
-		/* MCLK is already in use */
-		printk(KERN_WARNING
-		       "MCLK in use at %d Hz. We change it to %d Hz\n",
-		       (uint) clk_get_rate(aic23_mclk),
-		       CODEC_CLOCK);
-	}
-	
-	if (clk_set_rate(aic23_mclk, CODEC_CLOCK)) {
-		printk(KERN_ERR
-		       "Cannot set MCLK for AIC23 CODEC\n");
-		return -ECANCELED;
-	}
-
-	clk_enable(aic23_mclk);
-
-	printk(KERN_DEBUG
-		"MCLK = %d [%d], usecount = %d\n",
-	       (uint) clk_get_rate(aic23_mclk), CODEC_CLOCK,
-	       clk_get_usecount(aic23_mclk));
-
-	/* Now turn the audio on */
-	audio_aic23_write(POWER_DOWN_CONTROL_ADDR, 
-			  ~DEVICE_POWER_OFF & ~OUT_OFF & ~DAC_OFF &
-			  ~ADC_OFF & ~MIC_OFF & ~LINE_OFF);
-	
-	return 0;
-}
-/*
- * Do some sanity check, turn clock off and then turn
- *  codec audio off
- */
-int omap_aic23_clock_off(void)
-{
-	if  (clk_get_usecount(aic23_mclk) > 0) { 
-		if (clk_get_rate(aic23_mclk) != CODEC_CLOCK) {
-			printk(KERN_WARNING
-			       "MCLK for audio should be %d Hz. But is %d Hz\n",
-			       (uint) clk_get_rate(aic23_mclk),
-			       CODEC_CLOCK);
-		}
-
-		clk_disable(aic23_mclk);
-	}
-	
-	audio_aic23_write(POWER_DOWN_CONTROL_ADDR,
-			  DEVICE_POWER_OFF | OUT_OFF | DAC_OFF |
-			  ADC_OFF | MIC_OFF | LINE_OFF);	
-	return 0;
-}
-
-/* module init & exit */
-
-/* 
- *  Inits alsa soudcard structure
- */
-static int __init snd_omap_alsa_aic23_probe(struct platform_device *pdev)
-{
-	int err = 0;
-	snd_card_t *card;
-	ADEBUG();
-	
-	/* gets clock from clock framework */
-	omap_aic23_clock_setup();
-
-	/* register the soundcard */
-	card = snd_card_new(-1, id, THIS_MODULE, sizeof(omap_aic23));
-	if (card == NULL)
-		return -ENOMEM;
-
-	omap_aic23 = kcalloc(1, sizeof(*omap_aic23), GFP_KERNEL);
-	if (omap_aic23 == NULL)
-		return -ENOMEM;
-
-	card->private_data = (void *) omap_aic23;
-	card->private_free = snd_omap_alsa_free;
-
-	omap_aic23->card = card;
-	omap_aic23->samplerate = AUDIO_RATE_DEFAULT;
-
-	spin_lock_init(&omap_aic23->s[0].dma_lock);
-	spin_lock_init(&omap_aic23->s[1].dma_lock);
-
-	/* mixer */
-	if ((err = snd_omap_mixer(omap_aic23)) < 0) 
-		goto nodev;
-
-	/* PCM */
-	if ((err = snd_card_omap_alsa_pcm(omap_aic23, 0)) < 0)
-		goto nodev;
-
-	strcpy(card->driver, "AIC23");
-	strcpy(card->shortname, "OSK AIC23");
-	sprintf(card->longname, "OMAP OSK with AIC23");
-
-	snd_omap_init_mixer();
-
-	snd_card_set_dev(card, &pdev->dev);
-	
-	if ((err = snd_card_register(card)) == 0) {
-		printk(KERN_INFO "OSK audio support initialized\n");
-		platform_set_drvdata(pdev, card);
-		return 0;
-	}
-	
-nodev:
-	snd_card_free(card);
-	
-	return err;
-}
-
-static int snd_omap_alsa_remove(struct platform_device *pdev)
-{
-	snd_card_t *card = platform_get_drvdata(pdev);
-	struct snd_card_omap_codec *chip = card->private_data;
-	
-	snd_card_free(card);
-
-	omap_aic23 = NULL;
-	card->private_data = NULL;
-	kfree(chip);
-	
-	platform_set_drvdata(pdev, NULL);
-	
-	return 0;
-	
-}
-
-static struct platform_driver omap_alsa_driver = {
-	.probe		= snd_omap_alsa_aic23_probe,
-	.remove 	= snd_omap_alsa_remove,
-	.suspend	= snd_omap_alsa_suspend,
-	.resume		= snd_omap_alsa_resume,
-	.driver = {
-		.name =	"omap_mcbsp",
-	},
-};
-
-static int __init omap_alsa_aic23_init(void)
-{
-	int err;
-	ADEBUG();
-
-	err = platform_driver_register(&omap_alsa_driver);
-
-	return err;
-}
-
-static void __exit omap_alsa_aic23_exit(void)
-{
-	ADEBUG();
-	
-	platform_driver_unregister(&omap_alsa_driver);
-}
-
-module_init(omap_alsa_aic23_init);
-module_exit(omap_alsa_aic23_exit);
diff --git a/sound/arm/omap-aic23.h b/sound/arm/omap-aic23.h
deleted file mode 100644
index c471d6c..0000000
--- a/sound/arm/omap-aic23.h
+++ /dev/null
@@ -1,131 +0,0 @@
-/*
- * sound/arm/omap-aic23.h
- * 
- * Alsa Driver for AIC23 codec on OSK5912 platform board
- *
- * Copyright (C) 2005 Instituto Nokia de Tecnologia - INdT - Manaus Brazil
- * Written by Daniel Petrini, David Cohen, Anderson Briglia
- *            {daniel.petrini, david.cohen, anderson.briglia}@indt.org.br
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation; either version 2 of the License, or (at your
- * option) any later version.
- *
- * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
- * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
- * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
- * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
- * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- * You should have received a copy of the  GNU General Public License along
- * with this program; if not, write  to the Free Software Foundation, Inc.,
- * 675 Mass Ave, Cambridge, MA 02139, USA.
- *
- *  History
- *  -------
- *
- *  2005/07/25 INdT-10LE Kernel Team - 	Alsa driver for omap osk,
- *  					original version based in sa1100 driver
- *  					and omap oss driver.
- *
- *  2005-12-18   Dirk Behme      - Added L/R Channel Interchange fix as proposed by Ajaya Babu
- */
-
-#ifndef __OMAP_AIC23_H
-#define __OMAP_AIC23_H
-
-#include <sound/driver.h>
-#include <asm/arch/dma.h>
-#include <sound/core.h>
-#include <sound/pcm.h>
-
-#define DEFAULT_OUTPUT_VOLUME         0x60
-#define DEFAULT_INPUT_VOLUME          0x00	/* 0 ==> mute line in */
-
-#define OUTPUT_VOLUME_MIN             LHV_MIN
-#define OUTPUT_VOLUME_MAX             LHV_MAX
-#define OUTPUT_VOLUME_RANGE           (OUTPUT_VOLUME_MAX - OUTPUT_VOLUME_MIN)
-#define OUTPUT_VOLUME_MASK            OUTPUT_VOLUME_MAX
-
-#define INPUT_VOLUME_MIN 	      LIV_MIN
-#define INPUT_VOLUME_MAX 	      LIV_MAX
-#define INPUT_VOLUME_RANGE 	      (INPUT_VOLUME_MAX - INPUT_VOLUME_MIN)
-#define INPUT_VOLUME_MASK 	      INPUT_VOLUME_MAX
-
-#define SIDETONE_MASK                 0x1c0
-#define SIDETONE_0                    0x100
-#define SIDETONE_6                    0x000
-#define SIDETONE_9                    0x040
-#define SIDETONE_12                   0x080
-#define SIDETONE_18                   0x0c0
-
-#define DEFAULT_ANALOG_AUDIO_CONTROL  DAC_SELECTED | STE_ENABLED | BYPASS_ON | INSEL_MIC | MICB_20DB
-
-/*
- * Buffer management for alsa and dma
- */
-struct audio_stream {
-	char *id;		/* identification string */
-	int stream_id;		/* numeric identification */
-	int dma_dev;		/* dma number of that device */
-	int *lch;		/* Chain of channels this stream is linked to */
-	char started;		/* to store if the chain was started or not */
-	int dma_q_head;		/* DMA Channel Q Head */
-	int dma_q_tail;		/* DMA Channel Q Tail */
-	char dma_q_count;	/* DMA Channel Q Count */
-	int active:1;		/* we are using this stream for transfer now */
-	int period;		/* current transfer period */
-	int periods;		/* current count of periods registerd in the DMA engine */
-	spinlock_t dma_lock;	/* for locking in DMA operations */
-	snd_pcm_substream_t *stream;	/* the pcm stream */
-	unsigned linked:1;	/* dma channels linked */
-	int offset;		/* store start position of the last period in the alsa buffer */
-	int (*hw_start)(void);  /* interface to start HW interface, e.g. McBSP */
-	int (*hw_stop)(void);   /* interface to stop HW interface, e.g. McBSP */
-};
-
-/*
- * Alsa card structure for aic23
- */
-struct snd_card_omap_codec {
-	snd_card_t *card;
-	snd_pcm_t *pcm;
-	long samplerate;
-	struct audio_stream s[2];	/* playback & capture */
-};
-
-/*********** Mixer function prototypes *************************/
-int snd_omap_mixer(struct snd_card_omap_codec *);
-void snd_omap_init_mixer(void);
-/* Clock functions */
-int omap_aic23_clock_on(void);
-int omap_aic23_clock_off(void);
-
-#ifdef CONFIG_PM
-void snd_omap_suspend_mixer(void);
-void snd_omap_resume_mixer(void);
-#endif
-
-/*********** function prototype to function called from the dma interrupt handler ******/
-void callback_omap_alsa_sound_dma(void *);
-
-/* Codec AIC23 */
-#if defined(CONFIG_SENSORS_TLV320AIC23) || defined (CONFIG_SENSORS_TLV320AIC23_MODULE)
-
-extern int tlv320aic23_write_value(u8 reg, u16 value);
-
-/* TLV320AIC23 is a write only device */
-static __inline__ void audio_aic23_write(u8 address, u16 data)
-{
-	tlv320aic23_write_value(address, data);
-}
-
-#endif /* CONFIG_SENSORS_TLV320AIC23 */
-
-#endif
diff --git a/sound/arm/omap-alsa-dma.c b/sound/arm/omap-alsa-dma.c
deleted file mode 100644
index beb7944..0000000
--- a/sound/arm/omap-alsa-dma.c
+++ /dev/null
@@ -1,452 +0,0 @@
-/*
- * sound/arm/omap-alsa-dma.c
- *
- * Common audio DMA handling for the OMAP processors
- *
- * Copyright (C) 2006 Mika Laitio <lamikr@cc.jyu.fi>
- *
- * Copyright (C) 2005 Instituto Nokia de Tecnologia - INdT - Manaus Brazil
- * 
- * Copyright (C) 2004 Texas Instruments, Inc.
- *
- * Copyright (C) 2000, 2001 Nicolas Pitre <nico@cam.org>
- *
- * This package is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
- * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
- * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
- *
- * History:
- *
- * 2004-06-07	Sriram Kannan	- Created new file from omap_audio_dma_intfc.c. This file
- * 				  will contain only the DMA interface and buffer handling of OMAP
- * 				  audio driver.
- *
- * 2004-06-22	Sriram Kannan	- removed legacy code (auto-init). Self-linking of DMA logical channel.
- *
- * 2004-08-12   Nishanth Menon  - Modified to integrate Audio requirements on 1610,1710 platforms
- *
- * 2004-11-01   Nishanth Menon  - 16xx platform code base modified to support multi channel chaining.
- *
- * 2004-12-15   Nishanth Menon  - Improved 16xx platform channel logic introduced - tasklets, queue handling updated
- * 
- * 2005-07-19	INdT Kernel Team - Alsa port. Creation of new file omap-alsa-dma.c based in
- * 				   omap-audio-dma-intfc.c oss file. Support for aic23 codec.
- * 				   Removal of buffer handling (Alsa does that), modifications
- *	in dma handling and port to alsa structures.
- *
- * 2005-12-18   Dirk Behme      - Added L/R Channel Interchange fix as proposed by Ajaya Babu
- */
-
-#include <linux/config.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/types.h>
-#include <linux/fs.h>
-#include <linux/mm.h>
-#include <linux/slab.h>
-#include <linux/sched.h>
-#include <linux/poll.h>
-#include <linux/pm.h>
-#include <linux/errno.h>
-#include <linux/sound.h>
-#include <linux/soundcard.h>
-#include <linux/sysrq.h>
-#include <linux/interrupt.h>
-#include <linux/dma-mapping.h>
-
-#include <asm/uaccess.h>
-#include <asm/io.h>
-#include <asm/hardware.h>
-#include <asm/semaphore.h>
-
-#include <asm/arch/dma.h>
-#include "omap-alsa-dma.h"
-
-#include <asm/arch/mcbsp.h>
-
-#undef DEBUG
-#define DEBUG
-#ifdef DEBUG
-#define DPRINTK(ARGS...)  printk(KERN_INFO "<%s>: ",__FUNCTION__);printk(ARGS)
-#define FN_IN printk(KERN_INFO "[%s]: start\n", __FUNCTION__)
-#define FN_OUT(n) printk(KERN_INFO "[%s]: end(%u)\n",__FUNCTION__, n)
-#else
-
-#define DPRINTK( x... )
-#define FN_IN
-#define FN_OUT(x)
-#endif
-
-#define ERR(ARGS...) printk(KERN_ERR "{%s}-ERROR: ", __FUNCTION__);printk(ARGS);
-
-/* Channel Queue Handling macros
- * tail always points to the current free entry
- * Head always points to the current entry being used
- * end is either head or tail
- */
-
-#define AUDIO_QUEUE_INIT(s) s->dma_q_head = s->dma_q_tail = s->dma_q_count = 0;
-#define AUDIO_QUEUE_FULL(s) (nr_linked_channels == s->dma_q_count)
-#define AUDIO_QUEUE_LAST(s) (1 == s->dma_q_count)
-#define AUDIO_QUEUE_EMPTY(s) (0 == s->dma_q_count)
-#define __AUDIO_INCREMENT_QUEUE(end) ((end)=((end)+1) % nr_linked_channels)
-#define AUDIO_INCREMENT_HEAD(s) __AUDIO_INCREMENT_QUEUE(s->dma_q_head); s->dma_q_count--;
-#define AUDIO_INCREMENT_TAIL(s) __AUDIO_INCREMENT_QUEUE(s->dma_q_tail); s->dma_q_count++;
-
-/* DMA buffer fragmentation sizes */
-#define MAX_DMA_SIZE		 0x1000000 /* todo: sync with alsa */
-//#define CUT_DMA_SIZE		 0x1000
-/* TODO: To be moved to more appropriate location */
-#define DCSR_ERROR           0x3
-#define DCSR_END_BLOCK       (1 << 5)
-#define DCSR_SYNC_SET        (1 << 6)
-
-#define DCCR_FS              (1 << 5)
-#define DCCR_PRIO            (1 << 6)
-#define DCCR_EN              (1 << 7)
-#define DCCR_AI              (1 << 8)
-#define DCCR_REPEAT          (1 << 9)
-/* if 0 the channel works in 3.1 compatible mode*/
-#define DCCR_N31COMP         (1 << 10)
-#define DCCR_EP              (1 << 11)
-#define DCCR_SRC_AMODE_BIT   12
-#define DCCR_SRC_AMODE_MASK  (0x3<<12)
-#define DCCR_DST_AMODE_BIT   14
-#define DCCR_DST_AMODE_MASK  (0x3<<14)
-#define AMODE_CONST          0x0
-#define AMODE_POST_INC       0x1
-#define AMODE_SINGLE_INDEX   0x2
-#define AMODE_DOUBLE_INDEX   0x3
-
-/**************************** DATA STRUCTURES *****************************************/
-
-static spinlock_t dma_list_lock = SPIN_LOCK_UNLOCKED;
-
-static char nr_linked_channels = 1;
-
-/*********************************** MODULE SPECIFIC FUNCTIONS ***********************/
-
-static void sound_dma_irq_handler(int lch, u16 ch_status, void *data);
-static int audio_set_dma_params_play(int channel, dma_addr_t dma_ptr,
-				     u_int dma_size);
-static int audio_set_dma_params_capture(int channel, dma_addr_t dma_ptr,
-					u_int dma_size);
-static int audio_start_dma_chain(struct audio_stream * s);
-
-/***************************************************************************************
- *
- * DMA channel requests
- *
- **************************************************************************************/
-static void omap_sound_dma_link_lch(void *data)
-{
-
-	struct audio_stream *s = (struct audio_stream *) data;
-	int *chan = s->lch;
-	int i;
-
-	FN_IN;
-	if (s->linked) {
-		FN_OUT(1);
-		return;
-	}
-	for (i = 0; i < nr_linked_channels; i++) {
-		int cur_chan = chan[i];
-		int nex_chan =
-		    ((nr_linked_channels - 1 ==
-		      i) ? chan[0] : chan[i + 1]);
-		omap_dma_link_lch(cur_chan, nex_chan);
-	}
-	s->linked = 1;
-	FN_OUT(0);
-}
-
-int omap_request_alsa_sound_dma(int device_id, const char *device_name,
-			   void *data, int **channels)
-{
-	int i, err = 0;
-	int *chan = NULL;
-	FN_IN;
-	if (unlikely((NULL == channels) || (NULL == device_name))) {
-		BUG();
-		return -EPERM;
-	}
-	/* Try allocate memory for the num channels */
-	*channels =
-	    (int *) kmalloc(sizeof(int) * nr_linked_channels, GFP_KERNEL);
-	chan = *channels;
-	if (NULL == chan) {
-		ERR("No Memory for channel allocs!\n");
-		FN_OUT(-ENOMEM);
-		return -ENOMEM;
-	}
-	spin_lock(&dma_list_lock);
-	for (i = 0; i < nr_linked_channels; i++) {
-		err = omap_request_dma(device_id, 
-				device_name,
-				sound_dma_irq_handler, 
-				data,
-				&chan[i]);
-
-		/* Handle Failure condition here */
-		if (err < 0) {
-			int j;
-			for (j = 0; j < i; j++) {
-				omap_free_dma(chan[j]);
-			}
-			spin_unlock(&dma_list_lock);
-			kfree(chan);
-			*channels = NULL;
-			ERR("Error in requesting channel %d=0x%x\n", i,
-			    err);
-			FN_OUT(err);
-			return err;
-		}
-	}
-
-	/* Chain the channels together */
-	if (!cpu_is_omap1510())
-		omap_sound_dma_link_lch(data);
-
-	spin_unlock(&dma_list_lock);
-	FN_OUT(0);
-	return 0;
-}
-
-/***************************************************************************************
- *
- * DMA channel requests Freeing
- *
- **************************************************************************************/
-static void omap_sound_dma_unlink_lch(void *data)
-{
-	struct audio_stream *s = (struct audio_stream *)data;
-	int *chan = s->lch;
-	int i;
-
-	FN_IN;
-	if (!s->linked) {
-		FN_OUT(1);
-		return;
-	}
-	for (i = 0; i < nr_linked_channels; i++) {
-		int cur_chan = chan[i];
-		int nex_chan =
-		    ((nr_linked_channels - 1 ==
-		      i) ? chan[0] : chan[i + 1]);
-		omap_dma_unlink_lch(cur_chan, nex_chan);
-	}
-	s->linked = 0;
-	FN_OUT(0);
-}
-
-int omap_free_alsa_sound_dma(void *data, int **channels)
-{
-	int i;
-	int *chan = NULL;
-	
-	FN_IN;
-	if (unlikely(NULL == channels)) {
-		BUG();
-		return -EPERM;
-	}
-	if (unlikely(NULL == *channels)) {
-		BUG();
-		return -EPERM;
-	}
-	chan = (*channels);
-
-	if (!cpu_is_omap1510())
-		omap_sound_dma_unlink_lch(data);
-	for (i = 0; i < nr_linked_channels; i++) {
-		int cur_chan = chan[i];
-		omap_stop_dma(cur_chan);
-		omap_free_dma(cur_chan);
-	}
-	kfree(*channels);
-	*channels = NULL;
-	FN_OUT(0);
-	return 0;
-}
-
-/***************************************************************************************
- *
- * Stop all the DMA channels of the stream
- *
- **************************************************************************************/
-void omap_stop_alsa_sound_dma(struct audio_stream *s)
-{
-	int *chan = s->lch;
-	int i;
-	
-	FN_IN;
-	if (unlikely(NULL == chan)) {
-		BUG();
-		return;
-	}
-	for (i = 0; i < nr_linked_channels; i++) {
-		int cur_chan = chan[i];
-		omap_stop_dma(cur_chan);
-	}
-	s->started = 0;
-	FN_OUT(0);
-	return;
-}
-/***************************************************************************************
- *
- * Clear any pending transfers
- *
- **************************************************************************************/
-void omap_clear_alsa_sound_dma(struct audio_stream * s)
-{
-	FN_IN;
-	omap_clear_dma(s->lch[s->dma_q_head]);
-	FN_OUT(0);
-	return;
-}
-
-/***************************************************************************************
- *
- * DMA related functions
- *
- **************************************************************************************/
-static int audio_set_dma_params_play(int channel, dma_addr_t dma_ptr,
-				     u_int dma_size)
-{
-	int dt = 0x1;		/* data type 16 */
-	int cen = 32;		/* Stereo */
-	int cfn = dma_size / (2 * cen);
-	
-	FN_IN;
-	omap_set_dma_dest_params(channel, 0x05, 0x00,
-				 (OMAP1510_MCBSP1_BASE + 0x06),
-				 0, 0);
-	omap_set_dma_src_params(channel, 0x00, 0x01, dma_ptr,
-				0, 0);
-	omap_set_dma_transfer_params(channel, dt, cen, cfn, 0x00, 0, 0);
-	FN_OUT(0);
-	return 0;
-}
-
-static int audio_set_dma_params_capture(int channel, dma_addr_t dma_ptr,
-					u_int dma_size)
-{
-	int dt = 0x1;		/* data type 16 */
-	int cen = 32;		/* stereo */
-	int cfn = dma_size / (2 * cen);
-	
-	FN_IN;
-	omap_set_dma_src_params(channel, 0x05, 0x00,
-				(OMAP1510_MCBSP1_BASE + 0x02),
-				0, 0);
-	omap_set_dma_dest_params(channel, 0x00, 0x01, dma_ptr, 0, 0);
-	omap_set_dma_transfer_params(channel, dt, cen, cfn, 0x00, 0, 0);
-	FN_OUT(0);
-	return 0;
-}
-
-static int audio_start_dma_chain(struct audio_stream *s)
-{
-	int channel = s->lch[s->dma_q_head];
-	FN_IN;
-	if (!s->started) {
-	 	s->hw_stop();	   /* stops McBSP Interface */
-		omap_start_dma(channel);
-		s->started = 1;
-		s->hw_start();	   /* start McBSP interface */
-	}
-	/* else the dma itself will progress forward with out our help */
-	FN_OUT(0);
-	return 0;
-}
-
-/* Start DMA -
- * Do the initial set of work to initialize all the channels as required.
- * We shall then initate a transfer
- */
-int omap_start_alsa_sound_dma(struct audio_stream *s, 
-			dma_addr_t dma_ptr, 
-			u_int dma_size)
-{
-	int ret = -EPERM;
-
-	FN_IN;
-
-	if (unlikely(dma_size > MAX_DMA_SIZE)) {
-		ERR("DmaSoundDma: Start: overflowed %d-%d\n", dma_size,
-		    MAX_DMA_SIZE);
-		return -EOVERFLOW;
-	}
-	//if (AUDIO_QUEUE_FULL(s)) {
-	//      ret = -2;
-	//      goto sound_out;
-	//}
-
-	if (s->stream_id == SNDRV_PCM_STREAM_PLAYBACK) {
-		/*playback */
-		ret =
-		    audio_set_dma_params_play(s->lch[s->dma_q_tail],
-					      dma_ptr, dma_size);
-	} else {
-		ret =
-		    audio_set_dma_params_capture(s->lch[s->dma_q_tail],
-						 dma_ptr, dma_size);
-	}
-	if (ret != 0) {
-		ret = -3;	/* indicate queue full */
-		goto sound_out;
-	}
-	AUDIO_INCREMENT_TAIL(s);
-	ret = audio_start_dma_chain(s);
-	if (ret) {
-		ERR("dma start failed");
-	}
-      sound_out:
-	FN_OUT(ret);
-	return ret;
-
-}
-
-/* 
- * ISRs have to be short and smart.. 
- * Here we call alsa handling, after some error checking
- */
-static void sound_dma_irq_handler(int sound_curr_lch, u16 ch_status,
-				  void *data)
-{
-	int dma_status = ch_status;
-	struct audio_stream *s = (struct audio_stream *) data;
-	FN_IN;
-
-	/*
-	 * some register checkings
-	 */ 
-	DPRINTK("lch=%d,status=0x%x, dma_status=%d, data=%p\n",
-		sound_curr_lch, ch_status, dma_status, data);
-
-	if (dma_status & (DCSR_ERROR)) {
-		OMAP_DMA_CCR_REG(sound_curr_lch) &= ~DCCR_EN;
-		ERR("DCSR_ERROR!\n");
-		FN_OUT(-1);
-		return;
-	}
-
-	if (ch_status & DCSR_END_BLOCK) 
-		callback_omap_alsa_sound_dma(s);
-	FN_OUT(0);
-	return;
-}
-
-MODULE_AUTHOR("Texas Instruments");
-MODULE_DESCRIPTION("Common DMA handling for Audio driver on OMAP processors");
-MODULE_LICENSE("GPL");
-
-EXPORT_SYMBOL(omap_start_alsa_sound_dma);
-EXPORT_SYMBOL(omap_clear_alsa_sound_dma);
-EXPORT_SYMBOL(omap_request_alsa_sound_dma);
-EXPORT_SYMBOL(omap_free_alsa_sound_dma);
-EXPORT_SYMBOL(omap_stop_alsa_sound_dma);
diff --git a/sound/arm/omap-alsa-dma.h b/sound/arm/omap-alsa-dma.h
deleted file mode 100644
index 187e09c..0000000
--- a/sound/arm/omap-alsa-dma.h
+++ /dev/null
@@ -1,53 +0,0 @@
-/*  
- * sound/arm/omap-alsa-dma.h
- *
- * Common audio DMA handling for the OMAP processors
- *
- * Copyright (C) 2006 Mika Laitio <lamikr@cc.jyu.fi>
- *
- * Copyright (C) 2005 Instituto Nokia de Tecnologia - INdT - Manaus Brazil
- * 
- * Copyright (C) 2004 Texas Instruments, Inc.
- *
- * Copyright (C) 2000, 2001 Nicolas Pitre <nico@cam.org>
- *
- * This package is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
- * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
- * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
- *
- * History:
- *
- * 
- * 2004/08/12  Nishanth Menon - Modified to integrate Audio requirements on 1610,1710 platforms
- *
- * 2005/07/25  INdT Kernel Team - Renamed to omap-alsa-dma.h. Ported to Alsa.
- */
-
-#ifndef __OMAP_AUDIO_ALSA_DMA_H
-#define __OMAP_AUDIO_ALSA_DMA_H
-
-/************************** INCLUDES *************************************/
-
-#include "omap-aic23.h"
-
-/************************** GLOBAL DATA STRUCTURES *********************************/
-
-typedef void (*dma_callback_t) (int lch, u16 ch_status, void *data);
-
-/**************** ARCH SPECIFIC FUNCIONS *******************************************/
-
-void omap_clear_alsa_sound_dma(struct audio_stream * s);
-
-int omap_request_alsa_sound_dma(int device_id, const char *device_name,
-			   void *data, int **channels);
-int omap_free_alsa_sound_dma(void *data, int **channels);
-
-int omap_start_alsa_sound_dma(struct audio_stream *s, dma_addr_t dma_ptr,  u_int dma_size);
-
-void omap_stop_alsa_sound_dma(struct audio_stream *s);
-
-#endif
diff --git a/sound/arm/omap-alsa-mixer.c b/sound/arm/omap-alsa-mixer.c
deleted file mode 100644
index 476f106..0000000
--- a/sound/arm/omap-alsa-mixer.c
+++ /dev/null
@@ -1,496 +0,0 @@
-/*
- * sound/arm/omap-alsa-mixer.c
- * 
- * Alsa Driver Mixer for generic codecs for omap boards
- *
- * Copyright (C) 2005 Instituto Nokia de Tecnologia - INdT - Manaus Brazil
- * Written by David Cohen, Daniel Petrini
- *            {david.cohen, daniel.petrini}@indt.org.br
- *
- * Based on es1688_lib.c, 
- * Copyright (c) by Jaroslav Kysela <perex@suse.cz>
- *  
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation; either version 2 of the License, or (at your
- * option) any later version.
- *
- * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
- * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
- * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
- * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
- * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- * You should have received a copy of the  GNU General Public License along
- * with this program; if not, write  to the Free Software Foundation, Inc.,
- * 675 Mass Ave, Cambridge, MA 02139, USA.
- *
- * History:
- *
- * 2005-08-02   INdT Kernel Team - Alsa mixer driver for omap osk. Creation of new 
- *                                 file omap-alsa-mixer.c. Initial version
- *                                 with aic23 codec for osk5912
- */
-
-#include <linux/config.h>
-#include <sound/driver.h>
-#include <linux/module.h>
-#include <linux/device.h>
-#include <linux/init.h>
-#include <linux/errno.h>
-#include <linux/ioctl.h>
-#include <linux/delay.h>
-#include <linux/slab.h>
-
-#include <asm/hardware.h>
-#include <asm/mach-types.h>
-#include <asm/arch/dma.h>
-#include <asm/arch/aic23.h>
-
-#include "omap-aic23.h"
-#include <sound/initval.h>
-#include <sound/control.h>
-
-MODULE_AUTHOR("David Cohen, Daniel Petrini - INdT");
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("OMAP Alsa mixer driver for ALSA");
-
-/*
- * Codec dependent region
- */
-
-/* Codec AIC23 */
-#if defined(CONFIG_SENSORS_TLV320AIC23) || defined (CONFIG_SENSORS_TLV320AIC23_MODULE)
-
-extern __inline__ void audio_aic23_write(u8, u16);
-
-#define MIXER_NAME		     "Mixer AIC23"
-#define SND_OMAP_WRITE(reg, val)     audio_aic23_write(reg, val)
-
-#endif
-
-/* Callback Functions */
-#define OMAP_BOOL(xname, xindex, reg, reg_index, mask, invert) \
-{ \
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
-	.name = xname, \
-	.index = xindex, \
-	.info = snd_omap_info_bool, \
-	.get = snd_omap_get_bool, \
-	.put = snd_omap_put_bool, \
-	.private_value = reg | (reg_index << 8) | (invert << 10) | (mask << 12) \
-}
-
-#define OMAP_MUX(xname, reg, reg_index, mask) \
-{ \
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
-	.name = xname, \
-	.info = snd_omap_info_mux, \
-	.get = snd_omap_get_mux, \
-	.put = snd_omap_put_mux, \
-	.private_value = reg | (reg_index << 8) | (mask << 10) \
-}
-
-#define OMAP_SINGLE(xname, xindex, reg, reg_index, reg_val, mask) \
-{\
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
-	.name = xname, \
-	.index = xindex, \
-	.info = snd_omap_info_single, \
-	.get = snd_omap_get_single, \
-	.put = snd_omap_put_single, \
-	.private_value = reg | (reg_val << 8) | (reg_index << 16) | (mask << 18) \
-}
-
-#define OMAP_DOUBLE(xname, xindex, left_reg, right_reg, reg_index, mask) \
-{\
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
-	.name = xname, \
-	.index = xindex, \
-	.info = snd_omap_info_double, \
-	.get = snd_omap_get_double, \
-	.put = snd_omap_put_double, \
-	.private_value = left_reg | (right_reg << 8) | (reg_index << 16) | (mask << 18) \
-}
-
-/* Local Registers */
-enum snd_device_index {
-	PCM_INDEX = 0,
-	LINE_INDEX,
-	AAC_INDEX, /* Analog Audio Control: reg = l_reg */
-};
-
-struct {
-	u16 l_reg;
-	u16 r_reg;
-	u8 sw;
-} omap_regs[3];
-
-#ifdef CONFIG_PM
-struct {
-	u16 l_reg;
-	u16 r_reg;
-	u8 sw;
-} omap_pm_regs[3];
-#endif
-
-u16 snd_sidetone[6] = {
-	SIDETONE_18,
-	SIDETONE_12,
-	SIDETONE_9,
-	SIDETONE_6,
-	SIDETONE_0,
-	0
-};
-
-/* Begin Bool Functions */
-
-static int snd_omap_info_bool(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
-{
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
-	uinfo->count = 1;
-	uinfo->value.integer.min = 0;
-	uinfo->value.integer.max = 1;
-	
-	return 0;
-}
-
-static int snd_omap_get_bool(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
-{
-	int mic_index = (kcontrol->private_value >> 8) & 0x03;
-	u16 mask = (kcontrol->private_value >> 12) & 0xff;
-	int invert = (kcontrol->private_value >> 10) & 0x03;
-	
-	if (invert)
-		ucontrol->value.integer.value[0] = (omap_regs[mic_index].l_reg & mask) ? 0 : 1;
-	else
-		ucontrol->value.integer.value[0] = (omap_regs[mic_index].l_reg & mask) ? 1 : 0;
-	
-	return 0;
-}
-
-static int snd_omap_put_bool(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
-{
-	int mic_index = (kcontrol->private_value >> 8) & 0x03;
-	u16 mask = (kcontrol->private_value >> 12) & 0xff;
-	u16 reg = kcontrol->private_value & 0xff;
-	int invert = (kcontrol->private_value >> 10) & 0x03;
-	
-	int changed = 1;
-
-	if (ucontrol->value.integer.value[0]) /* XOR */
-		if (invert)
-			omap_regs[mic_index].l_reg &= ~mask;
-		else
-			omap_regs[mic_index].l_reg |= mask;
-	else
-		if (invert)
-			omap_regs[mic_index].l_reg |= mask;
-		else
-			omap_regs[mic_index].l_reg &= ~mask;
-		
-	SND_OMAP_WRITE(reg, omap_regs[mic_index].l_reg);
-	
-	return changed;
-}
-
-/* End Bool Functions */
-
-/* Begin Mux Functions */
-
-static int snd_omap_info_mux(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
-{
-	/* Mic = 0
-	 * Line = 1 */
-	static char *texts[2] =	{ "Mic", "Line"	};
-
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 2;
-	
-	if (uinfo->value.enumerated.item > 1)
-		uinfo->value.enumerated.item = 1;
-	
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	
-	return 0;
-}
-
-static int snd_omap_get_mux(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
-{
-	u16 mask = (kcontrol->private_value >> 10) & 0xff;
-	int mux_index = (kcontrol->private_value >> 8) & 0x03;
-
-	ucontrol->value.enumerated.item[0] = (omap_regs[mux_index].l_reg & mask) ? 0 /* Mic */ : 1 /* Line */;
-	
-	return 0;
-}
-
-static int snd_omap_put_mux(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
-{
-	u16 reg = kcontrol->private_value & 0xff;
-	u16 mask = (kcontrol->private_value >> 10) & 0xff;
-	int mux_index = (kcontrol->private_value >> 8) & 0x03;
-	
-	int changed = 1;
-
-	if (!ucontrol->value.integer.value[0])
-		omap_regs[mux_index].l_reg |= mask; /* AIC23: Mic */
-	else
-		omap_regs[mux_index].l_reg &= ~mask; /* AIC23: Line */
-	
-	SND_OMAP_WRITE(reg, omap_regs[mux_index].l_reg);
-	
-	return changed;
-}
-
-/* End Mux Functions */
-
-/* Begin Single Functions */
-
-static int snd_omap_info_single(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
-{
-	int mask = (kcontrol->private_value >> 18) & 0xff;
-	int reg_val = (kcontrol->private_value >> 8) & 0xff;
-	
-	uinfo->type = mask ? SNDRV_CTL_ELEM_TYPE_INTEGER : SNDRV_CTL_ELEM_TYPE_BOOLEAN;
-	uinfo->count = 1;
-	uinfo->value.integer.min = 0;
-	uinfo->value.integer.max = reg_val-1;
-	
-	return 0;
-}
-
-static int snd_omap_get_single(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
-{
-	u16 reg_val = (kcontrol->private_value >> 8) & 0xff;
-
-	ucontrol->value.integer.value[0] = snd_sidetone[reg_val];
-	
-	return 0;
-}
-
-static int snd_omap_put_single(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
-{
-	u16 reg_index = (kcontrol->private_value >> 16) & 0x03;
-	u16 mask = (kcontrol->private_value >> 18) & 0x1ff;
-	u16 reg = kcontrol->private_value & 0xff;
-	u16 reg_val = (kcontrol->private_value >> 8) & 0xff;
-
-	int changed = 0;
-
-	/* Volume */
-	if ((omap_regs[reg_index].l_reg != (ucontrol->value.integer.value[0] & mask)))
-	{
-		changed = 1;
-	
-		omap_regs[reg_index].l_reg &= ~mask;
-		omap_regs[reg_index].l_reg |= snd_sidetone[ucontrol->value.integer.value[0]];
-
-		snd_sidetone[reg_val] = ucontrol->value.integer.value[0];
-		SND_OMAP_WRITE(reg, omap_regs[reg_index].l_reg);
-	}
-	else
-		changed = 0;
-	
-	return changed;
-}
-
-/* End Single Functions */
-
-/* Begin Double Functions */
-
-static int snd_omap_info_double(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
-{
-	/* mask == 0 : Switch
-	 * mask != 0 : Volume */
-	int mask = (kcontrol->private_value >> 18) & 0xff;
-
-	uinfo->type = mask ? SNDRV_CTL_ELEM_TYPE_INTEGER : SNDRV_CTL_ELEM_TYPE_BOOLEAN;
-	uinfo->count = mask ? 2 : 1;
-	uinfo->value.integer.min = 0;
-	uinfo->value.integer.max = mask ? mask : 1;
-	
-	return 0;
-}
-
-static int snd_omap_get_double(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
-{
-	/* mask == 0 : Switch
-	 * mask != 0 : Volume */
-	int mask = (kcontrol->private_value >> 18) & 0xff;
-	int vol_index = (kcontrol->private_value >> 16) & 0x03;
-	
-	if (!mask)
-		/* Switch */
-		ucontrol->value.integer.value[0] = omap_regs[vol_index].sw;
-	else
-	{
-		/* Volume */
-		ucontrol->value.integer.value[0] = omap_regs[vol_index].l_reg;
-		ucontrol->value.integer.value[1] = omap_regs[vol_index].r_reg;
-	}
-
-	return 0;
-}
-
-static int snd_omap_put_double(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
-{
-	/* mask == 0 : Switch
-	 * mask != 0 : Volume */
-	int vol_index = (kcontrol->private_value >> 16) & 0x03;
-	int mask = (kcontrol->private_value >> 18) & 0xff;
-	int left_reg = kcontrol->private_value & 0xff;
-	int right_reg = (kcontrol->private_value >> 8) & 0xff;
-
-	int changed = 0;
-
-	if (!mask)
-	{
-		/* Switch */
-		if (!ucontrol->value.integer.value[0])
-		{
-			SND_OMAP_WRITE(left_reg, 0x00);
-			SND_OMAP_WRITE(right_reg, 0x00);
-		}
-		else
-		{
-			SND_OMAP_WRITE(left_reg, omap_regs[vol_index].l_reg);
-			SND_OMAP_WRITE(right_reg, omap_regs[vol_index].r_reg);
-		}
-		changed = 1;
-		omap_regs[vol_index].sw = ucontrol->value.integer.value[0]; 
-	}
-	else
-	{
-		/* Volume */
-		if ((omap_regs[vol_index].l_reg != (ucontrol->value.integer.value[0] & mask)) ||
-		    (omap_regs[vol_index].r_reg != (ucontrol->value.integer.value[1] & mask)))
-		{
-			changed = 1;
-		
-			omap_regs[vol_index].l_reg &= ~mask;
-			omap_regs[vol_index].r_reg &= ~mask;
-			omap_regs[vol_index].l_reg |= (ucontrol->value.integer.value[0] & mask);
-			omap_regs[vol_index].r_reg |= (ucontrol->value.integer.value[1] & mask);
-			if (omap_regs[vol_index].sw)
-			{
-				/* write to registers only if sw is actived */
-				SND_OMAP_WRITE(left_reg, omap_regs[vol_index].l_reg);
-				SND_OMAP_WRITE(right_reg, omap_regs[vol_index].r_reg);
-			}
-		}
-		else
-			changed = 0;
-	}
-	
-	return changed;
-}
-
-/* End Double Functions */
-
-static snd_kcontrol_new_t snd_omap_controls[] = {
-	OMAP_DOUBLE("PCM Playback Switch", 0, LEFT_CHANNEL_VOLUME_ADDR, RIGHT_CHANNEL_VOLUME_ADDR,
-		     PCM_INDEX, 0x00),
-	OMAP_DOUBLE("PCM Playback Volume", 0, LEFT_CHANNEL_VOLUME_ADDR, RIGHT_CHANNEL_VOLUME_ADDR,
-		     PCM_INDEX, OUTPUT_VOLUME_MASK),
-	OMAP_BOOL("Line Playback Switch", 0, ANALOG_AUDIO_CONTROL_ADDR, AAC_INDEX, BYPASS_ON, 0),
-	OMAP_DOUBLE("Line Capture Switch", 0, LEFT_LINE_VOLUME_ADDR, RIGHT_LINE_VOLUME_ADDR,
-		     LINE_INDEX, 0x00),
-	OMAP_DOUBLE("Line Capture Volume", 0, LEFT_LINE_VOLUME_ADDR, RIGHT_LINE_VOLUME_ADDR,
-		     LINE_INDEX, INPUT_VOLUME_MASK),	
-	OMAP_BOOL("Mic Playback Switch", 0, ANALOG_AUDIO_CONTROL_ADDR, AAC_INDEX, STE_ENABLED, 0),	
-	OMAP_SINGLE("Mic Playback Volume", 0, ANALOG_AUDIO_CONTROL_ADDR, AAC_INDEX, 5, SIDETONE_MASK),
-	OMAP_BOOL("Mic Capture Switch", 0, ANALOG_AUDIO_CONTROL_ADDR, AAC_INDEX, MICM_MUTED, 1),
-	OMAP_BOOL("Mic Booster Playback Switch", 0, ANALOG_AUDIO_CONTROL_ADDR, AAC_INDEX, MICB_20DB, 0),
-	OMAP_MUX("Capture Source", ANALOG_AUDIO_CONTROL_ADDR, AAC_INDEX, INSEL_MIC),
-};
-
-void snd_omap_init_mixer(void)
-{
-	u16 vol_reg;
-
-	/* Line's default values */
-	omap_regs[LINE_INDEX].l_reg = DEFAULT_INPUT_VOLUME & INPUT_VOLUME_MASK;
-	omap_regs[LINE_INDEX].r_reg = DEFAULT_INPUT_VOLUME & INPUT_VOLUME_MASK;
-	omap_regs[LINE_INDEX].sw = 0;
-	SND_OMAP_WRITE(LEFT_LINE_VOLUME_ADDR, DEFAULT_INPUT_VOLUME & INPUT_VOLUME_MASK);
-	SND_OMAP_WRITE(RIGHT_LINE_VOLUME_ADDR, DEFAULT_INPUT_VOLUME & INPUT_VOLUME_MASK);
-	
-	/* Analog Audio Control's default values */
-	omap_regs[AAC_INDEX].l_reg = DEFAULT_ANALOG_AUDIO_CONTROL;
-	
-	/* Headphone's default values */
-	vol_reg = LZC_ON;
-	vol_reg &= ~OUTPUT_VOLUME_MASK;
-	vol_reg |= DEFAULT_OUTPUT_VOLUME;
-	omap_regs[PCM_INDEX].l_reg = DEFAULT_OUTPUT_VOLUME;
-	omap_regs[PCM_INDEX].r_reg = DEFAULT_OUTPUT_VOLUME;
-	omap_regs[PCM_INDEX].sw = 1;
-	SND_OMAP_WRITE(LEFT_CHANNEL_VOLUME_ADDR, vol_reg);
-	SND_OMAP_WRITE(RIGHT_CHANNEL_VOLUME_ADDR, vol_reg);
-}
-
-#ifdef CONFIG_PM
-
-void snd_omap_suspend_mixer(void)
-{
-	/* Saves current values to wake-up correctly */
-	omap_pm_regs[LINE_INDEX].l_reg = omap_regs[LINE_INDEX].l_reg;
-	omap_pm_regs[LINE_INDEX].r_reg = omap_regs[LINE_INDEX].l_reg;
-	omap_pm_regs[LINE_INDEX].sw = omap_regs[LINE_INDEX].sw;
-	
-	omap_pm_regs[AAC_INDEX].l_reg = omap_regs[AAC_INDEX].l_reg;
-	
-	omap_pm_regs[PCM_INDEX].l_reg = omap_regs[PCM_INDEX].l_reg;
-	omap_pm_regs[PCM_INDEX].r_reg = omap_regs[PCM_INDEX].r_reg;
-	omap_pm_regs[PCM_INDEX].sw = omap_regs[PCM_INDEX].sw;
-}
-
-void snd_omap_resume_mixer(void)
-{
-	/* Line's saved values */
-	omap_regs[LINE_INDEX].l_reg = omap_pm_regs[LINE_INDEX].l_reg;
-	omap_regs[LINE_INDEX].r_reg = omap_pm_regs[LINE_INDEX].l_reg;
-	omap_regs[LINE_INDEX].sw = omap_pm_regs[LINE_INDEX].sw;
-	SND_OMAP_WRITE(LEFT_LINE_VOLUME_ADDR, omap_pm_regs[LINE_INDEX].l_reg);
-	SND_OMAP_WRITE(RIGHT_LINE_VOLUME_ADDR, omap_pm_regs[LINE_INDEX].l_reg);
-	
-	/* Analog Audio Control's saved values */
-	omap_regs[AAC_INDEX].l_reg = omap_pm_regs[AAC_INDEX].l_reg;
-	SND_OMAP_WRITE(ANALOG_AUDIO_CONTROL_ADDR, omap_regs[AAC_INDEX].l_reg);
-	
-	/* Headphone's saved values */
-	omap_regs[PCM_INDEX].l_reg = omap_pm_regs[PCM_INDEX].l_reg;
-	omap_regs[PCM_INDEX].r_reg = omap_pm_regs[PCM_INDEX].r_reg;
-	omap_regs[PCM_INDEX].sw = omap_pm_regs[PCM_INDEX].sw;
-	SND_OMAP_WRITE(LEFT_CHANNEL_VOLUME_ADDR, omap_pm_regs[PCM_INDEX].l_reg);
-	SND_OMAP_WRITE(RIGHT_CHANNEL_VOLUME_ADDR, omap_pm_regs[PCM_INDEX].r_reg);
-}
-#endif
-
-int snd_omap_mixer(struct snd_card_omap_codec *chip)
-{
-	snd_card_t *card;
-	unsigned int idx;
-	int err;
-
-	snd_assert(chip != NULL && chip->card != NULL, return -EINVAL);
-
-	card = chip->card;
-
-	strcpy(card->mixername, MIXER_NAME);
-
-	/* Registering alsa mixer controls */
-	for (idx = 0; idx < ARRAY_SIZE(snd_omap_controls); idx++) 
-		if ((err = snd_ctl_add(card, snd_ctl_new1(&snd_omap_controls[idx], chip))) < 0)
-			return err;
-
-	return 0;
-}
-
diff --git a/sound/arm/omap/Makefile b/sound/arm/omap/Makefile
new file mode 100644
index 0000000..74160da
--- /dev/null
+++ b/sound/arm/omap/Makefile
@@ -0,0 +1,6 @@
+#
+## Makefile for ALSA OMAP
+#
+#
+obj-$(CONFIG_SND_OMAP_AIC23) += snd-omap-alsa-aic23.o
+snd-omap-alsa-aic23-objs := omap-alsa.o omap-alsa-dma.o omap-alsa-aic23.o omap-alsa-aic23-mixer.o
diff --git a/sound/arm/omap/omap-alsa-aic23-mixer.c b/sound/arm/omap/omap-alsa-aic23-mixer.c
new file mode 100644
index 0000000..1fb0160
--- /dev/null
+++ b/sound/arm/omap/omap-alsa-aic23-mixer.c
@@ -0,0 +1,485 @@
+/*
+ * sound/arm/omap/omap-alsa-aic23-mixer.c
+ * 
+ * Alsa Driver Mixer for generic codecs for omap boards
+ *
+ * Copyright (C) 2005 Instituto Nokia de Tecnologia - INdT - Manaus Brazil
+ * Written by David Cohen, Daniel Petrini
+ *            {david.cohen, daniel.petrini}@indt.org.br
+ *
+ * Based on es1688_lib.c, 
+ * Copyright (c) by Jaroslav Kysela <perex@suse.cz>
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
+ * 2005-08-02   INdT Kernel Team - Alsa mixer driver for omap osk. Creation of new 
+ *                                 file omap-alsa-mixer.c. Initial version
+ *                                 with aic23 codec for osk5912
+ */
+
+#include <linux/config.h>
+#include <sound/driver.h>
+#include <asm/arch/aic23.h>
+
+#include <asm/arch/omap-alsa.h>
+#include "omap-alsa-aic23.h"
+#include <sound/initval.h>
+#include <sound/control.h>
+
+MODULE_AUTHOR("David Cohen, Daniel Petrini - INdT");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("OMAP Alsa mixer driver for ALSA");
+
+/*
+ * Codec dependent region
+ */
+
+/* Codec AIC23 */
+#if defined(CONFIG_SENSORS_TLV320AIC23) || defined (CONFIG_SENSORS_TLV320AIC23_MODULE)
+
+extern void audio_aic23_write(u8, u16);
+
+#define MIXER_NAME		     "Mixer AIC23"
+#define SND_OMAP_WRITE(reg, val)     audio_aic23_write(reg, val)
+
+#endif
+
+/* Callback Functions */
+#define OMAP_BOOL(xname, xindex, reg, reg_index, mask, invert) \
+{ \
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+	.name = xname, \
+	.index = xindex, \
+	.info = snd_omap_info_bool, \
+	.get = snd_omap_get_bool, \
+	.put = snd_omap_put_bool, \
+	.private_value = reg | (reg_index << 8) | (invert << 10) | (mask << 12) \
+}
+
+#define OMAP_MUX(xname, reg, reg_index, mask) \
+{ \
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+	.name = xname, \
+	.info = snd_omap_info_mux, \
+	.get = snd_omap_get_mux, \
+	.put = snd_omap_put_mux, \
+	.private_value = reg | (reg_index << 8) | (mask << 10) \
+}
+
+#define OMAP_SINGLE(xname, xindex, reg, reg_index, reg_val, mask) \
+{\
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+	.name = xname, \
+	.index = xindex, \
+	.info = snd_omap_info_single, \
+	.get = snd_omap_get_single, \
+	.put = snd_omap_put_single, \
+	.private_value = reg | (reg_val << 8) | (reg_index << 16) | (mask << 18) \
+}
+
+#define OMAP_DOUBLE(xname, xindex, left_reg, right_reg, reg_index, mask) \
+{\
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+	.name = xname, \
+	.index = xindex, \
+	.info = snd_omap_info_double, \
+	.get = snd_omap_get_double, \
+	.put = snd_omap_put_double, \
+	.private_value = left_reg | (right_reg << 8) | (reg_index << 16) | (mask << 18) \
+}
+
+/* Local Registers */
+enum snd_device_index {
+	PCM_INDEX = 0,
+	LINE_INDEX,
+	AAC_INDEX, /* Analog Audio Control: reg = l_reg */
+};
+
+struct {
+	u16 l_reg;
+	u16 r_reg;
+	u8 sw;
+} omap_regs[3];
+
+#ifdef CONFIG_PM
+struct {
+	u16 l_reg;
+	u16 r_reg;
+	u8 sw;
+} omap_pm_regs[3];
+#endif
+
+u16 snd_sidetone[6] = {
+	SIDETONE_18,
+	SIDETONE_12,
+	SIDETONE_9,
+	SIDETONE_6,
+	SIDETONE_0,
+	0
+};
+
+/* Begin Bool Functions */
+
+static int snd_omap_info_bool(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 1;
+	
+	return 0;
+}
+
+static int snd_omap_get_bool(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+{
+	int mic_index = (kcontrol->private_value >> 8) & 0x03;
+	u16 mask = (kcontrol->private_value >> 12) & 0xff;
+	int invert = (kcontrol->private_value >> 10) & 0x03;
+	
+	if (invert)
+		ucontrol->value.integer.value[0] = (omap_regs[mic_index].l_reg & mask) ? 0 : 1;
+	else
+		ucontrol->value.integer.value[0] = (omap_regs[mic_index].l_reg & mask) ? 1 : 0;
+	
+	return 0;
+}
+
+static int snd_omap_put_bool(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+{
+	int mic_index = (kcontrol->private_value >> 8) & 0x03;
+	u16 mask = (kcontrol->private_value >> 12) & 0xff;
+	u16 reg = kcontrol->private_value & 0xff;
+	int invert = (kcontrol->private_value >> 10) & 0x03;
+	
+	int changed = 1;
+
+	if (ucontrol->value.integer.value[0]) /* XOR */
+		if (invert)
+			omap_regs[mic_index].l_reg &= ~mask;
+		else
+			omap_regs[mic_index].l_reg |= mask;
+	else
+		if (invert)
+			omap_regs[mic_index].l_reg |= mask;
+		else
+			omap_regs[mic_index].l_reg &= ~mask;
+		
+	SND_OMAP_WRITE(reg, omap_regs[mic_index].l_reg);
+	
+	return changed;
+}
+
+/* End Bool Functions */
+
+/* Begin Mux Functions */
+
+static int snd_omap_info_mux(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
+{
+	/* Mic = 0
+	 * Line = 1 */
+	static char *texts[2] =	{ "Mic", "Line"	};
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = 2;
+	
+	if (uinfo->value.enumerated.item > 1)
+		uinfo->value.enumerated.item = 1;
+	
+	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
+	
+	return 0;
+}
+
+static int snd_omap_get_mux(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+{
+	u16 mask = (kcontrol->private_value >> 10) & 0xff;
+	int mux_index = (kcontrol->private_value >> 8) & 0x03;
+
+	ucontrol->value.enumerated.item[0] = (omap_regs[mux_index].l_reg & mask) ? 0 /* Mic */ : 1 /* Line */;
+	
+	return 0;
+}
+
+static int snd_omap_put_mux(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+{
+	u16 reg = kcontrol->private_value & 0xff;
+	u16 mask = (kcontrol->private_value >> 10) & 0xff;
+	int mux_index = (kcontrol->private_value >> 8) & 0x03;
+	
+	int changed = 1;
+
+	if (!ucontrol->value.integer.value[0])
+		omap_regs[mux_index].l_reg |= mask; /* AIC23: Mic */
+	else
+		omap_regs[mux_index].l_reg &= ~mask; /* AIC23: Line */
+	
+	SND_OMAP_WRITE(reg, omap_regs[mux_index].l_reg);
+	
+	return changed;
+}
+
+/* End Mux Functions */
+
+/* Begin Single Functions */
+
+static int snd_omap_info_single(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
+{
+	int mask = (kcontrol->private_value >> 18) & 0xff;
+	int reg_val = (kcontrol->private_value >> 8) & 0xff;
+	
+	uinfo->type = mask ? SNDRV_CTL_ELEM_TYPE_INTEGER : SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = reg_val-1;
+	
+	return 0;
+}
+
+static int snd_omap_get_single(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+{
+	u16 reg_val = (kcontrol->private_value >> 8) & 0xff;
+
+	ucontrol->value.integer.value[0] = snd_sidetone[reg_val];
+	
+	return 0;
+}
+
+static int snd_omap_put_single(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+{
+	u16 reg_index = (kcontrol->private_value >> 16) & 0x03;
+	u16 mask = (kcontrol->private_value >> 18) & 0x1ff;
+	u16 reg = kcontrol->private_value & 0xff;
+	u16 reg_val = (kcontrol->private_value >> 8) & 0xff;
+
+	int changed = 0;
+
+	/* Volume */
+	if ((omap_regs[reg_index].l_reg != (ucontrol->value.integer.value[0] & mask)))
+	{
+		changed = 1;
+	
+		omap_regs[reg_index].l_reg &= ~mask;
+		omap_regs[reg_index].l_reg |= snd_sidetone[ucontrol->value.integer.value[0]];
+
+		snd_sidetone[reg_val] = ucontrol->value.integer.value[0];
+		SND_OMAP_WRITE(reg, omap_regs[reg_index].l_reg);
+	}
+	else
+		changed = 0;
+	
+	return changed;
+}
+
+/* End Single Functions */
+
+/* Begin Double Functions */
+
+static int snd_omap_info_double(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
+{
+	/* mask == 0 : Switch
+	 * mask != 0 : Volume */
+	int mask = (kcontrol->private_value >> 18) & 0xff;
+
+	uinfo->type = mask ? SNDRV_CTL_ELEM_TYPE_INTEGER : SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count = mask ? 2 : 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = mask ? mask : 1;
+	
+	return 0;
+}
+
+static int snd_omap_get_double(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+{
+	/* mask == 0 : Switch
+	 * mask != 0 : Volume */
+	int mask = (kcontrol->private_value >> 18) & 0xff;
+	int vol_index = (kcontrol->private_value >> 16) & 0x03;
+	
+	if (!mask)
+		/* Switch */
+		ucontrol->value.integer.value[0] = omap_regs[vol_index].sw;
+	else
+	{
+		/* Volume */
+		ucontrol->value.integer.value[0] = omap_regs[vol_index].l_reg;
+		ucontrol->value.integer.value[1] = omap_regs[vol_index].r_reg;
+	}
+
+	return 0;
+}
+
+static int snd_omap_put_double(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+{
+	/* mask == 0 : Switch
+	 * mask != 0 : Volume */
+	int vol_index = (kcontrol->private_value >> 16) & 0x03;
+	int mask = (kcontrol->private_value >> 18) & 0xff;
+	int left_reg = kcontrol->private_value & 0xff;
+	int right_reg = (kcontrol->private_value >> 8) & 0xff;
+
+	int changed = 0;
+
+	if (!mask)
+	{
+		/* Switch */
+		if (!ucontrol->value.integer.value[0])
+		{
+			SND_OMAP_WRITE(left_reg, 0x00);
+			SND_OMAP_WRITE(right_reg, 0x00);
+		}
+		else
+		{
+			SND_OMAP_WRITE(left_reg, omap_regs[vol_index].l_reg);
+			SND_OMAP_WRITE(right_reg, omap_regs[vol_index].r_reg);
+		}
+		changed = 1;
+		omap_regs[vol_index].sw = ucontrol->value.integer.value[0]; 
+	}
+	else
+	{
+		/* Volume */
+		if ((omap_regs[vol_index].l_reg != (ucontrol->value.integer.value[0] & mask)) ||
+		    (omap_regs[vol_index].r_reg != (ucontrol->value.integer.value[1] & mask)))
+		{
+			changed = 1;
+		
+			omap_regs[vol_index].l_reg &= ~mask;
+			omap_regs[vol_index].r_reg &= ~mask;
+			omap_regs[vol_index].l_reg |= (ucontrol->value.integer.value[0] & mask);
+			omap_regs[vol_index].r_reg |= (ucontrol->value.integer.value[1] & mask);
+			if (omap_regs[vol_index].sw)
+			{
+				/* write to registers only if sw is actived */
+				SND_OMAP_WRITE(left_reg, omap_regs[vol_index].l_reg);
+				SND_OMAP_WRITE(right_reg, omap_regs[vol_index].r_reg);
+			}
+		}
+		else
+			changed = 0;
+	}
+	
+	return changed;
+}
+
+/* End Double Functions */
+
+static snd_kcontrol_new_t snd_omap_controls[] = {
+	OMAP_DOUBLE("PCM Playback Switch", 0, LEFT_CHANNEL_VOLUME_ADDR, RIGHT_CHANNEL_VOLUME_ADDR,
+		     PCM_INDEX, 0x00),
+	OMAP_DOUBLE("PCM Playback Volume", 0, LEFT_CHANNEL_VOLUME_ADDR, RIGHT_CHANNEL_VOLUME_ADDR,
+		     PCM_INDEX, OUTPUT_VOLUME_MASK),
+	OMAP_BOOL("Line Playback Switch", 0, ANALOG_AUDIO_CONTROL_ADDR, AAC_INDEX, BYPASS_ON, 0),
+	OMAP_DOUBLE("Line Capture Switch", 0, LEFT_LINE_VOLUME_ADDR, RIGHT_LINE_VOLUME_ADDR,
+		     LINE_INDEX, 0x00),
+	OMAP_DOUBLE("Line Capture Volume", 0, LEFT_LINE_VOLUME_ADDR, RIGHT_LINE_VOLUME_ADDR,
+		     LINE_INDEX, INPUT_VOLUME_MASK),	
+	OMAP_BOOL("Mic Playback Switch", 0, ANALOG_AUDIO_CONTROL_ADDR, AAC_INDEX, STE_ENABLED, 0),	
+	OMAP_SINGLE("Mic Playback Volume", 0, ANALOG_AUDIO_CONTROL_ADDR, AAC_INDEX, 5, SIDETONE_MASK),
+	OMAP_BOOL("Mic Capture Switch", 0, ANALOG_AUDIO_CONTROL_ADDR, AAC_INDEX, MICM_MUTED, 1),
+	OMAP_BOOL("Mic Booster Playback Switch", 0, ANALOG_AUDIO_CONTROL_ADDR, AAC_INDEX, MICB_20DB, 0),
+	OMAP_MUX("Capture Source", ANALOG_AUDIO_CONTROL_ADDR, AAC_INDEX, INSEL_MIC),
+};
+
+#ifdef CONFIG_PM
+
+void snd_omap_suspend_mixer(void)
+{
+	/* Saves current values to wake-up correctly */
+	omap_pm_regs[LINE_INDEX].l_reg = omap_regs[LINE_INDEX].l_reg;
+	omap_pm_regs[LINE_INDEX].r_reg = omap_regs[LINE_INDEX].l_reg;
+	omap_pm_regs[LINE_INDEX].sw = omap_regs[LINE_INDEX].sw;
+	
+	omap_pm_regs[AAC_INDEX].l_reg = omap_regs[AAC_INDEX].l_reg;
+	
+	omap_pm_regs[PCM_INDEX].l_reg = omap_regs[PCM_INDEX].l_reg;
+	omap_pm_regs[PCM_INDEX].r_reg = omap_regs[PCM_INDEX].r_reg;
+	omap_pm_regs[PCM_INDEX].sw = omap_regs[PCM_INDEX].sw;
+}
+
+void snd_omap_resume_mixer(void)
+{
+	/* Line's saved values */
+	omap_regs[LINE_INDEX].l_reg = omap_pm_regs[LINE_INDEX].l_reg;
+	omap_regs[LINE_INDEX].r_reg = omap_pm_regs[LINE_INDEX].l_reg;
+	omap_regs[LINE_INDEX].sw = omap_pm_regs[LINE_INDEX].sw;
+	SND_OMAP_WRITE(LEFT_LINE_VOLUME_ADDR, omap_pm_regs[LINE_INDEX].l_reg);
+	SND_OMAP_WRITE(RIGHT_LINE_VOLUME_ADDR, omap_pm_regs[LINE_INDEX].l_reg);
+	
+	/* Analog Audio Control's saved values */
+	omap_regs[AAC_INDEX].l_reg = omap_pm_regs[AAC_INDEX].l_reg;
+	SND_OMAP_WRITE(ANALOG_AUDIO_CONTROL_ADDR, omap_regs[AAC_INDEX].l_reg);
+	
+	/* Headphone's saved values */
+	omap_regs[PCM_INDEX].l_reg = omap_pm_regs[PCM_INDEX].l_reg;
+	omap_regs[PCM_INDEX].r_reg = omap_pm_regs[PCM_INDEX].r_reg;
+	omap_regs[PCM_INDEX].sw = omap_pm_regs[PCM_INDEX].sw;
+	SND_OMAP_WRITE(LEFT_CHANNEL_VOLUME_ADDR, omap_pm_regs[PCM_INDEX].l_reg);
+	SND_OMAP_WRITE(RIGHT_CHANNEL_VOLUME_ADDR, omap_pm_regs[PCM_INDEX].r_reg);
+}
+#endif
+
+void snd_omap_init_mixer(void)
+{
+	u16 vol_reg;
+
+	/* Line's default values */
+	omap_regs[LINE_INDEX].l_reg = DEFAULT_INPUT_VOLUME & INPUT_VOLUME_MASK;
+	omap_regs[LINE_INDEX].r_reg = DEFAULT_INPUT_VOLUME & INPUT_VOLUME_MASK;
+	omap_regs[LINE_INDEX].sw = 0;
+	SND_OMAP_WRITE(LEFT_LINE_VOLUME_ADDR, DEFAULT_INPUT_VOLUME & INPUT_VOLUME_MASK);
+	SND_OMAP_WRITE(RIGHT_LINE_VOLUME_ADDR, DEFAULT_INPUT_VOLUME & INPUT_VOLUME_MASK);
+	
+	/* Analog Audio Control's default values */
+	omap_regs[AAC_INDEX].l_reg = DEFAULT_ANALOG_AUDIO_CONTROL;
+	
+	/* Headphone's default values */
+	vol_reg = LZC_ON;
+	vol_reg &= ~OUTPUT_VOLUME_MASK;
+	vol_reg |= DEFAULT_OUTPUT_VOLUME;
+	omap_regs[PCM_INDEX].l_reg = DEFAULT_OUTPUT_VOLUME;
+	omap_regs[PCM_INDEX].r_reg = DEFAULT_OUTPUT_VOLUME;
+	omap_regs[PCM_INDEX].sw = 1;
+	SND_OMAP_WRITE(LEFT_CHANNEL_VOLUME_ADDR, vol_reg);
+	SND_OMAP_WRITE(RIGHT_CHANNEL_VOLUME_ADDR, vol_reg);
+}
+
+int snd_omap_mixer(struct snd_card_omap_codec *chip)
+{
+	snd_card_t *card;
+	unsigned int idx;
+	int err;
+
+	snd_assert(chip != NULL && chip->card != NULL, return -EINVAL);
+
+	card = chip->card;
+
+	strcpy(card->mixername, MIXER_NAME);
+
+	/* Registering alsa mixer controls */
+	for (idx = 0; idx < ARRAY_SIZE(snd_omap_controls); idx++) 
+		if ((err = snd_ctl_add(card, snd_ctl_new1(&snd_omap_controls[idx], chip))) < 0)
+			return err;
+
+	return 0;
+}
diff --git a/sound/arm/omap/omap-alsa-aic23.c b/sound/arm/omap/omap-alsa-aic23.c
new file mode 100644
index 0000000..f490616
--- /dev/null
+++ b/sound/arm/omap/omap-alsa-aic23.c
@@ -0,0 +1,321 @@
+/*
+ * arch/arm/mach-omap1/omap-alsa-aic23.c
+ * 
+ * Alsa codec Driver for AIC23 chip on OSK5912 platform board
+ *
+ * Copyright (C) 2005 Instituto Nokia de Tecnologia - INdT - Manaus Brazil
+ * Written by Daniel Petrini, David Cohen, Anderson Briglia
+ *            {daniel.petrini, david.cohen, anderson.briglia}@indt.org.br
+ *
+ * Copyright (C) 2006 Mika Laitio <lamikr@cc.jyu.fi>
+ * 
+ * Based in former alsa driver for osk and oss driver
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
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
+
+/*
+ * Hardware capabilities
+ */
+ 
+ /*
+ * DAC USB-mode sampling rates (MCLK = 12 MHz)
+ * The rates and rate_reg_into MUST be in the same order
+ */
+static unsigned int rates[] = {
+	4000, 8000, 16000, 22050,
+	24000, 32000, 44100,
+	48000, 88200, 96000,
+};
+
+static snd_pcm_hw_constraint_list_t aic23_hw_constraints_rates = {
+	.count = ARRAY_SIZE(rates),
+	.list = rates,
+	.mask = 0,
+};
+
+static snd_pcm_hardware_t aic23_snd_omap_alsa_playback = {
+	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
+		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID),	
+	.formats = (SNDRV_PCM_FMTBIT_S16_LE),
+	.rates = (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |
+		  SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 |
+		  SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
+		  SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000 |
+		  SNDRV_PCM_RATE_KNOT),
+	.rate_min = 8000,
+	.rate_max = 96000,
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
+static snd_pcm_hardware_t aic23_snd_omap_alsa_capture = {
+	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
+		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID),
+	.formats = (SNDRV_PCM_FMTBIT_S16_LE),
+	.rates = (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |
+		  SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 |
+		  SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
+		  SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000 |
+		  SNDRV_PCM_RATE_KNOT),
+	.rate_min = 8000,
+	.rate_max = 96000,
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
+static int __init snd_omap_alsa_aic23_probe(struct platform_device *pdev)
+{
+	int	ret;
+	struct	omap_alsa_codec_config *codec_cfg;
+	
+	codec_cfg = pdev->dev.platform_data;
+	if (codec_cfg != NULL) {
+		codec_cfg->hw_constraints_rates	= &aic23_hw_constraints_rates;
+		codec_cfg->snd_omap_alsa_playback  = &aic23_snd_omap_alsa_playback;
+		codec_cfg->snd_omap_alsa_capture  = &aic23_snd_omap_alsa_capture;		
+		codec_cfg->codec_configure_dev	= aic23_configure;
+		codec_cfg->codec_set_samplerate	= aic23_set_samplerate;
+		codec_cfg->codec_clock_setup	= aic23_clock_setup;
+		codec_cfg->codec_clock_on	= aic23_clock_on;
+		codec_cfg->codec_clock_off	= aic23_clock_off;
+		codec_cfg->get_default_samplerate = aic23_get_default_samplerate;
+		ret	= snd_omap_alsa_post_probe(pdev, codec_cfg);
+	}
+	else
+		ret = -ENODEV;
+	return ret;
+}
+
+static struct platform_driver omap_alsa_driver = {
+	.probe		= snd_omap_alsa_aic23_probe,
+	.remove 	= snd_omap_alsa_remove,
+	.suspend	= snd_omap_alsa_suspend,
+	.resume		= snd_omap_alsa_resume,
+	.driver	= {
+		.name =	"omap_alsa_mcbsp",
+	},
+};
+
+static int __init omap_alsa_aic23_init(void)
+{
+	int err;
+	
+	ADEBUG();
+	err = platform_driver_register(&omap_alsa_driver);
+
+	return err;
+}
+
+static void __exit omap_alsa_aic23_exit(void)
+{
+	ADEBUG();
+	
+	platform_driver_unregister(&omap_alsa_driver);
+}
+
+module_init(omap_alsa_aic23_init);
+module_exit(omap_alsa_aic23_exit);
diff --git a/sound/arm/omap/omap-alsa-aic23.h b/sound/arm/omap/omap-alsa-aic23.h
new file mode 100644
index 0000000..63907c4
--- /dev/null
+++ b/sound/arm/omap/omap-alsa-aic23.h
@@ -0,0 +1,83 @@
+/*
+ * sound/arm/omap-alsa-aic23.h
+ * 
+ * Alsa Driver for AIC23 codec on OSK5912 platform board
+ *
+ * Copyright (C) 2005 Instituto Nokia de Tecnologia - INdT - Manaus Brazil
+ * Written by Daniel Petrini, David Cohen, Anderson Briglia
+ *            {daniel.petrini, david.cohen, anderson.briglia}@indt.org.br
+ *
+ * Copyright (C) 2006 Mika Laitio <lamikr@cc.jyu.fi>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
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
+#define NUMBER_SAMPLE_RATES_SUPPORTED	10
+
+/*
+ * AUDIO related MACROS
+ */
+#ifndef DEFAULT_BITPERSAMPLE
+#define DEFAULT_BITPERSAMPLE		16
+#endif
+
+#define DEFAULT_SAMPLE_RATE		44100
+#define CODEC_CLOCK			12000000
+#define AUDIO_MCBSP			OMAP_MCBSP1
+
+#define DEFAULT_OUTPUT_VOLUME		0x60
+#define DEFAULT_INPUT_VOLUME		0x00	/* 0 ==> mute line in */
+
+#define OUTPUT_VOLUME_MIN		LHV_MIN
+#define OUTPUT_VOLUME_MAX		LHV_MAX
+#define OUTPUT_VOLUME_RANGE		(OUTPUT_VOLUME_MAX - OUTPUT_VOLUME_MIN)
+#define OUTPUT_VOLUME_MASK		OUTPUT_VOLUME_MAX
+
+#define INPUT_VOLUME_MIN		LIV_MIN
+#define INPUT_VOLUME_MAX		LIV_MAX
+#define INPUT_VOLUME_RANGE		(INPUT_VOLUME_MAX - INPUT_VOLUME_MIN)
+#define INPUT_VOLUME_MASK		INPUT_VOLUME_MAX
+
+#define SIDETONE_MASK			0x1c0
+#define SIDETONE_0			0x100
+#define SIDETONE_6			0x000
+#define SIDETONE_9			0x040
+#define SIDETONE_12			0x080
+#define SIDETONE_18			0x0c0
+
+#define DEFAULT_ANALOG_AUDIO_CONTROL  DAC_SELECTED | STE_ENABLED | BYPASS_ON | INSEL_MIC | MICB_20DB
+
+struct aic23_samplerate_reg_info {
+	u32 sample_rate;
+	u8 control;		/* SR3, SR2, SR1, SR0 and BOSR */
+	u8 divider;		/* if 0 CLKIN = MCLK, if 1 CLKIN = MCLK/2 */
+};
+
+/*
+ * Defines codec specific functions pointers that can be used from the 
+ * common omap-alse base driver for all omap codecs. (tsc2101 and aic23)
+ */
+void define_codec_functions(struct omap_alsa_codec_config *codec_config);
+inline void aic23_configure(void);
+void aic23_set_samplerate(long rate);
+void aic23_clock_setup(void);
+int aic23_clock_on(void);
+int aic23_clock_off(void);
+int aic23_get_default_samplerate(void);
+
+#endif
diff --git a/sound/arm/omap/omap-alsa-dma.c b/sound/arm/omap/omap-alsa-dma.c
new file mode 100644
index 0000000..7537d8e
--- /dev/null
+++ b/sound/arm/omap/omap-alsa-dma.c
@@ -0,0 +1,443 @@
+/*
+ * sound/arm/omap/omap-alsa-dma.c
+ *
+ * Common audio DMA handling for the OMAP processors
+ *
+ * Copyright (C) 2006 Mika Laitio <lamikr@cc.jyu.fi>
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
+ *	in dma handling and port to alsa structures.
+ *
+ * 2005-12-18   Dirk Behme      - Added L/R Channel Interchange fix as proposed by Ajaya Babu
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
+#include "omap-alsa-dma.h"
+
+#include <asm/arch/mcbsp.h>
+
+#include <asm/arch/omap-alsa.h>
+
+#undef DEBUG
+
+#define ERR(ARGS...) printk(KERN_ERR "{%s}-ERROR: ", __FUNCTION__);printk(ARGS);
+
+/* Channel Queue Handling macros
+ * tail always points to the current free entry
+ * Head always points to the current entry being used
+ * end is either head or tail
+ */
+
+#define AUDIO_QUEUE_INIT(s) s->dma_q_head = s->dma_q_tail = s->dma_q_count = 0;
+#define AUDIO_QUEUE_FULL(s) (nr_linked_channels == s->dma_q_count)
+#define AUDIO_QUEUE_LAST(s) (1 == s->dma_q_count)
+#define AUDIO_QUEUE_EMPTY(s) (0 == s->dma_q_count)
+#define __AUDIO_INCREMENT_QUEUE(end) ((end)=((end)+1) % nr_linked_channels)
+#define AUDIO_INCREMENT_HEAD(s) __AUDIO_INCREMENT_QUEUE(s->dma_q_head); s->dma_q_count--;
+#define AUDIO_INCREMENT_TAIL(s) __AUDIO_INCREMENT_QUEUE(s->dma_q_tail); s->dma_q_count++;
+
+/* DMA buffer fragmentation sizes */
+#define MAX_DMA_SIZE		 0x1000000 /* todo: sync with alsa */
+//#define CUT_DMA_SIZE		 0x1000
+/* TODO: To be moved to more appropriate location */
+#define DCSR_ERROR           0x3
+#define DCSR_END_BLOCK       (1 << 5)
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
+
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
+static void omap_sound_dma_link_lch(void *data)
+{
+
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
+int omap_request_alsa_sound_dma(int device_id, const char *device_name,
+			   void *data, int **channels)
+{
+	int i, err = 0;
+	int *chan = NULL;
+	FN_IN;
+	if (unlikely((NULL == channels) || (NULL == device_name))) {
+		BUG();
+		return -EPERM;
+	}
+	/* Try allocate memory for the num channels */
+	*channels =
+	    (int *) kmalloc(sizeof(int) * nr_linked_channels, GFP_KERNEL);
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
+
+		/* Handle Failure condition here */
+		if (err < 0) {
+			int j;
+			for (j = 0; j < i; j++) {
+				omap_free_dma(chan[j]);
+			}
+			spin_unlock(&dma_list_lock);
+			kfree(chan);
+			*channels = NULL;
+			ERR("Error in requesting channel %d=0x%x\n", i,
+			    err);
+			FN_OUT(err);
+			return err;
+		}
+	}
+
+	/* Chain the channels together */
+	if (!cpu_is_omap1510())
+		omap_sound_dma_link_lch(data);
+
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
+static void omap_sound_dma_unlink_lch(void *data)
+{
+	struct audio_stream *s = (struct audio_stream *)data;
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
+		int nex_chan =
+		    ((nr_linked_channels - 1 ==
+		      i) ? chan[0] : chan[i + 1]);
+		omap_dma_unlink_lch(cur_chan, nex_chan);
+	}
+	s->linked = 0;
+	FN_OUT(0);
+}
+
+int omap_free_alsa_sound_dma(void *data, int **channels)
+{
+	int i;
+	int *chan = NULL;
+	
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
+void omap_stop_alsa_sound_dma(struct audio_stream *s)
+{
+	int *chan = s->lch;
+	int i;
+	
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
+/***************************************************************************************
+ *
+ * Clear any pending transfers
+ *
+ **************************************************************************************/
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
+static int audio_set_dma_params_play(int channel, dma_addr_t dma_ptr,
+				     u_int dma_size)
+{
+	int dt = 0x1;		/* data type 16 */
+	int cen = 32;		/* Stereo */
+	int cfn = dma_size / (2 * cen);
+	
+	FN_IN;
+	omap_set_dma_dest_params(channel, 0x05, 0x00,
+				 (OMAP1510_MCBSP1_BASE + 0x06),
+				 0, 0);
+	omap_set_dma_src_params(channel, 0x00, 0x01, dma_ptr,
+				0, 0);
+	omap_set_dma_transfer_params(channel, dt, cen, cfn, 0x00, 0, 0);
+	FN_OUT(0);
+	return 0;
+}
+
+static int audio_set_dma_params_capture(int channel, dma_addr_t dma_ptr,
+					u_int dma_size)
+{
+	int dt = 0x1;		/* data type 16 */
+	int cen = 32;		/* stereo */
+	int cfn = dma_size / (2 * cen);
+	
+	FN_IN;
+	omap_set_dma_src_params(channel, 0x05, 0x00,
+				(OMAP1510_MCBSP1_BASE + 0x02),
+				0, 0);
+	omap_set_dma_dest_params(channel, 0x00, 0x01, dma_ptr, 0, 0);
+	omap_set_dma_transfer_params(channel, dt, cen, cfn, 0x00, 0, 0);
+	FN_OUT(0);
+	return 0;
+}
+
+static int audio_start_dma_chain(struct audio_stream *s)
+{
+	int channel = s->lch[s->dma_q_head];
+	FN_IN;
+	if (!s->started) {
+	 	s->hw_stop();	   /* stops McBSP Interface */
+		omap_start_dma(channel);
+		s->started = 1;
+		s->hw_start();	   /* start McBSP interface */
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
+
+	if (unlikely(dma_size > MAX_DMA_SIZE)) {
+		ERR("DmaSoundDma: Start: overflowed %d-%d\n", dma_size,
+		    MAX_DMA_SIZE);
+		return -EOVERFLOW;
+	}
+	//if (AUDIO_QUEUE_FULL(s)) {
+	//      ret = -2;
+	//      goto sound_out;
+	//}
+
+	if (s->stream_id == SNDRV_PCM_STREAM_PLAYBACK) {
+		/*playback */
+		ret =
+		    audio_set_dma_params_play(s->lch[s->dma_q_tail],
+					      dma_ptr, dma_size);
+	} else {
+		ret =
+		    audio_set_dma_params_capture(s->lch[s->dma_q_tail],
+						 dma_ptr, dma_size);
+	}
+	if (ret != 0) {
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
+
+}
+
+/* 
+ * ISRs have to be short and smart.. 
+ * Here we call alsa handling, after some error checking
+ */
+static void sound_dma_irq_handler(int sound_curr_lch, u16 ch_status,
+				  void *data)
+{
+	int dma_status = ch_status;
+	struct audio_stream *s = (struct audio_stream *) data;
+	FN_IN;
+
+	/*
+	 * some register checkings
+	 */ 
+	DPRINTK("lch=%d,status=0x%x, dma_status=%d, data=%p\n",
+		sound_curr_lch, ch_status, dma_status, data);
+
+	if (dma_status & (DCSR_ERROR)) {
+		OMAP_DMA_CCR_REG(sound_curr_lch) &= ~DCCR_EN;
+		ERR("DCSR_ERROR!\n");
+		FN_OUT(-1);
+		return;
+	}
+
+	if (ch_status & DCSR_END_BLOCK) 
+		callback_omap_alsa_sound_dma(s);
+	FN_OUT(0);
+	return;
+}
+
+MODULE_AUTHOR("Texas Instruments");
+MODULE_DESCRIPTION("Common DMA handling for Audio driver on OMAP processors");
+MODULE_LICENSE("GPL");
+
+EXPORT_SYMBOL(omap_start_alsa_sound_dma);
+EXPORT_SYMBOL(omap_clear_alsa_sound_dma);
+EXPORT_SYMBOL(omap_request_alsa_sound_dma);
+EXPORT_SYMBOL(omap_free_alsa_sound_dma);
+EXPORT_SYMBOL(omap_stop_alsa_sound_dma);
diff --git a/sound/arm/omap/omap-alsa-dma.h b/sound/arm/omap/omap-alsa-dma.h
new file mode 100644
index 0000000..1cecc8a
--- /dev/null
+++ b/sound/arm/omap/omap-alsa-dma.h
@@ -0,0 +1,53 @@
+/*  
+ * linux/sound/arm/omap/omap-alsa-dma.h
+ *
+ * Common audio DMA handling for the OMAP processors
+ *
+ * Copyright (C) 2006 Mika Laitio <lamikr@cc.jyu.fi>
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
+ */
+
+#ifndef __OMAP_AUDIO_ALSA_DMA_H
+#define __OMAP_AUDIO_ALSA_DMA_H
+
+/************************** INCLUDES *************************************/
+
+#include <asm/arch/omap-alsa.h>
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
+int omap_start_alsa_sound_dma(struct audio_stream *s, dma_addr_t dma_ptr,  u_int dma_size);
+
+void omap_stop_alsa_sound_dma(struct audio_stream *s);
+
+#endif
diff --git a/sound/arm/omap/omap-alsa.c b/sound/arm/omap/omap-alsa.c
new file mode 100644
index 0000000..328003b
--- /dev/null
+++ b/sound/arm/omap/omap-alsa.c
@@ -0,0 +1,579 @@
+/*
+ * sound/arm/omap-alsa.c
+ * 
+ * Alsa Driver for OMAP
+ *
+ * Copyright (C) 2005 Instituto Nokia de Tecnologia - INdT - Manaus Brazil
+ * Written by Daniel Petrini, David Cohen, Anderson Briglia
+ *            {daniel.petrini, david.cohen, anderson.briglia}@indt.org.br
+ *
+ * Copyright (C) 2006 Mika Laitio <lamikr@cc.jyu.fi>
+ *
+ * Based on sa11xx-uda1341.c, 
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
+ * 2005-07-29   INdT Kernel Team - Alsa driver for omap osk. Creation of new 
+ *                                 file omap-aic23.c
+ * 
+ * 2005-12-18   Dirk Behme       - Added L/R Channel Interchange fix as proposed 
+ *                                 by Ajaya Babu
+ *
+ */
+
+#include <linux/platform_device.h>
+#ifdef CONFIG_PM
+#include <linux/pm.h>
+#endif
+#include <sound/driver.h>
+#include <sound/core.h>
+
+#include <asm/arch/omap-alsa.h>
+#include "omap-alsa-dma.h"
+
+MODULE_AUTHOR("Mika Laitio, Daniel Petrini, David Cohen, Anderson Briglia - INdT");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("OMAP driver for ALSA");
+MODULE_ALIAS("omap_alsa_mcbsp.1");
+
+static char *id	= NULL;	
+static struct snd_card_omap_codec 	*alsa_codec		= NULL;
+static struct omap_alsa_codec_config	*alsa_codec_config	= NULL;
+
+/*
+ * HW interface start and stop helper functions
+ */
+static int audio_ifc_start(void)
+{
+	omap_mcbsp_start(AUDIO_MCBSP);
+	return 0;
+}
+
+static int audio_ifc_stop(void)
+{
+	omap_mcbsp_stop(AUDIO_MCBSP);
+	return 0;
+}
+
+static void omap_alsa_audio_init(struct snd_card_omap_codec *omap_alsa)
+{
+	/* Setup DMA stuff */
+	omap_alsa->s[SNDRV_PCM_STREAM_PLAYBACK].id = "Alsa omap out";
+	omap_alsa->s[SNDRV_PCM_STREAM_PLAYBACK].stream_id =
+	    SNDRV_PCM_STREAM_PLAYBACK;
+	omap_alsa->s[SNDRV_PCM_STREAM_PLAYBACK].dma_dev =
+	    OMAP_DMA_MCBSP1_TX;
+	omap_alsa->s[SNDRV_PCM_STREAM_PLAYBACK].hw_start =
+	    audio_ifc_start;
+	omap_alsa->s[SNDRV_PCM_STREAM_PLAYBACK].hw_stop =
+	    audio_ifc_stop;
+
+	omap_alsa->s[SNDRV_PCM_STREAM_CAPTURE].id = "Alsa omap in";
+	omap_alsa->s[SNDRV_PCM_STREAM_CAPTURE].stream_id =
+	    SNDRV_PCM_STREAM_CAPTURE;
+	omap_alsa->s[SNDRV_PCM_STREAM_CAPTURE].dma_dev =
+	    OMAP_DMA_MCBSP1_RX;
+	omap_alsa->s[SNDRV_PCM_STREAM_CAPTURE].hw_start =
+	    audio_ifc_start;
+	omap_alsa->s[SNDRV_PCM_STREAM_CAPTURE].hw_stop =
+	    audio_ifc_stop;
+}
+
+/* 
+ * DMA functions 
+ * Depends on omap-alsa-dma.c functions and (omap) dma.c
+ * 
+ */
+static int audio_dma_request(struct audio_stream *s,
+			     void (*callback) (void *))
+{
+	int err;
+	ADEBUG();
+
+	err = omap_request_alsa_sound_dma(s->dma_dev, s->id, s, &s->lch);
+	if (err < 0)
+		printk(KERN_ERR "Unable to grab audio dma 0x%x\n", s->dma_dev);
+	return err;
+}
+
+static int audio_dma_free(struct audio_stream *s)
+{
+	int err = 0;
+	ADEBUG();
+
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
+	ADEBUG();
+
+	/* this must be called w/ interrupts locked as requested in dma.c */
+	spin_lock_irqsave(&s->dma_lock, flags);
+
+	/* For the current period let's see where we are */
+	count = omap_get_dma_src_addr_counter(s->lch[s->dma_q_head]);
+
+	spin_unlock_irqrestore(&s->dma_lock, flags);
+
+	/* Now, the position related to the end of that period */
+	offset = bytes_to_frames(runtime, s->offset) - bytes_to_frames(runtime, count);
+
+	if (offset >= runtime->buffer_size)
+		offset = 0;
+
+	return offset;
+}
+
+/*
+ * this stops the dma and clears the dma ptrs
+ */
+static void audio_stop_dma(struct audio_stream *s)
+{
+	unsigned long flags;
+	ADEBUG();
+
+	spin_lock_irqsave(&s->dma_lock, flags);
+	s->active = 0;
+	s->period = 0;
+	s->periods = 0;
+
+	/* this stops the dma channel and clears the buffer ptrs */
+	omap_stop_alsa_sound_dma(s);
+
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
+	unsigned int dma_size;
+	unsigned int offset;
+	int ret;
+#ifdef CONFIG_MACH_OMAP_H6300
+	unsigned long flags;
+#endif
+	
+	ADEBUG();
+	runtime = substream->runtime;
+	if (s->active) {
+		dma_size = frames_to_bytes(runtime, runtime->period_size);
+		offset = dma_size * s->period;
+		snd_assert(dma_size <= DMA_BUF_SIZE,);
+#ifdef CONFIG_MACH_OMAP_H6300
+		spin_lock_irqsave(&s->dma_lock, flags);
+		omap_stop_alsa_sound_dma(s);
+		spin_unlock_irqrestore(&s->dma_lock, flags);
+#endif
+		ret = omap_start_alsa_sound_dma(s,
+					 (dma_addr_t) runtime->dma_area +
+					 offset, dma_size);
+		if (ret) {
+			printk(KERN_ERR
+			       "audio_process_dma: cannot queue DMA buffer (%i)\n",
+			       ret);
+			return;
+		}
+
+		s->period++;
+		s->period %= runtime->periods;
+		s->periods++;
+		s->offset = offset;
+	}
+}
+
+/* 
+ *  This is called when dma IRQ occurs at the end of each transmited block
+ */
+void callback_omap_alsa_sound_dma(void *data)
+{
+	struct audio_stream *s = data;
+	
+	ADEBUG();
+	/* 
+	 * If we are getting a callback for an active stream then we inform
+	 * the PCM middle layer we've finished a period
+	 */
+	if (s->active)
+		snd_pcm_period_elapsed(s->stream);
+
+	spin_lock(&s->dma_lock);
+	if (s->periods > 0) 
+		s->periods--;
+	
+	audio_process_dma(s);
+	spin_unlock(&s->dma_lock);
+}
+
+/* 
+ * Alsa section
+ * PCM settings and callbacks
+ */
+static int snd_omap_alsa_trigger(snd_pcm_substream_t * substream, int cmd)
+{
+	struct snd_card_omap_codec *chip =
+	    snd_pcm_substream_chip(substream);
+	int stream_id = substream->pstr->stream;
+	struct audio_stream *s = &chip->s[stream_id];
+	int err = 0;
+	
+	ADEBUG();
+	/* note local interrupts are already disabled in the midlevel code */
+	spin_lock(&s->dma_lock);
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		/* requested stream startup */
+		s->active = 1;
+		audio_process_dma(s);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		/* requested stream shutdown */
+		audio_stop_dma(s);
+		break;
+	default:
+		err = -EINVAL;
+		break;
+	}
+	spin_unlock(&s->dma_lock);
+	
+	return err;
+}
+
+static int snd_omap_alsa_prepare(snd_pcm_substream_t * substream)
+{
+	struct snd_card_omap_codec *chip = snd_pcm_substream_chip(substream);
+	snd_pcm_runtime_t *runtime = substream->runtime;
+	struct audio_stream *s = &chip->s[substream->pstr->stream];
+	
+	ADEBUG();
+	/* set requested samplerate */
+	alsa_codec_config->codec_set_samplerate(runtime->rate);
+	chip->samplerate = runtime->rate;
+
+	s->period = 0;
+	s->periods = 0;
+
+	return 0;
+}
+
+static snd_pcm_uframes_t snd_omap_alsa_pointer(snd_pcm_substream_t *substream)
+{
+	struct snd_card_omap_codec *chip = snd_pcm_substream_chip(substream);
+
+	ADEBUG();	
+	return audio_get_dma_pos(&chip->s[substream->pstr->stream]);
+}
+
+static int snd_card_omap_alsa_open(snd_pcm_substream_t * substream)
+{
+	struct snd_card_omap_codec *chip =
+	    snd_pcm_substream_chip(substream);
+	snd_pcm_runtime_t *runtime = substream->runtime;
+	int stream_id = substream->pstr->stream;
+	int err;
+	
+	ADEBUG();
+	chip->s[stream_id].stream = substream;
+	alsa_codec_config->codec_clock_on();
+	if (stream_id == SNDRV_PCM_STREAM_PLAYBACK) 
+		runtime->hw = *(alsa_codec_config->snd_omap_alsa_playback);
+	else 
+		runtime->hw = *(alsa_codec_config->snd_omap_alsa_capture);
+	
+	if ((err = snd_pcm_hw_constraint_integer(runtime,
+					   SNDRV_PCM_HW_PARAM_PERIODS)) < 0) 
+		return err;
+	
+	if ((err = snd_pcm_hw_constraint_list(runtime,
+					0,
+					SNDRV_PCM_HW_PARAM_RATE,
+					alsa_codec_config->hw_constraints_rates)) < 0) 
+		return err;
+	
+	return 0;
+}
+
+static int snd_card_omap_alsa_close(snd_pcm_substream_t * substream)
+{
+	struct snd_card_omap_codec *chip = snd_pcm_substream_chip(substream);
+	
+	ADEBUG();
+	alsa_codec_config->codec_clock_off();
+	chip->s[substream->pstr->stream].stream = NULL;
+	
+	return 0;
+}
+
+/* HW params & free */
+static int snd_omap_alsa_hw_params(snd_pcm_substream_t * substream,
+				    snd_pcm_hw_params_t * hw_params)
+{
+	return snd_pcm_lib_malloc_pages(substream,
+					params_buffer_bytes(hw_params));
+}
+
+static int snd_omap_alsa_hw_free(snd_pcm_substream_t * substream)
+{
+	return snd_pcm_lib_free_pages(substream);
+}
+
+/* pcm operations */
+static snd_pcm_ops_t snd_card_omap_alsa_playback_ops = {
+	.open =		snd_card_omap_alsa_open,
+	.close =	snd_card_omap_alsa_close,
+	.ioctl =	snd_pcm_lib_ioctl,
+	.hw_params =	snd_omap_alsa_hw_params,
+	.hw_free =	snd_omap_alsa_hw_free,
+	.prepare =	snd_omap_alsa_prepare,
+	.trigger =	snd_omap_alsa_trigger,
+	.pointer =	snd_omap_alsa_pointer,
+};
+
+static snd_pcm_ops_t snd_card_omap_alsa_capture_ops = {
+	.open =		snd_card_omap_alsa_open,
+	.close =	snd_card_omap_alsa_close,
+	.ioctl =	snd_pcm_lib_ioctl,
+	.hw_params =	snd_omap_alsa_hw_params,
+	.hw_free =	snd_omap_alsa_hw_free,
+	.prepare =	snd_omap_alsa_prepare,
+	.trigger =	snd_omap_alsa_trigger,
+	.pointer =	snd_omap_alsa_pointer,
+};
+
+/*
+ *  Alsa init and exit section
+ *  
+ *  Inits pcm alsa structures, allocate the alsa buffer, suspend, resume
+ */
+static int __init snd_card_omap_alsa_pcm(struct snd_card_omap_codec *omap_alsa, 
+					int device)
+{
+	snd_pcm_t *pcm;
+	int err;
+	
+	ADEBUG();
+	if ((err = snd_pcm_new(omap_alsa->card, "OMAP PCM", device, 1, 1, &pcm)) < 0)
+		return err;
+
+	/* sets up initial buffer with continuous allocation */
+	snd_pcm_lib_preallocate_pages_for_all(pcm,
+					      SNDRV_DMA_TYPE_CONTINUOUS,
+					      snd_dma_continuous_data
+					      (GFP_KERNEL),
+					      128 * 1024, 128 * 1024);
+
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK,
+			&snd_card_omap_alsa_playback_ops);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE,
+			&snd_card_omap_alsa_capture_ops);
+	pcm->private_data = omap_alsa;
+	pcm->info_flags = 0;
+	strcpy(pcm->name, "omap alsa pcm");
+
+	omap_alsa_audio_init(omap_alsa);
+
+	/* setup DMA controller */
+	audio_dma_request(&omap_alsa->s[SNDRV_PCM_STREAM_PLAYBACK],
+			  callback_omap_alsa_sound_dma);
+	audio_dma_request(&omap_alsa->s[SNDRV_PCM_STREAM_CAPTURE],
+			  callback_omap_alsa_sound_dma);
+
+	omap_alsa->pcm = pcm;
+
+	return 0;
+}
+
+
+#ifdef CONFIG_PM
+/*
+ * Driver suspend/resume - calls alsa functions. Some hints from aaci.c
+ */
+int snd_omap_alsa_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct snd_card_omap_codec *chip;
+	snd_card_t *card = platform_get_drvdata(pdev);
+	
+	if (card->power_state != SNDRV_CTL_POWER_D3hot) {
+		chip = card->private_data;
+		if (chip->card->power_state != SNDRV_CTL_POWER_D3hot) {
+			snd_power_change_state(chip->card, SNDRV_CTL_POWER_D3hot);
+			snd_pcm_suspend_all(chip->pcm);
+			/* Mutes and turn clock off */
+			alsa_codec_config->codec_clock_off();
+			snd_omap_suspend_mixer();
+		}
+	}
+	return 0;
+}
+
+int snd_omap_alsa_resume(struct platform_device *pdev)
+{
+	struct snd_card_omap_codec *chip;
+	snd_card_t *card = platform_get_drvdata(pdev);
+
+	if (card->power_state != SNDRV_CTL_POWER_D0) {				
+		chip = card->private_data;
+		if (chip->card->power_state != SNDRV_CTL_POWER_D0) {
+			snd_power_change_state(chip->card, SNDRV_CTL_POWER_D0);
+			alsa_codec_config->codec_clock_on();
+			snd_omap_resume_mixer();
+		}
+	}
+	return 0;
+}
+
+#endif	/* CONFIG_PM */
+
+void snd_omap_alsa_free(snd_card_t * card)
+{
+	struct snd_card_omap_codec *chip = card->private_data;
+	ADEBUG();
+	
+	/*
+	 * Turn off codec after it is done.
+	 * Can't do it immediately, since it may still have
+	 * buffered data.
+	 */
+	schedule_timeout_interruptible(2);
+
+	omap_mcbsp_stop(AUDIO_MCBSP);
+	omap_mcbsp_free(AUDIO_MCBSP);
+
+	audio_dma_free(&chip->s[SNDRV_PCM_STREAM_PLAYBACK]);
+	audio_dma_free(&chip->s[SNDRV_PCM_STREAM_CAPTURE]);
+}
+
+/* module init & exit */
+
+/* 
+ * Inits alsa soudcard structure.
+ * Called by the probe method in codec after function pointers has been set.
+ */
+int snd_omap_alsa_post_probe(struct platform_device *pdev, struct omap_alsa_codec_config *config)
+{
+	int err = 0;
+	int def_rate;
+	snd_card_t *card;
+	
+	ADEBUG();
+	alsa_codec_config	= config;
+
+	alsa_codec_config->codec_clock_setup();
+	alsa_codec_config->codec_clock_on(); 
+
+	omap_mcbsp_request(AUDIO_MCBSP);
+	omap_mcbsp_stop(AUDIO_MCBSP);
+	omap_mcbsp_config(AUDIO_MCBSP, alsa_codec_config->mcbsp_regs_alsa);
+	omap_mcbsp_start(AUDIO_MCBSP);
+	
+	if (alsa_codec_config && alsa_codec_config->codec_configure_dev)
+		alsa_codec_config->codec_configure_dev();
+
+	alsa_codec_config->codec_clock_off();
+
+	/* register the soundcard */
+	card = snd_card_new(-1, id, THIS_MODULE, sizeof(alsa_codec));
+	if (card == NULL)
+		goto nodev1;
+
+	alsa_codec = kcalloc(1, sizeof(*alsa_codec), GFP_KERNEL);
+	if (alsa_codec == NULL)
+		goto nodev2;
+
+	card->private_data = (void *)alsa_codec;
+	card->private_free = snd_omap_alsa_free;
+
+	alsa_codec->card	= card;
+	def_rate		= alsa_codec_config->get_default_samplerate(); 
+	alsa_codec->samplerate	= def_rate;
+
+	spin_lock_init(&alsa_codec->s[0].dma_lock);
+	spin_lock_init(&alsa_codec->s[1].dma_lock);
+
+	/* mixer */
+	if ((err = snd_omap_mixer(alsa_codec)) < 0)
+		goto nodev3;
+
+	/* PCM */
+	if ((err = snd_card_omap_alsa_pcm(alsa_codec, 0)) < 0)
+		goto nodev3;
+
+	strcpy(card->driver, "OMAP_ALSA");
+	strcpy(card->shortname, alsa_codec_config->name);
+	sprintf(card->longname, alsa_codec_config->name);
+
+	snd_omap_init_mixer();
+	snd_card_set_dev(card, &pdev->dev);
+	
+	if ((err = snd_card_register(card)) == 0) {
+		printk(KERN_INFO "audio support initialized\n");
+		platform_set_drvdata(pdev, card);
+		return 0;
+	}
+	
+nodev3:
+	kfree(alsa_codec);	
+nodev2:	
+	snd_card_free(card);
+nodev1:
+	omap_mcbsp_stop(AUDIO_MCBSP);
+	omap_mcbsp_free(AUDIO_MCBSP);
+
+	return err;
+}
+
+int snd_omap_alsa_remove(struct platform_device *pdev)
+{
+	snd_card_t *card = platform_get_drvdata(pdev);
+	struct snd_card_omap_codec *chip = card->private_data;
+	
+	snd_card_free(card);
+
+	alsa_codec = NULL;
+	card->private_data = NULL;
+	kfree(chip);
+	
+	platform_set_drvdata(pdev, NULL);
+	
+	return 0;
+}
-- 
1.2.2


--------------020705090209010105070509
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------020705090209010105070509--

From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: [PATCH] sound support on omap24xx
Date: Wed, 11 Jan 2006 14:08:47 +0900
Message-ID: <0ISW00BBUWYN0Z@mmp1.samsung.com>
Reply-To: kyungmin.park@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
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

Hi

Sorry for same mail since wrong title.

This patch enables OMAP sound on omap24xx
To test omap sound, you first have to patch the first spi patch from komal
shah not the latest spi patch.

It also adds 'OSS L/R Channel Interchange fix' on tsc2101

Any comments are welcome.

Regards,
Kyungmin Park

P.S., There's some problem when running qtopia on H4.
At the end of mediaplay. we can't stop audio, exactly audio_sync why?
But madplay is working well :)

--

diff --git a/sound/oss/Kconfig b/sound/oss/Kconfig
--- a/sound/oss/Kconfig
+++ b/sound/oss/Kconfig
@@ -13,14 +13,18 @@ config SOUND_OMAP
 
 config SOUND_OMAP_TSC2101
 	tristate "TSC2101 Stereo Codec"
-	depends on SOUND_OMAP && ( MACH_OMAP_H2 || MACH_OMAP_H3 )
-	select OMAP_TSC2101
-	select OMAP_UWIRE if ARCH_OMAP
+	depends on SOUND_OMAP && ( MACH_OMAP_H2 || MACH_OMAP_H3 ||
MACH_OMAP_H4)
+	select OMAP_TSC2101 if ( MACH_OMAP_H2 || MACH_OMAP_H3 )
+	select OMAP_UWIRE if ARCH_OMAP1
 	---help---
 	  Tsc2101 Audio Codec Driver for OMAP will be enabled.
 	  Will also Enable the following:
+	  case OMAP1:
 	  1. uWire Driver based on Platform
 	  2. TSC2101 Glue driver
+	  case OMAP2:
+	  1. McSPI Driver based on Platform
+	  2. TSC2101 Glue driver
 
 config SOUND_OMAP_AIC23
 	tristate "AIC23 Stereo Codec"
diff --git a/sound/oss/omap-audio-dma-intfc.c
b/sound/oss/omap-audio-dma-intfc.c
--- a/sound/oss/omap-audio-dma-intfc.c
+++ b/sound/oss/omap-audio-dma-intfc.c
@@ -701,12 +701,25 @@ static int audio_set_dma_params_play(int
 	int dt = 0x1;		/* data type 16 */
 	int cen = 32;		/* Stereo */
 	int cfn = dma_size / (2 * cen);
+	unsigned long dest_start;
+	int dest_port = 0;
+	int sync_dev = 0;
+
 	FN_IN;
-	omap_set_dma_dest_params(channel, 0x05, 0x00,
-				 (OMAP1610_MCBSP1_BASE + 0x806),
-				 0, 0);
-	omap_set_dma_src_params(channel, 0x00, 0x01, dma_ptr, 0, 0);
-	omap_set_dma_transfer_params(channel, dt, cen, cfn, 0x00, 0, 0);
+
+	if (cpu_is_omap16xx()) {
+		dest_start = (OMAP1610_MCBSP1_BASE + 0x806);
+		dest_port = OMAP_DMA_PORT_MPUI;
+	}
+	if (cpu_is_omap24xx()) {
+		dest_start = AUDIO_MCBSP_DATAWRITE;
+		sync_dev = AUDIO_DMA_TX;
+	}
+
+	omap_set_dma_dest_params(channel, dest_port,
OMAP_DMA_AMODE_CONSTANT, dest_start, 0, 0);
+	omap_set_dma_src_params(channel, 0, OMAP_DMA_AMODE_POST_INC,
dma_ptr, 0, 0);
+	omap_set_dma_transfer_params(channel, dt, cen, cfn,
OMAP_DMA_SYNC_ELEMENT, sync_dev, 0);
+
 	FN_OUT(0);
 	return 0;
 }
@@ -717,12 +730,27 @@ static int audio_set_dma_params_capture(
 	int dt = 0x1;		/* data type 16 */
 	int cen = 16;		/* mono */
 	int cfn = dma_size / (2 * cen);
+	unsigned long src_start;
+	int src_port = 0;
+	int sync_dev = 0;
+	int src_sync = 0;
+
 	FN_IN;
-	omap_set_dma_src_params(channel, 0x05, 0x00,
-				(OMAP1610_MCBSP1_BASE + 0x802),
-				0, 0);
-	omap_set_dma_dest_params(channel, 0x00, 0x01, dma_ptr, 0, 0);
-	omap_set_dma_transfer_params(channel, dt, cen, cfn, 0x00, 0, 0);
+
+	if (cpu_is_omap16xx()) {
+		src_start = (OMAP1610_MCBSP1_BASE + 0x802);
+		src_port = OMAP_DMA_PORT_MPUI;
+	}
+	if (cpu_is_omap24xx()) {
+		src_start = AUDIO_MCBSP_DATAREAD;
+		sync_dev = AUDIO_DMA_RX;
+		src_sync = 1;
+	}
+
+	omap_set_dma_src_params(channel, src_port, OMAP_DMA_AMODE_CONSTANT,
src_start, 0, 0);
+	omap_set_dma_dest_params(channel, 0, OMAP_DMA_AMODE_POST_INC,
dma_ptr, 0, 0);
+	omap_set_dma_transfer_params(channel, dt, cen, cfn,
OMAP_DMA_SYNC_ELEMENT, sync_dev, src_sync);
+
 	FN_OUT(0);
 	return 0;
 }
@@ -732,10 +760,10 @@ static int audio_start_dma_chain(audio_s
 	int channel = s->lch[s->dma_q_head];
 	FN_IN;
 	if (!s->started) {
-	 s->hw_stop();	    /* stops McBSP Interface */
+		s->hw_stop();		/* stops McBSP Interface */
 		omap_start_dma(channel);
 		s->started = 1;
-		s->hw_start();	   /* start McBSP interface */
+		s->hw_start();		/* start McBSP interface */
 	}
 	/* else the dma itself will progress forward with out our help */
 	FN_OUT(0);
@@ -850,8 +878,9 @@ static void sound_dma_irq_handler(int so
 	DPRINTK("lch=%d,status=0x%x, dma_status=%d, data=%p\n",
sound_curr_lch,
 		ch_status, dma_status, data);
 
-	if (dma_status & (DCSR_ERROR)) {
-		OMAP_DMA_CCR_REG(sound_curr_lch) &= ~DCCR_EN;
+	if (dma_status) {
+		if (cpu_is_omap16xx() && (dma_status & (DCSR_ERROR)))
+			OMAP_DMA_CCR_REG(sound_curr_lch) &= ~DCCR_EN;
 		ERR("DCSR_ERROR!\n");
 		FN_OUT(-1);
 		return;
diff --git a/sound/oss/omap-audio-tsc2101.c b/sound/oss/omap-audio-tsc2101.c
--- a/sound/oss/omap-audio-tsc2101.c
+++ b/sound/oss/omap-audio-tsc2101.c
@@ -48,9 +48,10 @@
 #include "omap-audio.h"
 #include "omap-audio-dma-intfc.h"
 #include <asm/arch/mcbsp.h>
-#if CONFIG_ARCH_OMAP16XX
+#ifdef CONFIG_ARCH_OMAP16XX
 #include <../drivers/ssi/omap-uwire.h>
 #include <asm/arch/dsp_common.h>
+#elif defined(CONFIG_ARCH_OMAP24XX)
 #else
 #error "Unsupported configuration"
 #endif
@@ -70,12 +71,10 @@
 
 #define CODEC_NAME		 "TSC2101"
 
-#if CONFIG_ARCH_OMAP16XX
+#ifdef CONFIG_ARCH_OMAP16XX
 #define PLATFORM_NAME "OMAP16XX"
-#endif
-
-#if CONFIG_ARCH_OMAP16XX
-#define OMAP_DSP_BASE        0xE0000000
+#elif defined(CONFIG_ARCH_OMAP24XX)
+#define PLATFORM_NAME "OMAP2"
 #endif
 
 /* Define to set the tsc as the master w.r.t McBSP */
@@ -90,9 +89,9 @@
 #define LEAVE_CS 			          0x80
 
 /* Select the McBSP For Audio */
-#if CONFIG_ARCH_OMAP16XX
-#define AUDIO_MCBSP                   OMAP_MCBSP1
-#else
+/* 16XX is MCBSP1 and 24XX is MCBSP2*/
+/* see include/asm-arm/arch-omap/mcbsp.h */
+#ifndef AUDIO_MCBSP
 #error "UnSupported Configuration"
 #endif
 
@@ -147,16 +146,32 @@
 
 /***************************** Data Structures
**********************************/
 
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
 static audio_stream_t output_stream = {
-	.id              = "TSC2101 out",
-	.dma_dev         = OMAP_DMA_MCBSP1_TX,
-	.input_or_output = FMODE_WRITE
+	.id			= "TSC2101 out",
+	.dma_dev		= AUDIO_DMA_TX,
+	.input_or_output	= FMODE_WRITE,
+	.hw_start		= audio_ifc_start,
+	.hw_stop		= audio_ifc_stop,
 };
 
 static audio_stream_t input_stream = {
-	.id              = "TSC2101 in",
-	.dma_dev         = OMAP_DMA_MCBSP1_RX,
-	.input_or_output = FMODE_READ
+	.id			= "TSC2101 in",
+	.dma_dev		= AUDIO_DMA_RX,
+	.input_or_output	= FMODE_READ,
+	.hw_start		= audio_ifc_start,
+	.hw_stop		= audio_ifc_stop,
 };
 
 static int audio_dev_id, mixer_dev_id;
@@ -227,9 +242,9 @@ static struct omap_mcbsp_reg_cfg initial
 	.srgr2 = GSYNC | CLKSP | FSGM | FPER(31),
 
 	/* platform specific initialization */
-#if CONFIG_MACH_OMAP_H2
+#ifdef CONFIG_MACH_OMAP_H2
 	.pcr0  = CLKXM | CLKRM | FSXP | FSRP | CLKXP | CLKRP,
-#elif CONFIG_MACH_OMAP_H3
+#elif defined(CONFIG_MACH_OMAP_H3) || defined(CONFIG_MACH_OMAP_H4)
 
 #ifndef TSC_MASTER
 	.pcr0  = FSXM | FSRM | CLKXM | CLKRM | CLKXP | CLKRP,

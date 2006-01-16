From: lamikr <lamikr@cc.jyu.fi>
Subject: omap1510/16xx fixes for the tsc2101 oss driver
Date: Mon, 16 Jan 2006 04:26:15 +0200
Message-ID: <43CB0447.2000606@cc.jyu.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090106030303070101000804"
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------090106030303070101000804
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

1) mcbsp.h needs to define AUDIO_MCBSP_DATAREAD and
AUDIO_MCBSP_DATAWRITE functions, etc... both for the omap1510 and
omap16xx oterwise the sound/oss/omap-audio-dma-intfc.c fails to compile
with omap1.

2) Added cpu_is_omap1510 check to places which earlier only checked
cpu_is_omap16xx() so that the dma got initialized properly also with the
omap1510 based iPAQ h6300.

3)  DCSR_ERROR check looked suspicious compared to the version in 2.6.14
kernel. In addition that prevented the sound working after first played
frame
in the iPAQ h6300 as assumed always that error had happened.

After applying attached fixes, cat my_song.wav > /dev/dsp worked ok for me.

Mika

--------------090106030303070101000804
Content-Type: text/x-patch;
 name="tsc2101_omap1_oss_audio_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tsc2101_omap1_oss_audio_fix.patch"

--- linux-omap-2.6/include/asm-arm/arch-omap/mcbsp.h	2006-01-14 13:26:21.000000000 +0200
+++ linux-omap-h6300-2.6/include/asm-arm/arch-omap/mcbsp.h	2006-01-16 03:40:27.000000000 +0200
@@ -40,7 +40,7 @@
 #define OMAP24XX_MCBSP1_BASE	0x48074000
 #define OMAP24XX_MCBSP2_BASE	0x48076000
 
-#ifdef CONFIG_ARCH_OMAP16XX
+#if defined(CONFIG_ARCH_OMAP15XX) || defined(CONFIG_ARCH_OMAP16XX)
 
 #define OMAP_MCBSP_REG_DRR2	0x00
 #define OMAP_MCBSP_REG_DRR1	0x02
@@ -76,6 +76,9 @@
 
 #define OMAP_MAX_MCBSP_COUNT 3
 
+#define AUDIO_MCBSP_DATAWRITE	(OMAP1510_MCBSP1_BASE + OMAP_MCBSP_REG_DXR1)
+#define AUDIO_MCBSP_DATAREAD	(OMAP1510_MCBSP1_BASE + OMAP_MCBSP_REG_DRR1)
+
 #define AUDIO_MCBSP		OMAP_MCBSP1
 #define AUDIO_DMA_TX		OMAP_DMA_MCBSP1_TX
 #define AUDIO_DMA_RX		OMAP_DMA_MCBSP1_RX
--- linux-omap-2.6/sound/oss/omap-audio-dma-intfc.c	2006-01-14 13:26:23.000000000 +0200
+++ linux-omap-h6300-2.6/sound/oss/omap-audio-dma-intfc.c	2006-01-16 03:47:30.000000000 +0200
@@ -683,13 +683,6 @@
 	return;
 }
 
-/*********************************** MODULE FUNCTIONS DEFINTIONS ***********************/
-
-#ifdef OMAP1610_MCBSP1_BASE
-#undef OMAP1610_MCBSP1_BASE
-#endif
-#define OMAP1610_MCBSP1_BASE    0xE1011000
-
 /***************************************************************************************
  *
  * DMA related functions
@@ -707,8 +700,8 @@
 
 	FN_IN;
 
-	if (cpu_is_omap16xx()) {
-		dest_start = (OMAP1610_MCBSP1_BASE + 0x806);
+	if (cpu_is_omap1510() || cpu_is_omap16xx()) {
+		dest_start = AUDIO_MCBSP_DATAWRITE;
 		dest_port = OMAP_DMA_PORT_MPUI;
 	}
 	if (cpu_is_omap24xx()) {
@@ -737,8 +730,8 @@
 
 	FN_IN;
 
-	if (cpu_is_omap16xx()) {
-		src_start = (OMAP1610_MCBSP1_BASE + 0x802);
+	if (cpu_is_omap1510() || cpu_is_omap16xx()) {
+		src_start = AUDIO_MCBSP_DATAREAD;
 		src_port = OMAP_DMA_PORT_MPUI;
 	}
 	if (cpu_is_omap24xx()) {
@@ -878,8 +871,8 @@
 	DPRINTK("lch=%d,status=0x%x, dma_status=%d, data=%p\n", sound_curr_lch,
 		ch_status, dma_status, data);
 
-	if (dma_status) {
-		if (cpu_is_omap16xx() && (dma_status & (DCSR_ERROR)))
+	if (dma_status & (DCSR_ERROR)) {
+		if (cpu_is_omap1510() || cpu_is_omap16xx())
 			OMAP_DMA_CCR_REG(sound_curr_lch) &= ~DCCR_EN;
 		ERR("DCSR_ERROR!\n");
 		FN_OUT(-1);

--------------090106030303070101000804
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------090106030303070101000804--

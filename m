From: David Brownell <david-b@pacbell.net>
Subject: [patch linux-omap-git] tsc2101-alsa build fixes
Date: Tue, 22 May 2007 22:33:53 -0700
Message-ID: <200705222233.53605.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
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

Partial build fixes for tsc2101 audio.  It still won't link though,
it needs undefined omap_tsc2101_{read,write}() functions to access
chip registers ... and requires that e.g. tsc2102 audio isn't also
configured (they use the same exported McBSP DMA functions, which
likewise prevent use with EAC).

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 sound/arm/omap/omap-alsa-tsc2101-mixer.h |    1 -
 sound/arm/omap/omap-alsa-tsc2101.c       |    3 +--
 sound/arm/omap/omap-alsa-tsc2101.h       |    7 ++++---
 3 files changed, 5 insertions(+), 6 deletions(-)

--- o26.orig/sound/arm/omap/omap-alsa-tsc2101-mixer.h	2007-05-22 22:20:37.000000000 -0700
+++ o26/sound/arm/omap/omap-alsa-tsc2101-mixer.h	2007-05-22 22:21:12.000000000 -0700
@@ -43,7 +43,6 @@
 #define OMAPALSATSC2101MIXER_H_
 
 #include <asm/hardware/tsc2101.h>
-#include <../drivers/ssi/omap-tsc2101.h>
 #include "omap-alsa-dma.h"
 
 /* tsc2101 DAC gain control volume specific  */
--- o26.orig/sound/arm/omap/omap-alsa-tsc2101.c	2007-05-22 22:20:37.000000000 -0700
+++ o26/sound/arm/omap/omap-alsa-tsc2101.c	2007-05-22 22:21:12.000000000 -0700
@@ -34,7 +34,6 @@
 #include <asm/arch/clock.h>
 
 #include <asm/hardware/tsc2101.h>
-#include <../drivers/ssi/omap-tsc2101.h>
 
 #include <asm/arch/omap-alsa.h>
 #include "omap-alsa-tsc2101.h"
@@ -118,7 +117,7 @@ static struct snd_pcm_hardware tsc2101_s
 	.fifo_size = 0,
 };
 
-static snd_pcm_hardware_t tsc2101_snd_omap_alsa_capture = {
+static struct snd_pcm_hardware tsc2101_snd_omap_alsa_capture = {
 	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID),
 	.formats = (SNDRV_PCM_FMTBIT_S16_LE),
--- o26.orig/sound/arm/omap/omap-alsa-tsc2101.h	2007-05-22 22:23:44.000000000 -0700
+++ o26/sound/arm/omap/omap-alsa-tsc2101.h	2007-05-22 22:24:56.000000000 -0700
@@ -23,7 +23,7 @@
 
 #include <linux/types.h>
 
-/* Define to set the tsc as the master w.r.t McBSP */
+/* Define to set the tsc as the master w.r.t McBSP or EAC */
 #define TSC_MASTER
 
 #define NUMBER_SAMPLE_RATES_SUPPORTED	16
@@ -36,8 +36,9 @@
 #endif
 
 #define DEFAULT_SAMPLE_RATE		44100
-#define CODEC_CLOCK 			12000000
-#define AUDIO_MCBSP        		OMAP_MCBSP1
+
+/* FIXME codec clock rate is board-specific */
+#define CODEC_CLOCK			12000000
 
 #define PAGE2_AUDIO_CODEC_REGISTERS	(2)
 

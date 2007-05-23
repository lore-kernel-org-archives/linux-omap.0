From: David Brownell <david-b@pacbell.net>
Subject: [patch linux-omap-git] tsc2102-alsa build fixes
Date: Tue, 22 May 2007 22:34:05 -0700
Message-ID: <200705222234.05583.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
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

Various fixes needed to build the tsc2102 audio.  Several fixes
relate specifically to building it as a module.

Note that this doesn't address the need for omap-alsa-dma.c
to go into a separate module so that e.g. tsc2101 and tsc2102
modules can both be built, or the assumption that the audio
is going out over McBSP not EAC.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/spi/tsc2102.c              |   13 +++++++++++--
 include/linux/spi/tsc2102.h        |    2 +-
 sound/arm/omap/omap-alsa-tsc2102.c |    3 ++-
 sound/arm/omap/omap-alsa-tsc2102.h |    3 ++-
 4 files changed, 16 insertions(+), 5 deletions(-)

--- o26.orig/sound/arm/omap/omap-alsa-tsc2102.c	2007-05-22 21:45:46.000000000 -0700
+++ o26/sound/arm/omap/omap-alsa-tsc2102.c	2007-05-22 22:03:15.000000000 -0700
@@ -19,7 +19,8 @@
 #include <linux/module.h>
 #include <linux/spi/tsc2102.h>
 
-#include <asm/arch/mcbsp.h>
+#include <asm/io.h>
+
 #include <asm/arch/dma.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/omap-alsa.h>
--- o26.orig/include/linux/spi/tsc2102.h	2007-05-22 21:47:05.000000000 -0700
+++ o26/include/linux/spi/tsc2102.h	2007-05-22 21:48:11.000000000 -0700
@@ -53,7 +53,7 @@ extern int tsc2102_ports_cb(tsc2102_port
 extern int tsc2102_temp1_cb(tsc2102_temp_t handler);
 extern int tsc2102_temp2_cb(tsc2102_temp_t handler);
 
-#ifdef CONFIG_SOUND
+#if defined(CONFIG_SND_OMAP_TSC2102) || defined(CONFIG_SND_OMAP_TSC2102_MODULE)
 extern void tsc2102_set_volume(uint8_t left_ch, uint8_t right_ch);
 extern void tsc2102_set_mute(int left_ch, int right_ch);
 extern void tsc2102_get_mute(int *left_ch, int *right_ch);
--- o26.orig/sound/arm/omap/omap-alsa-tsc2102.h	2007-05-22 21:51:18.000000000 -0700
+++ o26/sound/arm/omap/omap-alsa-tsc2102.h	2007-05-22 21:51:43.000000000 -0700
@@ -26,8 +26,9 @@
 #endif
 
 #define DEFAULT_SAMPLE_RATE		44100
+
+/* FIXME codec clock rate is board-specific */
 #define CODEC_CLOCK			12000000
-#define AUDIO_MCBSP			OMAP_MCBSP1
 
 /*
  * ALSA mixer related macros
--- o26.orig/drivers/spi/tsc2102.c	2007-05-22 21:41:49.000000000 -0700
+++ o26/drivers/spi/tsc2102.c	2007-05-22 21:41:52.000000000 -0700
@@ -583,7 +583,8 @@ static void tsc2102_pressure(unsigned lo
 			&dev->adc_status, tsc2102_pressure_report);
 }
 
-#ifdef CONFIG_SOUND
+#if defined(CONFIG_SND_OMAP_TSC2102) || defined(CONFIG_SND_OMAP_TSC2102_MODULE)
+
 /*
  * Volume level values should be in the range [0, 127].
  * Higher values mean lower volume.
@@ -607,6 +608,7 @@ void tsc2102_set_volume(uint8_t left_ch,
 
 	spin_unlock(&tsc.lock_sync);
 }
+EXPORT_SYMBOL_GPL(tsc2102_set_volume);
 
 void tsc2102_set_mute(int left_ch, int right_ch)
 {
@@ -622,6 +624,7 @@ void tsc2102_set_mute(int left_ch, int r
 
 	spin_unlock(&tsc.lock_sync);
 }
+EXPORT_SYMBOL_GPL(tsc2102_set_mute);
 
 void tsc2102_get_mute(int *left_ch, int *right_ch)
 {
@@ -650,6 +653,7 @@ void tsc2102_set_deemphasis(int enable)
 	tsc2102_write_sync(TSC2102_DAC_POWER_CTRL, val);
 	spin_unlock(&tsc.lock_sync);
 }
+EXPORT_SYMBOL_GPL(tsc2102_set_deemphasis);
 
 void tsc2102_set_bassboost(int enable)
 {
@@ -665,6 +669,7 @@ void tsc2102_set_bassboost(int enable)
 	tsc2102_write_sync(TSC2102_DAC_POWER_CTRL, val);
 	spin_unlock(&tsc.lock_sync);
 }
+EXPORT_SYMBOL_GPL(tsc2102_set_bassboost);
 
 /*	{rate, dsor, fsref}	*/
 static const struct tsc2102_rate_info_s tsc2102_rates[] = {
@@ -730,6 +735,7 @@ int tsc2102_set_rate(int rate)
 	spin_unlock(&tsc.lock_sync);
 	return 0;
 }
+EXPORT_SYMBOL(tsc2102_set_rate);
 
 /*
  * Perform basic set-up with default values and power the DAC on.
@@ -762,6 +768,7 @@ void tsc2102_dac_power(int state)
 
 	spin_unlock(&tsc.lock_sync);
 }
+EXPORT_SYMBOL_GPL(tsc2102_dac_power);
 
 void tsc2102_set_i2s_master(int state)
 {
@@ -777,7 +784,9 @@ void tsc2102_set_i2s_master(int state)
 
 	spin_unlock(&tsc.lock_sync);
 }
-#endif	/* CONFIG_SOUND */
+EXPORT_SYMBOL_GPL(tsc2102_set_i2s_master);
+
+#endif	/* CONFIG_SND_OMAP_TSC2101 */
 
 static int tsc2102_configure(struct tsc2102_dev *dev)
 {

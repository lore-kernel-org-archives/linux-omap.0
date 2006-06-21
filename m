From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH] ARM: OMAP: rework mutex_init() for RT compatibility
Date: Wed, 21 Jun 2006 12:49:39 -0700
Message-ID: <11509193791732-git-send-email-khilman@mvista.com>
Reply-To: Kevin Hilman <khilman@mvista.com>
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

Replace remaining __MUTEX_INITIALIZER() calls with mutex_init() to
enable compatibility with the realtime-preempt patchset.

Signed-off-by: Kevin Hilman <khilman@deeprooted.net>

Index: rt-dev/arch/arm/plat-omap/dsp/dsp_common.c
===================================================================
--- rt-dev.orig/arch/arm/plat-omap/dsp/dsp_common.c
+++ rt-dev/arch/arm/plat-omap/dsp/dsp_common.c
@@ -59,7 +59,6 @@ struct cpustat {
 	void (*mem_rel_cb)(void);
 };
 struct cpustat cpustat = {
-	.lock = __MUTEX_INITIALIZER(cpustat.lock),
 	.stat = CPUSTAT_RESET,
 	.icrmask = 0xffff,
 };
@@ -243,6 +242,8 @@ static int init_done;
 
 static int __init omap_dsp_init(void)
 {
+	mutex_init(&cpustat.lock);
+
 	dspmem_size = 0;
 #ifdef CONFIG_ARCH_OMAP15XX
 	if (cpu_is_omap1510()) {
Index: rt-dev/sound/oss/omap-audio-aic23.c
===================================================================
--- rt-dev.orig/sound/oss/omap-audio-aic23.c
+++ rt-dev/sound/oss/omap-audio-aic23.c
@@ -244,7 +244,6 @@ static audio_state_t aic23_state = {
         .hw_remove      =  __exit_p(omap_aic23_remove),
         .hw_suspend     = omap_aic23_suspend,
         .hw_resume      = omap_aic23_resume,
-	.mutex	    = __MUTEX_INITIALIZER(aic23_state.mutex),
 };
 
 /* This will be defined in the audio.h */
@@ -673,6 +672,8 @@ static int __init audio_aic23_init(void)
 	if (machine_is_omap_h2() || machine_is_omap_h3())
 		return -ENODEV;
 
+	mutex_init(&aic23_state.mutex);
+
         if (machine_is_omap_osk()) {
                 /* Set MCLK to be clock input for AIC23 */
                 aic23_mclk = clk_get(0, "mclk");
Index: rt-dev/sound/oss/omap-audio-tsc2101.c
===================================================================
--- rt-dev.orig/sound/oss/omap-audio-tsc2101.c
+++ rt-dev/sound/oss/omap-audio-tsc2101.c
@@ -326,7 +326,6 @@ static audio_state_t tsc2101_state = {
 	.hw_remove      = omap_tsc2101_remove,
 	.hw_suspend     = omap_tsc2101_suspend,
 	.hw_resume      = omap_tsc2101_resume,
-	.mutex		= __MUTEX_INITIALIZER(tsc2101_state.mutex),
 };
 
 /* This will be defined in the Audio.h */
@@ -1031,6 +1030,8 @@ static int __init audio_tsc2101_init(voi
 	if (machine_is_omap_osk() || machine_is_omap_innovator())
 		return -ENODEV;
 
+	mutex_init(&tsc2101_state.mutex);
+
 	/* register the codec with the audio driver */
 	if ((err = audio_register_codec(&tsc2101_state))) {
 		printk(KERN_ERR

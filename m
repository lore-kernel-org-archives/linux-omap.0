From: lamikr <lamikr@cc.jyu.fi>
Subject: [PATCH 1/5] omap-alsa-tsc2101: code, debug and comment cleanups.
Date: Fri, 31 Mar 2006 01:54:56 +0300
Message-ID: <442C61C0.8010100@cc.jyu.fi>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070304060805030607070002"
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
--------------070304060805030607070002
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Following patch-set cleanups and simplifies the code in
omap-alsa-tsc2101 and omap-alsa-tsc2101-mixer.

Mika

--------------070304060805030607070002
Content-Type: text/plain;
	name="0001-omap-alsa-tsc2101-code-debug-and-comment-cleanups.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="0001-omap-alsa-tsc2101-code-debug-and-comment-cleanups.txt"

>From nobody Mon Sep 17 00:00:00 2001
From: lamikr <lamikr@cc.jyu.fi)>
Date: Fri Mar 31 01:16:26 2006 +0300
Subject: [PATCH 1/5] omap-alsa-tsc2101: code, debug and comment cleanups.

Signed-off-by: lamikr <lamikr@cc.jyu.fi>


---

 sound/arm/omap/omap-alsa-tsc2101.c |   45 ++++++++++++++++--------------------
 1 files changed, 20 insertions(+), 25 deletions(-)

5b0be8090657122537bf01497423eaf056b1729c
diff --git a/sound/arm/omap/omap-alsa-tsc2101.c b/sound/arm/omap/omap-alsa-tsc2101.c
index a0096cb..c3abe1d 100644
--- a/sound/arm/omap/omap-alsa-tsc2101.c
+++ b/sound/arm/omap/omap-alsa-tsc2101.c
@@ -136,7 +136,7 @@ static snd_pcm_hardware_t tsc2101_snd_om
 };
 
 /* 
- * Simplified write for tsc Audio
+ * Simplified write for tsc2101 audio registers.
  */
 inline void tsc2101_audio_write(u8 address, u16 data)
 {
@@ -144,7 +144,7 @@ inline void tsc2101_audio_write(u8 addre
 }
 
 /* 
- * Simplified read for tsc  Audio
+ * Simplified read for tsc2101 audio registers.
  */
 inline u16 tsc2101_audio_read(u8 address)
 {
@@ -246,14 +246,17 @@ void tsc2101_set_samplerate(long sample_
 #endif				/* #ifdef TSC_MASTER */
 	tsc2101_audio_write(TSC2101_AUDIO_CTRL_3, data);
 
-	/* program the PLLs */
+	/* Program the PLLs. This code assumes that the 12 Mhz MCLK is in use.
+         * If MCLK rate is something else, these values must be changed.
+	 * See the tsc2101 specification for the details.
+	 */
 	if (rate_reg_info[count].fs_44kHz) {
-		/* 44.1 khz - 12 MHz Mclk */
+		/* samplerate = (44.1kHZ / x), where x is int. */
 		tsc2101_audio_write(TSC2101_PLL_PROG_1, PLL1_PLLSEL |
 				PLL1_PVAL(1) | PLL1_I_VAL(7));	/* PVAL 1; I_VAL 7 */
 		tsc2101_audio_write(TSC2101_PLL_PROG_2, PLL2_D_VAL(0x1490));	/* D_VAL 5264 */
 	} else {
-		/* 48 khz - 12 Mhz Mclk */
+		/* samplerate = (48.kHZ / x), where x is int. */
 		tsc2101_audio_write(TSC2101_PLL_PROG_1, PLL1_PLLSEL |
 			       PLL1_PVAL(1) | PLL1_I_VAL(8));	/* PVAL 1; I_VAL 8 */
 		tsc2101_audio_write(TSC2101_PLL_PROG_2, PLL2_D_VAL(0x780));	/* D_VAL 1920 */
@@ -317,21 +320,14 @@ int tsc2101_clock_on(void) 
 		       CODEC_CLOCK);
 	}
 	curRate	= (uint)clk_get_rate(tsc2101_mclk);
-	DPRINTK("old clock rate = %d\n", curRate);
 	if (curRate != CODEC_CLOCK) {
 		err	= clk_set_rate(tsc2101_mclk, CODEC_CLOCK);
 		if (err) {
 			printk(KERN_WARNING
 			       "Cannot set MCLK clock rate for TSC2101 CODEC, error code = %d\n", err);
-			//return -ECANCELED;
+			return -ECANCELED;
 		}
 	}
-	else
-	{
-		printk(KERN_INFO
-		       "omap_alsa_tsc2101_clock_on(), no need to change rate, no need to change clock rate, rate already %d Hz.\n",
-		       CODEC_CLOCK);
-	}
 	err		= clk_enable(tsc2101_mclk);
 	curRate		= (uint)clk_get_rate(tsc2101_mclk);
 	curUseCount	= clk_get_usecount(tsc2101_mclk);
@@ -349,8 +345,7 @@ int tsc2101_clock_on(void) 
 }
 
 /*
- * Do some sanity check, turn clock off and then turn
- *  codec audio off
+ * Do some sanity check, turn clock off and then turn codec audio off
  */
 int tsc2101_clock_off(void) 
 {
@@ -374,10 +369,6 @@ int tsc2101_clock_off(void) 
 	tsc2101_audio_write(TSC2101_CODEC_POWER_CTRL,
 			    ~(CPC_SP1PWDN | CPC_SP2PWDN | CPC_BASSBC));
 	DPRINTK("audio codec off\n");
-#ifdef DUMP_TSC2101_AUDIO_REGISTERS
-	printk("tsc2101_clock_off()\n");
-	dump_tsc2101_audio_reg();
-#endif	
 	return 0;	
 }
 
@@ -420,18 +411,22 @@ static struct platform_driver omap_alsa_
 };
 
 static int __init omap_alsa_tsc2101_init(void)
-{
-	int err;
-	
+{	
 	ADEBUG();
-	err = platform_driver_register(&omap_alsa_driver);
-
-	return err;
+#ifdef DUMP_TSC2101_AUDIO_REGISTERS
+	printk("omap_alsa_tsc2101_init()\n");
+	dump_tsc2101_audio_reg();
+#endif
+	return platform_driver_register(&omap_alsa_driver);
 }
 
 static void __exit omap_alsa_tsc2101_exit(void)
 {
 	ADEBUG();
+#ifdef DUMP_TSC2101_AUDIO_REGISTERS
+	printk("omap_alsa_tsc2101_exit()\n");
+	dump_tsc2101_audio_reg();
+#endif
 	platform_driver_unregister(&omap_alsa_driver);
 }
 
-- 
1.2.2


--------------070304060805030607070002
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------070304060805030607070002--

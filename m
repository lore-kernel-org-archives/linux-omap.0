From: lamikr <lamikr@cc.jyu.fi>
Subject: [PATCH 3/5] omap-alsa-tsc2101-mixer: playback and recording
 selection cleanup.
Date: Fri, 31 Mar 2006 01:55:23 +0300
Message-ID: <442C61DB.9090702@cc.jyu.fi>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000508000103080800090209"
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
--------------000508000103080800090209
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit



--------------000508000103080800090209
Content-Type: text/plain;
	name="0003-omap-alsa-tsc2101-mixer-playback-and-recording-selection-cleanup.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="0003-omap-alsa-tsc2101-mixer-playback-and-recording-selection-cleanup.txt"

>From nobody Mon Sep 17 00:00:00 2001
From: lamikr <lamikr@cc.jyu.fi)>
Date: Fri Mar 31 01:21:59 2006 +0300
Subject: [PATCH 3/5] omap-alsa-tsc2101-mixer: playback and recording selection cleanup.

Signed-off-by: lamikr <lamikr@cc.jyu.fi>


---

 sound/arm/omap/omap-alsa-tsc2101-mixer.c |   80 +++++++++++-------------------
 sound/arm/omap/omap-alsa-tsc2101-mixer.h |   16 +++---
 2 files changed, 37 insertions(+), 59 deletions(-)

cc513fa045980cdd6366f70559988cb4a8b5a137
diff --git a/sound/arm/omap/omap-alsa-tsc2101-mixer.c b/sound/arm/omap/omap-alsa-tsc2101-mixer.c
index 1b7b968..3d99984 100644
--- a/sound/arm/omap/omap-alsa-tsc2101-mixer.c
+++ b/sound/arm/omap/omap-alsa-tsc2101-mixer.c
@@ -85,25 +85,24 @@ inline u16 omap_tsc2101_audio_read(u8 ad
 }
 
 /*
- * Used for switching between TSC2101 recourd sources.
- * Logic is adjusted from the TSC2101 OSS code.
+ * For selecting tsc2101 recourd source.
  */
-static int set_record_source(int val)
+static void set_record_source(int val)
 {
 	u16	data;
-	int	maskedVal;
 	
-	FN_IN;
-	maskedVal	= 0xe0 & val;	
-
-	data	= omap_tsc2101_audio_read(TSC2101_MIXER_PGA_CTRL);
+	/* Mute Analog Sidetone
+	 * Analog sidetone gain db?
+	 * Cell Phone In not connected to ADC
+	 * Input selected by MICSEL connected to ADC
+	 */
+	data	= MPC_ASTMU | MPC_ASTG(0x45);
 	data	&= ~MPC_MICSEL(7); /* clear all MICSEL bits */
-	data	|= maskedVal;
+	data	|= MPC_MICSEL(val);
+	data	|= MPC_MICADC;
 	omap_tsc2101_audio_write(TSC2101_MIXER_PGA_CTRL, data);
+	
 	current_rec_src	= val;
-
-	FN_OUT(0);
-	return 0;
 }
 
 /*
@@ -324,24 +323,9 @@ int set_mixer_volume_as_handset_gain_con
 	return retVal;
 }
 
-void init_record_sources(void)
-{
-	/* Mute Analog Sidetone
-	 * analog sidetone gain db?
-	 * Cell Phone In not connected to ADC
-	 * Input selected by MICSEL connected to ADC
-	 */
-	omap_tsc2101_audio_write(TSC2101_MIXER_PGA_CTRL,
-			  MPC_ASTMU | MPC_ASTG(0x40) | ~MPC_CPADC | MPC_MICADC);
-	/* Set record source, Select MIC_INHED input for headset */
-	set_record_source(REC_SRC_SINGLE_ENDED_MICIN_HED);	
-}
-
 void set_loudspeaker_to_playback_target(void)
 {
-	u16	val;
-
-	/* power down sp1, sp2 and loudspeaker */
+	/* power down SPK1, SPK2 and loudspeaker */
 	omap_tsc2101_audio_write(TSC2101_CODEC_POWER_CTRL,
 			CPC_SP1PWDN | CPC_SP2PWDN | CPC_LDAPWDF);	
 	/* ADC, DAC, Analog Sidetone, cellphone, buzzer softstepping enabled
@@ -352,21 +336,13 @@ void set_loudspeaker_to_playback_target(
 
 	/* DAC left and right routed to SPK1/SPK2
 	 * SPK1/SPK2 unmuted
-	 * keyclicks routed to SPK1/SPK2
-	 */
-	val	= AC5_DIFFIN |
+	 * Keyclicks routed to SPK1/SPK2 */
+	omap_tsc2101_audio_write(TSC2101_AUDIO_CTRL_5, 
+			AC5_DIFFIN |
 			AC5_DAC2SPK1(3) | AC5_AST2SPK1 | AC5_KCL2SPK1 |
-			AC5_DAC2SPK2(3) | AC5_AST2SPK2 | AC5_KCL2SPK2 |
-			AC5_HDSCPTC;
-	val	= val & ~AC5_HDSCPTC;
-	omap_tsc2101_audio_write(TSC2101_AUDIO_CTRL_5, val);
-	
-	/* powerdown spk1/out32n and spk2 */
-	val	= omap_tsc2101_audio_read(TSC2101_POWERDOWN_STS);
-	val	= val & ~(~PS_SPK1FL | ~PS_HNDFL | PS_LSPKFL);
-	omap_tsc2101_audio_write(TSC2101_POWERDOWN_STS,	val);
-
-	/* routing selected to SPK1 goes to OUT8P/OUT84 alsa. (loudspeaker)
+			AC5_DAC2SPK2(3) | AC5_AST2SPK2 | AC5_KCL2SPK2);
+	
+	/* routing selected to SPK1 goes also to OUT8P/OUT8N. (loudspeaker)
 	 * analog sidetone routed to loudspeaker
 	 * buzzer pga routed to loudspeaker
 	 * keyclick routing to loudspeaker
@@ -380,29 +356,29 @@ void set_loudspeaker_to_playback_target(
 	 */
 	omap_tsc2101_audio_write(TSC2101_AUDIO_CTRL_6,
 			AC6_SPL2LSK | AC6_AST2LSK | AC6_BUZ2LSK | AC6_KCL2LSK |
-			AC6_CPI2LSK | AC6_MIC2CPO | AC6_SPL2CPO |
-			~AC6_MUTLSPK | ~AC6_MUTSPK2 | ~AC6_LDSCPTC | ~AC6_VGNDSCPTC);
+			AC6_CPI2LSK | AC6_MIC2CPO | AC6_SPL2CPO);
 	current_playback_target	= PLAYBACK_TARGET_LOUDSPEAKER;
 }
 
 void set_headphone_to_playback_target(void)
 {
-	/* power down sp1, sp2 and loudspeaker */
+	/* power down SPK1, SPK2 and loudspeaker */
 	omap_tsc2101_audio_write(TSC2101_CODEC_POWER_CTRL,
 			CPC_SP1PWDN | CPC_SP2PWDN | CPC_LDAPWDF);
 	/* ADC, DAC, Analog Sidetone, cellphone, buzzer softstepping enabled */
 	/* 1dB AGC hysteresis */
 	/* MICes bias 2V */
 	omap_tsc2101_audio_write(TSC2101_AUDIO_CTRL_4, AC4_MB_HED(0));
-
-	/* DAC left and right routed to SPK2 */
-	/* SPK1/2 unmuted */
+				
+	/* DAC left and right routed to SPK1/SPK2
+	 * SPK1/SPK2 unmuted
+	 * Keyclicks routed to SPK1/SPK2 */
 	omap_tsc2101_audio_write(TSC2101_AUDIO_CTRL_5,
 			AC5_DAC2SPK1(3) | AC5_AST2SPK1 | AC5_KCL2SPK1 |
 			AC5_DAC2SPK2(3) | AC5_AST2SPK2 | AC5_KCL2SPK2 |
 			AC5_HDSCPTC);
-
-	/* OUT8P/N muted, CPOUT muted */
+			
+	/* OUT8P/OUT8N muted, CPOUT muted */
 	omap_tsc2101_audio_write(TSC2101_AUDIO_CTRL_6,
 			AC6_MUTLSPK | AC6_MUTSPK2 | AC6_LDSCPTC |
 			AC6_VGNDSCPTC);
@@ -479,7 +455,9 @@ void snd_omap_init_mixer(void)
 	/* Headset/Hook switch detect enabled */
 	omap_tsc2101_audio_write(TSC2101_AUDIO_CTRL_7, AC7_DETECT);
 
-	init_record_sources();
+	/* Select headset to record source (MIC_INHED)*/
+	set_record_source(REC_SRC_SINGLE_ENDED_MICIN_HED);
+	/* Init loudspeaker as a default playback target*/
 	init_playback_targets();
 
 	FN_OUT(0);
diff --git a/sound/arm/omap/omap-alsa-tsc2101-mixer.h b/sound/arm/omap/omap-alsa-tsc2101-mixer.h
index f68f33d..ff852b5 100644
--- a/sound/arm/omap/omap-alsa-tsc2101-mixer.h
+++ b/sound/arm/omap/omap-alsa-tsc2101-mixer.h
@@ -62,14 +62,14 @@
 
 /* following are used for register 03h Mixer PGA control bits D7-D5 for selecting record source */
 #define REC_SRC_TARGET_COUNT		0x08
-#define REC_SRC_SINGLE_ENDED_MICIN_HED	MPC_MICSEL(0)	// oss code referred to MIXER_LINE
-#define REC_SRC_SINGLE_ENDED_MICIN_HND	MPC_MICSEL(1)	// oss code referred to MIXER_MIC
-#define REC_SRC_SINGLE_ENDED_AUX1	MPC_MICSEL(2)
-#define REC_SRC_SINGLE_ENDED_AUX2	MPC_MICSEL(3)
-#define REC_SRC_MICIN_HED_AND_AUX1	MPC_MICSEL(4)
-#define REC_SRC_MICIN_HED_AND_AUX2	MPC_MICSEL(5)
-#define REC_SRC_MICIN_HND_AND_AUX1	MPC_MICSEL(6)
-#define REC_SRC_MICIN_HND_AND_AUX2	MPC_MICSEL(7)
+#define REC_SRC_SINGLE_ENDED_MICIN_HED	0x00	// oss code referred to MIXER_LINE
+#define REC_SRC_SINGLE_ENDED_MICIN_HND	0x01	// oss code referred to MIXER_MIC
+#define REC_SRC_SINGLE_ENDED_AUX1	0x02
+#define REC_SRC_SINGLE_ENDED_AUX2	0x03
+#define REC_SRC_MICIN_HED_AND_AUX1	0x04
+#define REC_SRC_MICIN_HED_AND_AUX2	0x05
+#define REC_SRC_MICIN_HND_AND_AUX1	0x06
+#define REC_SRC_MICIN_HND_AND_AUX2	0x07
 
 #define DEFAULT_OUTPUT_VOLUME		90	// default output volume to dac dgc
 #define DEFAULT_INPUT_VOLUME		20	// default record volume
-- 
1.2.2


--------------000508000103080800090209
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------000508000103080800090209--

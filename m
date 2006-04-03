From: lamikr <lamikr@cc.jyu.fi>
Subject: Re: [PATCH 4/5] omap-alsa-tsc2101-mixer: merge similar looking
 methods together.
Date: Mon, 03 Apr 2006 21:37:09 +0300
Message-ID: <44316B55.4020805@cc.jyu.fi>
References: <442C61E8.3030707@cc.jyu.fi>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040608000804020605020008"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <442C61E8.3030707@cc.jyu.fi>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------040608000804020605020008
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi, just noticed that there were slipped one typo to earlier version of
this patch. (+#defome CHECK_BIT(... --> #define CHECK_BIT)
Attached is the newer version.

Mika



--------------040608000804020605020008
Content-Type: text/plain;
	name="0004-omap-alsa-tsc2101-mixer-merge-similar-looking-methods-together.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="0004-omap-alsa-tsc2101-mixer-merge-similar-looking-methods-together.txt"

>From nobody Mon Sep 17 00:00:00 2001
From: lamikr <lamikr@cc.jyu.fi)>
Date: Fri Mar 31 01:25:31 2006 +0300
Subject: [PATCH 4/5] omap-alsa-tsc2101-mixer: merge similar looking methods together.

Signed-off-by: lamikr <lamikr@cc.jyu.fi>


---

 sound/arm/omap/omap-alsa-tsc2101-mixer.c |  127 +++++++++++++++---------------
 1 files changed, 62 insertions(+), 65 deletions(-)

a3c51ca5f7606601bf1332d07130de27ba9ffc9a
diff --git a/sound/arm/omap/omap-alsa-tsc2101-mixer.c b/sound/arm/omap/omap-alsa-tsc2101-mixer.c
index 3d99984..5c9b0ba 100644
--- a/sound/arm/omap/omap-alsa-tsc2101-mixer.c
+++ b/sound/arm/omap/omap-alsa-tsc2101-mixer.c
@@ -50,20 +50,15 @@
 //#define M_DPRINTK(ARGS...)  printk(KERN_INFO "<%s>: ",__FUNCTION__);printk(ARGS)
 #define M_DPRINTK(ARGS...)  		/* nop */
 
+#define CHECK_BIT(INDX, ARG) (((ARG) & TSC2101_BIT(INDX)) >> INDX)
+#define IS_UNMUTED(INDX, ARG) (((CHECK_BIT(INDX, ARG)) == 0))
+
 #define DGC_DALVL_EXTRACT(ARG) ((ARG & 0x7f00) >> 8)
 #define DGC_DARVL_EXTRACT(ARG) ((ARG & 0x007f))
-#define GET_DGC_DALMU_BIT_VALUE(ARG)  (((ARG) & TSC2101_BIT(15)) >> 15)
-#define GET_DGC_DARMU_BIT_VALUE(ARG)  (((ARG) & TSC2101_BIT(7)) >> 7)
-#define IS_DGC_DALMU_UNMUTED(ARG)  (((GET_DGC_DALMU_BIT_VALUE(ARG)) == 0))
-#define IS_DGC_DARMU_UNMUTED(ARG) (((GET_DGC_DARMU_BIT_VALUE(ARG)) == 0))
 
 #define HGC_ADPGA_HED_EXTRACT(ARG) ((ARG & 0x7f00) >> 8)
-#define GET_DGC_HGCMU_BIT_VALUE(ARG) (((ARG) & TSC2101_BIT(15)) >> 15)
-#define IS_DGC_HGCMU_UNMUTED(ARG) (((GET_DGC_HGCMU_BIT_VALUE(ARG)) == 0))
-
 #define HNGC_ADPGA_HND_EXTRACT(ARG) ((ARG & 0x7f00) >> 8)
-#define GET_DGC_HNGCMU_BIT_VALUE(ARG) (((ARG) & TSC2101_BIT(15)) >> 15)
-#define IS_DGC_HNGCMU_UNMUTED(ARG) (((GET_DGC_HNGCMU_BIT_VALUE(ARG)) == 0))
+#define BGC_ADPGA_BGC_EXTRACT(ARG) ((ARG & 0x7f00) >> 8)
 
 static int current_playback_target	= PLAYBACK_TARGET_LOUDSPEAKER;
 static int current_rec_src 		= REC_SRC_SINGLE_ENDED_MICIN_HED;
@@ -171,7 +166,11 @@ int set_mixer_volume_as_dac_gain_control
 	return retVal;
 }
 
-int dac_gain_control_unmute_control(int muteLeft, int muteRight)
+/**
+ * If unmuteLeft/unmuteRight == 0  --> mute
+ * If unmuteLeft/unmuteRight == 1 --> unmute
+ */
+int dac_gain_control_unmute(int unmuteLeft, int unmuteRight)
 {
 	u16 val;
 	int count;
@@ -181,8 +180,8 @@ int dac_gain_control_unmute_control(int 
 	/* in alsa mixer 1 --> on, 0 == off. In tsc2101 registry 1 --> off, 0 --> on
 	 * so if values are same, it's time to change the registry value.
 	 */
-	if (muteLeft == GET_DGC_DALMU_BIT_VALUE(val)) {
-		if (muteLeft == 0) {
+	if (unmuteLeft != IS_UNMUTED(15, val)) {
+		if (unmuteLeft == 0) {
 			/* mute --> turn bit on */
 			val	= val | DGC_DALMU;
 		}
@@ -192,8 +191,8 @@ int dac_gain_control_unmute_control(int 
 		}
 		count++;
 	} /* L */
-	if (muteRight == GET_DGC_DARMU_BIT_VALUE(val)) {
-		if (muteRight == 0) {
+	if (unmuteRight != IS_UNMUTED(7, val)) {
+		if (unmuteRight == 0) {
 			/* mute --> turn bit on */
 			val	= val | DGC_DARMU;
 		}
@@ -206,12 +205,45 @@ int dac_gain_control_unmute_control(int 
 	if (count) {
 		omap_tsc2101_audio_write(TSC2101_DAC_GAIN_CTRL, val);
 		M_DPRINTK("changed value, is_unmuted left = %d, right = %d\n", 
-			IS_DGC_DALMU_UNMUTED(val),
-			IS_DGC_DARMU_UNMUTED(val));
+			IS_UNMUTED(15, val),
+			IS_UNMUTED(7, val));
 	}
 	return count;	
 }
 
+/**
+ * unmute: 0 --> mute, 1 --> unmute
+ * page2RegIndx: Registry index in tsc2101 page2.
+ * muteBitIndx: Index number for the bit in registry that indicates whether muted or unmuted.
+ */
+int adc_pga_unmute_control(int unmute, int page2regIndx, int muteBitIndx)
+{
+	int count;
+	u16 val;
+	
+	count	= 0;
+	val 	= omap_tsc2101_audio_read(page2regIndx);
+	/* in alsa mixer 1 --> on, 0 == off. In tsc2101 registry 1 --> off, 0 --> on
+	 * so if the values are same, it's time to change the registry value...
+	 */
+	if (unmute != IS_UNMUTED(muteBitIndx, val)) {
+		if (unmute == 0) {
+			/* mute --> turn bit on */
+			val	= val | TSC2101_BIT(muteBitIndx);
+		}
+		else {
+			/* unmute --> turn bit off */
+			val	= val & ~TSC2101_BIT(muteBitIndx);
+		}
+		M_DPRINTK("changed value, is_unmuted = %d\n", IS_UNMUTED(muteBitIndx, val));
+		count++;
+	}
+	if (count) {
+		omap_tsc2101_audio_write(page2regIndx, val);
+	}
+	return count;
+}
+
 /*
  * Converts the DGC registry value read from the TSC2101 registry to 
  * Alsa mixer volume format (0 - 100).
@@ -442,7 +474,7 @@ void init_playback_targets(void)
 	 */
 	set_mixer_volume_as_dac_gain_control_volume(DEFAULT_OUTPUT_VOLUME, DEFAULT_OUTPUT_VOLUME);	
 	/* unmute */
-	dac_gain_control_unmute_control(1, 1);
+	dac_gain_control_unmute(1, 1);
 }
 
 /*
@@ -568,14 +600,14 @@ static int __pcm_playback_switch_get(snd
 {
 	u16 val	= omap_tsc2101_audio_read(TSC2101_DAC_GAIN_CTRL);
 	
-	ucontrol->value.integer.value[0]	= IS_DGC_DALMU_UNMUTED(val);
-	ucontrol->value.integer.value[1]	= IS_DGC_DARMU_UNMUTED(val);
+	ucontrol->value.integer.value[0]	= IS_UNMUTED(15, val);	// left
+	ucontrol->value.integer.value[1]	= IS_UNMUTED(7, val);	// right
 	return 0;
 }
 
 static int __pcm_playback_switch_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol) 
 {
-	return dac_gain_control_unmute_control(ucontrol->value.integer.value[0], 
+	return dac_gain_control_unmute(ucontrol->value.integer.value[0], 
 					ucontrol->value.integer.value[1]);
 }
 
@@ -625,33 +657,16 @@ static int __headset_playback_switch_inf
 static int __headset_playback_switch_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol) 
 {
 	u16 val = omap_tsc2101_audio_read(TSC2101_HEADSET_GAIN_CTRL);
-	ucontrol->value.integer.value[0]	= IS_DGC_HGCMU_UNMUTED(val);
+	ucontrol->value.integer.value[0]	= IS_UNMUTED(15, val);
 	return 0;
 }
 
 static int __headset_playback_switch_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol) 
 {
-	int count = 0;
-	u16 val = omap_tsc2101_audio_read(TSC2101_HEADSET_GAIN_CTRL);
-	/* in alsa mixer 1 --> on, 0 == off. In tsc2101 registry 1 --> off, 0 --> on
-	 * so if values are same, it's time to change the registry value...
-	 */
-	if (ucontrol->value.integer.value[0] == GET_DGC_HGCMU_BIT_VALUE(val)) {
-		if (ucontrol->value.integer.value[0] == 0) {
-			/* mute --> turn bit on */
-			val	= val | HGC_ADMUT_HED;
-		}
-		else {
-			/* unmute --> turn bit off */
-			val	= val & ~HGC_ADMUT_HED;
-		}
-		count++;
-		M_DPRINTK("changed value, is_unmuted = %d\n", IS_DGC_HGCMU_UNMUTED(val));
-	}
-	if (count) {
-		omap_tsc2101_audio_write(TSC2101_HEADSET_GAIN_CTRL, val);
-	}
-	return count;
+	// mute/unmute headset
+	return adc_pga_unmute_control(ucontrol->value.integer.value[0],
+				TSC2101_HEADSET_GAIN_CTRL,
+				15);
 }
 
 static int __handset_playback_volume_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo) 
@@ -699,34 +714,16 @@ static int __handset_playback_switch_inf
 static int __handset_playback_switch_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol) 
 {
 	u16 val = omap_tsc2101_audio_read(TSC2101_HANDSET_GAIN_CTRL);
-	ucontrol->value.integer.value[0]	= IS_DGC_HNGCMU_UNMUTED(val);
+	ucontrol->value.integer.value[0]	= IS_UNMUTED(15, val);
 	return 0;
 }
 
 static int __handset_playback_switch_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol) 
 {
-	int count = 0;
-	u16 val = omap_tsc2101_audio_read(TSC2101_HANDSET_GAIN_CTRL);
-	
-	/* in alsa mixer 1 --> on, 0 == off. In tsc2101 registry 1 --> off, 0 --> on
-	 * so if values are same, it's time to change the registry value...
-	 */
-	if (ucontrol->value.integer.value[0] == GET_DGC_HNGCMU_BIT_VALUE(val)) {
-		if (ucontrol->value.integer.value[0] == 0) {
-			/* mute --> turn bit on */
-			val	= val | HNGC_ADMUT_HND;
-		}
-		else {
-			/* unmute --> turn bit off */
-			val	= val & ~HNGC_ADMUT_HND;
-		}
-		M_DPRINTK("changed value, is_unmuted = %d\n", IS_DGC_HNGCMU_UNMUTED(val));
-		count++;
-	}
-	if (count) {
-		omap_tsc2101_audio_write(TSC2101_HANDSET_GAIN_CTRL, val);
-	}
-	return count;
+	// handset mute/unmute
+	return adc_pga_unmute_control(ucontrol->value.integer.value[0],
+				TSC2101_HANDSET_GAIN_CTRL,
+				15);
 }
 
 static snd_kcontrol_new_t tsc2101_control[] __devinitdata = {
-- 
1.2.2


--------------040608000804020605020008
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------040608000804020605020008--

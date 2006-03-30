From: lamikr <lamikr@cc.jyu.fi>
Subject: [PATCH 2/5] omap-alsa-tsc2101-mixer: inline functions for registry
 read and write.
Date: Fri, 31 Mar 2006 01:55:11 +0300
Message-ID: <442C61CF.2050606@cc.jyu.fi>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040309020403030509090609"
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
--------------040309020403030509090609
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit



--------------040309020403030509090609
Content-Type: text/plain;
	name="0002-omap-alsa-tsc2101-mixer-inline-functions-for-registry-read-and-write.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="0002-omap-alsa-tsc2101-mixer-inline-functions-for-registry-read-and-write.txt"

>From nobody Mon Sep 17 00:00:00 2001
From: lamikr <lamikr@cc.jyu.fi)>
Date: Fri Mar 31 01:18:52 2006 +0300
Subject: [PATCH 2/5] omap-alsa-tsc2101-mixer: inline functions for registry read and write.

Signed-off-by: lamikr <lamikr@cc.jyu.fi>


---

 sound/arm/omap/omap-alsa-tsc2101-mixer.c |  124 ++++++++++++------------------
 1 files changed, 51 insertions(+), 73 deletions(-)

597d7464c2a6048dc61d8f1724ff52a60a9ce06c
diff --git a/sound/arm/omap/omap-alsa-tsc2101-mixer.c b/sound/arm/omap/omap-alsa-tsc2101-mixer.c
index 9dfaea8..1b7b968 100644
--- a/sound/arm/omap/omap-alsa-tsc2101-mixer.c
+++ b/sound/arm/omap/omap-alsa-tsc2101-mixer.c
@@ -68,6 +68,22 @@
 static int current_playback_target	= PLAYBACK_TARGET_LOUDSPEAKER;
 static int current_rec_src 		= REC_SRC_SINGLE_ENDED_MICIN_HED;
 
+/* 
+ * Simplified write for the tsc2101 audio registers.
+ */
+inline void omap_tsc2101_audio_write(u8 address, u16 data)
+{
+	omap_tsc2101_write(PAGE2_AUDIO_CODEC_REGISTERS, address, data);
+}
+
+/* 
+ * Simplified read for the tsc2101 audio registers.
+ */
+inline u16 omap_tsc2101_audio_read(u8 address)
+{
+	return (omap_tsc2101_read(PAGE2_AUDIO_CODEC_REGISTERS, address));
+}
+
 /*
  * Used for switching between TSC2101 recourd sources.
  * Logic is adjusted from the TSC2101 OSS code.
@@ -80,13 +96,10 @@ static int set_record_source(int val)
 	FN_IN;
 	maskedVal	= 0xe0 & val;	
 
-	data	= omap_tsc2101_read(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, 
-				TSC2101_MIXER_PGA_CTRL);
+	data	= omap_tsc2101_audio_read(TSC2101_MIXER_PGA_CTRL);
 	data	&= ~MPC_MICSEL(7); /* clear all MICSEL bits */
 	data	|= maskedVal;
-	omap_tsc2101_write(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2,
-				TSC2101_MIXER_PGA_CTRL,
-				data);
+	omap_tsc2101_audio_write(TSC2101_MIXER_PGA_CTRL, data);
 	current_rec_src	= val;
 
 	FN_OUT(0);
@@ -147,15 +160,13 @@ int set_mixer_volume_as_dac_gain_control
 	volL	= get_mixer_volume_as_dac_gain_control_volume(mixerVolL);
 	volR	= get_mixer_volume_as_dac_gain_control_volume(mixerVolR);
 	
-	val	= omap_tsc2101_read(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, TSC2101_DAC_GAIN_CTRL);
+	val	= omap_tsc2101_audio_read(TSC2101_DAC_GAIN_CTRL);
 	/* keep the old mute bit settings */
 	val	&= ~(DGC_DALVL(OUTPUT_VOLUME_MIN) | DGC_DARVL(OUTPUT_VOLUME_MIN));
 	val	|= DGC_DALVL(volL) | DGC_DARVL(volR);
 	retVal	= 2;
 	if (retVal) {
-		omap_tsc2101_write(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, 
-				TSC2101_DAC_GAIN_CTRL, 
-				val);
+		omap_tsc2101_audio_write(TSC2101_DAC_GAIN_CTRL, val);
 	}
 	M_DPRINTK("to registry: left = %d, right = %d, total = %d\n", DGC_DALVL_EXTRACT(val), DGC_DARVL_EXTRACT(val), val);
 	return retVal;
@@ -167,7 +178,7 @@ int dac_gain_control_unmute_control(int 
 	int count;
 
 	count	= 0;
-	val	= omap_tsc2101_read(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, TSC2101_DAC_GAIN_CTRL);
+	val	= omap_tsc2101_audio_read(TSC2101_DAC_GAIN_CTRL);
 	/* in alsa mixer 1 --> on, 0 == off. In tsc2101 registry 1 --> off, 0 --> on
 	 * so if values are same, it's time to change the registry value.
 	 */
@@ -194,7 +205,7 @@ int dac_gain_control_unmute_control(int 
 		count++;
 	} /* R */
 	if (count) {
-		omap_tsc2101_write(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, TSC2101_DAC_GAIN_CTRL, val);
+		omap_tsc2101_audio_write(TSC2101_DAC_GAIN_CTRL, val);
 		M_DPRINTK("changed value, is_unmuted left = %d, right = %d\n", 
 			IS_DGC_DALMU_UNMUTED(val),
 			IS_DGC_DARMU_UNMUTED(val));
@@ -271,14 +282,11 @@ int set_mixer_volume_as_headset_gain_con
 	/* Convert 0 -> 100 volume to 0x0(min) -> 0x7D(max) volume range */
 	/* NOTE: 0 is minimum volume and not mute */
 	volume	= get_mixer_volume_as_headset_gain_control_volume(mixerVol);	
-	val	= omap_tsc2101_read(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, 
-				TSC2101_HEADSET_GAIN_CTRL);
+	val	= omap_tsc2101_audio_read(TSC2101_HEADSET_GAIN_CTRL);
 	/* preserve the old mute settings */
 	val	&= ~(HGC_ADPGA_HED(INPUT_VOLUME_MAX));
 	val	|= HGC_ADPGA_HED(volume);
-	omap_tsc2101_write(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, 
-			TSC2101_HEADSET_GAIN_CTRL,
-			val);	
+	omap_tsc2101_audio_write(TSC2101_HEADSET_GAIN_CTRL, val);	
 	retVal	= 1;
 	
 	M_DPRINTK("to registry = %d\n", val);	
@@ -305,13 +313,11 @@ int set_mixer_volume_as_handset_gain_con
 	 * NOTE: 0 is minimum volume and not mute 
 	 */
 	volume	= get_mixer_volume_as_headset_gain_control_volume(mixerVol);
-	val	= omap_tsc2101_read(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, TSC2101_HANDSET_GAIN_CTRL);
+	val	= omap_tsc2101_audio_read(TSC2101_HANDSET_GAIN_CTRL);
 	/* preserve the old mute settigns */
 	val	&= ~(HNGC_ADPGA_HND(INPUT_VOLUME_MAX));
 	val	|= HNGC_ADPGA_HND(volume);
-	omap_tsc2101_write(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, 
-			TSC2101_HANDSET_GAIN_CTRL,
-			val);
+	omap_tsc2101_audio_write(TSC2101_HANDSET_GAIN_CTRL, val);
 	retVal	= 1;
 	
 	M_DPRINTK("to registry = %d\n", val);	
@@ -325,8 +331,7 @@ void init_record_sources(void)
 	 * Cell Phone In not connected to ADC
 	 * Input selected by MICSEL connected to ADC
 	 */
-	omap_tsc2101_write(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, 
-			  TSC2101_MIXER_PGA_CTRL,
+	omap_tsc2101_audio_write(TSC2101_MIXER_PGA_CTRL,
 			  MPC_ASTMU | MPC_ASTG(0x40) | ~MPC_CPADC | MPC_MICADC);
 	/* Set record source, Select MIC_INHED input for headset */
 	set_record_source(REC_SRC_SINGLE_ENDED_MICIN_HED);	
@@ -337,16 +342,13 @@ void set_loudspeaker_to_playback_target(
 	u16	val;
 
 	/* power down sp1, sp2 and loudspeaker */
-	omap_tsc2101_write(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2,
-			TSC2101_CODEC_POWER_CTRL,
+	omap_tsc2101_audio_write(TSC2101_CODEC_POWER_CTRL,
 			CPC_SP1PWDN | CPC_SP2PWDN | CPC_LDAPWDF);	
 	/* ADC, DAC, Analog Sidetone, cellphone, buzzer softstepping enabled
 	 * 1dB AGC hysteresis
 	 * MICes bias 2V
 	 */
-	omap_tsc2101_write(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, 
-			TSC2101_AUDIO_CTRL_4, 
-			AC4_MB_HED(0));
+	omap_tsc2101_audio_write(TSC2101_AUDIO_CTRL_4, AC4_MB_HED(0));
 
 	/* DAC left and right routed to SPK1/SPK2
 	 * SPK1/SPK2 unmuted
@@ -357,17 +359,12 @@ void set_loudspeaker_to_playback_target(
 			AC5_DAC2SPK2(3) | AC5_AST2SPK2 | AC5_KCL2SPK2 |
 			AC5_HDSCPTC;
 	val	= val & ~AC5_HDSCPTC;
-	omap_tsc2101_write(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2,
-			TSC2101_AUDIO_CTRL_5,
-			val);
+	omap_tsc2101_audio_write(TSC2101_AUDIO_CTRL_5, val);
 	
 	/* powerdown spk1/out32n and spk2 */
-	val	= omap_tsc2101_read(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2,
-				TSC2101_POWERDOWN_STS);
+	val	= omap_tsc2101_audio_read(TSC2101_POWERDOWN_STS);
 	val	= val & ~(~PS_SPK1FL | ~PS_HNDFL | PS_LSPKFL);
-	omap_tsc2101_write(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2,
-			TSC2101_POWERDOWN_STS,
-			val);
+	omap_tsc2101_audio_write(TSC2101_POWERDOWN_STS,	val);
 
 	/* routing selected to SPK1 goes to OUT8P/OUT84 alsa. (loudspeaker)
 	 * analog sidetone routed to loudspeaker
@@ -381,8 +378,7 @@ void set_loudspeaker_to_playback_target(
 	 * Enable loudspeaker short protection control (0 = enable protection)
 	 * VGND short protection control (0 = enable protection)
 	 */
-	omap_tsc2101_write(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2,
-			TSC2101_AUDIO_CTRL_6,
+	omap_tsc2101_audio_write(TSC2101_AUDIO_CTRL_6,
 			AC6_SPL2LSK | AC6_AST2LSK | AC6_BUZ2LSK | AC6_KCL2LSK |
 			AC6_CPI2LSK | AC6_MIC2CPO | AC6_SPL2CPO |
 			~AC6_MUTLSPK | ~AC6_MUTSPK2 | ~AC6_LDSCPTC | ~AC6_VGNDSCPTC);
@@ -392,27 +388,22 @@ void set_loudspeaker_to_playback_target(
 void set_headphone_to_playback_target(void)
 {
 	/* power down sp1, sp2 and loudspeaker */
-	omap_tsc2101_write(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2,
-			TSC2101_CODEC_POWER_CTRL,
+	omap_tsc2101_audio_write(TSC2101_CODEC_POWER_CTRL,
 			CPC_SP1PWDN | CPC_SP2PWDN | CPC_LDAPWDF);
 	/* ADC, DAC, Analog Sidetone, cellphone, buzzer softstepping enabled */
 	/* 1dB AGC hysteresis */
 	/* MICes bias 2V */
-	omap_tsc2101_write(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2,
-				TSC2101_AUDIO_CTRL_4, 
-				AC4_MB_HED(0));
+	omap_tsc2101_audio_write(TSC2101_AUDIO_CTRL_4, AC4_MB_HED(0));
 
 	/* DAC left and right routed to SPK2 */
 	/* SPK1/2 unmuted */
-	omap_tsc2101_write(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2,
-			TSC2101_AUDIO_CTRL_5,
+	omap_tsc2101_audio_write(TSC2101_AUDIO_CTRL_5,
 			AC5_DAC2SPK1(3) | AC5_AST2SPK1 | AC5_KCL2SPK1 |
 			AC5_DAC2SPK2(3) | AC5_AST2SPK2 | AC5_KCL2SPK2 |
 			AC5_HDSCPTC);
 
 	/* OUT8P/N muted, CPOUT muted */
-	omap_tsc2101_write(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2,
-			TSC2101_AUDIO_CTRL_6,
+	omap_tsc2101_audio_write(TSC2101_AUDIO_CTRL_6,
 			AC6_MUTLSPK | AC6_MUTSPK2 | AC6_LDSCPTC |
 			AC6_VGNDSCPTC);
 	current_playback_target	= PLAYBACK_TARGET_HEADPHONE;
@@ -433,8 +424,7 @@ u16 get_headset_detected(void)
 	u16	curVal;
 	
 	curType	= 0;	/* not detected */
-	curVal	= omap_tsc2101_read(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, 
-					TSC2101_AUDIO_CTRL_7);
+	curVal	= omap_tsc2101_audio_read(TSC2101_AUDIO_CTRL_7);
 	curDetected	= curVal & AC7_HDDETFL;
 	if (curDetected) {
 		printk("headset detected, checking type from %d \n", curVal);
@@ -461,13 +451,10 @@ void init_playback_targets(void)
 	 * AGC enable for handset input
 	 * Handset input not muted
 	 */
-	val	= omap_tsc2101_read(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, 
-				TSC2101_HANDSET_GAIN_CTRL);
+	val	= omap_tsc2101_audio_read(TSC2101_HANDSET_GAIN_CTRL);
 	val	= val | HNGC_AGCEN_HND;	
 	val	= val & ~HNGC_ADMUT_HND;
-	omap_tsc2101_write(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, 
-			TSC2101_HANDSET_GAIN_CTRL,
-			val);	
+	omap_tsc2101_audio_write(TSC2101_HANDSET_GAIN_CTRL, val);	
 			
 	/* mic input volume control
 	 * SET_MIC in the OSS driver 
@@ -490,9 +477,7 @@ void snd_omap_init_mixer(void)
 	FN_IN;
 	
 	/* Headset/Hook switch detect enabled */
-	omap_tsc2101_write(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2,
-			TSC2101_AUDIO_CTRL_7,
-			AC7_DETECT);
+	omap_tsc2101_audio_write(TSC2101_AUDIO_CTRL_7, AC7_DETECT);
 
 	init_record_sources();
 	init_playback_targets();
@@ -563,7 +548,7 @@ static int __pcm_playback_volume_get(snd
 	u16 volR;	
 	u16 val;
 	
-	val	= omap_tsc2101_read(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, TSC2101_DAC_GAIN_CTRL);
+	val	= omap_tsc2101_audio_read(TSC2101_DAC_GAIN_CTRL);
 	M_DPRINTK("registry value = %d!\n", val);
 	volL	= DGC_DALVL_EXTRACT(val);
 	volR	= DGC_DARVL_EXTRACT(val);
@@ -603,7 +588,7 @@ static int __pcm_playback_switch_info(sn
  */
 static int __pcm_playback_switch_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol) 
 {
-	u16 val	= omap_tsc2101_read(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, TSC2101_DAC_GAIN_CTRL);
+	u16 val	= omap_tsc2101_audio_read(TSC2101_DAC_GAIN_CTRL);
 	
 	ucontrol->value.integer.value[0]	= IS_DGC_DALMU_UNMUTED(val);
 	ucontrol->value.integer.value[1]	= IS_DGC_DARMU_UNMUTED(val);
@@ -630,8 +615,7 @@ static int __headset_playback_volume_get
 	u16 val;
 	u16 vol;
 	
-	val	= omap_tsc2101_read(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, 
-				TSC2101_HEADSET_GAIN_CTRL);
+	val	= omap_tsc2101_audio_read(TSC2101_HEADSET_GAIN_CTRL);
 	M_DPRINTK("registry value = %d\n", val);
 	vol	= HGC_ADPGA_HED_EXTRACT(val);
 	vol	= vol & ~HGC_ADMUT_HED;
@@ -662,8 +646,7 @@ static int __headset_playback_switch_inf
  */
 static int __headset_playback_switch_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol) 
 {
-	u16 val = omap_tsc2101_read(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, 
-				TSC2101_HEADSET_GAIN_CTRL);
+	u16 val = omap_tsc2101_audio_read(TSC2101_HEADSET_GAIN_CTRL);
 	ucontrol->value.integer.value[0]	= IS_DGC_HGCMU_UNMUTED(val);
 	return 0;
 }
@@ -671,8 +654,7 @@ static int __headset_playback_switch_get
 static int __headset_playback_switch_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol) 
 {
 	int count = 0;
-	u16 val = omap_tsc2101_read(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, 
-				TSC2101_HEADSET_GAIN_CTRL);
+	u16 val = omap_tsc2101_audio_read(TSC2101_HEADSET_GAIN_CTRL);
 	/* in alsa mixer 1 --> on, 0 == off. In tsc2101 registry 1 --> off, 0 --> on
 	 * so if values are same, it's time to change the registry value...
 	 */
@@ -689,9 +671,7 @@ static int __headset_playback_switch_put
 		M_DPRINTK("changed value, is_unmuted = %d\n", IS_DGC_HGCMU_UNMUTED(val));
 	}
 	if (count) {
-		omap_tsc2101_write(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, 
-				TSC2101_HEADSET_GAIN_CTRL, 
-				val);
+		omap_tsc2101_audio_write(TSC2101_HEADSET_GAIN_CTRL, val);
 	}
 	return count;
 }
@@ -710,7 +690,7 @@ static int __handset_playback_volume_get
 	u16 val;
 	u16 vol;
 	
-	val	= omap_tsc2101_read(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, TSC2101_HANDSET_GAIN_CTRL);
+	val	= omap_tsc2101_audio_read(TSC2101_HANDSET_GAIN_CTRL);
 	M_DPRINTK("registry value = %d\n", val);
 	vol	= HNGC_ADPGA_HND_EXTRACT(val);
 	vol	= vol & ~HNGC_ADMUT_HND;
@@ -740,7 +720,7 @@ static int __handset_playback_switch_inf
  */
 static int __handset_playback_switch_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol) 
 {
-	u16 val = omap_tsc2101_read(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, TSC2101_HANDSET_GAIN_CTRL);
+	u16 val = omap_tsc2101_audio_read(TSC2101_HANDSET_GAIN_CTRL);
 	ucontrol->value.integer.value[0]	= IS_DGC_HNGCMU_UNMUTED(val);
 	return 0;
 }
@@ -748,7 +728,7 @@ static int __handset_playback_switch_get
 static int __handset_playback_switch_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol) 
 {
 	int count = 0;
-	u16 val = omap_tsc2101_read(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, TSC2101_HANDSET_GAIN_CTRL);
+	u16 val = omap_tsc2101_audio_read(TSC2101_HANDSET_GAIN_CTRL);
 	
 	/* in alsa mixer 1 --> on, 0 == off. In tsc2101 registry 1 --> off, 0 --> on
 	 * so if values are same, it's time to change the registry value...
@@ -766,9 +746,7 @@ static int __handset_playback_switch_put
 		count++;
 	}
 	if (count) {
-		omap_tsc2101_write(TSC2101_AUDIO_CODEC_REGISTERS_PAGE2, 
-				TSC2101_HANDSET_GAIN_CTRL, 
-				val);
+		omap_tsc2101_audio_write(TSC2101_HANDSET_GAIN_CTRL, val);
 	}
 	return count;
 }
-- 
1.2.2


--------------040309020403030509090609
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------040309020403030509090609--

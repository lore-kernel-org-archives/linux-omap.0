From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 12/19] Code clean-up for sound/arm/omap/omap-alsa-tsc2101-mixer.c
Date: Tue, 15 Apr 2008 10:02:16 -0400
Message-ID: <1208268143-8789-13-git-send-email-edubezval@gmail.com>
References: <1208268143-8789-1-git-send-email-edubezval@gmail.com>
 <1208268143-8789-2-git-send-email-edubezval@gmail.com>
 <1208268143-8789-3-git-send-email-edubezval@gmail.com>
 <1208268143-8789-4-git-send-email-edubezval@gmail.com>
 <1208268143-8789-5-git-send-email-edubezval@gmail.com>
 <1208268143-8789-6-git-send-email-edubezval@gmail.com>
 <1208268143-8789-7-git-send-email-edubezval@gmail.com>
 <1208268143-8789-8-git-send-email-edubezval@gmail.com>
 <1208268143-8789-9-git-send-email-edubezval@gmail.com>
 <1208268143-8789-10-git-send-email-edubezval@gmail.com>
 <1208268143-8789-11-git-send-email-edubezval@gmail.com>
 <1208268143-8789-12-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:40422 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762251AbYDOOCk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Apr 2008 10:02:40 -0400
Received: from esebh108.NOE.Nokia.com (esebh108.ntc.nokia.com [172.21.143.145])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3FE28Mr008266
	for <linux-omap@vger.kernel.org>; Tue, 15 Apr 2008 17:02:37 +0300
In-Reply-To: <1208268143-8789-12-git-send-email-edubezval@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Eduardo Valentin <eduardo.valentin@indt.org.br>

=46rom: Eduardo Valentin <eduardo.valentin@indt.org.br>

Removed lots of whitespaces and a few errors and
warnings reported by checkpatch.pl.

Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
---
 sound/arm/omap/omap-alsa-tsc2101-mixer.c |  624 ++++++++++++++++------=
--------
 1 files changed, 342 insertions(+), 282 deletions(-)

diff --git a/sound/arm/omap/omap-alsa-tsc2101-mixer.c b/sound/arm/omap/=
omap-alsa-tsc2101-mixer.c
index 09257d7..d443342 100644
--- a/sound/arm/omap/omap-alsa-tsc2101-mixer.c
+++ b/sound/arm/omap/omap-alsa-tsc2101-mixer.c
@@ -1,15 +1,15 @@
 /*
  * sound/arm/omap/omap-alsa-tsc2101-mixer.c
- *=20
+ *
  * Alsa Driver for TSC2101 codec for OMAP platform boards.
  *
- * Copyright (C) 2005 Mika Laitio <lamikr@cc.jyu.fi> and=20
+ * Copyright (C) 2005 Mika Laitio <lamikr@cc.jyu.fi> and
  * 		     Everett Coleman II <gcc80x86@fuzzyneural.net>
  *
  * Board initialization code is based on the code in TSC2101 OSS drive=
r.
  * Copyright (C) 2004 Texas Instruments, Inc.
  * 	Written by Nishanth Menon and Sriram Kannan
- *=20
+ *
  * This program is free software; you can redistribute it and/or modif=
y it
  * under the terms of the GNU General Public License as published by t=
he
  * Free Software Foundation; either version 2 of the License, or (at y=
our
@@ -33,13 +33,13 @@
  * History:
  *
  * 2006-03-01   Mika Laitio - Mixer for the tsc2101 driver used in oma=
p boards.
- * 		Can switch between headset and loudspeaker playback,=20
+ * 		Can switch between headset and loudspeaker playback,
  * 		mute and unmute dgc, set dgc volume. Record source switch,
- * 		keyclick, buzzer and headset volume and handset volume control=20
+ * 		keyclick, buzzer and headset volume and handset volume control
  * 		are still missing.
- * 	=09
+ *
  */
-=20
+
 #include "omap-alsa-tsc2101.h"
 #include "omap-alsa-tsc2101-mixer.h"
=20
@@ -48,8 +48,15 @@
 #include <sound/initval.h>
 #include <sound/control.h>
=20
-//#define M_DPRINTK(ARGS...)  printk(KERN_INFO "<%s>: ",__FUNCTION__);=
printk(ARGS)
+#ifdef DEBUG
+#define M_DPRINTK(ARGS...)				\
+	do {						\
+		printk(KERN_INFO "<%s>: ", __func__);	\
+		printk(ARGS);				\
+	} while (0)
+#else
 #define M_DPRINTK(ARGS...)  		/* nop */
+#endif
=20
 #define CHECK_BIT(INDX, ARG) (((ARG) & TSC2101_BIT(INDX)) >> INDX)
 #define IS_UNMUTED(INDX, ARG) (((CHECK_BIT(INDX, ARG)) =3D=3D 0))
@@ -64,7 +71,7 @@
 static int current_playback_target	=3D PLAYBACK_TARGET_LOUDSPEAKER;
 static int current_rec_src 		=3D REC_SRC_SINGLE_ENDED_MICIN_HED;
=20
-/*=20
+/*
  * Simplified write for the tsc2101 audio registers.
  */
 inline void omap_tsc2101_audio_write(u8 address, u16 data)
@@ -73,7 +80,7 @@ inline void omap_tsc2101_audio_write(u8 address, u16 =
data)
 				address, data);
 }
=20
-/*=20
+/*
  * Simplified read for the tsc2101 audio registers.
  */
 inline u16 omap_tsc2101_audio_read(u8 address)
@@ -88,8 +95,9 @@ inline u16 omap_tsc2101_audio_read(u8 address)
 static void set_record_source(int val)
 {
 	u16	data;
-=09
-	/* Mute Analog Sidetone
+
+	/*
+	 * Mute Analog Sidetone
 	 * Analog sidetone gain db?
 	 * Input selected by MICSEL connected to ADC
 	 */
@@ -98,77 +106,84 @@ static void set_record_source(int val)
 	data	|=3D MPC_MICSEL(val);
 	data	|=3D MPC_MICADC;
 	omap_tsc2101_audio_write(TSC2101_MIXER_PGA_CTRL, data);
-=09
+
 	current_rec_src	=3D val;
 }
=20
 /*
- * Converts the Alsa mixer volume (0 - 100) to real=20
+ * Converts the Alsa mixer volume (0 - 100) to real
  * Digital Gain Control (DGC) value that can be written
  * or read from the TSC2101 registry.
- *=20
+ *
  * Note that the number "OUTPUT_VOLUME_MAX" is smaller than OUTPUT_VOL=
UME_MIN
  * because DGC works as a volume decreaser. (The more bigger value is =
put
  * to DGC, the more the volume of controlled channel is decreased)
- *=20
- * In addition the TCS2101 chip would allow the maximum volume reducti=
on be 63.5 DB
+ *
+ * In addition the TCS2101 chip would allow the maximum
+ * volume reduction be 63.5 DB
  * but according to some tests user can not hear anything with this ch=
ip
  * when the volume is set to be less than 25 db.
- * Therefore this function will return a value that means 38.5 db (63.=
5 db - 25 db)=20
+ * Therefore this function will return a value
+ * that means 38.5 db (63.5 db - 25 db)
  * reduction in the channel volume, when mixer is set to 0.
- * For mixer value 100, this will return a value that means 0 db volum=
e reduction.
+ * For mixer value 100, this will return a value that means
+ * 0 db volume reduction.
  * ([mute_left_bit]0000000[mute_right_bit]0000000)
-*/
+ */
 int get_mixer_volume_as_dac_gain_control_volume(int vol)
 {
 	u16 retVal;
=20
 	/* Convert 0 -> 100 volume to 0x7F(min) -> y(max) volume range */
-	retVal	=3D ((vol * OUTPUT_VOLUME_RANGE) / 100) + OUTPUT_VOLUME_MAX;
+	retVal =3D ((vol * OUTPUT_VOLUME_RANGE) / 100) + OUTPUT_VOLUME_MAX;
 	/* invert the value for getting the proper range 0 min and 100 max */
-	retVal	=3D OUTPUT_VOLUME_MIN - retVal;
-=09
+	retVal =3D OUTPUT_VOLUME_MIN - retVal;
+
 	return retVal;
 }
=20
 /*
- * Converts the Alsa mixer volume (0 - 100) to TSC2101=20
+ * Converts the Alsa mixer volume (0 - 100) to TSC2101
  * Digital Gain Control (DGC) volume. Alsa mixer volume 0
  * is converted to value meaning the volume reduction of -38.5 db
  * and Alsa mixer volume 100 is converted to value meaning the
  * reduction of 0 db.
  */
-int set_mixer_volume_as_dac_gain_control_volume(int mixerVolL, int mix=
erVolR)=20
+int set_mixer_volume_as_dac_gain_control_volume(int mixerVolL, int mix=
erVolR)
 {
 	u16 val;
 	int retVal;
 	int volL;
 	int volR;
-=09
-	if ((mixerVolL < 0) ||=20
+
+	if ((mixerVolL < 0) ||
 	    (mixerVolL > 100) ||
 	    (mixerVolR < 0) ||
 	    (mixerVolR > 100)) {
-		printk(KERN_ERR "Trying a bad mixer volume as dac gain control volum=
e value, left (%d), right (%d)!\n", mixerVolL, mixerVolR);
+		printk(KERN_ERR "Trying a bad mixer volume as dac gain control"
+			" volume value, left (%d), right (%d)!\n", mixerVolL,
+			mixerVolR);
 		return -EPERM;
 	}
-	M_DPRINTK("mixer volume left =3D %d, right =3D %d\n", mixerVolL, mixe=
rVolR);=09
+	M_DPRINTK("mixer volume left =3D %d, right =3D %d\n", mixerVolL, mixe=
rVolR);
 	volL	=3D get_mixer_volume_as_dac_gain_control_volume(mixerVolL);
 	volR	=3D get_mixer_volume_as_dac_gain_control_volume(mixerVolR);
-=09
+
 	val	=3D omap_tsc2101_audio_read(TSC2101_DAC_GAIN_CTRL);
 	/* keep the old mute bit settings */
-	val	&=3D ~(DGC_DALVL(OUTPUT_VOLUME_MIN) | DGC_DARVL(OUTPUT_VOLUME_MIN=
));
+	val	&=3D ~(DGC_DALVL(OUTPUT_VOLUME_MIN) |
+			DGC_DARVL(OUTPUT_VOLUME_MIN));
 	val	|=3D DGC_DALVL(volL) | DGC_DARVL(volR);
 	retVal	=3D 2;
-	if (retVal) {
+	if (retVal)
 		omap_tsc2101_audio_write(TSC2101_DAC_GAIN_CTRL, val);
-	}
-	M_DPRINTK("to registry: left =3D %d, right =3D %d, total =3D %d\n", D=
GC_DALVL_EXTRACT(val), DGC_DARVL_EXTRACT(val), val);
+
+	M_DPRINTK("to registry: left =3D %d, right =3D %d, total =3D %d\n",
+			DGC_DALVL_EXTRACT(val), DGC_DARVL_EXTRACT(val), val);
 	return retVal;
 }
=20
-/**
+/*
  * If unmuteLeft/unmuteRight =3D=3D 0  --> mute
  * If unmuteLeft/unmuteRight =3D=3D 1 --> unmute
  */
@@ -179,15 +194,16 @@ int dac_gain_control_unmute(int unmuteLeft, int u=
nmuteRight)
=20
 	count	=3D 0;
 	val	=3D omap_tsc2101_audio_read(TSC2101_DAC_GAIN_CTRL);
-	/* in alsa mixer 1 --> on, 0 =3D=3D off. In tsc2101 registry 1 --> of=
f, 0 --> on
-	 * so if values are same, it's time to change the registry value.
+	/*
+	 * in alsa mixer 1 --> on, 0 =3D=3D off. In tsc2101 registry 1 --> of=
f,
+	 * 0 --> on so if values are same, it's time to change the registry
+	 * value.
 	 */
 	if (unmuteLeft !=3D IS_UNMUTED(15, val)) {
 		if (unmuteLeft =3D=3D 0) {
 			/* mute --> turn bit on */
 			val	=3D val | DGC_DALMU;
-		}
-		else {
+		} else {
 			/* unmute --> turn bit off */
 			val	=3D val & ~DGC_DALMU;
 		}
@@ -197,69 +213,71 @@ int dac_gain_control_unmute(int unmuteLeft, int u=
nmuteRight)
 		if (unmuteRight =3D=3D 0) {
 			/* mute --> turn bit on */
 			val	=3D val | DGC_DARMU;
-		}
-		else {
+		} else {
 			/* unmute --> turn bit off */
 			val	=3D val & ~DGC_DARMU;
-		}	=09
+		}
 		count++;
 	} /* R */
 	if (count) {
 		omap_tsc2101_audio_write(TSC2101_DAC_GAIN_CTRL, val);
-		M_DPRINTK("changed value, is_unmuted left =3D %d, right =3D %d\n",=20
+		M_DPRINTK("changed value, is_unmuted left =3D %d, right =3D %d\n",
 			IS_UNMUTED(15, val),
 			IS_UNMUTED(7, val));
 	}
-	return count;=09
+	return count;
 }
=20
-/**
+/*
  * unmute: 0 --> mute, 1 --> unmute
  * page2RegIndx: Registry index in tsc2101 page2.
- * muteBitIndx: Index number for the bit in registry that indicates wh=
ether muted or unmuted.
+ * muteBitIndx: Index number for the bit in registry that indicates wh=
ether
+ * muted or unmuted.
  */
 int adc_pga_unmute_control(int unmute, int page2regIndx, int muteBitIn=
dx)
 {
 	int count;
 	u16 val;
-=09
+
 	count	=3D 0;
 	val 	=3D omap_tsc2101_audio_read(page2regIndx);
-	/* in alsa mixer 1 --> on, 0 =3D=3D off. In tsc2101 registry 1 --> of=
f, 0 --> on
-	 * so if the values are same, it's time to change the registry value.=
=2E.
+	/*
+	 * in alsa mixer 1 --> on, 0 =3D=3D off. In tsc2101 registry 1 --> of=
f,
+	 * 0 --> on so if the values are same, it's time to change the
+	 * registry value...
 	 */
 	if (unmute !=3D IS_UNMUTED(muteBitIndx, val)) {
 		if (unmute =3D=3D 0) {
 			/* mute --> turn bit on */
 			val	=3D val | TSC2101_BIT(muteBitIndx);
-		}
-		else {
+		} else {
 			/* unmute --> turn bit off */
 			val	=3D val & ~TSC2101_BIT(muteBitIndx);
 		}
-		M_DPRINTK("changed value, is_unmuted =3D %d\n", IS_UNMUTED(muteBitIn=
dx, val));
+		M_DPRINTK("changed value, is_unmuted =3D %d\n",
+				IS_UNMUTED(muteBitIndx, val));
 		count++;
 	}
-	if (count) {
+	if (count)
 		omap_tsc2101_audio_write(page2regIndx, val);
-	}
+
 	return count;
 }
=20
 /*
- * Converts the DGC registry value read from the TSC2101 registry to=20
+ * Converts the DGC registry value read from the TSC2101 registry to
  * Alsa mixer volume format (0 - 100).
  */
-int get_dac_gain_control_volume_as_mixer_volume(u16 vol)=20
+int get_dac_gain_control_volume_as_mixer_volume(u16 vol)
 {
-	u16 retVal;=09
+	u16 retVal;
=20
 	retVal	=3D OUTPUT_VOLUME_MIN - vol;
 	retVal	=3D ((retVal - OUTPUT_VOLUME_MAX) * 100) / OUTPUT_VOLUME_RANGE=
;
 	/* fix scaling error */
-	if ((retVal > 0) && (retVal < 100)) {
+	if ((retVal > 0) && (retVal < 100))
 		retVal++;
-	}
+
 	return retVal;
 }
=20
@@ -267,10 +285,10 @@ int get_dac_gain_control_volume_as_mixer_volume(u=
16 vol)
  * Converts the headset gain control volume (0 - 63.5 db)
  * to Alsa mixer volume (0 - 100)
  */
-int get_headset_gain_control_volume_as_mixer_volume(u16 registerVal)=20
+int get_headset_gain_control_volume_as_mixer_volume(u16 registerVal)
 {
 	u16 retVal;
-=09
+
 	retVal	=3D ((registerVal * 100) / INPUT_VOLUME_RANGE);
 	return retVal;
 }
@@ -279,71 +297,78 @@ int get_headset_gain_control_volume_as_mixer_volu=
me(u16 registerVal)
  * Converts the handset gain control volume (0 - 63.5 db)
  * to Alsa mixer volume (0 - 100)
  */
-int get_handset_gain_control_volume_as_mixer_volume(u16 registerVal)=20
+int get_handset_gain_control_volume_as_mixer_volume(u16 registerVal)
 {
 	return get_headset_gain_control_volume_as_mixer_volume(registerVal);
 }
=20
 /*
- * Converts the Alsa mixer volume (0 - 100) to=20
+ * Converts the Alsa mixer volume (0 - 100) to
  * headset gain control volume (0 - 63.5 db)
  */
-int get_mixer_volume_as_headset_gain_control_volume(u16 mixerVal)=20
+int get_mixer_volume_as_headset_gain_control_volume(u16 mixerVal)
 {
 	u16 retVal;
-=09
-	retVal	=3D ((mixerVal * INPUT_VOLUME_RANGE) / 100) + INPUT_VOLUME_MIN=
;=09
+
+	retVal	=3D ((mixerVal * INPUT_VOLUME_RANGE) / 100) + INPUT_VOLUME_MIN=
;
 	return retVal;
 }
=20
 /*
  * Writes Alsa mixer volume (0 - 100) to TSC2101 headset volume regist=
ry in
  * a TSC2101 format. (0 - 63.5 db)
- * In TSC2101 OSS driver this functionality was controlled with "SET_L=
INE" parameter.
+ * In TSC2101 OSS driver this functionality was controlled with "SET_L=
INE"
+ * parameter.
  */
-int set_mixer_volume_as_headset_gain_control_volume(int mixerVol)=20
+int set_mixer_volume_as_headset_gain_control_volume(int mixerVol)
 {
 	int volume;
 	int retVal;
 	u16 val;
=20
 	if (mixerVol < 0 || mixerVol > 100) {
-		M_DPRINTK("Trying a bad headset mixer volume value(%d)!\n", mixerVol=
);
+		M_DPRINTK("Trying a bad headset mixer volume value(%d)!\n",
+				mixerVol);
 		return -EPERM;
 	}
 	M_DPRINTK("mixer volume =3D %d\n", mixerVol);
-	/* Convert 0 -> 100 volume to 0x0(min) -> 0x7D(max) volume range */
-	/* NOTE: 0 is minimum volume and not mute */
-	volume	=3D get_mixer_volume_as_headset_gain_control_volume(mixerVol);=
=09
+	/*
+	 * Convert 0 -> 100 volume to 0x0(min) -> 0x7D(max) volume range
+	 * NOTE: 0 is minimum volume and not mute
+	 */
+	volume	=3D get_mixer_volume_as_headset_gain_control_volume(mixerVol);
 	val	=3D omap_tsc2101_audio_read(TSC2101_HEADSET_GAIN_CTRL);
 	/* preserve the old mute settings */
 	val	&=3D ~(HGC_ADPGA_HED(INPUT_VOLUME_MAX));
 	val	|=3D HGC_ADPGA_HED(volume);
-	omap_tsc2101_audio_write(TSC2101_HEADSET_GAIN_CTRL, val);=09
+	omap_tsc2101_audio_write(TSC2101_HEADSET_GAIN_CTRL, val);
 	retVal	=3D 1;
-=09
-	M_DPRINTK("to registry =3D %d\n", val);=09
+
+	M_DPRINTK("to registry =3D %d\n", val);
 	return retVal;
 }
=20
 /*
  * Writes Alsa mixer volume (0 - 100) to TSC2101 handset volume regist=
ry in
  * a TSC2101 format. (0 - 63.5 db)
- * In TSC2101 OSS driver this functionality was controlled with "SET_M=
IC" parameter.
+ * In TSC2101 OSS driver this functionality was controlled with
+ * "SET_MIC" parameter.
  */
-int set_mixer_volume_as_handset_gain_control_volume(int mixerVol)=20
+int set_mixer_volume_as_handset_gain_control_volume(int mixerVol)
 {
 	int volume;
 	int retVal;
-	u16 val;=09
+	u16 val;
=20
 	if (mixerVol < 0 || mixerVol > 100) {
-		M_DPRINTK("Trying a bad mic mixer volume value(%d)!\n", mixerVol);
+		M_DPRINTK("Trying a bad mic mixer volume value(%d)!\n",
+				mixerVol);
 		return -EPERM;
 	}
 	M_DPRINTK("mixer volume =3D %d\n", mixerVol);
-	/* Convert 0 -> 100 volume to 0x0(min) -> 0x7D(max) volume range
-	 * NOTE: 0 is minimum volume and not mute=20
+	/*
+	 * Convert 0 -> 100 volume to 0x0(min) -> 0x7D(max) volume range
+	 * NOTE: 0 is minimum volume and not mute
 	 */
 	volume	=3D get_mixer_volume_as_headset_gain_control_volume(mixerVol);
 	val	=3D omap_tsc2101_audio_read(TSC2101_HANDSET_GAIN_CTRL);
@@ -352,8 +377,8 @@ int set_mixer_volume_as_handset_gain_control_volume=
(int mixerVol)
 	val	|=3D HNGC_ADPGA_HND(volume);
 	omap_tsc2101_audio_write(TSC2101_HANDSET_GAIN_CTRL, val);
 	retVal	=3D 1;
-=09
-	M_DPRINTK("to registry =3D %d\n", val);=09
+
+	M_DPRINTK("to registry =3D %d\n", val);
 	return retVal;
 }
=20
@@ -361,27 +386,31 @@ void set_loudspeaker_to_playback_target(void)
 {
 	/* power down SPK1, SPK2 and loudspeaker */
 	omap_tsc2101_audio_write(TSC2101_CODEC_POWER_CTRL,
-			CPC_SP1PWDN | CPC_SP2PWDN | CPC_LDAPWDF);=09
-	/* ADC, DAC, Analog Sidetone, cellphone, buzzer softstepping enabled
+			CPC_SP1PWDN | CPC_SP2PWDN | CPC_LDAPWDF);
+	/*
+	 * ADC, DAC, Analog Sidetone, cellphone, buzzer softstepping enabled
 	 * 1dB AGC hysteresis
 	 * MICes bias 2V
 	 */
 	omap_tsc2101_audio_write(TSC2101_AUDIO_CTRL_4, AC4_MB_HED(0));
=20
-	/* DAC left and right routed to SPK1/SPK2
+	/*
+	 * DAC left and right routed to SPK1/SPK2
 	 * SPK1/SPK2 unmuted
 	 * Keyclicks routed to SPK1/SPK2 */
-	omap_tsc2101_audio_write(TSC2101_AUDIO_CTRL_5,=20
+	omap_tsc2101_audio_write(TSC2101_AUDIO_CTRL_5,
 			AC5_DIFFIN |
 			AC5_DAC2SPK1(3) | AC5_AST2SPK1 | AC5_KCL2SPK1 |
 			AC5_DAC2SPK2(3) | AC5_AST2SPK2 | AC5_KCL2SPK2);
-=09
-	/* routing selected to SPK1 goes also to OUT8P/OUT8N. (loudspeaker)
+
+	/*
+	 * routing selected to SPK1 goes also to OUT8P/OUT8N. (loudspeaker)
 	 * analog sidetone routed to loudspeaker
 	 * buzzer pga routed to loudspeaker
 	 * keyclick routing to loudspeaker
 	 * cellphone input routed to loudspeaker
-	 * mic selection (control register 04h/page2) routed to cell phone ou=
tput (CP_OUT)
+	 * mic selection (control register 04h/page2) routed to cell phone
+	 * output (CP_OUT)
 	 * routing selected for SPK1 goes also to cellphone output (CP_OUT)
 	 * OUT8P/OUT8N (loudspeakers) unmuted (0 =3D unmuted)
 	 * Cellphone output is not muted (0 =3D unmuted)
@@ -399,19 +428,23 @@ void set_headphone_to_playback_target(void)
 	/* power down SPK1, SPK2 and loudspeaker */
 	omap_tsc2101_audio_write(TSC2101_CODEC_POWER_CTRL,
 			CPC_SP1PWDN | CPC_SP2PWDN | CPC_LDAPWDF);
-	/* ADC, DAC, Analog Sidetone, cellphone, buzzer softstepping enabled =
*/
-	/* 1dB AGC hysteresis */
-	/* MICes bias 2V */
+	/*
+	 * ADC, DAC, Analog Sidetone, cellphone, buzzer softstepping enabled
+	=C2=A0* 1dB AGC hysteresis
+	 * MICes bias 2V
+	 */
 	omap_tsc2101_audio_write(TSC2101_AUDIO_CTRL_4, AC4_MB_HED(0));
-			=09
-	/* DAC left and right routed to SPK1/SPK2
+
+	/*
+	 * DAC left and right routed to SPK1/SPK2
 	 * SPK1/SPK2 unmuted
-	 * Keyclicks routed to SPK1/SPK2 */
+	 * Keyclicks routed to SPK1/SPK2
+	 */
 	omap_tsc2101_audio_write(TSC2101_AUDIO_CTRL_5,
 			AC5_DAC2SPK1(3) | AC5_AST2SPK1 | AC5_KCL2SPK1 |
 			AC5_DAC2SPK2(3) | AC5_AST2SPK2 | AC5_KCL2SPK2 |
 			AC5_HDSCPTC);
-		=09
+
 	/* OUT8P/OUT8N muted, CPOUT muted */
 	omap_tsc2101_audio_write(TSC2101_AUDIO_CTRL_6,
 			AC6_MUTLSPK | AC6_MUTSPK2 | AC6_LDSCPTC |
@@ -421,45 +454,47 @@ void set_headphone_to_playback_target(void)
=20
 void set_telephone_to_playback_target(void)
 {
-	/*=20
+	/*
 	 * 0110 1101 0101 1100
-	 * power down MICBIAS_HED, Analog sidetone, SPK2, DAC,=20
+	 * power down MICBIAS_HED, Analog sidetone, SPK2, DAC,
 	 * Driver virtual ground, loudspeaker. Values D2-d5 are flags.
-	 */	=20
+	 */
 	omap_tsc2101_audio_write(TSC2101_CODEC_POWER_CTRL,
 			CPC_MBIAS_HED | CPC_ASTPWD | CPC_SP2PWDN | CPC_DAPWDN |
 			CPC_VGPWDN | CPC_LSPWDN);
-		=09
-	/*=20
+
+	/*
 	 * 0010 1010 0100 0000
 	 * ADC, DAC, Analog Sidetone, cellphone, buzzer softstepping enabled
 	 * 1dB AGC hysteresis
 	 * MICes bias 2V
 	 */
 	omap_tsc2101_audio_write(TSC2101_AUDIO_CTRL_4,
-			AC4_MB_HND | AC4_MB_HED(0) | AC4_AGCHYS(1) |=20
+			AC4_MB_HND | AC4_MB_HED(0) | AC4_AGCHYS(1) |
 			AC4_BISTPD | AC4_ASSTPD | AC4_DASTPD);
-	printk("set_telephone_to_playback_target(), TSC2101_AUDIO_CTRL_4 =3D =
%d\n", omap_tsc2101_audio_read(TSC2101_AUDIO_CTRL_4));
-		=09
-	/*=20
+	printk(KERN_INFO "set_telephone_to_playback_target(), "
+			"TSC2101_AUDIO_CTRL_4 =3D %d\n",
+			omap_tsc2101_audio_read(TSC2101_AUDIO_CTRL_4));
+
+	/*
 	 * 1110 0010 0000 0010
 	 * DAC left and right routed to SPK1/SPK2
 	 * SPK1/SPK2 unmuted
 	 * keyclicks routed to SPK1/SPK2
-	 */	=20
+	 */
 	omap_tsc2101_audio_write(TSC2101_AUDIO_CTRL_5,
-			AC5_DIFFIN | AC5_DAC2SPK1(3) |=20
-		  	AC5_CPI2SPK1 | AC5_MUTSPK2);
-=09
+			AC5_DIFFIN | AC5_DAC2SPK1(3) |
+			AC5_CPI2SPK1 | AC5_MUTSPK2);
+
 	omap_tsc2101_audio_write(TSC2101_AUDIO_CTRL_6,
-			AC6_MIC2CPO | AC6_MUTLSPK |=20
+			AC6_MIC2CPO | AC6_MUTLSPK |
 			AC6_LDSCPTC | AC6_VGNDSCPTC | AC6_CAPINTF);
 	current_playback_target	=3D PLAYBACK_TARGET_CELLPHONE;
 }
=20
 /*
  * 1100 0101 1101 0000
- *=20
+ *
  * #define MPC_ASTMU           TSC2101_BIT(15)
  * #define MPC_ASTG(ARG)       (((ARG) & 0x7F) << 8)
  * #define MPC_MICSEL(ARG)     (((ARG) & 0x07) << 5)
@@ -470,14 +505,14 @@ void set_telephone_to_playback_target(void)
 static void set_telephone_to_record_source(void)
 {
 	u16	val;
-=09
-	/*=20
-	 * D0       =3D 0:=20
+
+	/*
+	 * D0       =3D 0:
 	 * 		--> AGC is off for handset input.
 	 *		--> ADC PGA is controlled by the ADMUT_HDN + ADPGA_HND
 	 *          (D15, D14-D8)
-	 * D4 - D1  =3D 0000=20
-	 * 		--> AGC time constant for handset input,=20
+	 * D4 - D1  =3D 0000
+	 * 		--> AGC time constant for handset input,
 	 * 		attack time =3D 8 mc, decay time =3D 100 ms
 	 * D7 - D5  =3D 000
 	 * 		--> AGC Target gain for handset input =3D -5.5 db
@@ -486,33 +521,36 @@ static void set_telephone_to_record_source(void)
 	 * D15 		=3D 0
 	 * 		--> Handset input ON (unmuted)
 	 */
-	val	=3D 0x3c00;	// 0011 1100 0000 0000 =3D 60 =3D 30
+	val	=3D 0x3c00;	/* 0011 1100 0000 0000 =3D 60 =3D 30 */
 	omap_tsc2101_audio_write(TSC2101_HANDSET_GAIN_CTRL, val);
-=09
+
 	/*
 	 * D0		=3D 0
 	 * 		--> AGC is off for headset/Aux input
-	 * 		--> ADC headset/Aux PGA is contoller by ADMUT_HED + ADPGA_HED
+	 * 		--> ADC headset/Aux PGA is contoller by
+	 * 		ADMUT_HED + ADPGA_HED
 	 *          (D15, D14-D8)
-	 * D4 - D1	=3D 0000=20
+	 * D4 - D1	=3D 0000
 	 * 		--> Agc constant for headset/Aux input,
-	 *      	attack time =3D 8 mc, decay time =3D 100 ms     =20
+	 *      	attack time =3D 8 mc, decay time =3D 100 ms
 	 * D7 - D5	=3D 000
 	 * 		--> AGC target gain for headset input =3D -5.5 db
 	 * D14 - D8 =3D 000 0000
 	 * 		--> Adc headset/AUX pga settings =3D 0 db
 	 * D15		=3D 1
 	 * 		--> Headset/AUX input muted
-	 *=20
+	 *
 	 * Mute headset aux input
 	 */
-	val	=3D 0x8000;	// 1000 0000 0000 0000
+	val	=3D 0x8000;	/* 1000 0000 0000 0000 */
 	omap_tsc2101_audio_write(TSC2101_HEADSET_GAIN_CTRL, val);
 	set_record_source(REC_SRC_MICIN_HND_AND_AUX1);
=20
-	// hacks start
-	/* D0		=3D flag, Headset/Aux or handset PGA flag
-	 * 		--> & with 1 (=3D 1 -->gain applied =3D=3D pga register settings=
)
+	/*
+	 * hacks start
+	 * D0		=3D flag, Headset/Aux or handset PGA flag
+	 * 		--> & with 1 (=3D 1 -->gain applied =3D=3D pga
+	 * 		register settings)
 	 * D1		=3D 0, DAC channel PGA soft stepping control
 	 * 		--> 0.5 db change every WCLK
 	 * D2		=3D flag, DAC right channel PGA flag
@@ -521,8 +559,8 @@ static void set_telephone_to_record_source(void)
 	 * 		-- > & with 1
 	 * D7 - D4	=3D 0001, keyclick length
 	 * 		--> 4 periods key clicks
-	 * D10 - D8 =3D 100, keyclick frequenzy
-	 * 		--> 1 kHz,=20
+	 * D10 - D8 =3D 100, keyclick frequency
+	 * 		--> 1 kHz,
 	 * D11		=3D 0, Headset/Aux or handset soft stepping control
 	 * 		--> 0,5 db change every WCLK or ADWS
 	 * D14 -D12 =3D 100, Keyclick applitude control
@@ -531,7 +569,7 @@ static void set_telephone_to_record_source(void)
 	 */
 	val	=3D omap_tsc2101_audio_read(TSC2101_AUDIO_CTRL_2);
 	val	=3D val & 0x441d;
-	val	=3D val | 0x4410;	// D14, D10, D4 bits =3D=3D 1
+	val	=3D val | 0x4410;	/* D14, D10, D4 bits =3D=3D 1 */
 	omap_tsc2101_audio_write(TSC2101_AUDIO_CTRL_2, val);
=20
 	/*
@@ -543,24 +581,28 @@ static void set_telephone_to_record_source(void)
 	 * 			--> MICBIAS_HND =3D 2.0 v
 	 * D8 - D7	=3D 00
 	 * 			--> MICBIAS_HED =3D 3.3 v
-	 * D10 - D9	=3D 01,=20
+	 * D10 - D9	=3D 01,
 	 * 			--> Mic AGC hysteric selection =3D 2 db
-	 * D11		=3D 1,=20
+	 * D11		=3D 1,
 	 * 			--> Disable buzzer PGA soft stepping
 	 * D12		=3D 0,
 	 * 			--> Enable CELL phone PGA soft stepping control
 	 * D13		=3D 1
-	 * 			--> Disable analog sidetone soft stepping control
+	 * 			--> Disable analog sidetone soft
+	 * 			stepping control
 	 * D14		=3D 0
 	 * 			--> Enable DAC PGA soft stepping control
 	 * D15		=3D 0,
-	 * 			--> Enable headset/Aux or Handset soft stepping control
+	 * 			--> Enable headset/Aux or Handset soft
+	 * 			stepping control
 	 */
 	val	=3D omap_tsc2101_audio_read(TSC2101_AUDIO_CTRL_4);
-	val	=3D val & 0x2a42;	// 0010 1010 0100 0010
-	val	=3D val | 0x2a40;	// bits D13, D11, D9, D6 =3D=3D 1
+	val	=3D val & 0x2a42;	/* 0010 1010 0100 0010 */
+	val	=3D val | 0x2a40;	/* bits D13, D11, D9, D6 =3D=3D 1 */
 	omap_tsc2101_audio_write(TSC2101_AUDIO_CTRL_4, val);
-	printk("set_telephone_to_record_source(), TSC2101_AUDIO_CTRL_4 =3D %d=
\n", omap_tsc2101_audio_read(TSC2101_AUDIO_CTRL_4));
+	printk(KERN_INFO "set_telephone_to_record_source(), "
+			"TSC2101_AUDIO_CTRL_4 =3D %d\n",
+			omap_tsc2101_audio_read(TSC2101_AUDIO_CTRL_4));
 	/*
 	 * D0		=3D 0
 	 * 		--> reserved, write always =3D 0
@@ -579,10 +621,12 @@ static void set_telephone_to_record_source(void)
 	 */
 	val	=3D omap_tsc2101_audio_read(TSC2101_BUZZER_GAIN_CTRL);
 	val	=3D val & 0x5dfe;
-	val	=3D val | 0x5dfe;	// bits, D14, D12, D11, D10, D8, D6, D5,D4,D3,D=
2
+	/* bits, D14, D12, D11, D10, D8, D6, D5,D4,D3,D2 */
+	val	=3D val | 0x5dfe;
 	omap_tsc2101_audio_write(TSC2101_BUZZER_GAIN_CTRL, val);
-=09
-	/* D6 - D0	=3D 000 1001
+
+	/*
+	 * D6 - D0	=3D 000 1001
 	 * 		--> -4.5 db for DAC right channel volume control
 	 * D7		=3D 1
 	 * 		-->  DAC right channel muted
@@ -591,12 +635,13 @@ static void set_telephone_to_record_source(void)
 	 * D15 		=3D 1
 	 * 		--> DAC left channel muted
 	 */
-	//val	=3D omap_tsc2101_audio_read(TSC2101_DAC_GAIN_CTRL);
+	/* val	=3D omap_tsc2101_audio_read(TSC2101_DAC_GAIN_CTRL); */
 	val	=3D 0x8989;
-	omap_tsc2101_audio_write(TSC2101_DAC_GAIN_CTRL, val);=09
-=09
-	/*  0000 0000 0100 0000
-	 *=20
+	omap_tsc2101_audio_write(TSC2101_DAC_GAIN_CTRL, val);
+
+	/*
+	 *   0000 0000 0100 0000
+	 *
 	 * D1 - D0	=3D 0
 	 * 		--> GPIO 1 pin output is three stated
 	 * D2		=3D 0
@@ -610,18 +655,18 @@ static void set_telephone_to_record_source(void)
 	 * 		--> 8 ms clitch detection
 	 * D8		=3D reserved, write only 0
 	 * D10 -D9	=3D 00
-	 * 		--> 16 ms de bouncing programmatitily=20
+	 * 		--> 16 ms de-bouncing
 	 *          for glitch detection during headset detection
 	 * D11		=3D flag for button press
 	 * D12		=3D flag for headset detection
 	 * D14-D13	=3D 00
-	 * 		--> type of headset detected =3D 00 =3D=3D no stereo headset dee=
cted
+	 * 		--> type of headset detected =3D 00 =3D=3D no stereo
+	 * 		headset deected
 	 * D15		=3D 0
 	 * 		--> Disable headset detection
-	 *=20
-	 * */
+	 */
 	val	=3D 0x40;
-	omap_tsc2101_audio_write(TSC2101_AUDIO_CTRL_7, val);=09
+	omap_tsc2101_audio_write(TSC2101_AUDIO_CTRL_7, val);
 }
=20
 /*
@@ -637,17 +682,17 @@ u16 get_headset_detected(void)
 	u16	curDetected;
 	u16	curType;
 	u16	curVal;
-=09
+
 	curType	=3D 0;	/* not detected */
 	curVal	=3D omap_tsc2101_audio_read(TSC2101_AUDIO_CTRL_7);
 	curDetected	=3D curVal & AC7_HDDETFL;
 	if (curDetected) {
-		printk("headset detected, checking type from %d \n", curVal);
+		printk(KERN_INFO "headset detected, checking type from %d \n",
+			curVal);
 		curType	=3D ((curVal & 0x6000) >> 13);
-		printk("headset type detected =3D %d \n", curType);
-	}
-	else {
-		printk("headset not detected\n");
+		printk(KERN_INFO "headset type detected =3D %d \n", curType);
+	} else {
+		printk(KERN_INFO "headset not detected\n");
 	}
 	return curType;
 }
@@ -657,40 +702,46 @@ void init_playback_targets(void)
 	u16	val;
=20
 	set_loudspeaker_to_playback_target();
-	/* Left line input volume control
+	/*
+	 * Left line input volume control
 	 * =3D SET_LINE in the OSS driver
 	 */
 	set_mixer_volume_as_headset_gain_control_volume(DEFAULT_INPUT_VOLUME)=
;
=20
-	/* Set headset to be controllable by handset mixer
+	/*
+	 * Set headset to be controllable by handset mixer
 	 * AGC enable for handset input
 	 * Handset input not muted
 	 */
 	val	=3D omap_tsc2101_audio_read(TSC2101_HANDSET_GAIN_CTRL);
-	val	=3D val | HNGC_AGCEN_HND;=09
+	val	=3D val | HNGC_AGCEN_HND;
 	val	=3D val & ~HNGC_ADMUT_HND;
-	omap_tsc2101_audio_write(TSC2101_HANDSET_GAIN_CTRL, val);=09
-		=09
-	/* mic input volume control
-	 * SET_MIC in the OSS driver=20
+	omap_tsc2101_audio_write(TSC2101_HANDSET_GAIN_CTRL, val);
+
+	/*
+	 * mic input volume control
+	 * SET_MIC in the OSS driver
 	 */
 	set_mixer_volume_as_handset_gain_control_volume(DEFAULT_INPUT_VOLUME)=
;
=20
-	/* Left/Right headphone channel volume control
+	/*
+	 * Left/Right headphone channel volume control
 	 * Zero-cross detect on
 	 */
-	set_mixer_volume_as_dac_gain_control_volume(DEFAULT_OUTPUT_VOLUME, DE=
=46AULT_OUTPUT_VOLUME);=09
+	set_mixer_volume_as_dac_gain_control_volume(DEFAULT_OUTPUT_VOLUME,
+							DEFAULT_OUTPUT_VOLUME);
 	/* unmute */
 	dac_gain_control_unmute(1, 1);
 }
=20
 /*
- * Initializes tsc2101 recourd source (to line) and playback target (t=
o loudspeaker)
+ * Initializes tsc2101 recourd source (to line) and playback target
+ * (to loudspeaker)
  */
 void snd_omap_init_mixer(void)
-{=09
+{
 	FN_IN;
-=09
+
 	/* Headset/Hook switch detect enabled */
 	omap_tsc2101_audio_write(TSC2101_AUDIO_CTRL_7, AC7_DETECT);
=20
@@ -706,17 +757,17 @@ static int __pcm_playback_target_info(struct snd_=
kcontrol *kcontrol,
 		struct snd_ctl_elem_info *uinfo)
 {
 	static char *texts[PLAYBACK_TARGET_COUNT] =3D {
-        	"Loudspeaker", "Headphone", "Cellphone"
+		"Loudspeaker", "Headphone", "Cellphone"
 	};
=20
 	uinfo->type =3D SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count =3D 1;
 	uinfo->value.enumerated.items =3D PLAYBACK_TARGET_COUNT;
-	if (uinfo->value.enumerated.item > PLAYBACK_TARGET_COUNT - 1) {
-        	uinfo->value.enumerated.item =3D PLAYBACK_TARGET_COUNT - 1;
-	}
+	if (uinfo->value.enumerated.item > PLAYBACK_TARGET_COUNT - 1)
+		uinfo->value.enumerated.item =3D PLAYBACK_TARGET_COUNT - 1;
+
 	strcpy(uinfo->value.enumerated.name,
-       	texts[uinfo->value.enumerated.item]);
+		texts[uinfo->value.enumerated.item]);
 	return 0;
 }
=20
@@ -732,28 +783,26 @@ static int __pcm_playback_target_put(struct snd_k=
control *kcontrol,
 {
 	int	retVal;
 	int	curVal;
-=09
+
 	retVal	=3D 0;
 	curVal	=3D ucontrol->value.integer.value[0];
 	if ((curVal >=3D 0) &&
 	    (curVal < PLAYBACK_TARGET_COUNT) &&
-	    (curVal !=3D current_playback_target)) {	=09
+	    (curVal !=3D current_playback_target)) {
 		if (curVal =3D=3D PLAYBACK_TARGET_LOUDSPEAKER) {
 			set_record_source(REC_SRC_SINGLE_ENDED_MICIN_HED);
 			set_loudspeaker_to_playback_target();
-		}
-		else if (curVal =3D=3D PLAYBACK_TARGET_HEADPHONE) {
+		} else if (curVal =3D=3D PLAYBACK_TARGET_HEADPHONE) {
 			set_record_source(REC_SRC_SINGLE_ENDED_MICIN_HND);
 			set_headphone_to_playback_target();
-		}
-		else if (curVal =3D=3D PLAYBACK_TARGET_CELLPHONE) {
+		} else if (curVal =3D=3D PLAYBACK_TARGET_CELLPHONE) {
 			set_telephone_to_record_source();
 			set_telephone_to_playback_target();
 		}
 		retVal	=3D 1;
 	}
 	return retVal;
-}=09
+}
=20
 static int __pcm_playback_volume_info(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_info *uinfo)
@@ -766,16 +815,16 @@ static int __pcm_playback_volume_info(struct snd_=
kcontrol *kcontrol,
 }
=20
 /*
- * Alsa mixer interface function for getting the volume read from the =
DGC in a=20
+ * Alsa mixer interface function for getting the volume read from the =
DGC in a
  * 0 -100 alsa mixer format.
  */
 static int __pcm_playback_volume_get(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
 	u16 volL;
-	u16 volR;=09
+	u16 volR;
 	u16 val;
-=09
+
 	val	=3D omap_tsc2101_audio_read(TSC2101_DAC_GAIN_CTRL);
 	M_DPRINTK("registry value =3D %d!\n", val);
 	volL	=3D DGC_DALVL_EXTRACT(val);
@@ -786,19 +835,22 @@ static int __pcm_playback_volume_get(struct snd_k=
control *kcontrol,
=20
 	volL	=3D get_dac_gain_control_volume_as_mixer_volume(volL);
 	volR	=3D get_dac_gain_control_volume_as_mixer_volume(volR);
-=09
+
 	ucontrol->value.integer.value[0]	=3D volL; /* L */
 	ucontrol->value.integer.value[1]	=3D volR; /* R */
-=09
-	M_DPRINTK("mixer volume left =3D %ld, right =3D %ld\n", ucontrol->val=
ue.integer.value[0], ucontrol->value.integer.value[1]);
+
+	M_DPRINTK("mixer volume left =3D %ld, right =3D %ld\n",
+			ucontrol->value.integer.value[0],
+			ucontrol->value.integer.value[1]);
 	return 0;
 }
=20
 static int __pcm_playback_volume_put(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
-	return set_mixer_volume_as_dac_gain_control_volume(ucontrol->value.in=
teger.value[0],=20
-							ucontrol->value.integer.value[1]);
+	return set_mixer_volume_as_dac_gain_control_volume(
+					ucontrol->value.integer.value[0],
+					ucontrol->value.integer.value[1]);
 }
=20
 static int __pcm_playback_switch_info(struct snd_kcontrol *kcontrol,
@@ -811,7 +863,7 @@ static int __pcm_playback_switch_info(struct snd_kc=
ontrol *kcontrol,
 	return 0;
 }
=20
-/*=20
+/*
  * When DGC_DALMU (bit 15) is 1, the left channel is muted.
  * When DGC_DALMU is 0, left channel is not muted.
  * Same logic apply also for the right channel.
@@ -820,16 +872,16 @@ static int __pcm_playback_switch_get(struct snd_k=
control *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
 	u16 val	=3D omap_tsc2101_audio_read(TSC2101_DAC_GAIN_CTRL);
-=09
-	ucontrol->value.integer.value[0]	=3D IS_UNMUTED(15, val);	// left
-	ucontrol->value.integer.value[1]	=3D IS_UNMUTED(7, val);	// right
+
+	ucontrol->value.integer.value[0] =3D IS_UNMUTED(15, val);	/* left */
+	ucontrol->value.integer.value[1] =3D IS_UNMUTED(7, val); /* right */
 	return 0;
 }
=20
 static int __pcm_playback_switch_put(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
-	return dac_gain_control_unmute(ucontrol->value.integer.value[0],=20
+	return dac_gain_control_unmute(ucontrol->value.integer.value[0],
 					ucontrol->value.integer.value[1]);
 }
=20
@@ -848,7 +900,7 @@ static int __headset_playback_volume_get(struct snd=
_kcontrol *kcontrol,
 {
 	u16 val;
 	u16 vol;
-=09
+
 	val	=3D omap_tsc2101_audio_read(TSC2101_HEADSET_GAIN_CTRL);
 	M_DPRINTK("registry value =3D %d\n", val);
 	vol	=3D HGC_ADPGA_HED_EXTRACT(val);
@@ -856,15 +908,17 @@ static int __headset_playback_volume_get(struct s=
nd_kcontrol *kcontrol,
=20
 	vol	=3D get_headset_gain_control_volume_as_mixer_volume(vol);
 	ucontrol->value.integer.value[0]	=3D vol;
-=09
-	M_DPRINTK("mixer volume returned =3D %ld\n", ucontrol->value.integer.=
value[0]);
+
+	M_DPRINTK("mixer volume returned =3D %ld\n",
+			ucontrol->value.integer.value[0]);
 	return 0;
 }
=20
 static int __headset_playback_volume_put(struct snd_kcontrol *kcontrol=
,
 		struct snd_ctl_elem_value *ucontrol)
 {
-	return set_mixer_volume_as_headset_gain_control_volume(ucontrol->valu=
e.integer.value[0]);=09
+	return set_mixer_volume_as_headset_gain_control_volume(
+					ucontrol->value.integer.value[0]);
 }
=20
 static int __headset_playback_switch_info(struct snd_kcontrol *kcontro=
l,
@@ -877,7 +931,8 @@ static int __headset_playback_switch_info(struct sn=
d_kcontrol *kcontrol,
 	return 0;
 }
=20
-/* When HGC_ADMUT_HED (bit 15) is 1, the headset is muted.
+/*
+ * When HGC_ADMUT_HED (bit 15) is 1, the headset is muted.
  * When HGC_ADMUT_HED is 0, headset is not muted.
  */
 static int __headset_playback_switch_get(struct snd_kcontrol *kcontrol=
,
@@ -891,7 +946,7 @@ static int __headset_playback_switch_get(struct snd=
_kcontrol *kcontrol,
 static int __headset_playback_switch_put(struct snd_kcontrol *kcontrol=
,
 		struct snd_ctl_elem_value *ucontrol)
 {
-	// mute/unmute headset
+	/* mute/unmute headset */
 	return adc_pga_unmute_control(ucontrol->value.integer.value[0],
 				TSC2101_HEADSET_GAIN_CTRL,
 				15);
@@ -912,22 +967,24 @@ static int __handset_playback_volume_get(struct s=
nd_kcontrol *kcontrol,
 {
 	u16 val;
 	u16 vol;
-=09
+
 	val	=3D omap_tsc2101_audio_read(TSC2101_HANDSET_GAIN_CTRL);
 	M_DPRINTK("registry value =3D %d\n", val);
 	vol	=3D HNGC_ADPGA_HND_EXTRACT(val);
 	vol	=3D vol & ~HNGC_ADMUT_HND;
 	vol	=3D get_handset_gain_control_volume_as_mixer_volume(vol);
 	ucontrol->value.integer.value[0]	=3D vol;
-=09
-	M_DPRINTK("mixer volume returned =3D %ld\n", ucontrol->value.integer.=
value[0]);
+
+	M_DPRINTK("mixer volume returned =3D %ld\n",
+			ucontrol->value.integer.value[0]);
 	return 0;
 }
=20
 static int __handset_playback_volume_put(struct snd_kcontrol *kcontrol=
,
 		struct snd_ctl_elem_value *ucontrol)
 {
-	return set_mixer_volume_as_handset_gain_control_volume(ucontrol->valu=
e.integer.value[0]);=09
+	return set_mixer_volume_as_handset_gain_control_volume(
+					ucontrol->value.integer.value[0]);
 }
=20
 static int __handset_playback_switch_info(struct snd_kcontrol *kcontro=
l,
@@ -940,7 +997,8 @@ static int __handset_playback_switch_info(struct sn=
d_kcontrol *kcontrol,
 	return 0;
 }
=20
-/* When HNGC_ADMUT_HND (bit 15) is 1, the handset is muted.
+/*
+ * When HNGC_ADMUT_HND (bit 15) is 1, the handset is muted.
  * When HNGC_ADMUT_HND is 0, handset is not muted.
  */
 static int __handset_playback_switch_get(struct snd_kcontrol *kcontrol=
,
@@ -954,7 +1012,7 @@ static int __handset_playback_switch_get(struct sn=
d_kcontrol *kcontrol,
 static int __handset_playback_switch_put(struct snd_kcontrol *kcontrol=
,
 		struct snd_ctl_elem_value *ucontrol)
 {
-	// handset mute/unmute
+	/* handset mute/unmute */
 	return adc_pga_unmute_control(ucontrol->value.integer.value[0],
 				TSC2101_HANDSET_GAIN_CTRL,
 				15);
@@ -970,7 +1028,8 @@ static int __cellphone_input_switch_info(struct sn=
d_kcontrol *kcontrol,
 	return 0;
 }
=20
-/* When BGC_MUT_CP (bit 15) =3D 1, power down cellphone input pga.
+/*
+ * When BGC_MUT_CP (bit 15) =3D 1, power down cellphone input pga.
  * When BGC_MUT_CP =3D 0, power up cellphone input pga.
  */
 static int __cellphone_input_switch_get(struct snd_kcontrol *kcontrol,
@@ -986,7 +1045,7 @@ static int __cellphone_input_switch_put(struct snd=
_kcontrol *kcontrol,
 {
 	return adc_pga_unmute_control(ucontrol->value.integer.value[0],
 				TSC2101_BUZZER_GAIN_CTRL,
-				15);=09
+				15);
 }
=20
 static int __buzzer_input_switch_info(struct snd_kcontrol *kcontrol,
@@ -999,7 +1058,8 @@ static int __buzzer_input_switch_info(struct snd_k=
control *kcontrol,
 	return 0;
 }
=20
-/* When BGC_MUT_BU (bit 6) =3D 1, power down cellphone input pga.
+/*
+ * When BGC_MUT_BU (bit 6) =3D 1, power down cellphone input pga.
  * When BGC_MUT_BU =3D 0, power up cellphone input pga.
  */
 static int __buzzer_input_switch_get(struct snd_kcontrol *kcontrol,
@@ -1015,82 +1075,82 @@ static int __buzzer_input_switch_put(struct snd=
_kcontrol *kcontrol,
 {
 	return adc_pga_unmute_control(ucontrol->value.integer.value[0],
 				TSC2101_BUZZER_GAIN_CTRL,
-				6);=09
+				6);
 }
=20
 static struct snd_kcontrol_new tsc2101_control[] __devinitdata =3D {
 	{
-		.name  =3D "Target Playback Route",
-		.iface =3D SNDRV_CTL_ELEM_IFACE_MIXER,
-		.index =3D 0,
-		.access=3D SNDRV_CTL_ELEM_ACCESS_READWRITE,
-		.info  =3D __pcm_playback_target_info,
-		.get   =3D __pcm_playback_target_get,
-		.put   =3D __pcm_playback_target_put,
+		.name	=3D "Target Playback Route",
+		.iface	=3D SNDRV_CTL_ELEM_IFACE_MIXER,
+		.index	=3D 0,
+		.access	=3D SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info	=3D __pcm_playback_target_info,
+		.get	=3D __pcm_playback_target_get,
+		.put	=3D __pcm_playback_target_put,
 	}, {
-		.name  =3D "Master Playback Volume",
-		.iface =3D SNDRV_CTL_ELEM_IFACE_MIXER,
-		.index =3D 0,
-		.access=3D SNDRV_CTL_ELEM_ACCESS_READWRITE,
-		.info  =3D __pcm_playback_volume_info,
-		.get   =3D __pcm_playback_volume_get,
-		.put   =3D __pcm_playback_volume_put,
+		.name	=3D "Master Playback Volume",
+		.iface	=3D SNDRV_CTL_ELEM_IFACE_MIXER,
+		.index	=3D 0,
+		.access	=3D SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info	=3D __pcm_playback_volume_info,
+		.get	=3D __pcm_playback_volume_get,
+		.put	=3D __pcm_playback_volume_put,
 	}, {
-		.name  =3D "Master Playback Switch",
-		.iface =3D SNDRV_CTL_ELEM_IFACE_MIXER,
-		.index =3D 0,
-		.access=3D SNDRV_CTL_ELEM_ACCESS_READWRITE,
-		.info  =3D __pcm_playback_switch_info,
-		.get   =3D __pcm_playback_switch_get,
-		.put   =3D __pcm_playback_switch_put,
+		.name	=3D "Master Playback Switch",
+		.iface	=3D SNDRV_CTL_ELEM_IFACE_MIXER,
+		.index	=3D 0,
+		.access	=3D SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info	=3D __pcm_playback_switch_info,
+		.get	=3D __pcm_playback_switch_get,
+		.put	=3D __pcm_playback_switch_put,
 	}, {
-		.name  =3D "Headset Playback Volume",
-		.iface =3D SNDRV_CTL_ELEM_IFACE_MIXER,
-		.index =3D 0,
-		.access=3D SNDRV_CTL_ELEM_ACCESS_READWRITE,
-		.info  =3D __headset_playback_volume_info,
-		.get   =3D __headset_playback_volume_get,
-		.put   =3D __headset_playback_volume_put,
+		.name	=3D "Headset Playback Volume",
+		.iface	=3D SNDRV_CTL_ELEM_IFACE_MIXER,
+		.index	=3D 0,
+		.access	=3D SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info	=3D __headset_playback_volume_info,
+		.get	=3D __headset_playback_volume_get,
+		.put	=3D __headset_playback_volume_put,
 	}, {
-		.name  =3D "Headset Playback Switch",
-		.iface =3D SNDRV_CTL_ELEM_IFACE_MIXER,
-		.index =3D 0,
-		.access=3D SNDRV_CTL_ELEM_ACCESS_READWRITE,
-		.info  =3D __headset_playback_switch_info,
-		.get   =3D __headset_playback_switch_get,
-		.put   =3D __headset_playback_switch_put,
+		.name	=3D "Headset Playback Switch",
+		.iface	=3D SNDRV_CTL_ELEM_IFACE_MIXER,
+		.index	=3D 0,
+		.access	=3D SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info	=3D __headset_playback_switch_info,
+		.get	=3D __headset_playback_switch_get,
+		.put	=3D __headset_playback_switch_put,
 	}, {
-		.name  =3D "Handset Playback Volume",
-		.iface =3D SNDRV_CTL_ELEM_IFACE_MIXER,
-		.index =3D 0,
-		.access=3D SNDRV_CTL_ELEM_ACCESS_READWRITE,
-		.info  =3D __handset_playback_volume_info,
-		.get   =3D __handset_playback_volume_get,
-		.put   =3D __handset_playback_volume_put,
+		.name	=3D "Handset Playback Volume",
+		.iface	=3D SNDRV_CTL_ELEM_IFACE_MIXER,
+		.index	=3D 0,
+		.access	=3D SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info	=3D __handset_playback_volume_info,
+		.get	=3D __handset_playback_volume_get,
+		.put	=3D __handset_playback_volume_put,
 	}, {
-		.name  =3D "Handset Playback Switch",
-		.iface =3D SNDRV_CTL_ELEM_IFACE_MIXER,
-		.index =3D 0,
-		.access=3D SNDRV_CTL_ELEM_ACCESS_READWRITE,
-		.info  =3D __handset_playback_switch_info,
-		.get   =3D __handset_playback_switch_get,
-		.put   =3D __handset_playback_switch_put,
+		.name	=3D "Handset Playback Switch",
+		.iface	=3D SNDRV_CTL_ELEM_IFACE_MIXER,
+		.index	=3D 0,
+		.access	=3D SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info	=3D __handset_playback_switch_info,
+		.get	=3D __handset_playback_switch_get,
+		.put	=3D __handset_playback_switch_put,
 	}, {
-		.name  =3D "Cellphone Input Switch",
-		.iface =3D SNDRV_CTL_ELEM_IFACE_MIXER,
-		.index =3D 0,
-		.access=3D SNDRV_CTL_ELEM_ACCESS_READWRITE,
-		.info  =3D __cellphone_input_switch_info,
-		.get   =3D __cellphone_input_switch_get,
-		.put   =3D __cellphone_input_switch_put,
+		.name	=3D "Cellphone Input Switch",
+		.iface	=3D SNDRV_CTL_ELEM_IFACE_MIXER,
+		.index	=3D 0,
+		.access	=3D SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info	=3D __cellphone_input_switch_info,
+		.get	=3D __cellphone_input_switch_get,
+		.put	=3D __cellphone_input_switch_put,
 	}, {
-		.name  =3D "Buzzer Input Switch",
-		.iface =3D SNDRV_CTL_ELEM_IFACE_MIXER,
-		.index =3D 0,
-		.access=3D SNDRV_CTL_ELEM_ACCESS_READWRITE,
-		.info  =3D __buzzer_input_switch_info,
-		.get   =3D __buzzer_input_switch_get,
-		.put   =3D __buzzer_input_switch_put,
+		.name	=3D "Buzzer Input Switch",
+		.iface	=3D SNDRV_CTL_ELEM_IFACE_MIXER,
+		.index	=3D 0,
+		.access	=3D SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info	=3D __buzzer_input_switch_info,
+		.get	=3D __buzzer_input_switch_get,
+		.put	=3D __buzzer_input_switch_put,
 	}
 };
=20
@@ -1106,20 +1166,20 @@ void snd_omap_resume_mixer(void)
 }
 #endif
=20
-int snd_omap_mixer(struct snd_card_omap_codec *tsc2101)=20
+int snd_omap_mixer(struct snd_card_omap_codec *tsc2101)
 {
-	int i=3D0;
-	int err=3D0;
+	int i =3D 0;
+	int err =3D 0;
=20
-	if (!tsc2101) {
+	if (!tsc2101)
 		return -EINVAL;
-	}
-	for (i=3D0; i < ARRAY_SIZE(tsc2101_control); i++) {
-		if ((err =3D snd_ctl_add(tsc2101->card,=20
-				snd_ctl_new1(&tsc2101_control[i],=20
-				tsc2101->card))) < 0) {
+
+	for (i =3D 0; i < ARRAY_SIZE(tsc2101_control); i++) {
+		err =3D snd_ctl_add(tsc2101->card,
+					snd_ctl_new1(&tsc2101_control[i],
+					tsc2101->card));
+		if (err < 0)
 			return err;
-		}
 	}
 	return 0;
 }
--=20
1.5.5-rc3.GIT

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

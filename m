From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 08/19] Code clean-up for sound/arm/omap/omap-alsa-sx1-mixer.c
Date: Tue, 15 Apr 2008 10:02:12 -0400
Message-ID: <1208268143-8789-9-git-send-email-edubezval@gmail.com>
References: <1208268143-8789-1-git-send-email-edubezval@gmail.com>
 <1208268143-8789-2-git-send-email-edubezval@gmail.com>
 <1208268143-8789-3-git-send-email-edubezval@gmail.com>
 <1208268143-8789-4-git-send-email-edubezval@gmail.com>
 <1208268143-8789-5-git-send-email-edubezval@gmail.com>
 <1208268143-8789-6-git-send-email-edubezval@gmail.com>
 <1208268143-8789-7-git-send-email-edubezval@gmail.com>
 <1208268143-8789-8-git-send-email-edubezval@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:48065 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758764AbYDOOCd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Apr 2008 10:02:33 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3FE2PD4018693
	for <linux-omap@vger.kernel.org>; Tue, 15 Apr 2008 17:02:31 +0300
In-Reply-To: <1208268143-8789-8-git-send-email-edubezval@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Eduardo Valentin <eduardo.valentin@indt.org.br>

From: Eduardo Valentin <eduardo.valentin@indt.org.br>

Removed lots of whitespaces and a few errors and
warnings reported by checkpatch.pl.

Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
---
 sound/arm/omap/omap-alsa-sx1-mixer.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/arm/omap/omap-alsa-sx1-mixer.c b/sound/arm/omap/omap-alsa-sx1-mixer.c
index 631b080..d0c3322 100644
--- a/sound/arm/omap/omap-alsa-sx1-mixer.c
+++ b/sound/arm/omap/omap-alsa-sx1-mixer.c
@@ -111,9 +111,9 @@ static int pcm_playback_target_info(struct snd_kcontrol *kcontrol,
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
 	uinfo->value.enumerated.items = PLAYBACK_TARGET_COUNT;
-	if (uinfo->value.enumerated.item > PLAYBACK_TARGET_COUNT - 1) {
+	if (uinfo->value.enumerated.item > PLAYBACK_TARGET_COUNT - 1)
 		uinfo->value.enumerated.item = PLAYBACK_TARGET_COUNT - 1;
-	}
+
 	strcpy(uinfo->value.enumerated.name,
 			texts[uinfo->value.enumerated.item]);
 	return 0;
@@ -210,14 +210,14 @@ static int headset_playback_volume_info(struct snd_kcontrol *kcontrol,
 }
 
 static int headset_playback_volume_get(struct snd_kcontrol *kcontrol,
-						struct snd_ctl_elem_value *ucontrol)
+					struct snd_ctl_elem_value *ucontrol)
 {
 	ucontrol->value.integer.value[0]	= current_volume;
 	return 0;
 }
 
 static int headset_playback_volume_put(struct snd_kcontrol *kcontrol,
-						struct snd_ctl_elem_value *ucontrol)
+					struct snd_ctl_elem_value *ucontrol)
 {
 	return set_mixer_volume(ucontrol->value.integer.value[0]);
 }
@@ -233,14 +233,14 @@ static int headset_playback_switch_info(struct snd_kcontrol *kcontrol,
 }
 
 static int headset_playback_switch_get(struct snd_kcontrol *kcontrol,
-						struct snd_ctl_elem_value *ucontrol)
+					struct snd_ctl_elem_value *ucontrol)
 {
 	ucontrol->value.integer.value[0] = 1;
 	return 0;
 }
 
 static int headset_playback_switch_put(struct snd_kcontrol *kcontrol,
-						struct snd_ctl_elem_value *ucontrol)
+					struct snd_ctl_elem_value *ucontrol)
 {
 	/* mute/unmute headset */
 #if 0
@@ -262,14 +262,14 @@ static int fmradio_playback_volume_info(struct snd_kcontrol *kcontrol,
 }
 
 static int fmradio_playback_volume_get(struct snd_kcontrol *kcontrol,
-						struct snd_ctl_elem_value *ucontrol)
+					struct snd_ctl_elem_value *ucontrol)
 {
 	ucontrol->value.integer.value[0] = current_fm_volume;
 	return 0;
 }
 
 static int fmradio_playback_volume_put(struct snd_kcontrol *kcontrol,
-						struct snd_ctl_elem_value *ucontrol)
+					struct snd_ctl_elem_value *ucontrol)
 {
 	int ret = current_fm_volume != ucontrol->value.integer.value[0];
 	int i;
@@ -291,14 +291,14 @@ static int fmradio_playback_switch_info(struct snd_kcontrol *kcontrol,
 }
 
 static int fmradio_playback_switch_get(struct snd_kcontrol *kcontrol,
-						struct snd_ctl_elem_value *ucontrol)
+					struct snd_ctl_elem_value *ucontrol)
 {
 	ucontrol->value.integer.value[0] = 1;
 	return 0;
 }
 
 static int fmradio_playback_switch_put(struct snd_kcontrol *kcontrol,
-						struct snd_ctl_elem_value *ucontrol)
+					struct snd_ctl_elem_value *ucontrol)
 {
 	/* mute/unmute FM radio */
 	if (ucontrol->value.integer.value[0])
@@ -460,7 +460,7 @@ int snd_omap_mixer(struct snd_card_omap_codec *egold)
 	if (!egold)
 		return -EINVAL;
 
-	for (i=0; i < ARRAY_SIZE(egold_control); i++) {
+	for (i = 0; i < ARRAY_SIZE(egold_control); i++) {
 		err = snd_ctl_add(egold->card,
 				snd_ctl_new1(&egold_control[i], egold->card));
 		if (err < 0)
-- 
1.5.5-rc3.GIT


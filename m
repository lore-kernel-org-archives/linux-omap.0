From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 16/19] Code clean-up for sound/arm/omap/omap-alsa-tsc2102-mixer.c
Date: Tue, 15 Apr 2008 10:02:20 -0400
Message-ID: <1208268143-8789-17-git-send-email-edubezval@gmail.com>
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
 <1208268143-8789-13-git-send-email-edubezval@gmail.com>
 <1208268143-8789-14-git-send-email-edubezval@gmail.com>
 <1208268143-8789-15-git-send-email-edubezval@gmail.com>
 <1208268143-8789-16-git-send-email-edubezval@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:64757 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753360AbYDOOC7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Apr 2008 10:02:59 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3FDrDf6022308
	for <linux-omap@vger.kernel.org>; Tue, 15 Apr 2008 09:05:13 -0500
In-Reply-To: <1208268143-8789-16-git-send-email-edubezval@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Eduardo Valentin <eduardo.valentin@indt.org.br>

From: Eduardo Valentin <eduardo.valentin@indt.org.br>

Removed lots of whitespaces and a few errors and
warnings reported by checkpatch.pl.

Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
---
 sound/arm/omap/omap-alsa-tsc2102-mixer.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/arm/omap/omap-alsa-tsc2102-mixer.c b/sound/arm/omap/omap-alsa-tsc2102-mixer.c
index d1c8b65..71e07c0 100644
--- a/sound/arm/omap/omap-alsa-tsc2102-mixer.c
+++ b/sound/arm/omap/omap-alsa-tsc2102-mixer.c
@@ -83,8 +83,10 @@ void init_playback_targets(void)
 	/* Unmute */
 	tsc2102_set_mute(0, 0);
 
-	mute[0] = mute[1] = 0;
-	filter[0] = filter[1] = 0;
+	mute[0] = 0;
+	mute[1] = 0;
+	filter[0] = 0;
+	filter[1] = 0;
 }
 
 /*
@@ -147,7 +149,7 @@ static int __pcm_playback_switch_get(struct snd_kcontrol *kcontrol,
 }
 
 static int __pcm_playback_switch_put(struct snd_kcontrol *kcontrol,
-		struct snd_ctl_elem_value *ucontrol) 
+		struct snd_ctl_elem_value *ucontrol)
 {
 	mute[0] = (ucontrol->value.integer.value[0] == 0);	/* L */
 	mute[1] = (ucontrol->value.integer.value[1] == 0);	/* R */
@@ -174,7 +176,7 @@ static int __pcm_playback_deemphasis_get(struct snd_kcontrol *kcontrol,
 }
 
 static int __pcm_playback_deemphasis_put(struct snd_kcontrol *kcontrol,
-		struct snd_ctl_elem_value *ucontrol) 
+		struct snd_ctl_elem_value *ucontrol)
 {
 	filter[0] = (ucontrol->value.integer.value[0] > 0);
 
@@ -200,7 +202,7 @@ static int __pcm_playback_bassboost_get(struct snd_kcontrol *kcontrol,
 }
 
 static int __pcm_playback_bassboost_put(struct snd_kcontrol *kcontrol,
-		struct snd_ctl_elem_value *ucontrol) 
+		struct snd_ctl_elem_value *ucontrol)
 {
 	filter[1] = (ucontrol->value.integer.value[0] > 0);
 
@@ -271,7 +273,7 @@ int snd_omap_mixer(struct snd_card_omap_codec *tsc2102)
 	if (!tsc2102)
 		return -EINVAL;
 
-	for (i = 0; i < ARRAY_SIZE(tsc2102_controls); i ++) {
+	for (i = 0; i < ARRAY_SIZE(tsc2102_controls); i++) {
 		err = snd_ctl_add(tsc2102->card,
 				snd_ctl_new1(&tsc2102_controls[i],
 				tsc2102->card));
-- 
1.5.5-rc3.GIT


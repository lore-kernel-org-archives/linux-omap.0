From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 16/19] Code clean-up for sound/arm/omap/omap-alsa-tsc2102-mixer.c
Date: Fri, 18 Apr 2008 04:01:03 -0400
Message-ID: <1208505666-13744-17-git-send-email-edubezval@gmail.com>
References: <1208505666-13744-1-git-send-email-edubezval@gmail.com>
 <1208505666-13744-2-git-send-email-edubezval@gmail.com>
 <1208505666-13744-3-git-send-email-edubezval@gmail.com>
 <1208505666-13744-4-git-send-email-edubezval@gmail.com>
 <1208505666-13744-5-git-send-email-edubezval@gmail.com>
 <1208505666-13744-6-git-send-email-edubezval@gmail.com>
 <1208505666-13744-7-git-send-email-edubezval@gmail.com>
 <1208505666-13744-8-git-send-email-edubezval@gmail.com>
 <1208505666-13744-9-git-send-email-edubezval@gmail.com>
 <1208505666-13744-10-git-send-email-edubezval@gmail.com>
 <1208505666-13744-11-git-send-email-edubezval@gmail.com>
 <1208505666-13744-12-git-send-email-edubezval@gmail.com>
 <1208505666-13744-13-git-send-email-edubezval@gmail.com>
 <1208505666-13744-14-git-send-email-edubezval@gmail.com>
 <1208505666-13744-15-git-send-email-edubezval@gmail.com>
 <1208505666-13744-16-git-send-email-edubezval@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:18817 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756762AbYDRIBZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Apr 2008 04:01:25 -0400
In-Reply-To: <1208505666-13744-16-git-send-email-edubezval@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <me@felipebalbi.com>, Ragner Magalhaes <ragner.magalhaes@indt.org.br>, Eduardo Valentin <eduardo.valentin@indt.org.br>

From: Eduardo Valentin <eduardo.valentin@indt.org.br>

Removed lots of whitespaces and a few errors and
warnings reported by checkpatch.pl.

Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
---
 sound/arm/omap/omap-alsa-tsc2102-mixer.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/arm/omap/omap-alsa-tsc2102-mixer.c b/sound/arm/omap/omap-alsa-tsc2102-mixer.c
index 99b1a1d..cf1f852 100644
--- a/sound/arm/omap/omap-alsa-tsc2102-mixer.c
+++ b/sound/arm/omap/omap-alsa-tsc2102-mixer.c
@@ -82,8 +82,10 @@ void init_playback_targets(void)
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
@@ -146,7 +148,7 @@ static int __pcm_playback_switch_get(struct snd_kcontrol *kcontrol,
 }
 
 static int __pcm_playback_switch_put(struct snd_kcontrol *kcontrol,
-		struct snd_ctl_elem_value *ucontrol) 
+		struct snd_ctl_elem_value *ucontrol)
 {
 	mute[0] = (ucontrol->value.integer.value[0] == 0);	/* L */
 	mute[1] = (ucontrol->value.integer.value[1] == 0);	/* R */
@@ -173,7 +175,7 @@ static int __pcm_playback_deemphasis_get(struct snd_kcontrol *kcontrol,
 }
 
 static int __pcm_playback_deemphasis_put(struct snd_kcontrol *kcontrol,
-		struct snd_ctl_elem_value *ucontrol) 
+		struct snd_ctl_elem_value *ucontrol)
 {
 	filter[0] = (ucontrol->value.integer.value[0] > 0);
 
@@ -199,7 +201,7 @@ static int __pcm_playback_bassboost_get(struct snd_kcontrol *kcontrol,
 }
 
 static int __pcm_playback_bassboost_put(struct snd_kcontrol *kcontrol,
-		struct snd_ctl_elem_value *ucontrol) 
+		struct snd_ctl_elem_value *ucontrol)
 {
 	filter[1] = (ucontrol->value.integer.value[0] > 0);
 
@@ -270,7 +272,7 @@ int snd_omap_mixer(struct snd_card_omap_codec *tsc2102)
 	if (!tsc2102)
 		return -EINVAL;
 
-	for (i = 0; i < ARRAY_SIZE(tsc2102_controls); i ++) {
+	for (i = 0; i < ARRAY_SIZE(tsc2102_controls); i++) {
 		err = snd_ctl_add(tsc2102->card,
 				snd_ctl_new1(&tsc2102_controls[i],
 				tsc2102->card));
-- 
1.5.5-rc3.GIT


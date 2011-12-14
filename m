From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 09/10] ASoC: omap-abe-twl6040: Add missing audio route information
Date: Wed, 14 Dec 2011 11:47:02 +0200
Message-ID: <1323856022-24053-10-git-send-email-peter.ujfalusi@ti.com>
References: <1323856022-24053-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:53538 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755668Ab1LNJtW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Dec 2011 04:49:22 -0500
Received: by mail-lpp01m010-f47.google.com with SMTP id i14so303773lam.34
        for <linux-omap@vger.kernel.org>; Wed, 14 Dec 2011 01:49:21 -0800 (PST)
In-Reply-To: <1323856022-24053-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

AUXL/R: connected to FM transmitter on SDP4430
Vibra: connected to vibrator drivers (only SDP4430)

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-abe-twl6040.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/omap-abe-twl6040.c b/sound/soc/omap/omap-abe-twl6040.c
index 25a75f3..05c6474 100644
--- a/sound/soc/omap/omap-abe-twl6040.c
+++ b/sound/soc/omap/omap-abe-twl6040.c
@@ -121,6 +121,7 @@ static const struct snd_soc_dapm_widget twl6040_dapm_widgets[] = {
 	SND_SOC_DAPM_INPUT("FM Stereo In"),
 	SND_SOC_DAPM_LINE("FM Stereo Out", NULL),
 	SND_SOC_DAPM_LINE("Line In", NULL),
+	SND_SOC_DAPM_SPK("Vibrators", NULL),
 };
 
 static const struct snd_soc_dapm_route sdp4430_audio_map[] = {
@@ -147,6 +148,14 @@ static const struct snd_soc_dapm_route sdp4430_audio_map[] = {
 	/* Aux/FM Stereo In: AFML, AFMR */
 	{"AFML", NULL, "FM Stereo In"},
 	{"AFMR", NULL, "FM Stereo In"},
+
+	/* AUXL/R output to FM transmitter */
+	{"FM Stereo Out", NULL, "AUXL"},
+	{"FM Stereo Out", NULL, "AUXR"},
+
+	/* Vibra outputs */
+	{"Vibrators", NULL, "VIBRAL"},
+	{"Vibrators", NULL, "VIBRAR"},
 };
 
 static const struct snd_soc_dapm_route panda_audio_map[] = {
-- 
1.7.8


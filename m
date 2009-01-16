From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 1/1] ASoC: Fix the power update function for snd_soc_dapm_value_mux
Date: Fri, 16 Jan 2009 09:48:06 +0200
Message-ID: <1232092086-30074-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1232092086-30074-1-git-send-email-peter.ujfalusi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:37471 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754579AbZAPHsb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Jan 2009 02:48:31 -0500
In-Reply-To: <1232092086-30074-1-git-send-email-peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>, Takashi Iwai <tiwai@suse.de>

Modify the check for the mux type to also handle the
snd_soc_dapm_value_mux type in a same way as the snd_soc_dapm_mux.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/soc-dapm.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 493a4e8..a2f1da8 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -720,7 +720,8 @@ static int dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
 	struct snd_soc_dapm_path *path;
 	int found = 0;
 
-	if (widget->id != snd_soc_dapm_mux)
+	if (widget->id != snd_soc_dapm_mux &&
+	    widget->id != snd_soc_dapm_value_mux)
 		return -ENODEV;
 
 	if (!snd_soc_test_bits(widget->codec, e->reg, mask, val))
-- 
1.6.1


From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v7 06/20] OMAPDSS: omapdss.h: Remove audio_state member of struct omap_dss_device
Date: Wed, 12 Nov 2014 12:49:08 +0200
Message-ID: <2c129e22e96eba98ec1d825d01c25571272da13b.1415786458.git.jsarha@ti.com>
References: <cover.1415786458.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39548 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752797AbaKLKtm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Nov 2014 05:49:42 -0500
In-Reply-To: <cover.1415786458.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, Jyri Sarha <jsarha@ti.com>

The audio_state member is not used.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 include/video/omapdss.h |    9 ---------
 1 file changed, 9 deletions(-)

diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 069dfca..9f2699f 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -166,13 +166,6 @@ enum omap_dss_display_state {
 	OMAP_DSS_DISPLAY_ACTIVE,
 };
 
-enum omap_dss_audio_state {
-	OMAP_DSS_AUDIO_DISABLED = 0,
-	OMAP_DSS_AUDIO_ENABLED,
-	OMAP_DSS_AUDIO_CONFIGURED,
-	OMAP_DSS_AUDIO_PLAYING,
-};
-
 struct omap_dss_audio {
 	struct snd_aes_iec958 *iec;
 	struct snd_cea_861_aud_if *cea;
@@ -783,8 +776,6 @@ struct omap_dss_device {
 
 	enum omap_dss_display_state state;
 
-	enum omap_dss_audio_state audio_state;
-
 	/* OMAP DSS output specific fields */
 
 	struct list_head list;
-- 
1.7.9.5


From: lamikr <lamikr@cc.jyu.fi>
Subject: [PATCH 5/5] omap-alsa-tsc2101: fix iPAQ h6300 playback.
Date: Fri, 31 Mar 2006 01:55:53 +0300
Message-ID: <442C61F9.7050805@cc.jyu.fi>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030309040808040109080006"
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
--------------030309040808040109080006
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit



--------------030309040808040109080006
Content-Type: text/plain;
	name="0005-omap-alsa-tsc2101-fix-iPAQ-h6300-playback.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="0005-omap-alsa-tsc2101-fix-iPAQ-h6300-playback.txt"

>From nobody Mon Sep 17 00:00:00 2001
From: lamikr <lamikr@cc.jyu.fi)>
Date: Fri Mar 31 01:28:30 2006 +0300
Subject: [PATCH 5/5] omap-alsa-tsc2101: fix iPAQ h6300 playback.

Signed-off-by: lamikr <lamikr@cc.jyu.fi>


---

 sound/arm/omap/omap-alsa-tsc2101.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

30d54226a403e3c7d8cfb06aebffa005f5392bcb
diff --git a/sound/arm/omap/omap-alsa-tsc2101.c b/sound/arm/omap/omap-alsa-tsc2101.c
index c3abe1d..14afcc6 100644
--- a/sound/arm/omap/omap-alsa-tsc2101.c
+++ b/sound/arm/omap/omap-alsa-tsc2101.c
@@ -96,7 +96,11 @@ static const struct tsc2101_samplerate_r
 static snd_pcm_hardware_t tsc2101_snd_omap_alsa_playback = {
 	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID),	
-	.formats = (SNDRV_PCM_FMTBIT_S16_LE),
+#ifdef CONFIG_MACH_OMAP_H6300
+	.formats = (SNDRV_PCM_FMTBIT_S8),
+#else
+ 	.formats = (SNDRV_PCM_FMTBIT_S16_LE),
+#endif
 	.rates = (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |
 		  SNDRV_PCM_RATE_16000 |
 		  SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 |
-- 
1.2.2


--------------030309040808040109080006
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------030309040808040109080006--

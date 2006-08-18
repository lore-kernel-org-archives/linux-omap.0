From: lamikr <lamikr@cc.jyu.fi>
Subject: [PATCH 3/5] Fix init warning in tsc2101 alsa driver.
Date: Fri, 18 Aug 2006 04:15:56 +0300
Message-ID: <44E514CC.9030706@cc.jyu.fi>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010400020305030805090705"
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
--------------010400020305030805090705
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Fix init warning in tsc2101 alsa driver. WARNING:
sound/arm/omap/snd-omap-alsa-tsc2101.o - Section mismatch: reference to
.init.text: from .data between '' (at offset 0x6c) and
'tsc2101_snd_omap_alsa_capture'

Signed-off-by: Mika Laitio <lamikr@cc.jyu.fi>



--------------010400020305030805090705
Content-Type: text/x-patch;
	name="0003-fix-init-warning-in-tsc2101-alsa-driver.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="0003-fix-init-warning-in-tsc2101-alsa-driver.patch"

>From a72985872597a4c7358a977dac9754afc7e59795 Mon Sep 17 00:00:00 2001
From: Mika Laitio <lamikr@cc.jyu.fi>
Date: Fri, 18 Aug 2006 02:44:01 +0300
Subject: [PATCH 3/5] fix init warning in tsc2101 alsa driver.

Fix init warning in tsc2101 alsa driver. WARNING: sound/arm/omap/snd-omap-alsa-tsc2101.o - Section mismatch: reference to .init.text: from .data between '' (at offset 0x6c) and 'tsc2101_snd_omap_alsa_capture'

Signed-off-by: Mika Laitio <lamikr@cc.jyu.fi>
---
 sound/arm/omap/omap-alsa-tsc2101.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/arm/omap/omap-alsa-tsc2101.c b/sound/arm/omap/omap-alsa-tsc2101.c
index 14afcc6..9bbf0c7 100644
--- a/sound/arm/omap/omap-alsa-tsc2101.c
+++ b/sound/arm/omap/omap-alsa-tsc2101.c
@@ -381,7 +381,7 @@ int tsc2101_get_default_samplerate(void)
 	return DEFAULT_SAMPLE_RATE;
 }
 
-static int __init snd_omap_alsa_tsc2101_probe(struct platform_device *pdev)
+static int __devinit snd_omap_alsa_tsc2101_probe(struct platform_device *pdev)
 {
 	int	ret;
 	struct	omap_alsa_codec_config *codec_cfg;
-- 
1.4.2


--------------010400020305030805090705
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------010400020305030805090705--

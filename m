From: Thomas Weber <weber@corscience.de>
Subject: [PATCH] ASoC/MFD: twl4030: Fix dependencies for audio codec
Date: Mon,  5 Sep 2011 11:26:33 +0200
Message-ID: <1315214793-661-1-git-send-email-weber@corscience.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:61726 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802Ab1IEJ1M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Sep 2011 05:27:12 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: peter.ujfalusi@ti.com, sameo@linux.intel.com, linux-omap@vger.kernel.org, broonie@opensource.wolfsonicro.com, tiwai@suse.de, alsa-devel@alsa-project.org, Thomas Weber <weber@corscience.de>

The codec for Devkit8000 (TWL4030)  was not detected except
when build with CONFIG_SND_SOC_ALL_CODECS.

twl-core.c still uses the CONFIG_TWL4030_CODEC for
twl_has_codec().

In commit 57fe7251f5bfc4332f24479376de48a1e8ca6211
the CONFIG_TWL4030_CODEC was renamed
into CONFIG_MFD_TWL4030_AUDIO, thatswhy the codec
was not detected.

This patch renames the CONFIG_ TWL4030_CODEC into
CONFIG_MFD_TWL4030_AUDIO in twl-core.c.

Signed-off-by: Thomas Weber <weber@corscience.de>
---
 drivers/mfd/twl-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 01ecfee..b8eef46 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -109,7 +109,7 @@
 #define twl_has_watchdog()        false
 #endif
 
-#if defined(CONFIG_TWL4030_CODEC) || defined(CONFIG_TWL4030_CODEC_MODULE) ||\
+#if defined(CONFIG_MFD_TWL4030_AUDIO) || defined(CONFIG_MFD_TWL4030_AUDIO_MODULE) ||\
 	defined(CONFIG_TWL6040_CORE) || defined(CONFIG_TWL6040_CORE_MODULE)
 #define twl_has_codec()	true
 #else
-- 
1.7.6.1


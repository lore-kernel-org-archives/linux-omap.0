From: Paul Bolle <pebolle@tiscali.nl>
Subject: [PATCH] ASoC: OMAP: Remove obsolete Makefile line
Date: Thu, 30 May 2013 09:37:40 +0200
Message-ID: <1369899460.23034.31.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Support for omap2evm was removed in v3.0. But only one of its two
lines in this Makefile was removed. Remove the second line too.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Eyeball tested only.

 sound/soc/omap/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
index 2b22594..a725905 100644
--- a/sound/soc/omap/Makefile
+++ b/sound/soc/omap/Makefile
@@ -26,7 +26,6 @@ obj-$(CONFIG_SND_OMAP_SOC_N810) += snd-soc-n810.o
 obj-$(CONFIG_SND_OMAP_SOC_RX51) += snd-soc-rx51.o
 obj-$(CONFIG_SND_OMAP_SOC_AMS_DELTA) += snd-soc-ams-delta.o
 obj-$(CONFIG_SND_OMAP_SOC_OSK5912) += snd-soc-osk5912.o
-obj-$(CONFIG_SND_OMAP_SOC_OMAP2EVM) += snd-soc-omap2evm.o
 obj-$(CONFIG_SND_OMAP_SOC_AM3517EVM) += snd-soc-am3517evm.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP_ABE_TWL6040) += snd-soc-omap-abe-twl6040.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP_TWL4030) += snd-soc-omap-twl4030.o
-- 
1.7.11.7

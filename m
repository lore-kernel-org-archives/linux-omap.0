From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [RFC 3/7] ASoC: twl6040: Remove dependency on twl4030 from Kconfig
Date: Thu,  2 Feb 2012 14:16:55 +0200
Message-ID: <1328185019-29575-4-git-send-email-peter.ujfalusi@ti.com>
References: <1328185019-29575-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1328185019-29575-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Dmitry Torokhov <dtor@mail.ru>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

twl6040 no longer needs twl4030.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 7c205e7..9462d50 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -56,7 +56,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_TPA6130A2 if I2C
 	select SND_SOC_TLV320DAC33 if I2C
 	select SND_SOC_TWL4030 if TWL4030_CORE
-	select SND_SOC_TWL6040 if TWL4030_CORE
+	select SND_SOC_TWL6040
 	select SND_SOC_UDA134X
 	select SND_SOC_UDA1380 if I2C
 	select SND_SOC_WL1273 if MFD_WL1273_CORE
-- 
1.7.8.4

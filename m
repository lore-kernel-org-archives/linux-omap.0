From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: fix ABE_TWL6040 dependency
Date: Mon, 13 Jun 2016 17:39:43 +0200
Message-ID: <1465832422-2998958-2-git-send-email-arnd@arndb.de>
References: <1465832422-2998958-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465832422-2998958-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The TWL6040 ASoC support has recently started turning on CLK_TWL6040,
but that fails to build when CONFIG_COMMON_CLK is disabled:

warning: (SND_OMAP_SOC_OMAP_ABE_TWL6040) selects CLK_TWL6040 which has unmet direct dependencies (COMMON_CLK && TWL6040_CORE)
0xF18E38F6 Thu Jun 9 18:57:32 CEST 2016 failed
In file included from ../include/linux/clocksource.h:18:0,
                 from ../drivers/clocksource/timer-nps.c:34:
../include/linux/of.h:1005:20: error: comparison of distinct pointer types lacks a cast [-Werror]
        .data = (fn == (fn_type)NULL) ? fn : fn  }
                    ^

This adds a dependency to avoid the invalid configuration.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 443500a3927a ("ASoC: omap: Kconfig: SND_OMAP_SOC_OMAP_ABE_TWL6040 to select CLK_TWL6040")
---
 sound/soc/omap/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index 5c471d920898..f5451c78ede5 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -100,7 +100,7 @@ config SND_OMAP_SOC_OMAP_TWL4030
 
 config SND_OMAP_SOC_OMAP_ABE_TWL6040
 	tristate "SoC Audio support for OMAP boards using ABE and twl6040 codec"
-	depends on TWL6040_CORE && SND_OMAP_SOC
+	depends on TWL6040_CORE && SND_OMAP_SOC && COMMON_CLK
 	depends on ARCH_OMAP4 || (SOC_OMAP5 && MFD_PALMAS) || COMPILE_TEST
 	select SND_OMAP_SOC_DMIC
 	select SND_OMAP_SOC_MCPDM
-- 
2.7.0

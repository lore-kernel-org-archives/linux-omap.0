From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fix ABE_TWL6040 dependency" to the asoc tree
Date: Mon, 13 Jun 2016 17:54:55 +0100
Message-ID: <E1bCV8Z-0004fa-FT@finisterre>
References: <1465832422-2998958-2-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465832422-2998958-2-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

The patch

   ASoC: fix ABE_TWL6040 dependency

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From d13e4362dec91304143875d9b8e1348bdfe69e63 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 13 Jun 2016 17:39:43 +0200
Subject: [PATCH] ASoC: fix ABE_TWL6040 dependency

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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/omap/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index 5185a3844da9..c82fa542c9e7 100644
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
2.8.1

From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: omap: Remove OMAP_MUX dependency from
	Nokia N810 audio support" to the asoc tree
Date: Fri, 27 Apr 2018 11:59:30 +0100
Message-ID: <E1fC16A-0003wv-UI@debutante>
References: <20180425180100.15104-1-jarkko.nikula@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180425180100.15104-1-jarkko.nikula@bitmer.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: alsa-devel@alsa-project.org, tony@atomide.com, Liam Girdwood <lgirdwood@gmail.com>, aaro.koskinen@iki.f, peter.ujfalusi@ti.com, Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The patch

   ASoC: omap: Remove OMAP_MUX dependency from Nokia N810 audio support

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 6534e3ab4b15369a1af63940c91b31b92be45d4f Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Date: Fri, 27 Apr 2018 11:17:15 +0300
Subject: [PATCH] ASoC: omap: Remove OMAP_MUX dependency from Nokia N810 audio
 support

Commit e9f5f1e45608 ("ARM: OMAP2+: Remove legacy mux code") removed
CONFIG_OMAP_MUX making impossible to build Nokia N810 audio support. Remove
this dependency so we can do at least build tests.

Fixes: e9f5f1e45608 ("ARM: OMAP2+: Remove legacy mux code")
Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/omap/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index f5451c78ede5..9d20c9b94477 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -30,7 +30,6 @@ config SND_OMAP_SOC_HDMI_AUDIO
 config SND_OMAP_SOC_N810
 	tristate "SoC Audio support for Nokia N810"
 	depends on SND_OMAP_SOC && MACH_NOKIA_N810 && I2C
-	depends on OMAP_MUX
 	select SND_OMAP_SOC_MCBSP
 	select SND_SOC_TLV320AIC3X
 	help
-- 
2.17.0

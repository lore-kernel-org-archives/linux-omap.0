From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cx20442: Don't ignore regulator_get() errors." to the asoc tree
Date: Mon, 25 Jun 2018 14:15:13 +0100
Message-ID: <E1fXRKr-0008HO-Bk@debutante>
References: <20180624181441.6975-1-jmkrzyszt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180624181441.6975-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Bhumika Goyal <bhumirks@gmail.com>alsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org

The patch

   ASoC: cx20442: Don't ignore regulator_get() errors.

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

>From 50c678772a0b3f9dc6b04262f27e2c373fe03a4d Mon Sep 17 00:00:00 2001
From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Date: Sun, 24 Jun 2018 20:14:41 +0200
Subject: [PATCH] ASoC: cx20442: Don't ignore regulator_get() errors.

In its current shape, the driver just ignores errors returned by
regulator_get() at component_probe().  This doesn't hurt on Amstrad
Delta board as long as it registers the codec device at late_initcall,
when the regulator which depends on basic-mmio-gpio device (probed as
late as at dev_initcall) is already available.  Otherwise the driver
may end up trying to control a codec which is not powered up.

Remove that dependency on initialization order by handling the error.
If the regulator is not yet available and -ENODEV is returned, convert
it to -EPROBE_DEFER to get another chance.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cx20442.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cx20442.c b/sound/soc/codecs/cx20442.c
index 07dd33b09596..ab174b5114dc 100644
--- a/sound/soc/codecs/cx20442.c
+++ b/sound/soc/codecs/cx20442.c
@@ -362,8 +362,27 @@ static int cx20442_component_probe(struct snd_soc_component *component)
 		return -ENOMEM;
 
 	cx20442->por = regulator_get(component->dev, "POR");
-	if (IS_ERR(cx20442->por))
-		dev_warn(component->dev, "failed to get the regulator");
+	if (IS_ERR(cx20442->por)) {
+		int err = PTR_ERR(cx20442->por);
+
+		dev_warn(component->dev, "failed to get POR supply (%d)", err);
+		/*
+		 * When running on a non-dt platform and requested regulator
+		 * is not available, regulator_get() never returns
+		 * -EPROBE_DEFER as it is not able to justify if the regulator
+		 * may still appear later.  On the other hand, the board can
+		 * still set full constraints flag at late_initcall in order
+		 * to instruct regulator_get() to return a dummy one if
+		 * sufficient.  Hence, if we get -ENODEV here, let's convert
+		 * it to -EPROBE_DEFER and wait for the board to decide or
+		 * let Deferred Probe infrastructure handle this error.
+		 */
+		if (err == -ENODEV)
+			err = -EPROBE_DEFER;
+		kfree(cx20442);
+		return err;
+	}
+
 	cx20442->tty = NULL;
 
 	snd_soc_component_set_drvdata(component, cx20442);
-- 
2.18.0.rc2

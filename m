From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH] ASoC: cx20442: Don't ignore regulator_get()
	errors.
Date: Sun, 24 Jun 2018 20:14:41 +0200
Message-ID: <20180624181441.6975-1-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Bhumika Goyal <bhumirks@gmail.com>
List-Id: linux-omap@vger.kernel.org

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
---
Created and tested on linux-4.18-rc1

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
2.16.4

From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ti: Mark expected switch fall-throughs"
	to the asoc tree
Date: Wed, 31 Jul 2019 12:29:45 +0100 (BST)
Message-ID: <20190731112945.E36502742CC3@ypsilon.sirena.org.uk>
References: <20190729221534.GA18696@embeddedor>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7324135832987247995=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20190729221534.GA18696@embeddedor>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Kees Cook <keescook@chromium.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

--===============7324135832987247995==
Content-Type: text/plain

The patch

   ASoC: ti: Mark expected switch fall-throughs

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From 22581e7c51f50fbbadba70499bb5e2d09f830cbb Mon Sep 17 00:00:00 2001
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Mon, 29 Jul 2019 17:15:34 -0500
Subject: [PATCH] ASoC: ti: Mark expected switch fall-throughs
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Mark switch cases where we are expecting to fall through.

This patch fixes the following warning (Building: arm):

sound/soc/ti/n810.c: In function ‘n810_ext_control’:
sound/soc/ti/n810.c:48:10: warning: this statement may fall through [-Wimplicit-fallthrough=]
   line1l = 1;
   ~~~~~~~^~~
sound/soc/ti/n810.c:49:2: note: here
  case N810_JACK_HP:
  ^~~~

sound/soc/ti/rx51.c: In function ‘rx51_ext_control’:
sound/soc/ti/rx51.c:57:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   hs = 1;
   ~~~^~~
sound/soc/ti/rx51.c:58:2: note: here
  case RX51_JACK_HP:
  ^~~~

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Link: https://lore.kernel.org/r/20190729221534.GA18696@embeddedor
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/ti/n810.c | 1 +
 sound/soc/ti/rx51.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/sound/soc/ti/n810.c b/sound/soc/ti/n810.c
index 2c3f2a4c1700..3ad2b6daf31e 100644
--- a/sound/soc/ti/n810.c
+++ b/sound/soc/ti/n810.c
@@ -46,6 +46,7 @@ static void n810_ext_control(struct snd_soc_dapm_context *dapm)
 	switch (n810_jack_func) {
 	case N810_JACK_HS:
 		line1l = 1;
+		/* fall through */
 	case N810_JACK_HP:
 		hp = 1;
 		break;
diff --git a/sound/soc/ti/rx51.c b/sound/soc/ti/rx51.c
index bc6046534fa5..ccd0e8a07dd1 100644
--- a/sound/soc/ti/rx51.c
+++ b/sound/soc/ti/rx51.c
@@ -55,6 +55,7 @@ static void rx51_ext_control(struct snd_soc_dapm_context *dapm)
 		break;
 	case RX51_JACK_HS:
 		hs = 1;
+		/* fall through */
 	case RX51_JACK_HP:
 		hp = 1;
 		break;
-- 
2.20.1


--===============7324135832987247995==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7324135832987247995==--

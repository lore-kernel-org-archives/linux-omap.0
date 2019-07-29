From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ASoC: ti: Mark expected switch fall-throughs
Date: Mon, 29 Jul 2019 17:15:34 -0500
Message-ID: <20190729221534.GA18696@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Kees Cook <keescook@chromium.org>
List-Id: linux-omap@vger.kernel.org

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
2.22.0

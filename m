From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 4/7] ASoC: omap-dmic: Mark expected switch
	fall-throughs
Date: Fri, 3 Aug 2018 11:31:48 -0500
Message-ID: <e75dd38f324254c9c002b9a90b513aa8504dd639.1533312229.git.gustavo@embeddedor.com>
References: <cover.1533312229.git.gustavo@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <cover.1533312229.git.gustavo@embeddedor.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: linux-omap@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 1468847 ("Missing break in switch")
Addresses-Coverity-ID: 1468849 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/soc/omap/omap-dmic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/omap/omap-dmic.c b/sound/soc/omap/omap-dmic.c
index 51dd7c6..fe96627 100644
--- a/sound/soc/omap/omap-dmic.c
+++ b/sound/soc/omap/omap-dmic.c
@@ -213,8 +213,10 @@ static int omap_dmic_dai_hw_params(struct snd_pcm_substream *substream,
 	switch (channels) {
 	case 6:
 		dmic->ch_enabled |= OMAP_DMIC_UP3_ENABLE;
+		/* fall through */
 	case 4:
 		dmic->ch_enabled |= OMAP_DMIC_UP2_ENABLE;
+		/* fall through */
 	case 2:
 		dmic->ch_enabled |= OMAP_DMIC_UP1_ENABLE;
 		break;
-- 
2.7.4

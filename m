From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] ASoC: omap: constify snd_soc_ops structures
Date: Sat, 18 Mar 2017 19:34:11 +0530
Message-ID: <1489845851-25364-1-git-send-email-bhumirks@gmail.com>
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
To: julia.lawall@lip6.fr, peter.ujfalusi@ti.com, jarkko.nikula@bitmer.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: linux-omap@vger.kernel.org

Declare snd_soc_ops structures as const as they are only stored
in the ops field of a snd_soc_dai_link structure. This field is
of type const, so snd_soc_ops structures having this property
can be made const too.

Cross compiled the .o files for arm architecture.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/soc/omap/am3517evm.c        | 2 +-
 sound/soc/omap/n810.c             | 2 +-
 sound/soc/omap/omap-abe-twl6040.c | 2 +-
 sound/soc/omap/omap-twl4030.c     | 2 +-
 sound/soc/omap/omap3pandora.c     | 2 +-
 sound/soc/omap/osk5912.c          | 2 +-
 sound/soc/omap/rx51.c             | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/omap/am3517evm.c b/sound/soc/omap/am3517evm.c
index 25a33e9..d565102 100644
--- a/sound/soc/omap/am3517evm.c
+++ b/sound/soc/omap/am3517evm.c
@@ -49,7 +49,7 @@ static int am3517evm_hw_params(struct snd_pcm_substream *substream,
 	return ret;
 }
 
-static struct snd_soc_ops am3517evm_ops = {
+static const struct snd_soc_ops am3517evm_ops = {
 	.hw_params = am3517evm_hw_params,
 };
 
diff --git a/sound/soc/omap/n810.c b/sound/soc/omap/n810.c
index fdecb70..71e5f31 100644
--- a/sound/soc/omap/n810.c
+++ b/sound/soc/omap/n810.c
@@ -124,7 +124,7 @@ static int n810_hw_params(struct snd_pcm_substream *substream,
 	return err;
 }
 
-static struct snd_soc_ops n810_ops = {
+static const struct snd_soc_ops n810_ops = {
 	.startup = n810_startup,
 	.hw_params = n810_hw_params,
 	.shutdown = n810_shutdown,
diff --git a/sound/soc/omap/omap-abe-twl6040.c b/sound/soc/omap/omap-abe-twl6040.c
index 89fe95e..614b18d 100644
--- a/sound/soc/omap/omap-abe-twl6040.c
+++ b/sound/soc/omap/omap-abe-twl6040.c
@@ -70,7 +70,7 @@ static int omap_abe_hw_params(struct snd_pcm_substream *substream,
 	return ret;
 }
 
-static struct snd_soc_ops omap_abe_ops = {
+static const struct snd_soc_ops omap_abe_ops = {
 	.hw_params = omap_abe_hw_params,
 };
 
diff --git a/sound/soc/omap/omap-twl4030.c b/sound/soc/omap/omap-twl4030.c
index 7431314..a24b0de 100644
--- a/sound/soc/omap/omap-twl4030.c
+++ b/sound/soc/omap/omap-twl4030.c
@@ -73,7 +73,7 @@ static int omap_twl4030_hw_params(struct snd_pcm_substream *substream,
 	return snd_soc_runtime_set_dai_fmt(rtd, fmt);
 }
 
-static struct snd_soc_ops omap_twl4030_ops = {
+static const struct snd_soc_ops omap_twl4030_ops = {
 	.hw_params = omap_twl4030_hw_params,
 };
 
diff --git a/sound/soc/omap/omap3pandora.c b/sound/soc/omap/omap3pandora.c
index 732e749..4e3de71 100644
--- a/sound/soc/omap/omap3pandora.c
+++ b/sound/soc/omap/omap3pandora.c
@@ -184,7 +184,7 @@ static int omap3pandora_in_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
-static struct snd_soc_ops omap3pandora_ops = {
+static const struct snd_soc_ops omap3pandora_ops = {
 	.hw_params = omap3pandora_hw_params,
 };
 
diff --git a/sound/soc/omap/osk5912.c b/sound/soc/omap/osk5912.c
index aa4053b..e409677 100644
--- a/sound/soc/omap/osk5912.c
+++ b/sound/soc/omap/osk5912.c
@@ -68,7 +68,7 @@ static int osk_hw_params(struct snd_pcm_substream *substream,
 	return err;
 }
 
-static struct snd_soc_ops osk_ops = {
+static const struct snd_soc_ops osk_ops = {
 	.startup = osk_startup,
 	.hw_params = osk_hw_params,
 	.shutdown = osk_shutdown,
diff --git a/sound/soc/omap/rx51.c b/sound/soc/omap/rx51.c
index a768457..66ac358 100644
--- a/sound/soc/omap/rx51.c
+++ b/sound/soc/omap/rx51.c
@@ -123,7 +123,7 @@ static int rx51_hw_params(struct snd_pcm_substream *substream,
 				      SND_SOC_CLOCK_IN);
 }
 
-static struct snd_soc_ops rx51_ops = {
+static const struct snd_soc_ops rx51_ops = {
 	.startup = rx51_startup,
 	.hw_params = rx51_hw_params,
 };
-- 
2.7.4

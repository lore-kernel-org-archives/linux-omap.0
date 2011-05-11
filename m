From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH] ASoC: omap-mcbsp: Remove restrictive checks
	for cpu type
Date: Wed, 11 May 2011 19:25:35 +0530
Message-ID: <1305122135-27938-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Jarkko@alsa-project.org, Sanjeev Premi <premi@ti.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: linux-omap@vger.kernel.org

Current checks for cpu type were too restrictive leading
to failures for other silicons in same family.

The problem was found while testing audio playback on
AM37x and AM35x processors. But should exist on OMAP36xx
as well.

Signed-off-by: Sanjeev Premi <premi@ti.com>
cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
cc: Liam Girdwood <lrg@ti.com>
cc: Jarkko Nikula <jhnikula@gmail.com>
---

 Changes in v4:
   Reposting after validating that patch still applies cleanly on
   linux-omap master [46966f1]

   Changed the subject as suggested by Jarkko. Since the subject
   has changed, i have omitted v4.

 Changes in v3::
   None. Reposting[1] after subscribing to alsa-devel list

 Changes in v2:
   1) Added one more check to the changes.
   2) Updated commit message to use plurals.


 [1] http://marc.info/?l=linux-omap&m=130026430110592&w=2


 sound/soc/omap/omap-mcbsp.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 2175f09..a88a0bf 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -146,7 +146,7 @@ static int omap_mcbsp_dai_startup(struct snd_pcm_substream *substream,
 	 * 2 channels (stereo): size is 128 / 2 = 64 frames (2 * 64 words)
 	 * 4 channels: size is 128 / 4 = 32 frames (4 * 32 words)
 	 */
-	if (cpu_is_omap343x() || cpu_is_omap44xx()) {
+	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
 		/*
 		* Rule for the buffer size. We should not allow
 		* smaller buffer than the FIFO size to avoid underruns
@@ -258,7 +258,7 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 	default:
 		return -EINVAL;
 	}
-	if (cpu_is_omap343x()) {
+	if (cpu_is_omap34xx()) {
 		dma_data->set_threshold = omap_mcbsp_set_threshold;
 		/* TODO: Currently, MODE_ELEMENT == MODE_FRAME */
 		if (omap_mcbsp_get_dma_op_mode(bus_id) ==
-- 
1.7.2.2

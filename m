From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 2/8] ASoC: omap-mcbsp: Skip
	dma_data.maxburst initialization
Date: Thu, 8 Nov 2018 09:29:54 +0200
Message-ID: <20181108073000.21114-3-peter.ujfalusi@ti.com>
References: <20181108073000.21114-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20181108073000.21114-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, jarkko.nikula@bitmer.com
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

It is configured runtime so no need to initialize it.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
 sound/soc/omap/mcbsp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
index d6784f2887e4..8c3cedfcb878 100644
--- a/sound/soc/omap/mcbsp.c
+++ b/sound/soc/omap/mcbsp.c
@@ -1035,11 +1035,8 @@ int omap_mcbsp_init(struct platform_device *pdev)
 
 	mcbsp->dma_data[0].addr = omap_mcbsp_dma_reg_params(mcbsp,
 						SNDRV_PCM_STREAM_PLAYBACK);
-	mcbsp->dma_data[0].maxburst = 4;
-
 	mcbsp->dma_data[1].addr = omap_mcbsp_dma_reg_params(mcbsp,
 						SNDRV_PCM_STREAM_CAPTURE);
-	mcbsp->dma_data[1].maxburst = 4;
 
 	mcbsp->fclk = clk_get(&pdev->dev, "fck");
 	if (IS_ERR(mcbsp->fclk)) {
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

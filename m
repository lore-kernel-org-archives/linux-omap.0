From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: omap-mcbsp: Clean up dma_data addr
	initialization code" to the asoc tree
Date: Tue, 13 Nov 2018 18:33:47 +0000 (GMT)
Message-ID: <20181113183347.DC459440078@finisterre.ee.mobilebroadband>
References: <20181108073000.21114-2-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20181108073000.21114-2-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, jarkko.nikula@bitmer.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The patch

   ASoC: omap-mcbsp: Clean up dma_data addr initialization code

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

>From dd443a7c0b00edb9aa471a18e4238b0199b3a3ad Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Thu, 8 Nov 2018 09:29:53 +0200
Subject: [PATCH] ASoC: omap-mcbsp: Clean up dma_data addr initialization code

Make the omap_mcbsp_dma_reg_params() a bit more intuitive to read for the
first glance by using SNDRV_PCM_STREAM_PLAYBACK/CAPTURE and to group the
outermost if case by stream direction.

While there, fix the outdated comment for the function.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Tested-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/omap/mcbsp.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
index 79d4dc785e5c..d6784f2887e4 100644
--- a/sound/soc/omap/mcbsp.c
+++ b/sound/soc/omap/mcbsp.c
@@ -227,28 +227,27 @@ void omap_mcbsp_config(struct omap_mcbsp *mcbsp,
 
 /**
  * omap_mcbsp_dma_reg_params - returns the address of mcbsp data register
- * @id - mcbsp id
- * @stream - indicates the direction of data flow (rx or tx)
+ * @mcbsp: omap_mcbsp struct for the McBSP instance
+ * @stream: Stream direction (playback/capture)
  *
  * Returns the address of mcbsp data transmit register or data receive register
- * to be used by DMA for transferring/receiving data based on the value of
- * @stream for the requested mcbsp given by @id
+ * to be used by DMA for transferring/receiving data
  */
 static int omap_mcbsp_dma_reg_params(struct omap_mcbsp *mcbsp,
 				     unsigned int stream)
 {
 	int data_reg;
 
-	if (mcbsp->pdata->reg_size == 2) {
-		if (stream)
-			data_reg = OMAP_MCBSP_REG_DRR1;
-		else
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		if (mcbsp->pdata->reg_size == 2)
 			data_reg = OMAP_MCBSP_REG_DXR1;
-	} else {
-		if (stream)
-			data_reg = OMAP_MCBSP_REG_DRR;
 		else
 			data_reg = OMAP_MCBSP_REG_DXR;
+	} else {
+		if (mcbsp->pdata->reg_size == 2)
+			data_reg = OMAP_MCBSP_REG_DRR1;
+		else
+			data_reg = OMAP_MCBSP_REG_DRR;
 	}
 
 	return mcbsp->phys_dma_base + data_reg * mcbsp->pdata->reg_step;
@@ -1034,10 +1033,12 @@ int omap_mcbsp_init(struct platform_device *pdev)
 		mcbsp->dma_data[1].filter_data = "rx";
 	}
 
-	mcbsp->dma_data[0].addr = omap_mcbsp_dma_reg_params(mcbsp, 0);
+	mcbsp->dma_data[0].addr = omap_mcbsp_dma_reg_params(mcbsp,
+						SNDRV_PCM_STREAM_PLAYBACK);
 	mcbsp->dma_data[0].maxburst = 4;
 
-	mcbsp->dma_data[1].addr = omap_mcbsp_dma_reg_params(mcbsp, 1);
+	mcbsp->dma_data[1].addr = omap_mcbsp_dma_reg_params(mcbsp,
+						SNDRV_PCM_STREAM_CAPTURE);
 	mcbsp->dma_data[1].maxburst = 4;
 
 	mcbsp->fclk = clk_get(&pdev->dev, "fck");
-- 
2.19.1

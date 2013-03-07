From: Sebastien Guiriec <s-guiriec@ti.com>
Subject: [PATCH 2/5] ASoC: omap-dmic: Update driver for DMA DT
	binding.
Date: Thu, 7 Mar 2013 13:43:21 +0100
Message-ID: <1362660204-27074-3-git-send-email-s-guiriec@ti.com>
References: <1362660204-27074-1-git-send-email-s-guiriec@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1362660204-27074-1-git-send-email-s-guiriec@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sebastien Guiriec <s-guiriec@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Update the driver in order to use OMAP DMA DT binding instead of
hwmod data for DT boot.

Signed-off-by: Sebastien Guiriec <s-guiriec@ti.com>
---
 sound/soc/omap/omap-dmic.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/sound/soc/omap/omap-dmic.c b/sound/soc/omap/omap-dmic.c
index ba49ccd..8695b32 100644
--- a/sound/soc/omap/omap-dmic.c
+++ b/sound/soc/omap/omap-dmic.c
@@ -62,6 +62,7 @@ struct omap_dmic {
  */
 static struct omap_pcm_dma_data omap_dmic_dai_dma_params = {
 	.name		= "DMIC capture",
+	.dma_name	= "up_link",
 };
 
 static inline void omap_dmic_write(struct omap_dmic *dmic, u16 reg, u32 val)
@@ -478,13 +479,15 @@ static int asoc_dmic_probe(struct platform_device *pdev)
 	}
 	omap_dmic_dai_dma_params.port_addr = res->start + OMAP_DMIC_DATA_REG;
 
-	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
-	if (!res) {
-		dev_err(dmic->dev, "invalid dma resource\n");
-		ret = -ENODEV;
-		goto err_put_clk;
+	if (!pdev->dev.of_node) {
+		res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
+		if (!res) {
+			dev_err(dmic->dev, "invalid dma resource\n");
+			ret = -ENODEV;
+			goto err_put_clk;
+		}
+		omap_dmic_dai_dma_params.dma_req = res->start;
 	}
-	omap_dmic_dai_dma_params.dma_req = res->start;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mpu");
 	if (!res) {
-- 
1.7.10.4

From: Sebastien Guiriec <s-guiriec@ti.com>
Subject: [PATCH] ASoC: omap-mcpdm: Remove useless ressource get.
Date: Mon, 11 Feb 2013 14:02:42 +0100
Message-ID: <1360587762-29072-1-git-send-email-s-guiriec@ti.com>
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
To: Sebastien Guiriec <s-guiriec@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org

Remove unused memory ressource get from McPDM driver.

Signed-off-by: Sebastien Guiriec <s-guiriec@ti.com>
---
 sound/soc/omap/omap-mcpdm.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
index 2fe8be2..5ca11bd 100644
--- a/sound/soc/omap/omap-mcpdm.c
+++ b/sound/soc/omap/omap-mcpdm.c
@@ -449,10 +449,6 @@ static int asoc_mcpdm_probe(struct platform_device *pdev)
 	omap_mcpdm_dai_dma_params[0].port_addr = res->start + MCPDM_REG_DN_DATA;
 	omap_mcpdm_dai_dma_params[1].port_addr = res->start + MCPDM_REG_UP_DATA;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res == NULL)
-		return -ENOMEM;
-
 	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "dn_link");
 	if (!res)
 		return -ENODEV;
-- 
1.7.10.4

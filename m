From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH v4 04/16] mtd: onenand: omap2: Remove regulator support
Date: Sat, 11 Nov 2017 22:19:08 +0100
Message-ID: <20171111211908.66xd2bw4xoeudz7g@lenoch>
References: <20171111211206.465pgorrjp3eyix6@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20171111211206.465pgorrjp3eyix6@lenoch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Kyungmin Park <kyungmin.park@samsung.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

As no platform data user sets regulator_can_sleep, regulator code is
no-op and can be deleted.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 Changes:
 -v2: new patch
 -v3: none
 -v4: none

 drivers/mtd/onenand/omap2.c | 42 +-----------------------------------------
 1 file changed, 1 insertion(+), 41 deletions(-)

diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
index 24a1388d3031..a03e1fe4aa48 100644
--- a/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -34,7 +34,6 @@
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
 #include <linux/slab.h>
-#include <linux/regulator/consumer.h>
 #include <linux/gpio.h>
 
 #include <asm/mach/flash.h>
@@ -59,7 +58,6 @@ struct omap2_onenand {
 	int dma_channel;
 	int freq;
 	int (*setup)(void __iomem *base, int *freq_ptr);
-	struct regulator *regulator;
 	u8 flags;
 };
 
@@ -583,30 +581,6 @@ static void omap2_onenand_shutdown(struct platform_device *pdev)
 	memset((__force void *)c->onenand.base, 0, ONENAND_BUFRAM_SIZE);
 }
 
-static int omap2_onenand_enable(struct mtd_info *mtd)
-{
-	int ret;
-	struct omap2_onenand *c = container_of(mtd, struct omap2_onenand, mtd);
-
-	ret = regulator_enable(c->regulator);
-	if (ret != 0)
-		dev_err(&c->pdev->dev, "can't enable regulator\n");
-
-	return ret;
-}
-
-static int omap2_onenand_disable(struct mtd_info *mtd)
-{
-	int ret;
-	struct omap2_onenand *c = container_of(mtd, struct omap2_onenand, mtd);
-
-	ret = regulator_disable(c->regulator);
-	if (ret != 0)
-		dev_err(&c->pdev->dev, "can't disable regulator\n");
-
-	return ret;
-}
-
 static int omap2_onenand_probe(struct platform_device *pdev)
 {
 	struct omap_onenand_platform_data *pdata;
@@ -726,22 +700,11 @@ static int omap2_onenand_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (pdata->regulator_can_sleep) {
-		c->regulator = regulator_get(&pdev->dev, "vonenand");
-		if (IS_ERR(c->regulator)) {
-			dev_err(&pdev->dev,  "Failed to get regulator\n");
-			r = PTR_ERR(c->regulator);
-			goto err_release_dma;
-		}
-		c->onenand.enable = omap2_onenand_enable;
-		c->onenand.disable = omap2_onenand_disable;
-	}
-
 	if (pdata->skip_initial_unlocking)
 		this->options |= ONENAND_SKIP_INITIAL_UNLOCKING;
 
 	if ((r = onenand_scan(&c->mtd, 1)) < 0)
-		goto err_release_regulator;
+		goto err_release_dma;
 
 	r = mtd_device_register(&c->mtd, pdata ? pdata->parts : NULL,
 				pdata ? pdata->nr_parts : 0);
@@ -754,8 +717,6 @@ static int omap2_onenand_probe(struct platform_device *pdev)
 
 err_release_onenand:
 	onenand_release(&c->mtd);
-err_release_regulator:
-	regulator_put(c->regulator);
 err_release_dma:
 	if (c->dma_channel != -1)
 		omap_free_dma(c->dma_channel);
@@ -779,7 +740,6 @@ static int omap2_onenand_remove(struct platform_device *pdev)
 	struct omap2_onenand *c = dev_get_drvdata(&pdev->dev);
 
 	onenand_release(&c->mtd);
-	regulator_put(c->regulator);
 	if (c->dma_channel != -1)
 		omap_free_dma(c->dma_channel);
 	omap2_onenand_shutdown(pdev);
-- 
2.11.0


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

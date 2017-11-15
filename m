From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH v5 11/16] mtd: onenand: omap2: Do not make delay for GPIO
 OMAP3 specific
Date: Wed, 15 Nov 2017 17:34:25 +0100
Message-ID: <20171115163424.zznur37je35kcdno@lenoch>
References: <20171115162306.2o2w2yrf7wucroxd@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20171115162306.2o2w2yrf7wucroxd@lenoch>
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
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Kyungmin Park <kyungmin.park@samsung.com>, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Second commit in driver history (782b7a367d81: "[MTD] [OneNAND] OMAP3:
add delay for GPIO") added quirk for waiting until GPIO line settle.
As DMA was disabled for OMAP2 boards, chances are this problem was
not OMAP3 specific and as it is just one register read, previous
test for SoC type is approximately as expensive as read itself.
Make delay unconditional, which allows removing SoC specific code
alltogether.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Acked-by: Roger Quadros <rogerq@ti.com>
Tested-by: Tony Lindgren <tony@atomide.com>
---

Changes in v5: None
Changes in v4: None
Changes in v3:
- new patch

Changes in v2: None

 drivers/mtd/onenand/omap2.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
index c9ff67100ef4..e4857a41760d 100644
--- a/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -57,7 +57,6 @@ struct omap2_onenand {
 	struct dma_chan *dma_chan;
 	int freq;
 	int (*setup)(void __iomem *base, int *freq_ptr);
-	u8 flags;
 };
 
 static void omap2_onenand_dma_complete_func(void *completion)
@@ -148,9 +147,8 @@ static int omap2_onenand_wait(struct mtd_info *mtd, int state)
 		if (!(syscfg & ONENAND_SYS_CFG1_IOBE)) {
 			syscfg |= ONENAND_SYS_CFG1_IOBE;
 			write_reg(c, syscfg, ONENAND_REG_SYS_CFG1);
-			if (c->flags & ONENAND_IN_OMAP34XX)
-				/* Add a delay to let GPIO settle */
-				syscfg = read_reg(c, ONENAND_REG_SYS_CFG1);
+			/* Add a delay to let GPIO settle */
+			syscfg = read_reg(c, ONENAND_REG_SYS_CFG1);
 		}
 
 		reinit_completion(&c->irq_done);
@@ -470,7 +468,6 @@ static int omap2_onenand_probe(struct platform_device *pdev)
 
 	init_completion(&c->irq_done);
 	init_completion(&c->dma_done);
-	c->flags = pdata->flags;
 	c->gpmc_cs = pdata->cs;
 	c->gpio_irq = pdata->gpio_irq;
 	if (pdata->dma_channel < 0) {
-- 
2.11.0


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

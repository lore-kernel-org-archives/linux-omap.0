From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH v3 6/7] mtd: onenand: omap2: Do not make delay for GPIO OMAP3
 specific
Date: Thu, 9 Nov 2017 10:16:12 +0100
Message-ID: <20171109091612.qfkfjvu2ajwymcjr@lenoch>
References: <20171109091155.6a6azfvjarwvlfh2@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20171109091155.6a6azfvjarwvlfh2@lenoch>
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
Cc: Tony Lindgren <tony@atomide.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Kyungmin Park <kyungmin.park@samsung.com>, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Second commit in driver history (782b7a367d81: "[MTD] [OneNAND] OMAP3:
add delay for GPIO") added quirk for waiting until GPIO line settle.
As DMA was disabled for OMAP2 boards, chances are this problem was
not OMAP3 specific and as it is just one register read, previous
test for SoC type is approximately as expensive as read itself.
Make delay unconditional, which allows removing SoC specific code
alltogether.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 Changes:
 -v3: new patch

 drivers/mtd/onenand/omap2.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
index 5760e40be008..13da0b8c418b 100644
--- a/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -58,7 +58,6 @@ struct omap2_onenand {
 	int dma_channel;
 	int freq;
 	int (*setup)(void __iomem *base, int *freq_ptr);
-	u8 flags;
 };
 
 static void omap2_onenand_dma_cb(int lch, u16 ch_status, void *data)
@@ -151,9 +150,8 @@ static int omap2_onenand_wait(struct mtd_info *mtd, int state)
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
@@ -461,7 +459,6 @@ static int omap2_onenand_probe(struct platform_device *pdev)
 
 	init_completion(&c->irq_done);
 	init_completion(&c->dma_done);
-	c->flags = pdata->flags;
 	c->gpmc_cs = pdata->cs;
 	c->gpio_irq = pdata->gpio_irq;
 	c->dma_channel = pdata->dma_channel;
-- 
2.11.0


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

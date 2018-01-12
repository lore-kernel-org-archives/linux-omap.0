From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH v6 12/14] mtd: onenand: omap2: Decouple DMA enabling from INT
 pin availability
Date: Fri, 12 Jan 2018 14:16:57 +0100
Message-ID: <20180112131657.GM13810@lenoch>
References: <20180112131105.GA13810@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180112131105.GA13810@lenoch>
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

INT pin (gpio_irq) is not really needed for DMA but only for notification
when a command that needs wait has completed. DMA memcpy can be still used
even without gpio_irq available, so enable it unconditionally.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---

Changes in v6: None
Changes in v5:
- rename patch and fix commit message

Changes in v4:
- new patch

Changes in v3: None
Changes in v2: None

 drivers/mtd/onenand/omap2.c | 52 ++++++++++++++++++---------------------------
 1 file changed, 21 insertions(+), 31 deletions(-)

diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
index e4857a41760d..1cd78a076759 100644
--- a/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -152,17 +152,13 @@ static int omap2_onenand_wait(struct mtd_info *mtd, int state)
 		}
 
 		reinit_completion(&c->irq_done);
-		if (c->gpio_irq) {
-			result = gpio_get_value(c->gpio_irq);
-			if (result == -1) {
-				ctrl = read_reg(c, ONENAND_REG_CTRL_STATUS);
-				intr = read_reg(c, ONENAND_REG_INTERRUPT);
-				wait_err("gpio error", state, ctrl, intr);
-				return -EIO;
-			}
-		} else
-			result = 0;
-		if (result == 0) {
+		result = gpio_get_value(c->gpio_irq);
+		if (result < 0) {
+			ctrl = read_reg(c, ONENAND_REG_CTRL_STATUS);
+			intr = read_reg(c, ONENAND_REG_INTERRUPT);
+			wait_err("gpio error", state, ctrl, intr);
+			return -EIO;
+		} else if (result == 0) {
 			int retry_cnt = 0;
 retry:
 			if (!wait_for_completion_io_timeout(&c->irq_done,
@@ -450,6 +446,7 @@ static void omap2_onenand_shutdown(struct platform_device *pdev)
 
 static int omap2_onenand_probe(struct platform_device *pdev)
 {
+	dma_cap_mask_t mask;
 	struct omap_onenand_platform_data *pdata;
 	struct omap2_onenand *c;
 	struct onenand_chip *this;
@@ -513,31 +510,25 @@ static int omap2_onenand_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev,  "Failed to request GPIO%d for "
 				"OneNAND\n", c->gpio_irq);
 			goto err_iounmap;
-	}
-	gpio_direction_input(c->gpio_irq);
+		}
+		gpio_direction_input(c->gpio_irq);
 
-	if ((r = request_irq(gpio_to_irq(c->gpio_irq),
-			     omap2_onenand_interrupt, IRQF_TRIGGER_RISING,
-			     pdev->dev.driver->name, c)) < 0)
-		goto err_release_gpio;
-	}
+		if ((r = request_irq(gpio_to_irq(c->gpio_irq),
+				     omap2_onenand_interrupt, IRQF_TRIGGER_RISING,
+				     pdev->dev.driver->name, c)) < 0)
+			goto err_release_gpio;
 
-	if (pdata->dma_channel >= 0) {
-		dma_cap_mask_t mask;
+		this->wait = omap2_onenand_wait;
+	}
 
-		dma_cap_zero(mask);
-		dma_cap_set(DMA_MEMCPY, mask);
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_MEMCPY, mask);
 
-		c->dma_chan = dma_request_channel(mask, NULL, NULL);
-		if (!c->dma_chan)
-			dev_info(&pdev->dev,
-				 "failed to allocate DMA for OneNAND, "
-				 "using PIO instead\n");
-	}
+	c->dma_chan = dma_request_channel(mask, NULL, NULL);
 
 	dev_info(&pdev->dev, "initializing on CS%d, phys base 0x%08lx, virtual "
-		 "base %p, freq %d MHz\n", c->gpmc_cs, c->phys_base,
-		 c->onenand.base, c->freq);
+		 "base %p, freq %d MHz, %s mode\n", c->gpmc_cs, c->phys_base,
+		 c->onenand.base, c->freq, c->dma_chan ? "DMA" : "PIO");
 
 	c->pdev = pdev;
 	c->mtd.priv = &c->onenand;
@@ -547,7 +538,6 @@ static int omap2_onenand_probe(struct platform_device *pdev)
 
 	this = &c->onenand;
 	if (c->dma_chan) {
-		this->wait = omap2_onenand_wait;
 		this->read_bufferram = omap2_onenand_read_bufferram;
 		this->write_bufferram = omap2_onenand_write_bufferram;
 	}
-- 
2.15.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

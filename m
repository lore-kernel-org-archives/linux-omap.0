From: Vignesh R <vigneshr@ti.com>
Subject: [RFC PATCH 2/2] mtd: devices: m25p80: Enable spi-nor bounce buffer
 support
Date: Mon, 27 Feb 2017 17:38:39 +0530
Message-ID: <20170227120839.16545-3-vigneshr@ti.com>
References: <20170227120839.16545-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20170227120839.16545-1-vigneshr@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Cyrille Pitchen <cyrille.pitchen@atmel.com>
Cc: Frode Isaksen <fisaksen@baylibre.com>, Vignesh R <vigneshr@ti.com>, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Many SPI controller drivers use DMA to read/write from m25p80 compatible
flashes. Therefore enable bounce buffers support provided by spi-nor
framework to take care of handling vmalloc'd buffers which may not be
DMA'able.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/mtd/devices/m25p80.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index c4df3b1bded0..d05acf22eadf 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -241,6 +241,7 @@ static int m25p_probe(struct spi_device *spi)
 	else
 		flash_name = spi->modalias;
 
+	nor->flags |= SNOR_F_USE_BOUNCE_BUFFER;
 	ret = spi_nor_scan(nor, flash_name, mode);
 	if (ret)
 		return ret;
-- 
2.11.0


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

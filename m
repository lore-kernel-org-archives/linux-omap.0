From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] spi: omap2-mcspi: Fix mcspi FIFO usage
Date: Mon, 20 Jan 2014 15:14:04 +0530
Message-ID: <1390211044-9791-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The following commit add Fifo support for omap mcspi.
commit d33f473dcd8e69321f001ba330d648f475b504c9
Author: Illia Smyrnov <illia.smyrnov-l0cyMroinI0@public.gmane.org>
Date:   Mon Jun 17 16:31:06 2013 +0300

    spi: omap2-mcspi: Add FIFO buffer support

Currently, enabling of FIFO is done based on rx_buf or tx_buf checks
and only one of the RX or TX fifo is enabled. There can be transfers
in which both RX/TX fifo is desired. Hence, fixing code for the
same to allow setting both TX/RX fifo when needed.

Application:
While doing a loopback testing on beaglebone white(DMA
with FIFO enabled), where both RX and TX buf buffers are passed,
./spidev_test hangs.
The $subject patch fixes that hang and data can be loopbacked.

Signed-off-by: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/spi-omap2-mcspi.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index ed4af47..86402a7 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -299,7 +299,9 @@ static void omap2_mcspi_set_fifo(const struct spi_device *spi,
 		if (t->rx_buf != NULL) {
 			chconf |= OMAP2_MCSPI_CHCONF_FFER;
 			xferlevel |= (fifo_depth - 1) << 8;
-		} else {
+		}
+
+		if (t->tx_buf != NULL) {
 			chconf |= OMAP2_MCSPI_CHCONF_FFET;
 			xferlevel |= fifo_depth - 1;
 		}
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

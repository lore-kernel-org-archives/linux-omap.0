From: Michael Welling <mwelling@ieee.org>
Subject: [PATCH 3/4] spi: omap2-mcspi: Fix GPIO chip select support
Date: Sat, 23 May 2015 21:13:44 -0500
Message-ID: <1432433625-23407-4-git-send-email-mwelling@ieee.org>
References: <20150522122544.GL21391@sirena.org.uk>
 <1432433625-23407-1-git-send-email-mwelling@ieee.org>
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <1432433625-23407-1-git-send-email-mwelling@ieee.org>
Sender: linux-next-owner@vger.kernel.org
To: broonie@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-next@vger.kernel.org, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Michael Welling <mwelling@ieee.org>
List-Id: linux-omap@vger.kernel.org

The OMAP2_MCSPI_CHCONF_FORCE must be toggled even when using GPIO
chip selects. This patch conditionally calls the omap2_mcspi_set_cs 
function to do so when using GPIO chip selects.

Signed-off-by: Michael Welling <mwelling@ieee.org>
---
 drivers/spi/spi-omap2-mcspi.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 502db29..c4e21ad 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1108,6 +1108,9 @@ static int omap2_mcspi_work_one(struct omap2_mcspi *mcspi,
 
 	omap2_mcspi_set_enable(spi, 0);
 
+	if (gpio_is_valid(spi->cs_gpio))
+		omap2_mcspi_set_cs(spi, spi->mode & SPI_CS_HIGH);
+
 	if (par_override ||
 	    (t->speed_hz != spi->max_speed_hz) ||
 	    (t->bits_per_word != spi->bits_per_word)) {
@@ -1192,6 +1195,9 @@ out:
 
 	omap2_mcspi_set_enable(spi, 0);
 
+	if (gpio_is_valid(spi->cs_gpio))
+		omap2_mcspi_set_cs(spi, !(spi->mode & SPI_CS_HIGH));
+
 	if (mcspi->fifo_depth > 0 && t)
 		omap2_mcspi_set_fifo(spi, t, 0);
 
-- 
1.7.9.5

From: Michael Welling <mwelling@ieee.org>
Subject: [PATCH 2/4] spi: omap2-mcspi: Fix set_cs function for active high
Date: Sat, 23 May 2015 21:13:43 -0500
Message-ID: <1432433625-23407-3-git-send-email-mwelling@ieee.org>
References: <20150522122544.GL21391@sirena.org.uk>
 <1432433625-23407-1-git-send-email-mwelling@ieee.org>
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <1432433625-23407-1-git-send-email-mwelling@ieee.org>
Sender: linux-next-owner@vger.kernel.org
To: broonie@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-next@vger.kernel.org, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Michael Welling <mwelling@ieee.org>
List-Id: linux-omap@vger.kernel.org

The core spi driver swaps the polarity of the enable based on SPI_CS_HIGH.
The omap2 controller has an internal configuration register bit called
OMAP2_MCSPI_CHCONF_EPOL to handle active high chip selects as well.

So we have to revert swap the polarity back for the correct setting of the
OMAP2_MCSPI_CHCONF_FORCE bit in omap2_mcspi_set_cs.

Signed-off-by: Michael Welling <mwelling@ieee.org>
---
 drivers/spi/spi-omap2-mcspi.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 304b427..502db29 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -247,6 +247,13 @@ static void omap2_mcspi_set_cs(struct spi_device *spi, bool enable)
 {
 	u32 l;
 
+	/* The controller handles the inverted chip selects
+	 * using the OMAP2_MCSPI_CHCONF_EPOL bit so revert
+	 * the inversion from the core spi_set_cs function.
+	 */
+	if (spi->mode & SPI_CS_HIGH)
+		enable = !enable;
+
 	if (spi->controller_state) {
 		l = mcspi_cached_chconf0(spi);
 
-- 
1.7.9.5

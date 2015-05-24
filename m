From: Michael Welling <mwelling@ieee.org>
Subject: [PATCH 4/4] spi: omap2-mcspi: Handle error on gpio_request
Date: Sat, 23 May 2015 21:13:45 -0500
Message-ID: <1432433625-23407-5-git-send-email-mwelling@ieee.org>
References: <20150522122544.GL21391@sirena.org.uk>
 <1432433625-23407-1-git-send-email-mwelling@ieee.org>
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <1432433625-23407-1-git-send-email-mwelling@ieee.org>
Sender: linux-next-owner@vger.kernel.org
To: broonie@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-next@vger.kernel.org, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Michael Welling <mwelling@ieee.org>
List-Id: linux-omap@vger.kernel.org

If a valid GPIO is specified but cannot be requested by the driver, print a
message and error out of omap2_mcspi_setup.

Signed-off-by: Michael Welling <mwelling@ieee.org>
---
 drivers/spi/spi-omap2-mcspi.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index c4e21ad..5867384 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1023,9 +1023,12 @@ static int omap2_mcspi_setup(struct spi_device *spi)
 	}
 
 	if (gpio_is_valid(spi->cs_gpio)) {
-		if (gpio_request(spi->cs_gpio, dev_name(&spi->dev)) == 0)
-			gpio_direction_output(spi->cs_gpio,
-			!(spi->mode & SPI_CS_HIGH));
+		ret = gpio_request(spi->cs_gpio, dev_name(&spi->dev));
+		if (ret) {
+			dev_err(&spi->dev, "failed to request gpio\n");
+			return ret;
+		}
+		gpio_direction_output(spi->cs_gpio, !(spi->mode & SPI_CS_HIGH));
 	}
 
 	ret = pm_runtime_get_sync(mcspi->dev);
-- 
1.7.9.5

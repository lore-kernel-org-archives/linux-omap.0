From: Scott Ellis <scott@jumpnowtek.com>
Subject: [PATCH 6/6] SPI omap2_mcspi.c: Limit debug messages from
 setup_transfer
Date: Fri, 12 Mar 2010 10:22:14 -0500
Message-ID: <1268407334.14445.55.camel@quad>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pan.gwi.net ([207.5.128.165]:4945 "EHLO pan.gwi.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934254Ab0CLPWP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Mar 2010 10:22:15 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: spi-devel-general@lists.sourceforge.net
Cc: David Brownell <dbrownell@users.sourceforge.net>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Andrew Morton <akpm@linux-foundation.org>, Roman Tereshonkov <roman.tereshonkov@nokia.com>, linux-omap@vger.kernel.org, Aaro Koskinen <Aaro.Koskinen@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>

Limit the debug messages put out in omap2_mcspi_setup_transfer().
If you are overriding the speed on transfers, the volume is 
excessive. 

Wrap it with VERBOSE.

Signed-off-by: Scott Ellis <scott@jumpnowtek.com>

 drivers/spi/omap2_mcspi.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index adc6fd3..b2dbbc0 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -637,11 +637,12 @@ static int omap2_mcspi_setup_transfer(struct spi_device *spi,
 
 	mcspi_write_chconf0(spi, l);
 
+#ifdef VERBOSE
 	dev_dbg(&spi->dev, "setup: speed %d, sample %s edge, clk %s\n",
 			OMAP2_MCSPI_MAX_FREQ / (1 << div),
 			(spi->mode & SPI_CPHA) ? "trailing" : "leading",
 			(spi->mode & SPI_CPOL) ? "inverted" : "normal");
-
+#endif
 	return 0;
 }
 






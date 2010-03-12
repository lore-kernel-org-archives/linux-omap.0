From: Scott Ellis <scott@jumpnowtek.com>
Subject: [PATCH 3/6] SPI omap2_mcspi.c: Use appropriate clock divider value
Date: Fri, 12 Mar 2010 10:21:55 -0500
Message-ID: <1268407315.14445.52.camel@quad>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pan.gwi.net ([207.5.128.165]:2424 "EHLO pan.gwi.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934020Ab0CLPV5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Mar 2010 10:21:57 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: spi-devel-general@lists.sourceforge.net
Cc: David Brownell <dbrownell@users.sourceforge.net>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Andrew Morton <akpm@linux-foundation.org>, Roman Tereshonkov <roman.tereshonkov@nokia.com>, linux-omap@vger.kernel.org, Aaro Koskinen <Aaro.Koskinen@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>

The MCSPI_CHxCONF.CLKD register field has different limits 
for the OMAP3 then the OMAP24xx. 

Use the new max_clk_div value from 
omap2_mcspi_platform_config.

Signed-off-by: Scott Ellis <scott@jumpnowtek.com>

 drivers/spi/omap2_mcspi.c |   27 ++++++++++++++++++---------
 1 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index fe1b56d..37e6d73 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -37,6 +37,7 @@
 
 #include <plat/dma.h>
 #include <plat/clock.h>
+#include <plat/mcspi.h>
 

 #define OMAP2_MCSPI_MAX_FREQ		48000000
@@ -128,6 +129,7 @@ struct omap2_mcspi {
 	unsigned long		phys;
 	/* SPI1 has 4 channels, while SPI2 has 2 */
 	struct omap2_mcspi_dma	*dma_channels;
+	int			max_clk_div;
 };
 
 struct omap2_mcspi_cs {
@@ -588,11 +590,12 @@ static int omap2_mcspi_setup_transfer(struct spi_device *spi,
 	cs->word_len = word_len;
 
 	if (spi->max_speed_hz) {
-		while (div <= 15 && (OMAP2_MCSPI_MAX_FREQ / (1 << div))
-					> spi->max_speed_hz)
+		while (div <= mcspi->max_clk_div &&
+			(OMAP2_MCSPI_MAX_FREQ/(1 << div)) > spi->max_speed_hz)
 			div++;
-	} else
-		div = 15;
+	} else {
+		div = mcspi->max_clk_div;
+	}
 
 	l = mcspi_cached_chconf0(spi);
 
@@ -893,6 +896,8 @@ static int omap2_mcspi_transfer(struct spi_device *spi, struct spi_message *m)
 	unsigned long		flags;
 	struct spi_transfer	*t;
 
+	mcspi = spi_master_get_devdata(spi->master);
+
 	m->actual_length = 0;
 	m->status = 0;
 
@@ -917,10 +922,13 @@ static int omap2_mcspi_transfer(struct spi_device *spi, struct spi_message *m)
 					t->bits_per_word);
 			return -EINVAL;
 		}
-		if (t->speed_hz && t->speed_hz < OMAP2_MCSPI_MAX_FREQ/(1<<16)) {
+		if (t->speed_hz &&
+			t->speed_hz < OMAP2_MCSPI_MAX_FREQ
+					/(1 << mcspi->max_clk_div)) {
 			dev_dbg(&spi->dev, "%d Hz max exceeds %d\n",
-					t->speed_hz,
-					OMAP2_MCSPI_MAX_FREQ/(1<<16));
+				t->speed_hz,
+				OMAP2_MCSPI_MAX_FREQ
+					/(1 << mcspi->max_clk_div));
 			return -EINVAL;
 		}
 
@@ -955,8 +963,6 @@ static int omap2_mcspi_transfer(struct spi_device *spi, struct spi_message *m)
 		}
 	}
 
-	mcspi = spi_master_get_devdata(spi->master);
-
 	spin_lock_irqsave(&mcspi->lock, flags);
 	list_add_tail(&m->queue, &mcspi->msg_queue);
 	queue_work(omap2_mcspi_wq, &mcspi->work);
@@ -1049,6 +1055,7 @@ static int __init omap2_mcspi_probe(struct platform_device *pdev)
 	int			status = 0, i;
 	const u8		*rxdma_id, *txdma_id;
 	unsigned		num_chipselect;
+	struct omap2_mcspi_platform_config *pdata;
 
 	switch (pdev->id) {
 	case 1:
@@ -1101,6 +1108,8 @@ static int __init omap2_mcspi_probe(struct platform_device *pdev)
 
 	mcspi = spi_master_get_devdata(master);
 	mcspi->master = master;
+	pdata = (struct omap2_mcspi_platform_config *)pdev->dev.platform_data;
+	mcspi->max_clk_div = pdata->max_clk_div;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (r == NULL) {







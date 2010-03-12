From: Scott Ellis <scott@jumpnowtek.com>
Subject: [PATCH 4/6] SPI omap2_mcspi.c: Use the transfer speed_hz value if
 provided
Date: Fri, 12 Mar 2010 10:22:04 -0500
Message-ID: <1268407324.14445.53.camel@quad>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pan.gwi.net ([207.5.128.165]:3498 "EHLO pan.gwi.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934020Ab0CLPWH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Mar 2010 10:22:07 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: spi-devel-general@lists.sourceforge.net
Cc: David Brownell <dbrownell@users.sourceforge.net>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Andrew Morton <akpm@linux-foundation.org>, Roman Tereshonkov <roman.tereshonkov@nokia.com>, linux-omap@vger.kernel.org, Aaro Koskinen <Aaro.Koskinen@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>

omap2_mcspi_setup_transfer() gets called if a transfer has a non-zero
speed_hz value but it is never used in the function to override the
speed. 

This patch enables its use.

Signed-off-by: Scott Ellis <scott@jumpnowtek.com>

 drivers/spi/omap2_mcspi.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index 37e6d73..2a93a73 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -580,18 +580,24 @@ static int omap2_mcspi_setup_transfer(struct spi_device *spi,
 	struct spi_master *spi_cntrl;
 	u32 l = 0, div = 0;
 	u8 word_len = spi->bits_per_word;
+	u32 speed_hz = spi->max_speed_hz;
 
 	mcspi = spi_master_get_devdata(spi->master);
 	spi_cntrl = mcspi->master;
 
-	if (t != NULL && t->bits_per_word)
-		word_len = t->bits_per_word;
+	if (t != NULL) {
+		if (t->bits_per_word)
+			word_len = t->bits_per_word;
+
+		if (t->speed_hz)
+			speed_hz = t->speed_hz;
+	}
 
 	cs->word_len = word_len;
 
-	if (spi->max_speed_hz) {
+	if (speed_hz) {
 		while (div <= mcspi->max_clk_div &&
-			(OMAP2_MCSPI_MAX_FREQ/(1 << div)) > spi->max_speed_hz)
+			(OMAP2_MCSPI_MAX_FREQ/(1 << div)) > speed_hz)
 			div++;
 	} else {
 		div = mcspi->max_clk_div;






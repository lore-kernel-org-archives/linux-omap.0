From: Scott Ellis <scott@jumpnowtek.com>
Subject: [PATCH] omap2_mcspi.c : Use transaction speed if provided
Date: Mon, 08 Mar 2010 06:50:30 -0500
Message-ID: <1268049030.2558.72.camel@quad>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pan.gwi.net ([207.5.128.165]:3781 "EHLO pan.gwi.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752463Ab0CHNV3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Mar 2010 08:21:29 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@deeprootsystems.com, spi-devel-general@lists.sourceforge.net

omap2_mcspi_transfer() gets called in omap2_mcspi_work() when the
transaction speed_hz or bits_per_word fields are non-zero. 

omap2_mcspi_transfer() does not look at the speed_hz field so
the override speed value is ignored. 

The code should probably change to one of these options.

1. Skip the call to omap2_mcsp_transfer() if the only reason was a 
non-zero speed_hz and it's not going to be used. 

2. Use the new speed_hz value provided


The patch below uses the speed_hz value.

The OMAP2_MCSPI_MAX_CLK_DIV comes from a previous patch submission.


Signed-off-by: Scott Ellis <scott@jumpnowtek.com>


 drivers/spi/omap2_mcspi.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index a73127b..a622560 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -587,6 +587,7 @@ static int omap2_mcspi_setup_transfer(struct spi_device *spi,
 	struct spi_master *spi_cntrl;
 	u32 l = 0, div = 0;
 	u8 word_len = spi->bits_per_word;
+	u32 speed_hz = spi->max_speed_hz;
 
 	mcspi = spi_master_get_devdata(spi->master);
 	spi_cntrl = mcspi->master;
@@ -596,9 +597,12 @@ static int omap2_mcspi_setup_transfer(struct spi_device *spi,
 
 	cs->word_len = word_len;
 
-	if (spi->max_speed_hz) {
+	if (t != NULL && t->speed_hz)
+		speed_hz = t->speed_hz;
+
+	if (speed_hz) {
 		while (div <= OMAP2_MCSPI_MAX_CLK_DIV && 
-			(OMAP2_MCSPI_MAX_FREQ / (1 << div)) > spi->max_speed_hz)
+			(OMAP2_MCSPI_MAX_FREQ / (1 << div)) > speed_hz)
 			div++;
 	} else {
 		div = OMAP2_MCSPI_MAX_CLK_DIV;



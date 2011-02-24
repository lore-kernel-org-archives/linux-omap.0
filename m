From: hannuxx@iki.fi
Subject: [PATCHv2 1/1] OMAP: McSPI: Off-by-one error in finding the right divisor
Date: Thu, 24 Feb 2011 21:31:33 +0200
Message-ID: <2cfdc20e8a843b5c008b9beaa413e35deb0f24a3.1298574394.git.hannuxx@iki.fi>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:35589 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755899Ab1BXTb6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Feb 2011 14:31:58 -0500
Received: by eyx24 with SMTP id 24so358167eyx.19
        for <linux-omap@vger.kernel.org>; Thu, 24 Feb 2011 11:31:57 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, spi-devel-general@lists.sourceforge.net, dbrownell@users.sourceforge.net, grant.likely@secretlab.ca, tony@atomide.com
Cc: ext-phil.2.carmody@nokia.com, hannuxx@iki.fi

From: Hannu Heikkinen <ext-hannu.m.heikkinen@nokia.com>

Off-by-one error, gave erroneous divisor value 16 if speed_hz is over zero but
less than OMAP2_MCSPI_MAX_FREQ / (1 << 15), that is, [1..1463].

Also few overly complex bit shifts in divisor fixed.

Also one dev_dgb line fixed, which indicated max speed exceeding transfer speed.

Introducing a new function omap2_mcspi_calc_divisor() for getting the right
divisor in omap2_mcspi_setup_transfer().

Signed-off-by: Phil Carmody <ext-phil.2.carmody@nokia.com>
Signed-off-by: Hannu Heikkinen <ext-hannu.m.heikkinen@nokia.com>
---
 drivers/spi/omap2_mcspi.c |   29 ++++++++++++++++++-----------
 1 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index 36501ad..c196d56 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -631,6 +631,17 @@ out:
 	return count - c;
 }
 
+static u32 omap2_mcspi_calc_divisor(u32 speed_hz)
+{
+	u32 div;
+
+	for (div = 0; div < 15; div++)
+		if (speed_hz >= (OMAP2_MCSPI_MAX_FREQ >> div))
+			return div;
+
+	return 15;
+}
+
 /* called only when no transfer is active to this device */
 static int omap2_mcspi_setup_transfer(struct spi_device *spi,
 		struct spi_transfer *t)
@@ -653,12 +664,8 @@ static int omap2_mcspi_setup_transfer(struct spi_device *spi,
 	if (t && t->speed_hz)
 		speed_hz = t->speed_hz;
 
-	if (speed_hz) {
-		while (div <= 15 && (OMAP2_MCSPI_MAX_FREQ / (1 << div))
-					> speed_hz)
-			div++;
-	} else
-		div = 15;
+	speed_hz = min_t(u32, speed_hz, OMAP2_MCSPI_MAX_FREQ);
+	div = omap2_mcspi_calc_divisor(speed_hz);
 
 	l = mcspi_cached_chconf0(spi);
 
@@ -695,7 +702,7 @@ static int omap2_mcspi_setup_transfer(struct spi_device *spi,
 	mcspi_write_chconf0(spi, l);
 
 	dev_dbg(&spi->dev, "setup: speed %d, sample %s edge, clk %s\n",
-			OMAP2_MCSPI_MAX_FREQ / (1 << div),
+			OMAP2_MCSPI_MAX_FREQ >> div,
 			(spi->mode & SPI_CPHA) ? "trailing" : "leading",
 			(spi->mode & SPI_CPOL) ? "inverted" : "normal");
 
@@ -996,10 +1003,10 @@ static int omap2_mcspi_transfer(struct spi_device *spi, struct spi_message *m)
 					t->bits_per_word);
 			return -EINVAL;
 		}
-		if (t->speed_hz && t->speed_hz < OMAP2_MCSPI_MAX_FREQ/(1<<16)) {
-			dev_dbg(&spi->dev, "%d Hz max exceeds %d\n",
-					t->speed_hz,
-					OMAP2_MCSPI_MAX_FREQ/(1<<16));
+		if (t->speed_hz && t->speed_hz < (OMAP2_MCSPI_MAX_FREQ >> 15)) {
+			dev_dbg(&spi->dev, "speed_hz %d below minimum %d Hz\n",
+				t->speed_hz,
+				OMAP2_MCSPI_MAX_FREQ >> 15);
 			return -EINVAL;
 		}
 
-- 
1.7.1


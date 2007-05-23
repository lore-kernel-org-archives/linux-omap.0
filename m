From: David Brownell <david-b@pacbell.net>
Subject: [patch linux-omap-git] fix SPI_CPHA related errors
Date: Tue, 22 May 2007 22:32:27 -0700
Message-ID: <200705222232.27584.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

The OMAP SPI controller drivers handle SPI_CPHA incorrectly.
It should mean:

  CPHA=0 ... sample at leading edge of clock
  CPHA=1 ... sample at trailing edge of clock

This fixes them, and the protocol drivers which depended on the wrong
meaning.  Separate ads7846 and omap_uwire patches are going upstream,
already since those drivers were already pushed there.  The tsc2102
code already had this right ... strange.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/input/touchscreen/tsc2046_ts.c |    2 +-
 drivers/spi/omap2_mcspi.c              |    4 ++--
 drivers/spi/tsc2101.c                  |    2 +-
 drivers/spi/tsc2301-core.c             |    2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

--- o26.orig/drivers/spi/omap2_mcspi.c	2007-05-22 22:19:10.000000000 -0700
+++ o26/drivers/spi/omap2_mcspi.c	2007-05-22 22:20:31.000000000 -0700
@@ -550,9 +550,9 @@ static int omap2_mcspi_setup_transfer(st
 	else
 		l &= ~OMAP2_MCSPI_CHCONF_POL;
 	if (spi->mode & SPI_CPHA)
-		l &= ~OMAP2_MCSPI_CHCONF_PHA;
-	else
 		l |= OMAP2_MCSPI_CHCONF_PHA;
+	else
+		l &= ~OMAP2_MCSPI_CHCONF_PHA;
 	mcspi_write_cs_reg(spi, OMAP2_MCSPI_CHCONF0, l);
 
 	dev_dbg(&spi->dev, "setup: speed %d, sample %s edge, clk %s inverted\n",
--- o26.orig/drivers/spi/tsc2101.c	2007-05-22 22:19:10.000000000 -0700
+++ o26/drivers/spi/tsc2101.c	2007-05-22 22:20:31.000000000 -0700
@@ -237,7 +237,7 @@ static int tsc2101_probe(struct spi_devi
 
 	mutex_init(&tsc2101->mutex);
 
-	spi->mode = SPI_MODE_0;
+	spi->mode = SPI_MODE_1;
 	spi->bits_per_word = 16;
 	if ((r = spi_setup(spi)) < 0) {
 		dev_err(&spi->dev, "SPI setup failed\n");
--- o26.orig/drivers/spi/tsc2301-core.c	2007-05-22 22:19:10.000000000 -0700
+++ o26/drivers/spi/tsc2301-core.c	2007-05-22 22:20:31.000000000 -0700
@@ -170,7 +170,7 @@ static int __devinit tsc2301_probe(struc
 	} else
 		tsc->reset_gpio = -1;
 
-	spi->mode = SPI_MODE_0;
+	spi->mode = SPI_MODE_1;
 	spi->bits_per_word = 16;
 	/* The max speed might've been defined by the board-specific
 	 * struct */
--- o26.orig/drivers/input/touchscreen/tsc2046_ts.c	2007-05-22 22:19:10.000000000 -0700
+++ o26/drivers/input/touchscreen/tsc2046_ts.c	2007-05-22 22:20:31.000000000 -0700
@@ -499,7 +499,7 @@ static int __devinit tsc2046_probe(struc
 	tsc->spi = spi;
 	spi->dev.power.power_state = PMSG_ON;
 
-	spi->mode = SPI_MODE_1;
+	spi->mode = SPI_MODE_0;
 	spi->bits_per_word = 16;
 
 	/*

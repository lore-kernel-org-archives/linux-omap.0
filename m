From: Imre Deak <imre.deak@nokia.com>
Subject: [PATCH 1/3] ARM: OMAP: omap2_mcspi: fix for channel configuration
	and CS
Date: Wed, 17 May 2006 01:13:20 +0300
Message-ID: <1147817600.27886.56.camel@mammoth.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

[ resending an earlier patch ]

ARM: OMAP: omap2_mcspi: fix for channel configuration and CS

Fix for channel reconfiguration case: once the EPOL, POL or PHA has been
configured to 1, further configuration on the channel can't change it to
0.
The first CS enable is not needed. The CS will be enabled right before
the transfer anyway, if it's not active.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Index: linux-2.6/drivers/spi/omap2_mcspi.c
===================================================================
--- linux-2.6.orig/drivers/spi/omap2_mcspi.c	2006-05-17 00:21:15.000000000 +0300
+++ linux-2.6/drivers/spi/omap2_mcspi.c	2006-05-17 00:22:13.000000000 +0300
@@ -307,12 +307,18 @@ static int omap2_mcspi_setup_transfer(st
 	l |= (word_len - 1) << 7;
 	if (!(spi->mode & SPI_CS_HIGH))
 		l |= OMAP2_MCSPI_CHCONF_EPOL;
+	else
+		l &= ~OMAP2_MCSPI_CHCONF_EPOL;
 	l &= ~OMAP2_MCSPI_CHCONF_CLKD_MASK;
 	l |= div << 2;
 	if (spi->mode & SPI_CPOL)
 		l |= OMAP2_MCSPI_CHCONF_POL;
+	else
+		l &= ~OMAP2_MCSPI_CHCONF_POL;
 	if (spi->mode & SPI_CPHA)
 		l |= OMAP2_MCSPI_CHCONF_PHA;
+	else
+		l &= ~OMAP2_MCSPI_CHCONF_PHA;
 	mcspi_write_cs_reg(spi, OMAP2_MCSPI_CHCONF0, l);
 
 	return 0;
@@ -349,7 +355,7 @@ static void omap2_mcspi_work(unsigned lo
 		struct spi_message		*m;
 		struct spi_device		*spi;
 		struct spi_transfer		*t = NULL;
-		int				cs_active;
+		int				cs_active = 0;
 		struct omap2_mcspi_device_config *conf;
 		struct omap2_mcspi_cs		*cs;
 		int				par_override = 0;
@@ -365,9 +371,6 @@ static void omap2_mcspi_work(unsigned lo
 		conf = (struct omap2_mcspi_device_config *) spi->controller_data;
 		cs = (struct omap2_mcspi_cs *) spi->controller_state;
 
-		omap2_mcspi_force_cs(spi, 1);
-		cs_active = 1;
-
 		list_for_each_entry(t, &m->transfers, transfer_list) {
 			if (t->tx_buf == NULL && t->rx_buf == NULL && t->len) {
 				status = -EINVAL;

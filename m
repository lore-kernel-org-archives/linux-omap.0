From: Imre Deak <imre.deak@nokia.com>
Subject: [PATCH 2/3] ARM: OMAP: edge selection for McSPI / uWire
Date: Wed, 17 May 2006 01:14:41 +0300
Message-ID: <1147817681.27886.59.camel@mammoth.research.nokia.com>
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

ARM: OMAP: edge selection for McSPI / uWire

SPI mode 0 maps to the case where we have write on rising and read on
falling clock edge. Fix the OMAP2 McSPI and OMAP1 uWire edge selection
accordingly.

In the uWire case the meaning of the HW flag selecting the read edge
selection must be flipped for correct operation and this is in
contradiction with the OMAP1 specification. Tests were performed on SPI
devices using mode 1 (original uWire protocoll) like the ads7846 to
validate this.

Signed-off-by: Imre Deak <imre.deak@nokia.com>

Index: linux-2.6/drivers/spi/omap2_mcspi.c
===================================================================
--- linux-2.6.orig/drivers/spi/omap2_mcspi.c	2006-05-17 00:24:46.000000000 +0300
+++ linux-2.6/drivers/spi/omap2_mcspi.c	2006-05-17 00:26:22.000000000 +0300
@@ -316,9 +316,9 @@ static int omap2_mcspi_setup_transfer(st
 	else
 		l &= ~OMAP2_MCSPI_CHCONF_POL;
 	if (spi->mode & SPI_CPHA)
-		l |= OMAP2_MCSPI_CHCONF_PHA;
-	else
 		l &= ~OMAP2_MCSPI_CHCONF_PHA;
+	else
+		l |= OMAP2_MCSPI_CHCONF_PHA;
 	mcspi_write_cs_reg(spi, OMAP2_MCSPI_CHCONF0, l);
 
 	return 0;
Index: linux-2.6/drivers/spi/omap_uwire.c
===================================================================
--- linux-2.6.orig/drivers/spi/omap_uwire.c	2006-05-17 00:24:50.000000000 +0300
+++ linux-2.6/drivers/spi/omap_uwire.c	2006-05-17 00:26:11.000000000 +0300
@@ -76,8 +76,8 @@
 #define	CS_CMD	(1 << 12)
 
 /* SR1 or SR2 bits */
-#define UWIRE_READ_FALLING_EDGE		0x0000
-#define UWIRE_READ_RISING_EDGE		0x0001
+#define UWIRE_READ_FALLING_EDGE		0x0001
+#define UWIRE_READ_RISING_EDGE		0x0000
 #define UWIRE_WRITE_FALLING_EDGE	0x0000
 #define UWIRE_WRITE_RISING_EDGE		0x0002
 #define UWIRE_CS_ACTIVE_LOW		0x0000
@@ -355,7 +355,7 @@ static int uwire_setup_transfer(struct s
 	switch (spi->mode & (SPI_CPOL | SPI_CPHA)) {
 	case SPI_MODE_0:
 	case SPI_MODE_3:
-		flags |= UWIRE_WRITE_FALLING_EDGE | UWIRE_READ_FALLING_EDGE;
+		flags |= UWIRE_WRITE_RISING_EDGE | UWIRE_READ_FALLING_EDGE;
 		break;
 	case SPI_MODE_1:
 	case SPI_MODE_2:

From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH 1/2] ARM: OMAP: use SPI_MODE_0 for ads7846
Date: Thu, 24 May 2007 10:21:44 -0700
Message-ID: <20070524172156.133029558@mvista.com>
References: <20070524172143.809836878@mvista.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=ads7846-use-spi-mode-0.patch
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

Following on David Brownell's CPHA fixups/cleanups, Convert the
ads7846 driver to SPI_MODE_0 also.

Signed-off-by: Kevin Hilman <khilman@mvista.com>

---
 drivers/input/touchscreen/ads7846.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: dev/drivers/input/touchscreen/ads7846.c
===================================================================
--- dev.orig/drivers/input/touchscreen/ads7846.c
+++ dev/drivers/input/touchscreen/ads7846.c
@@ -848,7 +848,7 @@ static int __devinit ads7846_probe(struc
 	 * may not.  So we stick to very-portable 8 bit words, both RX and TX.
 	 */
 	spi->bits_per_word = 8;
-	spi->mode = SPI_MODE_1;
+	spi->mode = SPI_MODE_0;
 	err = spi_setup(spi);
 	if (err < 0)
 		return err;

--

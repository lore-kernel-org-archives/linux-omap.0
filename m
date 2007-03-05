From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Remove double omap_uwire entry in spi Makefile
Date: Mon, 05 Mar 2007 20:16:58 +0100
Message-ID: <45EC6CAA.9050208@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000404010504040007080401"
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------000404010504040007080401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


[PATCH] ARM: OMAP: Remove double omap_uwire entry in
drivers/spi/Makefile.

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>


--------------000404010504040007080401
Content-Type: text/plain;
 name="omap_uwire_double_makefile_entry_fix.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="omap_uwire_double_makefile_entry_fix.txt"

Index: linux-osk/drivers/spi/Makefile
===================================================================
--- linux-osk.orig/drivers/spi/Makefile
+++ linux-osk/drivers/spi/Makefile
@@ -16,7 +16,6 @@ obj-$(CONFIG_SPI_ATMEL)			+= atmel_spi.o
 obj-$(CONFIG_SPI_BUTTERFLY)		+= spi_butterfly.o
 obj-$(CONFIG_SPI_IMX)			+= spi_imx.o
 obj-$(CONFIG_SPI_PXA2XX)		+= pxa2xx_spi.o
-obj-$(CONFIG_SPI_OMAP_UWIRE)		+= omap_uwire.o
 obj-$(CONFIG_SPI_MPC83xx)		+= spi_mpc83xx.o
 obj-$(CONFIG_SPI_S3C24XX_GPIO)		+= spi_s3c24xx_gpio.o
 obj-$(CONFIG_SPI_S3C24XX)		+= spi_s3c24xx.o


--------------000404010504040007080401
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------000404010504040007080401--

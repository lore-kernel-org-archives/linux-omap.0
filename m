From: Imre Deak <imre.deak@nokia.com>
Subject: [PATCH 3/3] Input: ads7846: select correct SPI mode
Date: Wed, 17 May 2006 01:14:53 +0300
Message-ID: <1147817693.27886.61.camel@mammoth.research.nokia.com>
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

Input: ads7846: select correct SPI mode

The device is using a protocoll where writes are on the falling, reads are
on the rising edge of the clock. This maps to SPI mode 1.

Signed-off-by: Imre Deak <imre.deak@nokia.com>

Index: linux-2.6/drivers/input/touchscreen/ads7846.c
===================================================================
--- linux-2.6.orig/drivers/input/touchscreen/ads7846.c	2006-05-17 00:29:36.000000000 +0300
+++ linux-2.6/drivers/input/touchscreen/ads7846.c	2006-05-17 00:30:17.000000000 +0300
@@ -683,6 +683,10 @@ static int __devinit ads7846_probe(struc
 
 	dev_set_drvdata(&spi->dev, ts);
 	spi->dev.power.power_state = PMSG_ON;
+	spi->mode = SPI_MODE_1;
+	err = spi_setup(spi);
+	if (err < 0)
+		goto err_free_mem;
 
 	ts->spi = spi;
 	ts->input = input_dev;

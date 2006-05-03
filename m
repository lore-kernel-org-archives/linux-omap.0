From: David Brownell <david-b@pacbell.net>
Subject: [PATCH 2.6.17-rc3-omap] omap_uwire byteswap bugfix
Date: Tue, 2 May 2006 22:15:48 -0700
Message-ID: <200605022215.49062.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_FyDWEJcef1gdBWF"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--Boundary-00=_FyDWEJcef1gdBWF
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I mentioned a while back that my original omap_uwire code had some bugs
that came from a bogus optimization ... here's a patch fixing them.
(Please merge...)

The consequence of that bogus optimization is that some SPI protocol
drivers (layered on top of this driver) would get data in strange byte
orders.  Hence for example an ads7846 issue that Juha and Imre noticed,
but were trying to fix at the wrong level.  (So in a moment I'll post
a separate patch for that driver.)

Other drivers layered on top of omap_uwire may also need to revisit
how they've handled byte order.

- Dave


--Boundary-00=_FyDWEJcef1gdBWF
Content-Type: text/x-diff;
  charset="us-ascii";
  name="omap-uwire.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="omap-uwire.patch"

Get rid of broken optimization in MicroWire driver:  don't try to morph
consecutive single-byte operations into one (faster) two-byte operation.
This resolves some byteswap problems.  (And consequently allows fixing
some bugs in at least the OMAP version of the ads7846 driver...)

Also, reject LSB-first device modes; this controller doesn't support them.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: osk/drivers/spi/omap_uwire.c
===================================================================
--- osk.orig/drivers/spi/omap_uwire.c	2006-04-22 14:41:22.000000000 -0700
+++ osk/drivers/spi/omap_uwire.c	2006-05-02 18:37:24.000000000 -0700
@@ -196,6 +196,9 @@ static int uwire_txrx(struct spi_device 
 	if (t->tx_buf && t->rx_buf)
 		return -EPERM;
 
+	if (!bits)
+		bits = 8;
+
 	w = spi->chip_select << 10;
 	w |= CS_CMD;
 
@@ -206,18 +209,15 @@ static int uwire_txrx(struct spi_device 
 
 		/* write one or two bytes at a time */
 		while (len >= 1) {
-			/* tx is msb-aligned */
+			/* tx bit 15 is first sent; we byteswap multibyte words
+			 * (msb-first) on the way out from memory.
+			 */
 			val = *buf++;
-			if (len > 1 && (!bits || bits > 8)) {
-				if (!bits)
-					bits = 16;
+			if (bits > 8) {
 				bytes = 2;
 				val |= *buf++ << 8;
-			} else {
-				if (!bits || bits > 8)
-					bits = 8;
+			} else
 				bytes = 1;
-			}
 			val <<= 16 - bits;
 
 #ifdef	VERBOSE
@@ -253,15 +253,10 @@ static int uwire_txrx(struct spi_device 
 
 		/* read one or two bytes at a time */
 		while (len) {
-			if (len > 1 && (!bits || bits > 8)) {
-				if (!bits)
-					bits = 16;
+			if (bits > 8) {
 				bytes = 2;
-			} else {
-				if (!bits || bits > 8)
-					bits = 8;
+			} else
 				bytes = 1;
-			}
 
 			/* start read */
 			val = START | w | (bits << 0);
@@ -275,7 +270,9 @@ static int uwire_txrx(struct spi_device 
 						RDRB, 0))
 				goto eio;
 
-			/* rx is lsb-aligned */
+			/* rx bit 0 is last received; multibyte words will
+			 * be properly byteswapped on the way to memory.
+			 */
 			val = uwire_read_reg(UWIRE_RDR);
 			val &= (1 << bits) - 1;
 			*buf++ = (u8) val;
@@ -320,6 +317,12 @@ static int uwire_setup(struct spi_device
 		goto done;
 	}
 
+	if (spi->mode & SPI_LSB_FIRST) {
+		pr_debug("%s: lsb first?\n", spi->dev.bus_id);
+		status = -EINVAL;
+		goto done;
+	}
+
 	/* mode 0..3, clock inverted separately;
 	 * standard nCS signaling;
 	 * don't treat DI=high as "not ready"

--Boundary-00=_FyDWEJcef1gdBWF
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--Boundary-00=_FyDWEJcef1gdBWF--

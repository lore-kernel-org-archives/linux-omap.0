From: Imre Deak <imre.deak@nokia.com>
Subject: [PATCH] ARM: OMAP: omap_uwire: wait for tx complete before
	starting the next one
Date: Fri, 09 Jun 2006 18:17:50 +0300
Message-ID: <1149866270.3240.11.camel@mammoth.research.nokia.com>
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
To: Tony Lindgren <tony@atomide.com>
Cc: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

The TDR register shouldn't be written when the CSRB flag is set. The fix
solves the problem where one SPI transfer includes multiple 8 or 16 bit
tx elements and the current transfer can be corrupted by accessing the
TDR too early.

Signed-off-by: Imre Deak <imre.deak@nokia.com>

diff --git a/drivers/spi/omap_uwire.c b/drivers/spi/omap_uwire.c
index ce4b992..6375256 100644
--- a/drivers/spi/omap_uwire.c
+++ b/drivers/spi/omap_uwire.c
@@ -240,12 +240,13 @@ static int uwire_txrx(struct spi_device 
 			pr_debug("%s: write-%d =%04x\n",
 					spi->dev.bus_id, bits, val);
 #endif
+			if (wait_uwire_csr_flag(CSRB, 0, 0))
+				goto eio;
+
 			uwire_write_reg(UWIRE_TDR, val);
 
 			/* start write */
 			val = START | w | (bits << 5);
-			if (wait_uwire_csr_flag(CSRB, 0, 0))
-				goto eio;
 
 			uwire_write_reg(UWIRE_CSR, val);
 			len -= bytes;

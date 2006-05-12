From: Imre Deak <imre.deak@nokia.com>
Subject: [PATCH] SPI: rename bitbang_transfer_setup
Date: Fri, 12 May 2006 14:37:48 +0300
Message-ID: <1147433868.9837.20.camel@mammoth.research.nokia.com>
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

[ As the previous, this is in Greg's queue ]

Renamed bitbang_transfer_setup to follow convention of other exported symbols
from spi-bitbang.  Exported spi_bitbang_setup_transfer to allow users of
spi-bitbang to use the function in their own setup_transfer.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
Cc: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 drivers/spi/spi_bitbang.c       |   10 ++++++----
 include/linux/spi/spi_bitbang.h |    2 ++
 2 files changed, 8 insertions(+), 4 deletions(-)

5b39d01119d2b989914ca34bb3f78834f026578e
diff --git a/drivers/spi/spi_bitbang.c b/drivers/spi/spi_bitbang.c
index 0525c99..6c3da64 100644
--- a/drivers/spi/spi_bitbang.c
+++ b/drivers/spi/spi_bitbang.c
@@ -138,8 +138,7 @@ static unsigned bitbang_txrx_32(
 	return t->len - count;
 }
 
-static int
-bitbang_transfer_setup(struct spi_device *spi, struct spi_transfer *t)
+int spi_bitbang_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 {
 	struct spi_bitbang_cs	*cs = spi->controller_state;
 	u8			bits_per_word;
@@ -174,6 +173,7 @@ bitbang_transfer_setup(struct spi_device
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(spi_bitbang_setup_transfer);
 
 /**
  * spi_bitbang_setup - default setup for per-word I/O loops
@@ -203,7 +203,7 @@ int spi_bitbang_setup(struct spi_device 
 	if (!cs->txrx_word)
 		return -EINVAL;
 
-	retval = bitbang_transfer_setup(spi, NULL);
+	retval = spi_bitbang_setup_transfer(spi, NULL);
 	if (retval < 0)
 		return retval;
 
@@ -454,7 +454,9 @@ int spi_bitbang_start(struct spi_bitbang
 		bitbang->use_dma = 0;
 		bitbang->txrx_bufs = spi_bitbang_bufs;
 		if (!bitbang->master->setup) {
-			bitbang->setup_transfer = bitbang_transfer_setup;
+			if (!bitbang->setup_transfer)
+				bitbang->setup_transfer =
+					 spi_bitbang_setup_transfer;
 			bitbang->master->setup = spi_bitbang_setup;
 			bitbang->master->cleanup = spi_bitbang_cleanup;
 		}
diff --git a/include/linux/spi/spi_bitbang.h b/include/linux/spi/spi_bitbang.h
index c954557..16ce178 100644
--- a/include/linux/spi/spi_bitbang.h
+++ b/include/linux/spi/spi_bitbang.h
@@ -57,6 +57,8 @@ struct spi_bitbang {
 extern int spi_bitbang_setup(struct spi_device *spi);
 extern void spi_bitbang_cleanup(const struct spi_device *spi);
 extern int spi_bitbang_transfer(struct spi_device *spi, struct spi_message *m);
+extern int spi_bitbang_setup_transfer(struct spi_device *spi,
+				      struct spi_transfer *t);
 
 /* start or stop queue processing */
 extern int spi_bitbang_start(struct spi_bitbang *spi);
-- 
1.2.3.g90cc1-dirty

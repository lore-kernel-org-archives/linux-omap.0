From: Illia Smyrnov <illia.smyrnov-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 1/2] spi: omap2-mcspi: Move bytes per word calculation to
	the function
Date: Tue, 11 Jun 2013 20:09:14 +0300
Message-ID: <1370970556-11713-2-git-send-email-illia.smyrnov@ti.com>
References: <1370970556-11713-1-git-send-email-illia.smyrnov@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1370970556-11713-1-git-send-email-illia.smyrnov-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Illia Smyrnov <illia.smyrnov-l0cyMroinI0@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Introduce mcspi_bytes_per_word function as replacement for the next code
fragment:

int c = (word_len <= 8)  ? 1 :
	(word_len <= 16) ? 2 :
	/* word_len <= 32 */ 4;

This code used 2 times in current driver code and will be used 2 times in
the next FIFO buffer support patch. Replace it with inline function with clear
name to improve code legibility.

Signed-off-by: Illia Smyrnov <illia.smyrnov-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/spi-omap2-mcspi.c |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 86d2158..707f1db 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -187,6 +187,16 @@ static inline void mcspi_write_chconf0(const struct spi_device *spi, u32 val)
 	mcspi_read_cs_reg(spi, OMAP2_MCSPI_CHCONF0);
 }
 
+static inline int mcspi_bytes_per_word(int word_len)
+{
+	if (word_len <= 8)
+		return 1;
+	else if (word_len <= 16)
+		return 2;
+	else /* word_len <= 32 */
+		return 4;
+}
+
 static void omap2_mcspi_set_dma_req(const struct spi_device *spi,
 		int is_read, int enable)
 {
@@ -433,10 +443,9 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_transfer *xfer,
 			else /* word_len <= 32 */
 				((u32 *)xfer->rx_buf)[elements++] = w;
 		} else {
+			int bytes_per_word = mcspi_bytes_per_word(word_len);
 			dev_err(&spi->dev, "DMA RX penultimate word empty");
-			count -= (word_len <= 8)  ? 2 :
-				(word_len <= 16) ? 4 :
-				/* word_len <= 32 */ 8;
+			count -= (bytes_per_word << 1);
 			omap2_mcspi_set_enable(spi, 1);
 			return count;
 		}
@@ -454,9 +463,7 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_transfer *xfer,
 			((u32 *)xfer->rx_buf)[elements] = w;
 	} else {
 		dev_err(&spi->dev, "DMA RX last word empty");
-		count -= (word_len <= 8)  ? 1 :
-			 (word_len <= 16) ? 2 :
-		       /* word_len <= 32 */ 4;
+		count -= mcspi_bytes_per_word(word_len);
 	}
 	omap2_mcspi_set_enable(spi, 1);
 	return count;
-- 
1.7.0.4


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev

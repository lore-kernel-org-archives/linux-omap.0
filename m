From: Roman Tereshonkov <roman.tereshonkov@nokia.com>
Subject: [PATCH] omap2_mcspi: add turbo mode support
Date: Tue, 13 Apr 2010 13:41:51 +0300
Message-ID: <1271155311-24809-1-git-send-email-roman.tereshonkov@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:60773 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520Ab0DMKmR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Apr 2010 06:42:17 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: spi-devel-general@lists.sourceforge.net, glikely@secretlab.ca
Cc: linux-omap@vger.kernel.org, juuso.oikarinen@nokia.com, Roman Tereshonkov <roman.tereshonkov@nokia.com>

Turbo mode allows to read data to shift register when rx-buffer
is full thus improving the perfomance. This feature is available
for RX-only mode.

In PIO turbo mode when the penultimate word is available
in RX-buffer the controller should be disabled before reading data
to prevent the next transaction triggering. The controller itself
handles the last word to be correctly loaded to shift-register and
then transferred to RX-buffer.

The turbo mode is enabled by setting turbo_mode parameter to 1.
This parameter is a part of omap2_mcspi_device_config structure
which is passed through the spi_device controller_data pointer.

Signed-off-by: Roman Tereshonkov <roman.tereshonkov@nokia.com>
---
 drivers/spi/omap2_mcspi.c |  132 +++++++++++++++++++++++++++++++++++++-------
 1 files changed, 111 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index d87ca43..ac1fef1 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -38,7 +38,7 @@
 
 #include <plat/dma.h>
 #include <plat/clock.h>
-
+#include <plat/mcspi.h>
 
 #define OMAP2_MCSPI_MAX_FREQ		48000000
 
@@ -228,6 +228,8 @@ static void omap2_mcspi_set_enable(const struct spi_device *spi, int enable)
 
 	l = enable ? OMAP2_MCSPI_CHCTRL_EN : 0;
 	mcspi_write_cs_reg(spi, OMAP2_MCSPI_CHCTRL0, l);
+	/* Flash post-writes */
+	mcspi_read_cs_reg(spi, OMAP2_MCSPI_CHCTRL0);
 }
 
 static void omap2_mcspi_force_cs(struct spi_device *spi, int cs_active)
@@ -302,11 +304,14 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 	unsigned int		count, c;
 	unsigned long		base, tx_reg, rx_reg;
 	int			word_len, data_type, element_count;
+	int			elements;
+	u32			l;
 	u8			* rx;
 	const u8		* tx;
 
 	mcspi = spi_master_get_devdata(spi->master);
 	mcspi_dma = &mcspi->dma_channels[spi->chip_select];
+	l = mcspi_cached_chconf0(spi);
 
 	count = xfer->len;
 	c = count;
@@ -345,8 +350,12 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 	}
 
 	if (rx != NULL) {
+		elements = element_count - 1;
+		if (l & OMAP2_MCSPI_CHCONF_TURBO)
+			elements--;
+
 		omap_set_dma_transfer_params(mcspi_dma->dma_rx_channel,
-				data_type, element_count - 1, 1,
+				data_type, elements, 1,
 				OMAP_DMA_SYNC_ELEMENT,
 				mcspi_dma->dma_rx_sync_dev, 1);
 
@@ -378,17 +387,42 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 		wait_for_completion(&mcspi_dma->dma_rx_completion);
 		dma_unmap_single(NULL, xfer->rx_dma, count, DMA_FROM_DEVICE);
 		omap2_mcspi_set_enable(spi, 0);
+
+		if (l & OMAP2_MCSPI_CHCONF_TURBO) {
+
+			if (likely(mcspi_read_cs_reg(spi, OMAP2_MCSPI_CHSTAT0)
+				   & OMAP2_MCSPI_CHSTAT_RXS)) {
+				u32 w;
+
+				w = mcspi_read_cs_reg(spi, OMAP2_MCSPI_RX0);
+				if (word_len <= 8)
+					((u8 *)xfer->rx_buf)[elements++] = w;
+				else if (word_len <= 16)
+					((u16 *)xfer->rx_buf)[elements++] = w;
+				else /* word_len <= 32 */
+					((u32 *)xfer->rx_buf)[elements++] = w;
+			} else {
+				dev_err(&spi->dev,
+					"DMA RX penultimate word empty");
+				count -= (word_len <= 8)  ? 2 :
+					(word_len <= 16) ? 4 :
+					/* word_len <= 32 */ 8;
+				omap2_mcspi_set_enable(spi, 1);
+				return count;
+			}
+		}
+
 		if (likely(mcspi_read_cs_reg(spi, OMAP2_MCSPI_CHSTAT0)
 				& OMAP2_MCSPI_CHSTAT_RXS)) {
 			u32 w;
 
 			w = mcspi_read_cs_reg(spi, OMAP2_MCSPI_RX0);
 			if (word_len <= 8)
-				((u8 *)xfer->rx_buf)[element_count - 1] = w;
+				((u8 *)xfer->rx_buf)[elements] = w;
 			else if (word_len <= 16)
-				((u16 *)xfer->rx_buf)[element_count - 1] = w;
+				((u16 *)xfer->rx_buf)[elements] = w;
 			else /* word_len <= 32 */
-				((u32 *)xfer->rx_buf)[element_count - 1] = w;
+				((u32 *)xfer->rx_buf)[elements] = w;
 		} else {
 			dev_err(&spi->dev, "DMA RX last word empty");
 			count -= (word_len <= 8)  ? 1 :
@@ -432,7 +466,6 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 	word_len = cs->word_len;
 
 	l = mcspi_cached_chconf0(spi);
-	l &= ~OMAP2_MCSPI_CHCONF_TRM_MASK;
 
 	/* We store the pre-calculated register addresses on stack to speed
 	 * up the transfer loop. */
@@ -467,11 +500,26 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 					dev_err(&spi->dev, "RXS timed out\n");
 					goto out;
 				}
-				/* prevent last RX_ONLY read from triggering
-				 * more word i/o: switch to rx+tx
-				 */
-				if (c == 0 && tx == NULL)
-					mcspi_write_chconf0(spi, l);
+
+				if (c == 1 && tx == NULL &&
+				    (l & OMAP2_MCSPI_CHCONF_TURBO)) {
+					omap2_mcspi_set_enable(spi, 0);
+					*rx++ = __raw_readl(rx_reg);
+#ifdef VERBOSE
+					dev_dbg(&spi->dev, "read-%d %02x\n",
+						    word_len, *(rx - 1));
+#endif
+					if (mcspi_wait_for_reg_bit(chstat_reg,
+						OMAP2_MCSPI_CHSTAT_RXS) < 0) {
+						dev_err(&spi->dev,
+							"RXS timed out\n");
+						goto out;
+					}
+					c = 0;
+				} else if (c == 0 && tx == NULL) {
+					omap2_mcspi_set_enable(spi, 0);
+				}
+
 				*rx++ = __raw_readl(rx_reg);
 #ifdef VERBOSE
 				dev_dbg(&spi->dev, "read-%d %02x\n",
@@ -505,11 +553,26 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 					dev_err(&spi->dev, "RXS timed out\n");
 					goto out;
 				}
-				/* prevent last RX_ONLY read from triggering
-				 * more word i/o: switch to rx+tx
-				 */
-				if (c == 0 && tx == NULL)
-					mcspi_write_chconf0(spi, l);
+
+				if (c == 2 && tx == NULL &&
+				    (l & OMAP2_MCSPI_CHCONF_TURBO)) {
+					omap2_mcspi_set_enable(spi, 0);
+					*rx++ = __raw_readl(rx_reg);
+#ifdef VERBOSE
+					dev_dbg(&spi->dev, "read-%d %04x\n",
+						    word_len, *(rx - 1));
+#endif
+					if (mcspi_wait_for_reg_bit(chstat_reg,
+						OMAP2_MCSPI_CHSTAT_RXS) < 0) {
+						dev_err(&spi->dev,
+							"RXS timed out\n");
+						goto out;
+					}
+					c = 0;
+				} else if (c == 0 && tx == NULL) {
+					omap2_mcspi_set_enable(spi, 0);
+				}
+
 				*rx++ = __raw_readl(rx_reg);
 #ifdef VERBOSE
 				dev_dbg(&spi->dev, "read-%d %04x\n",
@@ -543,11 +606,26 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 					dev_err(&spi->dev, "RXS timed out\n");
 					goto out;
 				}
-				/* prevent last RX_ONLY read from triggering
-				 * more word i/o: switch to rx+tx
-				 */
-				if (c == 0 && tx == NULL)
-					mcspi_write_chconf0(spi, l);
+
+				if (c == 4 && tx == NULL &&
+				    (l & OMAP2_MCSPI_CHCONF_TURBO)) {
+					omap2_mcspi_set_enable(spi, 0);
+					*rx++ = __raw_readl(rx_reg);
+#ifdef VERBOSE
+					dev_dbg(&spi->dev, "read-%d %08x\n",
+						    word_len, *(rx - 1));
+#endif
+					if (mcspi_wait_for_reg_bit(chstat_reg,
+						OMAP2_MCSPI_CHSTAT_RXS) < 0) {
+						dev_err(&spi->dev,
+							"RXS timed out\n");
+						goto out;
+					}
+					c = 0;
+				} else if (c == 0 && tx == NULL) {
+					omap2_mcspi_set_enable(spi, 0);
+				}
+
 				*rx++ = __raw_readl(rx_reg);
 #ifdef VERBOSE
 				dev_dbg(&spi->dev, "read-%d %04x\n",
@@ -567,6 +645,7 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 			dev_err(&spi->dev, "EOT timed out\n");
 	}
 out:
+	omap2_mcspi_set_enable(spi, 1);
 	return count - c;
 }
 
@@ -796,6 +875,7 @@ static void omap2_mcspi_work(struct work_struct *work)
 		struct spi_transfer		*t = NULL;
 		int				cs_active = 0;
 		struct omap2_mcspi_cs		*cs;
+		struct omap2_mcspi_device_config *cd;
 		int				par_override = 0;
 		int				status = 0;
 		u32				chconf;
@@ -808,6 +888,7 @@ static void omap2_mcspi_work(struct work_struct *work)
 
 		spi = m->spi;
 		cs = spi->controller_state;
+		cd = spi->controller_data;
 
 		omap2_mcspi_set_enable(spi, 1);
 		list_for_each_entry(t, &m->transfers, transfer_list) {
@@ -831,10 +912,19 @@ static void omap2_mcspi_work(struct work_struct *work)
 
 			chconf = mcspi_cached_chconf0(spi);
 			chconf &= ~OMAP2_MCSPI_CHCONF_TRM_MASK;
+			chconf &= ~OMAP2_MCSPI_CHCONF_TURBO;
+
 			if (t->tx_buf == NULL)
 				chconf |= OMAP2_MCSPI_CHCONF_TRM_RX_ONLY;
 			else if (t->rx_buf == NULL)
 				chconf |= OMAP2_MCSPI_CHCONF_TRM_TX_ONLY;
+
+			if (cd && cd->turbo_mode && t->tx_buf == NULL) {
+				/* Turbo mode is for more than one word */
+				if (t->len > ((cs->word_len + 7) >> 3))
+					chconf |= OMAP2_MCSPI_CHCONF_TURBO;
+			}
+
 			mcspi_write_chconf0(spi, chconf);
 
 			if (t->len) {
-- 
1.6.2.rc1.3.g81d3f


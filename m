From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: [PATCH] [SPI] SPI100k: Fix 8-bit and RX-only transfers
Date: Sat, 29 May 2010 17:12:23 -0700
Message-ID: <1275178343-28193-1-git-send-email-darkstar6262@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:61812 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756835Ab0E3AM4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 29 May 2010 20:12:56 -0400
Received: by gwaa12 with SMTP id a12so1904528gwa.19
        for <linux-omap@vger.kernel.org>; Sat, 29 May 2010 17:12:55 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: spi-devel-general@lists.sourceforge.net
Cc: linux-omap@vger.kernel.org, Cory Maccarrone <darkstar6262@gmail.com>

This change fixes 8-bit transfers and RX-only transfers.  The
SPI100k framework requires minimum 16-bit words to be written, so 8-bit
transfers must be shited by 8 bits and sent out as a 16-bit word.

Additionally, receive-only transfers were failing due to the
perceived need to fill the TX buffer with something.  This is in
fact not needed.

Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
---
 drivers/spi/omap_spi_100k.c |   23 ++++++++++++-----------
 1 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/omap_spi_100k.c b/drivers/spi/omap_spi_100k.c
index 24668b3..9bd1c92 100644
--- a/drivers/spi/omap_spi_100k.c
+++ b/drivers/spi/omap_spi_100k.c
@@ -141,7 +141,12 @@ static void spi100k_write_data(struct spi_master *master, int len, int data)
 {
 	struct omap1_spi100k *spi100k = spi_master_get_devdata(master);
 
-	/* write 16-bit word */
+	/* write 16-bit word, shifting 8-bit data if necessary */
+	if (len <= 8) {
+		data <<= 8;
+		len = 16;
+	}
+
 	spi100k_enable_clock(master);
 	writew( data , spi100k->base + SPI_TX_MSB);
 
@@ -162,6 +167,10 @@ static int spi100k_read_data(struct spi_master *master, int len)
 	int dataH,dataL;
 	struct omap1_spi100k *spi100k = spi_master_get_devdata(master);
 
+	/* Always do at least 16 bits */
+	if (len <= 8)
+		len = 16;
+
 	spi100k_enable_clock(master);
 	writew(SPI_CTRL_SEN(0) |
 	       SPI_CTRL_WORD_SIZE(len) |
@@ -214,10 +223,6 @@ omap1_spi100k_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 	c = count;
 	word_len = cs->word_len;
 
-	/* RX_ONLY mode needs dummy data in TX reg */
-	if (xfer->tx_buf == NULL)
-		spi100k_write_data(spi->master,word_len, 0);
-
 	if (word_len <= 8) {
 		u8              *rx;
 		const u8        *tx;
@@ -227,9 +232,9 @@ omap1_spi100k_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 		do {
 			c-=1;
 			if (xfer->tx_buf != NULL)
-				spi100k_write_data(spi->master,word_len, *tx);
+				spi100k_write_data(spi->master, word_len, *tx++);
 			if (xfer->rx_buf != NULL)
-				*rx = spi100k_read_data(spi->master,word_len);
+				*rx++ = spi100k_read_data(spi->master, word_len);
 		} while(c);
 	} else if (word_len <= 16) {
 		u16             *rx;
@@ -380,10 +385,6 @@ static void omap1_spi100k_work(struct work_struct *work)
 			if (t->len) {
 				unsigned count;
 
-				/* RX_ONLY mode needs dummy data in TX reg */
-				if (t->tx_buf == NULL)
-					spi100k_write_data(spi->master, 8, 0);
-
 				count = omap1_spi100k_txrx_pio(spi, t);
 				m->actual_length += count;
 
-- 
1.7.0.4


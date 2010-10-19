From: Jason Wang <jason77.wang@gmail.com>
Subject: [PATCH] spi/omap2_mcspi: disable channel after TX_ONLY transfer in PIO mode
Date: Tue, 19 Oct 2010 18:03:27 +0800
Message-ID: <1287482607-18912-1-git-send-email-jason77.wang@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:43586 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755147Ab0JSJ7V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Oct 2010 05:59:21 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grant.likely@secretlab.ca
Cc: tony@atomide.com, notasas@gmail.com, linux-omap@vger.kernel.org, spi-devel-general@lists.sourceforge.net

In the TX_ONLY transfer, the SPI controller also receives data
simultaneously and saves them in the rx register. After the TX_ONLY
transfer, the rx register will hold the random data received during
the last tx transaction.

If the direct following transfer is RX_ONLY, this random data has the
possibility to affect this transfer like this:
  When the SPI controller is changed from TX_ONLY to RX_ONLY,
  the random data makes the rx register full immediately and
  triggers a dummy write automatically(in SPI RX_ONLY transfers,
  we need a dummy write to trigger the first transaction).

  So the first data received in the RX_ONLY transfer will be that
  random data instead of something meaningful.

We can avoid this by inserting a Disable/Re-enable toggle of the
channel after the TX_ONLY transfer, since it purges the rx register.

Signed-off-by: Jason Wang <jason77.wang@gmail.com>
Tested-by: Grazvydas Ignotas <notasas@gmail.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
Hi Grant,

The touchpanel driver can't work correctly on the omap3evm platform,
This is due to a omap2_mcspi driver issue, now fix it.

 drivers/spi/omap2_mcspi.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index b3a94ca..43fab41 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -644,6 +644,12 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 		} else if (mcspi_wait_for_reg_bit(chstat_reg,
 				OMAP2_MCSPI_CHSTAT_EOT) < 0)
 			dev_err(&spi->dev, "EOT timed out\n");
+
+		/* disable chan to purge rx datas received in TX_ONLY transfer,
+		 * otherwise these rx datas will affect the direct following
+		 * RX_ONLY transfer.
+		 */
+		omap2_mcspi_set_enable(spi, 0);
 	}
 out:
 	omap2_mcspi_set_enable(spi, 1);
-- 
1.5.6.5


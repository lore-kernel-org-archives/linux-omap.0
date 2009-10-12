From: manjugk@ti.com
Subject: [PATCH] OMAP3 : Fix McSPI RX Timeout
Date: Mon, 12 Oct 2009 16:34:28 +0530
Message-ID: <1255345468-21806-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43442 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750978AbZJLLFY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Oct 2009 07:05:24 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: spi-devel-general@lists.sourceforge.net
Cc: dbrownell@users.sourceforge.net, linux-omap@vger.kernel.org, Manjunatha GK <manjugk@ti.com>

Resending this patch to SPI mailing list as well.

McSPI RX timeout issues are reported on some of the OMAP3 custom boards.

After verifying configuration sequence in TRM, there seems to be issue with 
McSPI configuration sequence.

The steps to be followed for both TX and RX:
1. Configure OMAP2_MCSPI_CHCONF0 register with required settings such as
TX/RX mode, word length, force chip select(if required).
2. Set MS bit to 0 in OMAP2_MCSPI_CHCTRL0 register to provide the clock.
3. Enable SPI channel in OMAP2_MCSPI_MODULCTRL

But, the sequence used in current code seems to be wrong. Here it is:
1. Set MS bit to 0 in OMAP2_MCSPI_CHCTRL0 register to provide the clock
(This is done during bootup)
2. Enable SPI channel in OMAP2_MCSPI_MODULCTRL
3. Configure OMAP2_MCSPI_CHCONF0 register with required settings such as
TX/RX mode, word length, force chip select(if required).

After correcting configuration sequence, the timeout seems to be not
reproducible anymore.

Signed-off-by: Manjunatha GK <manjugk@ti.com>
---
 drivers/spi/omap2_mcspi.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index ba1a872..846485c 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -802,7 +802,6 @@ static void omap2_mcspi_work(struct work_struct *work)
 		spi = m->spi;
 		cs = spi->controller_state;
 
-		omap2_mcspi_set_enable(spi, 1);
 		list_for_each_entry(t, &m->transfers, transfer_list) {
 			if (t->tx_buf == NULL && t->rx_buf == NULL && t->len) {
 				status = -EINVAL;
@@ -830,6 +829,9 @@ static void omap2_mcspi_work(struct work_struct *work)
 				chconf |= OMAP2_MCSPI_CHCONF_TRM_TX_ONLY;
 			mcspi_write_chconf0(spi, chconf);
 
+			omap2_mcspi_set_master_mode(mcspi->master);
+
+			omap2_mcspi_set_enable(spi, 1);
 			if (t->len) {
 				unsigned	count;
 
-- 
1.6.0.4


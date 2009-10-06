From: manjugk@ti.com
Subject: [PATCH] OMAP3 : Fix McSPI RX Timeout
Date: Tue,  6 Oct 2009 12:07:16 +0530
Message-ID: <1254811036-22666-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46868 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756548AbZJFGh6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Oct 2009 02:37:58 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n966bJqC011482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 6 Oct 2009 01:37:21 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Manjunatha GK <manjugk@ti.com>

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


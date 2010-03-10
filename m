From: Roman Tereshonkov <roman.tereshonkov@nokia.com>
Subject: [PATCH 2/2] omap2_mcspi: small fixes of output data format
Date: Wed, 10 Mar 2010 12:18:36 +0200
Message-ID: <1268216316-32552-2-git-send-email-roman.tereshonkov@nokia.com>
References: <1268216316-32552-1-git-send-email-roman.tereshonkov@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:52712 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142Ab0CJKSy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Mar 2010 05:18:54 -0500
In-Reply-To: <1268216316-32552-1-git-send-email-roman.tereshonkov@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: scott@jumpnowtek.com, gadiyar@ti.com, Roman Tereshonkov <roman.tereshonkov@nokia.com>

Replaces %04x by %08x for 32-bits data output.

Signed-off-by: Roman Tereshonkov <roman.tereshonkov@nokia.com>
---
 drivers/spi/omap2_mcspi.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index 35b31fe..2ebdca8 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -532,7 +532,7 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 					goto out;
 				}
 #ifdef VERBOSE
-				dev_dbg(&spi->dev, "write-%d %04x\n",
+				dev_dbg(&spi->dev, "write-%d %08x\n",
 						word_len, *tx);
 #endif
 				__raw_writel(*tx++, tx_reg);
@@ -550,7 +550,7 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 					mcspi_write_chconf0(spi, l);
 				*rx++ = __raw_readl(rx_reg);
 #ifdef VERBOSE
-				dev_dbg(&spi->dev, "read-%d %04x\n",
+				dev_dbg(&spi->dev, "read-%d %08x\n",
 						word_len, *(rx - 1));
 #endif
 			}
-- 
1.6.2.rc1.3.g81d3f


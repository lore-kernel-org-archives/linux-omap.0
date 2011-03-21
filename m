From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH-v2.6.39] spi/omap_mcspi: Fix broken last word xfer
Date: Mon, 21 Mar 2011 16:27:30 +0200
Message-ID: <1300717650-28953-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:51087 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376Ab1CUO11 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Mar 2011 10:27:27 -0400
Received: by eyx24 with SMTP id 24so1521433eyx.19
        for <linux-omap@vger.kernel.org>; Mon, 21 Mar 2011 07:27:26 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: spi-devel-general@lists.sourceforge.net
Cc: linux-omap@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Jarkko Nikula <jhnikula@gmail.com>, Michael Jones <michael.jones@matrix-vision.de>

Commit adef658 "spi/omap_mcspi: catch xfers of non-multiple SPI word size"
broke the transmission of last word in cases where access is multiple of
word size and word size is 16 or 32 bits.

Fix this by replacing the test "c > (word_len>>3)" in do-while loops with
"c >= 'pointer increment size'". This ensures that the last word is
transmitted in above case and still allow to break the loop and prevent
variable c underflow in cases where word size != 'pointer increment size'.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Cc: Michael Jones <michael.jones@matrix-vision.de>
---
I noticed the issue with wl1251 WLAN driver on Nokia N900 using today's
vanilla head a44f99c7efdb88fa41128065c9a9445c19894e34.
---
 drivers/spi/omap2_mcspi.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index 3a5ed06..6f86ba0 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -517,7 +517,7 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 				dev_vdbg(&spi->dev, "read-%d %02x\n",
 						word_len, *(rx - 1));
 			}
-		} while (c > (word_len>>3));
+		} while (c);
 	} else if (word_len <= 16) {
 		u16		*rx;
 		const u16	*tx;
@@ -564,7 +564,7 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 				dev_vdbg(&spi->dev, "read-%d %04x\n",
 						word_len, *(rx - 1));
 			}
-		} while (c > (word_len>>3));
+		} while (c >= 2);
 	} else if (word_len <= 32) {
 		u32		*rx;
 		const u32	*tx;
@@ -611,7 +611,7 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 				dev_vdbg(&spi->dev, "read-%d %08x\n",
 						word_len, *(rx - 1));
 			}
-		} while (c > (word_len>>3));
+		} while (c >= 4);
 	}
 
 	/* for TX_ONLY mode, be sure all words have shifted out */
-- 
1.7.4.1


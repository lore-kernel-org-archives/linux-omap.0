From: Michael Welling <mwelling@ieee.org>
Subject: [PATCH 1/4] spi: omap2-mcspi: Remove unnecessary delay
Date: Sat, 23 May 2015 21:13:42 -0500
Message-ID: <1432433625-23407-2-git-send-email-mwelling@ieee.org>
References: <20150522122544.GL21391@sirena.org.uk>
 <1432433625-23407-1-git-send-email-mwelling@ieee.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1432433625-23407-1-git-send-email-mwelling@ieee.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-next@vger.kernel.org, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Michael Welling <mwelling@ieee.org>
List-Id: linux-omap@vger.kernel.org

The core spi driver handles the delay between transactions.
This is a remanant from the transfer_one conversion.

Signed-off-by: Michael Welling <mwelling@ieee.org>
---
 drivers/spi/spi-omap2-mcspi.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index a7d85c5..304b427 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1163,9 +1163,6 @@ static int omap2_mcspi_work_one(struct omap2_mcspi *mcspi,
 		}
 	}
 
-	if (t->delay_usecs)
-		udelay(t->delay_usecs);
-
 	omap2_mcspi_set_enable(spi, 0);
 
 	if (mcspi->fifo_depth > 0)
-- 
1.7.9.5

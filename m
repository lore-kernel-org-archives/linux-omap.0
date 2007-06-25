From: Hiroshi.DOYU@nokia.com
Subject: [PATCH 1/1] ARM: OMAP: Fix wrong SPI mode in N800 LCD
Date: Mon, 25 Jun 2007 13:19:37 +0300
Message-ID: <11827667772695-git-send-email-Hiroshi.DOYU@nokia.com>
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
To: linux-omap-open-source@linux.omap.com
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
List-Id: linux-omap@vger.kernel.org

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 drivers/video/omap/lcd_mipid.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap/lcd_mipid.c b/drivers/video/omap/lcd_mipid.c
index 569e18b..922e322 100644
--- a/drivers/video/omap/lcd_mipid.c
+++ b/drivers/video/omap/lcd_mipid.c
@@ -565,7 +565,7 @@ static int mipid_spi_probe(struct spi_device *spi)
 		return -ENOMEM;
 	}
 
-	spi->mode = SPI_MODE_1;
+	spi->mode = SPI_MODE_0;
 	md->spi = spi;
 	dev_set_drvdata(&spi->dev, md);
 	md->panel = mipid_panel;
-- 
1.5.2.2.238.g7cbf2f2

From: Timo Savola <tsavola@movial.fi>
Subject: [PATCH] OMAP: lcd_mipid: Fix OOM error reporting
Date: Thu, 20 Sep 2007 14:31:43 +0300
Message-ID: <1190287903652-git-send-email-tsavola@movial.fi>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Do not try access a memory region when its allocation failed.

Signed-off-by: Timo Savola <tsavola@movial.fi>
---
 drivers/video/omap/lcd_mipid.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap/lcd_mipid.c b/drivers/video/omap/lcd_mipid.c
index 922e322..ef071a6 100644
--- a/drivers/video/omap/lcd_mipid.c
+++ b/drivers/video/omap/lcd_mipid.c
@@ -561,7 +561,7 @@ static int mipid_spi_probe(struct spi_device *spi)
 
 	md = kzalloc(sizeof(*md), GFP_KERNEL);
 	if (md == NULL) {
-		dev_err(&md->spi->dev, "out of memory\n");
+		dev_err(&spi->dev, "out of memory\n");
 		return -ENOMEM;
 	}
 
-- 
1.5.2

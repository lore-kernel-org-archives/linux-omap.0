From: Todd Poynor <tpoynor@mvista.com>
Subject: H3 LCD clocking changes suggested by the driver.
Date: Mon, 12 Dec 2005 17:56:21 -0800
Message-ID: <20051213015621.GA25503@slurryseal.ddns.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
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
List-Id: linux-omap@vger.kernel.org

H3 LCD internal controller clocking updates suggested by the driver:

omapfb-lcdc: Pixel clock divider value is obsolete.
omapfb-lcdc: Try to set pixel_clock to 12000 and pcd to 0 in drivers/video/omap/lcd_h3.c and submit a patch.

Tux logo appears fine and so does IceWM under Xfbdev.

---
commit 5a4af805bbd4ba2556eaf29c410cc72782068a65
tree 83f21f7ccc0804ae2adf08fb213cfaffd6b3916f
parent 3490191abec0cb86e8907afdff038af890355930
author Todd Poynor <tpoynor@mvista.com> Mon, 12 Dec 2005 17:49:21 -0800
committer Todd Poynor <tpoynor@mvista.com> Mon, 12 Dec 2005 17:49:21 -0800

 drivers/video/omap/lcd_h3.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap/lcd_h3.c b/drivers/video/omap/lcd_h3.c
index 78b10c0..f6e8e62 100644
--- a/drivers/video/omap/lcd_h3.c
+++ b/drivers/video/omap/lcd_h3.c
@@ -94,14 +94,14 @@ struct lcd_panel h3_panel = {
 	.bpp		= 16,
 	.x_res		= 240,
 	.y_res		= 320,
-	.pixel_clock	= 12500,
+	.pixel_clock	= 12000,
 	.hsw		= 12,
 	.hfp		= 14,
 	.hbp		= 72 - 12,
 	.vsw		= 1,
 	.vfp		= 1,
 	.vbp		= 0,
-	.pcd		= 2,
+	.pcd		= 0,
 
 	.init		= h3_panel_init,
 	.cleanup	= h3_panel_cleanup,

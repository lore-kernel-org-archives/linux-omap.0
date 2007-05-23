From: David Brownell <david-b@pacbell.net>
Subject: [patch linux-omap-git] lcd_mipid kconfig fixes
Date: Tue, 22 May 2007 22:35:18 -0700
Message-ID: <200705222235.18275.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

Fixes some Kconfig glitches with lcd_mipid.c ... I suspect this
driver should use SPI_MODE_0 now (but, no specs so I can't know).

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/video/omap/Kconfig |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- o26.orig/drivers/video/omap/Kconfig	2007-05-22 22:19:11.000000000 -0700
+++ o26/drivers/video/omap/Kconfig	2007-05-22 22:19:55.000000000 -0700
@@ -36,8 +36,7 @@ config FB_OMAP_MANUAL_UPDATE
 
 config FB_OMAP_LCD_MIPID
 	bool "MIPI DBI-C/DCS compatible LCD support"
-	select SPI
-	depends on FB_OMAP
+	depends on FB_OMAP && SPI_MASTER && CBUS_TAHVO
 	help
 	  Say Y here if you want to have support for LCDs compatible with
 	  the Mobile Industry Processor Interface DBI-C/DCS

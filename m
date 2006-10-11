From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: [PATCH] ARM: OMAP: Replace apollon LCD mux setting
Date: Wed, 11 Oct 2006 17:32:11 +0900
Message-ID: <000901c6ed0f$bf962ba0$c7a3580a@swcenter.sec.samsung.co.kr>
Reply-To: kyungmin.park@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7BIT
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
List-Id: linux-omap@vger.kernel.org

Change the LCD mux setting from enable() to init() for PM

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

--

diff --git a/drivers/video/omap/lcd_apollon.c
b/drivers/video/omap/lcd_apollon.c
index fabc3a5..4c0f370 100644
--- a/drivers/video/omap/lcd_apollon.c
+++ b/drivers/video/omap/lcd_apollon.c
@@ -35,6 +35,8 @@ #include <asm/arch/omapfb.h>  static int
apollon_panel_init(struct lcd_panel *panel,
 				struct omapfb_device *fbdev)
 {
+	/* configure LCD PWR_EN */
+	omap_cfg_reg(M21_242X_GPIO11);
 	return 0;
 }
 
@@ -44,10 +46,6 @@ static void apollon_panel_cleanup(struct
 
 static int apollon_panel_enable(struct lcd_panel *panel)  {
-
-	/* configure LCD PWR_EN */
-	omap_cfg_reg(M21_242X_GPIO11);
-
 	return 0;
 }
 

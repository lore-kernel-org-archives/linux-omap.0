From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Fix warning in lcdc.c
Date: Tue, 01 May 2007 15:25:16 +0200
Message-ID: <46373FBC.40808@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060209090600090108090204"
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

This is a multi-part message in MIME format.
--------------060209090600090108090204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Fix warning

drivers/video/omap/lcdc.c:878: warning: initialization from
incompatible pointer type

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>

--------------060209090600090108090204
Content-Type: text/plain;
 name="lcdc_warning_fix_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lcdc_warning_fix_patch.txt"

Index: linux-osk/drivers/video/omap/lcdc.c
===================================================================
--- linux-osk.orig/drivers/video/omap/lcdc.c
+++ linux-osk/drivers/video/omap/lcdc.c
@@ -611,9 +611,9 @@ static void omap_lcdc_resume(void)
 	}
 }
 
-static unsigned long omap_lcdc_get_caps(void)
+static void omap_lcdc_get_caps(int plane, struct omapfb_caps *caps)
 {
-	return 0;
+	return;
 }
 
 int omap_lcdc_set_dma_callback(void (*callback)(void *data), void *data)



--------------060209090600090108090204
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------060209090600090108090204--

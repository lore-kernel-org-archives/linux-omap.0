From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Fix compilation of dsp_mem.c
Date: Sat, 19 May 2007 16:48:51 +0200
Message-ID: <464F0E53.50007@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090602060801040507070403"
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
--------------090602060801040507070403
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Fix compilation of dsp_mem.c. omapfb_ready is only available if 
CONFIG_FB_OMAP_LCDC_EXTERNAL is set, else compiler stops with error. 
status is only used in case CONFIG_FB_OMAP_LCDC_EXTERNAL is set. 
Compiler warns about this.

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>



--------------090602060801040507070403
Content-Type: text/plain;
 name="fix_error_omapfb_ready_undeclared.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="fix_error_omapfb_ready_undeclared.txt"

Index: linux-osk/arch/arm/plat-omap/dsp/dsp_mem.c
===================================================================
--- linux-osk.orig/arch/arm/plat-omap/dsp/dsp_mem.c
+++ linux-osk/arch/arm/plat-omap/dsp/dsp_mem.c
@@ -210,11 +210,13 @@ void mbox_fbctl_upd(void)
 	win.format = buf[4];
 	release_ipbuf_pvt(ipbuf_sys_da);
 
+#ifdef CONFIG_FB_OMAP_LCDC_EXTERNAL
 	if (!omapfb_ready) {
 		printk(KERN_WARNING
 		       "omapdsp: fbupd() called while HWA742 is not ready!\n");
 		return;
 	}
+#endif
 	omapfb_update_window_async(registered_fb[0], &win, fbupd_cb, NULL);
 }
 
@@ -237,7 +239,10 @@ static int dsp_fbexport(dsp_long_t *dspa
 {
 	dsp_long_t dspadr_actual;
 	unsigned long padr_sys, padr, fbsz_sys, fbsz;
-	int cnt, status;
+	int cnt;
+#ifdef CONFIG_FB_OMAP_LCDC_EXTERNAL
+	int status;
+#endif
 
 	pr_debug( "omapdsp: frame buffer export\n");
 

--------------090602060801040507070403
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------090602060801040507070403--

From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Fix missing channel using omap_set_dma_priority()
Date: Tue, 04 Jul 2006 16:45:23 +0200
Message-ID: <44AA7F03.7090802@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020503090001040607050708"
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
--------------020503090001040607050708
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


ARM: OMAP: Fix missing channel parameter using
omap_set_dma_priority() in omapfb_main.c:

drivers/video/omap/omapfb_main.c: In function 'omapfb_do_probe':
drivers/video/omap/omapfb_main.c:1441: error: too few
arguments to function
         'omap_set_dma_priority'

omap_set_dma_priority() in dma.c wants a channel as first
parameter which is missing here. However, this is only used
on OMAP24xx, on OMAP1 it isn't. Therefore I don't know if 0
is correct here, it's
don't care for OMAP1. Please check.

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>

--------------020503090001040607050708
Content-Type: text/plain;
 name="dma_priority_workaround_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dma_priority_workaround_patch.txt"

--- ./drivers/video/omap/omapfb_main.c_orig	2006-07-04 16:28:26.000000000 +0200
+++ ./drivers/video/omap/omapfb_main.c	2006-07-04 16:34:25.000000000 +0200
@@ -1438,7 +1438,7 @@ static int omapfb_do_probe(struct platfo
 #ifdef CONFIG_FB_OMAP_DMA_TUNE
 	/* Set DMA priority for EMIFF access to highest */
 	if (cpu_class_is_omap1())
-		omap_set_dma_priority(OMAP_DMA_PORT_EMIFF, 15);
+	        omap_set_dma_priority(0, OMAP_DMA_PORT_EMIFF, 15);
 #endif
 
 	r = ctrl_change_mode(fbdev->fb_info[0]);








--------------020503090001040607050708
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------020503090001040607050708--

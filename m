From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Fix warning in tusb6010_omap.c
Date: Sat, 05 May 2007 09:58:25 +0200
Message-ID: <463C3921.104@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040708030507000108050007"
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
--------------040708030507000108050007
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Fix warning

drivers/usb/musb/tusb6010_omap.c: In function 'tusb_omap_dma_cb':
drivers/usb/musb/tusb6010_omap.c:188: warning: format '%i' expects
type 'int', but argument 4 has type 'long unsigned int'

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>


--------------040708030507000108050007
Content-Type: text/plain;
 name="tusb6010_omap_warning_fix.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tusb6010_omap_warning_fix.txt"

Index: linux-osk/drivers/usb/musb/tusb6010_omap.c
===================================================================
--- linux-osk.orig/drivers/usb/musb/tusb6010_omap.c
+++ linux-osk/drivers/usb/musb/tusb6010_omap.c
@@ -185,7 +185,7 @@ static void tusb_omap_dma_cb(int lch, u1
 	if (pio > 0 && pio < 32) {
 		u8	*buf;
 
-		DBG(2, "Using PIO for remaining %i bytes\n", pio);
+		DBG(2, "Using PIO for remaining %lu bytes\n", pio);
 		buf = phys_to_virt((u32)chdat->dma_addr) + chdat->transfer_len;
 		if (chdat->tx) {
 			consistent_sync(phys_to_virt((u32)chdat->dma_addr),


--------------040708030507000108050007
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------040708030507000108050007--

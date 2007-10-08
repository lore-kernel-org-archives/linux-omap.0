From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH 1/1] ARM: OMAP: Fix musb_core parameter passing to cppi start
Date: Mon, 08 Oct 2007 20:35:14 +0200
Message-ID: <470A7862.4060802@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040508030507030806050302"
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

This is a multi-part message in MIME format.
--------------040508030507030806050302
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


cppi_controller_start() expects a struct dma_controller as parameter
and not dma_controller private_data. Current implementation crashes
with e.g.

Internal error: Oops: 805 [#1]
Modules linked in:
CPU: 0    Not tainted  (2.6.23-rc4-davinci1 #2)
PC is at cppi_controller_start+0x18/0x140
LR is at musb_probe+0x1f4/0x824

Fix this. Initial proposal for fix by David Brownell. Thanks!

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>


--------------040508030507030806050302
Content-Type: text/plain;
 name="musb_core_oops_fix.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="musb_core_oops_fix.txt"

Index: linux-osk/drivers/usb/musb/musb_core.c
===================================================================
--- linux-osk.orig/drivers/usb/musb/musb_core.c
+++ linux-osk/drivers/usb/musb/musb_core.c
@@ -1980,7 +1980,7 @@ musb_init_controller(struct device *dev,
 		c = dma_controller_create(musb, musb->mregs);
 		musb->dma_controller = c;
 		if (c)
-			(void) c->start(c->private_data);
+			(void) c->start(c);
 	}
 #endif
 	/* ideally this would be abstracted in platform setup */


--------------040508030507030806050302
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------040508030507030806050302--

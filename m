From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Fix USB compilation for N800 defconfig
Date: Sun, 04 Mar 2007 11:29:51 +0100
Message-ID: <45EA9F9F.3010305@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000700000501090901040501"
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
--------------000700000501090901040501
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


linux/usb_ch9.h has moved to linux/usb/ch9.h

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>



--------------000700000501090901040501
Content-Type: text/x-patch;
 name="plat_uds_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="plat_uds_fix.patch"

Index: linux-osk/drivers/usb/musb/musbdefs.h
===================================================================
--- linux-osk.orig/drivers/usb/musb/musbdefs.h
+++ linux-osk/drivers/usb/musb/musbdefs.h
@@ -40,7 +40,7 @@
 #include <linux/smp_lock.h>
 #include <linux/errno.h>
 #include <linux/device.h>
-#include <linux/usb_ch9.h>
+#include <linux/usb/ch9.h>
 #include <linux/usb_gadget.h>
 #include <linux/usb.h>
 #include <linux/usb/otg.h>


--------------000700000501090901040501
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------000700000501090901040501--

From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Fix USB compilation for N770 defconfig
Date: Sun, 18 Mar 2007 11:29:21 +0100
Message-ID: <45FD1481.6010602@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020408020205070307010605"
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
--------------020408020205070307010605
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


linux/usb_ch9.h is now linux/usb/ch9.h

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>


--------------020408020205070307010605
Content-Type: text/x-patch;
 name="tahvo_usb_include_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tahvo_usb_include_fix.patch"

Index: linux-osk/drivers/cbus/tahvo-usb.c
===================================================================
--- linux-osk.orig/drivers/cbus/tahvo-usb.c
+++ linux-osk/drivers/cbus/tahvo-usb.c
@@ -33,7 +33,7 @@
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
-#include <linux/usb_ch9.h>
+#include <linux/usb/ch9.h>
 #include <linux/usb_gadget.h>
 #include <linux/usb.h>
 #include <linux/usb/otg.h>


--------------020408020205070307010605
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------020408020205070307010605--

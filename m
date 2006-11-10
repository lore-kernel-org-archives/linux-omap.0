From: Khem Raj <kraj@mvista.com>
Subject: [PATCH] Fix for error: invalid storage class for function
	'__usb_port_suspend'
Date: Thu, 9 Nov 2006 18:41:04 -0800
Message-ID: <239316CA-B95B-4C41-9269-F22A7FBE530C@mvista.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed
Content-Transfer-Encoding: 7bit
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
To: Linux OMAP Mailing List <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi

Compiling kernel for OMAP1610 with GCC 4.2 I stumbled over this error.

drivers/usb/core/hub.c: In function 'usb_new_device':
drivers/usb/core/hub.c:1293: error: invalid storage class for  
function '__usb_port_suspend'
drivers/usb/core/hub.c:1294: warning: implicit declaration of  
function '__usb_port_suspend'
drivers/usb/core/hub.c: At top level:
drivers/usb/core/hub.c:1567: error: static declaration of  
'__usb_port_suspend' follows non-static declaration
drivers/usb/core/hub.c:1294: error: previous implicit declaration of  
'__usb_port_suspend' was here
make[3]: *** [drivers/usb/core/hub.o] Error 1
make[2]: *** [drivers/usb/core] Error 2
make[1]: *** [drivers/usb] Error 2
make: *** [drivers] Error 2


GCC does not like the forward declaration of the function inside the  
function. Attached patch moves the declaration outside the function  
and because the call is inside the code in CONFIG_USB_OTG I moved the  
declaration also under same conditional.

I am able to build and and boot the kernel on OMAP1610 with this patch.

OK?


Khem Raj <kraj@mvista.com>
MontaVista Software Inc.

Signed-off-by: Khem Raj <kraj@mvista.com>

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 66bff18..ba165af 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -1188,6 +1188,7 @@ #endif
#ifdef CONFIG_USB_OTG
#include "otg_whitelist.h"
+static int __usb_port_suspend(struct usb_device *, int port1);
#endif
/**
@@ -1289,8 +1290,6 @@ #ifdef    CONFIG_USB_OTG
                  * (Includes HNP test device.)
                  */
                 if (udev->bus->b_hnp_enable || udev->bus->is_b_host) {
-                       static int __usb_port_suspend(struct  
usb_device *,
-                                               int port1);
                         err = __usb_port_suspend(udev, udev->bus- 
 >otg_port);
                         if (err < 0)
                                 dev_dbg(&udev->dev, "HNP fail, %d 
\n", err);

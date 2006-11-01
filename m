From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: Re: Invalid Storage Class BUG
Date: Wed, 01 Nov 2006 22:32:00 +0100
Message-ID: <85ejsmn99r.fsf@orfeo.duckcorp.org>
References: <4549087F.5070701@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
In-Reply-To: <4549087F.5070701@nokia.com> (Felipe Balbi's message of "Wed, 01
	Nov 2006 16:50:07 -0400")
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: Felipe Balbi <ext-felipe.lima@nokia.com>
Cc: Linux OMAP Mailing List <linux-omap-open-source@linux.omap.com>, linux-usb-devel@lists.sourceforge.net
List-Id: linux-omap@vger.kernel.org

--=-=-=

Felipe Balbi <ext-felipe.lima@nokia.com> writes:

> Hello all,

Hi !

>
> Could anyone help me fix this bug?
>
> I couldn't figure out what is happening.
>
> Here's the bug:
> drivers/usb/core/hub.c: In function 'usb_new_device':
> drivers/usb/core/hub.c:1293: error: invalid storage class for function
> '__usb_port_suspend'
> drivers/usb/core/hub.c:1294: warning: implicit declaration of function
> '__usb_port_suspend'
> drivers/usb/core/hub.c: At top level:
> drivers/usb/core/hub.c:1567: error: static declaration of
> '__usb_port_suspend' follows non-static declaration
> drivers/usb/core/hub.c:1294: error: previous implicit declaration of
> '__usb_port_suspend' was here
> make[3]: *** [drivers/usb/core/hub.o] Error 1
> make[2]: *** [drivers/usb/core] Error 2
> make[1]: *** [drivers/usb] Error 2
> make: *** [drivers] Error 2
>

Try the attached patch. It's a quick fix/hack and has not been tested in
every configurations but it should be enough to get things working.

Regards,
Arnaud Patard



--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=usb_core_hub_breakage.patch

---
 drivers/usb/core/hub.c |    3 	1 +	2 -	0 !
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: linux-omap-2.6/drivers/usb/core/hub.c
===================================================================
--- linux-omap-2.6.orig/drivers/usb/core/hub.c	2006-10-24 14:06:58.000000000 +0200
+++ linux-omap-2.6/drivers/usb/core/hub.c	2006-10-24 14:07:46.000000000 +0200
@@ -1188,6 +1188,7 @@ static inline void show_string(struct us
 
 #ifdef	CONFIG_USB_OTG
 #include "otg_whitelist.h"
+static int __usb_port_suspend(struct usb_device *udev, int port1);
 #endif
 
 /**
@@ -1289,8 +1290,6 @@ int usb_new_device(struct usb_device *ud
 		 * (Includes HNP test device.)
 		 */
 		if (udev->bus->b_hnp_enable || udev->bus->is_b_host) {
-			static int __usb_port_suspend(struct usb_device *,
-						int port1);
 			err = __usb_port_suspend(udev, udev->bus->otg_port);
 			if (err < 0)
 				dev_dbg(&udev->dev, "HNP fail, %d\n", err);

--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel

--=-=-=--

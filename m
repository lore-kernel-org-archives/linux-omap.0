From: David Brownell <david-b@pacbell.net>
Subject: Re: Invalid Storage Class BUG
Date: Wed, 1 Nov 2006 14:26:26 -0800
Message-ID: <200611011426.28869.david-b@pacbell.net>
References: <4549087F.5070701@nokia.com> <85ejsmn99r.fsf@orfeo.duckcorp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
In-Reply-To: <85ejsmn99r.fsf@orfeo.duckcorp.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: linux-omap-open-source@linux.omap.com
Cc: Andrew Morton <akpm@osdl.org>, linux-usb-devel@lists.sourceforge.net, "Arnaud Patard (Rtp)" <arnaud.patard@rtp-net.org>, Greg KH <greg@kroah.com>
List-Id: linux-omap@vger.kernel.org

That's identical to what I've been using in some work on a high-speed
OTG controller that I suspect Felipe is getting familiar with ... :)

So here's a standard format patch.  This should get into 2.6.19 IMO.

(Andrew, ISTR that a topological sort won't work in this file.)

=================	CUT HERE

Remove complaint from newer GCCs; they don't like forward function
declarations except in top-level contexts.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: h4/drivers/usb/core/hub.c
===================================================================
--- h4.orig/drivers/usb/core/hub.c	2006-10-25 13:37:45.000000000 -0700
+++ h4/drivers/usb/core/hub.c	2006-10-25 21:54:17.000000000 -0700
@@ -1188,6 +1188,7 @@ static inline void show_string(struct us
 
 #ifdef	CONFIG_USB_OTG
 #include "otg_whitelist.h"
+static int __usb_port_suspend(struct usb_device *, int port1);
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

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel

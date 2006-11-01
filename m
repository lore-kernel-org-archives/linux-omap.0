From: Felipe Balbi <ext-felipe.lima@nokia.com>
Subject: Invalid Storage Class BUG
Date: Wed, 01 Nov 2006 16:50:07 -0400
Message-ID: <4549087F.5070701@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: Linux OMAP Mailing List <linux-omap-open-source@linux.omap.com>, linux-usb-devel@lists.sourceforge.net
List-Id: linux-omap@vger.kernel.org

Hello all,

Could anyone help me fix this bug?

I couldn't figure out what is happening.

Here's the bug:
drivers/usb/core/hub.c: In function 'usb_new_device':
drivers/usb/core/hub.c:1293: error: invalid storage class for function 
'__usb_port_suspend'
drivers/usb/core/hub.c:1294: warning: implicit declaration of function 
'__usb_port_suspend'
drivers/usb/core/hub.c: At top level:
drivers/usb/core/hub.c:1567: error: static declaration of 
'__usb_port_suspend' follows non-static declaration
drivers/usb/core/hub.c:1294: error: previous implicit declaration of 
'__usb_port_suspend' was here
make[3]: *** [drivers/usb/core/hub.o] Error 1
make[2]: *** [drivers/usb/core] Error 2
make[1]: *** [drivers/usb] Error 2
make: *** [drivers] Error 2


Here's the source code:

 /* Maybe it can talk to us, though we can't talk to it.
                 * (Includes HNP test device.)
                 */
                if (udev->bus->b_hnp_enable || udev->bus->is_b_host) {
                        static int __usb_port_suspend(struct usb_device *,
                                                int port1);   * (line 1293)*
                        err = __usb_port_suspend(udev, 
udev->bus->otg_port); * (line 1294)*
                        if (err < 0)
                                dev_dbg(&udev->dev, "HNP fail, %d\n", err);
                }
                err = -ENODEV;
                goto fail;
        }


static int __usb_port_suspend (struct usb_device *udev, int port1)
{ * (line 1567)*
        int     status = 0;

        /* caller owns the udev device lock */
        if (port1 < 0)
                return port1;

        /* we change the device's upstream USB link,
         * but root hubs have no upstream USB link.
         */
        if (udev->parent)
                status = hub_port_suspend(hdev_to_hub(udev->parent), port1,
                                udev);
        else {
                dev_dbg(&udev->dev, "usb %ssuspend\n",
                                udev->auto_pm ? "auto-" : "");
                usb_set_device_state(udev, USB_STATE_SUSPENDED);
        }
        return status;
}


-- 
Best Regards,

Felipe Balbi
ext-felipe.lima@nokia.com
OSMRC - INdT


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel

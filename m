From: Andrew Morton <akpm@osdl.org>
Subject: Re: Invalid Storage Class BUG
Date: Wed, 1 Nov 2006 13:58:13 -0800
Message-ID: <20061101135813.ae0c960f.akpm@osdl.org>
References: <4549087F.5070701@nokia.com>
	<Pine.LNX.4.44L0.0611011608490.8259-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44L0.0611011608490.8259-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux OMAP Mailing List <linux-omap-open-source@linux.omap.com>, USB development list <linux-usb-devel@lists.sourceforge.net>
List-Id: linux-omap@vger.kernel.org

On Wed, 1 Nov 2006 16:14:01 -0500 (EST)
Alan Stern <stern@rowland.harvard.edu> wrote:

> On Wed, 1 Nov 2006, Felipe Balbi wrote:
> 
> > Hello all,
> > 
> > Could anyone help me fix this bug?
> > 
> > I couldn't figure out what is happening.
> > 
> > Here's the bug:
> > drivers/usb/core/hub.c: In function 'usb_new_device':
> > drivers/usb/core/hub.c:1293: error: invalid storage class for function 
> > '__usb_port_suspend'
> > drivers/usb/core/hub.c:1294: warning: implicit declaration of function 
> > '__usb_port_suspend'
> > drivers/usb/core/hub.c: At top level:
> > drivers/usb/core/hub.c:1567: error: static declaration of 
> > '__usb_port_suspend' follows non-static declaration
> > drivers/usb/core/hub.c:1294: error: previous implicit declaration of 
> > '__usb_port_suspend' was here
> > make[3]: *** [drivers/usb/core/hub.o] Error 1
> > make[2]: *** [drivers/usb/core] Error 2
> > make[1]: *** [drivers/usb] Error 2
> > make: *** [drivers] Error 2
> 
> Ho, ho!
> 
> Andrew, I _told_ you this inner declaration of a static function would 
> cause problems!

I thought we fixed that ages ago?  What happened to it?

> > Here's the source code:
> > 
> >  /* Maybe it can talk to us, though we can't talk to it.
> >                  * (Includes HNP test device.)
> >                  */
> >                 if (udev->bus->b_hnp_enable || udev->bus->is_b_host) {
> >                         static int __usb_port_suspend(struct usb_device *,
> >                                                 int port1);   * (line 1293)*
> >                         err = __usb_port_suspend(udev, 
> > udev->bus->otg_port); * (line 1294)*
> >                         if (err < 0)
> >                                 dev_dbg(&udev->dev, "HNP fail, %d\n", err);
> >                 }
> >                 err = -ENODEV;
> >                 goto fail;
> >         }
> 
> The solution is simple.  Just take line 1293 (the static function 
> declaration) and move it outside of the usb_new_device() function.  Stick 
> it inside the "#ifdef CONFIG_USB_OTG" block just above the function's 
> start.

It'd be better to rearrange things in there so that no forward declarations
are needed.  A manual tsort...  But whatever.  It'd be better if it
compiled ;)

> The problem is that gcc 4 doesn't like static function declarations in 
> inner blocks.  Earlier versions of gcc didn't mind.

Wanna send a 2.6.19 patch please?

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel

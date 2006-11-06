From: David Brownell <david-b@pacbell.net>
Subject: Re: [ERROR]: -ENODEV Error!
Date: Mon, 6 Nov 2006 13:44:39 -0800
Message-ID: <200611061344.40177.david-b@pacbell.net>
References: <454F8488.6010806@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <454F8488.6010806@nokia.com>
Content-Disposition: inline
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

On Monday 06 November 2006 10:52 am, Felipe Balbi wrote:
> int usb_gadget_register_driver (struct usb_gadget_driver *driver)
> {
>         int             status = -ENODEV;
>         struct omap_ep  *ep;
>         unsigned long   flags;
> 
>         /* basic sanity tests */
>         if (!udc)       <---- THIS IS GIVING ME THE ERROR... 

Then your board setup is probably wrong, so that probe() didn't get
called because there was no USB peripheral controller.  Or probe()
failed for some reason.

This realy _is_ a fatal error...

>                 return -ENODEV;
>         if (!driver 
>                         // FIXME if otg, check:  driver->is_otg
>                         || driver->speed < USB_SPEED_FULL
>                         || !driver->bind
>                         || !driver->unbind
>                         || !driver->setup)    <------ THIS GAVE ME 
> ANOTHER BUG!!! :-P

Also a fatal error.  Gadget drivers **MUST** handle control messages, e.g.
so they will send device descriptors.

- Dave

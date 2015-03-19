From: Li Jun <b47624-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [RFC][PATCH 2/9] usb: gadget: add usb_gadget_start/stop()
Date: Thu, 19 Mar 2015 22:09:00 +0800
Message-ID: <20150319140859.GA7950@shlinux1.ap.freescale.net>
References: <1426686963-11613-1-git-send-email-rogerq@ti.com>
 <1426686963-11613-3-git-send-email-rogerq@ti.com>
 <20150319032944.GA2476@shlinux2> <550AA18F.2000106@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <550AA18F.2000106-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Mar 19, 2015 at 12:14:39PM +0200, Roger Quadros wrote:
> On 19/03/15 05:30, Peter Chen wrote:
> > On Wed, Mar 18, 2015 at 03:55:56PM +0200, Roger Quadros wrote:
> >> The OTG state machine needs a mechanism to start and
> >> stop the gadget controller. Add usb_gadget_start()
> >> and usb_gadget_stop().
> >>
> >> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> >> ---
> >>  drivers/usb/gadget/udc/udc-core.c | 166 +++++++++++++++++++++++++++++++++++---
> >>  include/linux/usb/gadget.h        |   3 +
> >>  2 files changed, 158 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/udc-core.c
> >> index 5a81cb0..69b4123 100644
> >> --- a/drivers/usb/gadget/udc/udc-core.c
> >> +++ b/drivers/usb/gadget/udc/udc-core.c
> >> @@ -35,6 +35,8 @@
> >>   * @dev - the child device to the actual controller
> >>   * @gadget - the gadget. For use by the class code
> >>   * @list - for use by the udc class driver
> >> + * @running - udc is running
> > 
> > Doesn't OTG FSM should know it?
> 
> Not really, as the gadget driver might not have been loaded yet or userspace might
> have disabled softconnect when the OTG FSM wants UDC to start.
> 
> So only UDC knows if it has really started or not based on this flag.
> 

why this can not be known by check the otg fsm state? i.e. if the device in
b_peripheral or a_peripheral state, udc should had started, isn't it?

Li Jun
> cheers,
> -roger
> 
> > 
> > Peter
> >> + * @softconnect - sysfs softconnect says OK to connect
> >>   *
> > 
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

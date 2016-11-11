From: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 0/4] musb fixes for v4.9-rc cycle
Date: Fri, 11 Nov 2016 17:06:02 -0600
Message-ID: <20161111230602.GA17429@uda0271908>
References: <20161107215020.31399-1-tony@atomide.com>
 <20161111162427.GA17372@uda0271908>
 <20161111165321.GF7138@atomide.com>
 <3814185.kgidRBy8ST@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3814185.kgidRBy8ST@avalon>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Sat, Nov 12, 2016 at 12:11:04AM +0200, Laurent Pinchart wrote:
> Hello,
> 
> On Friday 11 Nov 2016 08:53:22 Tony Lindgren wrote:
> > * Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> [161111 08:25]:
> > > On Fri, Nov 11, 2016 at 01:39:28AM +0200, Laurent Pinchart wrote:
> > >> Hello,
> > >> 
> > >> On Friday 11 Nov 2016 00:27:52 Laurent Pinchart wrote:
> > >>> On Thursday 10 Nov 2016 13:42:34 Tony Lindgren wrote:
> > >>>> * Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> [161110 13:29]:
> > >>>>> I had to disable CONFIG_USB_GADGET is compiling it as a module
> > >>>>> prevents selecting CONFIG_NOP_USB_XCEIV=y, which is a dependency for
> > >>>>> CONFIG_USB_EHCI_HCD_OMAP=m.
> > >>>>> 
> > >>>>> The new configuration resulted in a few changes, among which the
> > >>>>> most notable is
> > >>>>> 
> > >>>>> -# CONFIG_USB_MUSB_HOST is not set
> > >>>>> -# CONFIG_USB_MUSB_GADGET is not set
> > >>>>> -CONFIG_USB_MUSB_DUAL_ROLE=y
> > >>>>> +CONFIG_USB_MUSB_HOST=y
> > >>>>> 
> > >>>>> I then get the same error as originally reported.
> > >>>> 
> > >>>> Yeah OK, that's the problem.. We still have musb hardware
> > >>>> trying to do things on it's own and phy trying to detect
> > >>>> the state.
> > >>>> 
> > >>>> Any ideas why we have a dependency like that in Kconfig?
> > >>> 
> > >>> Well, with CONFIG_USB_GADGET disabled, I don't expect
> > >>> CONFIG_USB_MUSB_GADGET to be enabled. MUSB can only operate in host
> > >>> mode in that case, so musb-> xceiv->otg->state = OTG_STATE_A_IDLE
> > >>> makes sense.
> > >> 
> > >> I've tried to investigate this but I'm not familiar enough with the MUSB
> > >> driver to reach any conclusion. Felipe, if you have time could you give
> > >> me a hand ?
> > >> 
> > >> To summarize the issue, on a pandaboard-es where the MUSB is wired to an
> > >> OTG connector with mode rightfully set to MUSB_PORT_MODE_DUAL_ROLE in
> > >> DT, a kernel configured with CONFIG_USB_MUSB_HOST=y (for instance
> > >> because CONFIG_USB_GADGET is disabled) will print an endless stream of
> > >> the following meessage.
> > >> 
> > >> [    2.766174] musb_bus_suspend 2586: trying to suspend as a_idle while
> > >> active
> > >
> > > I don't have a omap3/4 platform to test on this, but I don't see this
> > > problem on am335x board.
> 
> Which board is that ? For the problem to occur the board has to have an OTG 
> connector.

It is the TI am335x GP EVM, which usb0 port has an otg receptacle, and a
power switch controlled by usb0 drvvbus pin.

> 
> > >> musb_init_controller() performs the following actions
> > >> 
> > >>         case MUSB_PORT_MODE_DUAL_ROLE:
> > >>                 status = musb_host_setup(musb, plat->power);
> > >>                 if (status < 0)
> > >>                         goto fail3;
> > >>                 status = musb_gadget_setup(musb);
> > >>                 if (status) {
> > >>                         musb_host_cleanup(musb);
> > >>                         goto fail3;
> > >>                 }
> > >>                 status = musb_platform_set_mode(musb, MUSB_OTG);
> > >>                 break;
> > >> 
> > >> and as gadget support is disabled musb_gadget_setup() compiles to a
> > >> no-op inline function. The system is thus configured in host mode by
> > >> musb_host_setup() with musb->xceiv->otg->state = OTG_STATE_A_IDLE. A
> > >> later call to musb_start() verifies the condition
> > >> 
> > >>         if (musb->port_mode != MUSB_PORT_MODE_HOST &&
> > >>             musb->xceiv->otg->state != OTG_STATE_A_WAIT_BCON &&
> > >>             (devctl & MUSB_DEVCTL_VBUS) == MUSB_DEVCTL_VBUS) {
> > > 
> > > To get there, devctl[MUSB_DEVCTL_VBUS] bits have to be set, where does the
> > > vbus voltage come from? Session is not on yet.
> 
> MUSB_DEVCTL is first set to 0 by musb_generic_disable() called from 
> musb_init_controller(). The register is then left untouched (as far as I can 
> tell, I've intercepted all musb_writeb() and musb_readb() calls) until 
> musb_start() to reads the register. The read value has BDEVICE and VBUS=3 set.

The DEVCTL_VBUS bits are set by the controller, when it sense VBUS
voltage > VBUS_VALID.

> 
> > >> and sets musb->is_active to 1. Later, musb_bus_suspend() complains
> > >> because is_active is not 0.
> > >> 
> > >> What is wrong in that sequence ?
> > 
> > I think the issue is pandaboard connected to a PC with mini-B
> > cable while musb is being forced to host mode?
> 
> The issue also occurs when the cable isn't connected.

If the otg port is not connected to a host but you still get VBUS=3, the
vbus voltage must be provided from the board itself. We have to check
the schematics to see how it is possible. This is pandaboard es, right?
Assume I will be able to find its schematics on internet...
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 

Regards,
-Bin.

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

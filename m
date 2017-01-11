From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] usb: musb: Add support for optional VBUS irq to dsps
 glue layer
Date: Wed, 11 Jan 2017 09:12:17 -0800
Message-ID: <20170111171217.GX2630@atomide.com>
References: <20170105191259.28723-1-tony@atomide.com>
 <20170110195317.GB2479@uda0271908>
 <20170111134151.GA18730@uda0271908>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170111134151.GA18730@uda0271908>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> [170111 05:42]:
> On Tue, Jan 10, 2017 at 01:53:53PM -0600, Bin Liu wrote:
> > On Thu, Jan 05, 2017 at 11:12:59AM -0800, Tony Lindgren wrote:
> > > We can now configure the PMIC interrupt to provide us VBUS
> > > events. In that case we don't need to constantly poll the
> > > status and can make it optional. This is only wired up
> > > for the mini-B interface on beaglebone.
> > 
> > Is it possible someone designed a board which hooks up the vbus of a
> > dual-role/otg port to PMIC? The port wouldn't be able to detect the
> > attach since no polling anymore.
> 
> I haven't seen any am335xx design other than the Beaglebone, that routes
> VBUS to PMIC, and I guess the reason that Beaglebone did this way is
> only for supporting bus-powered.

Yeah I guess that remains to be seen. I guess it could also be configured
to use any 5V GPIO in the dts and ideally and work the same way.

> > > +static int dsps_setup_optional_vbus_irq(struct platform_device *pdev,
> > > +					struct dsps_glue *glue)
> > > +{
> > > +	int error;
> > > +
> 
> How about check dr_mode at here, and simply return if dr_mode is not
> "peripheral". So this ensures this VBUS irq is only used for device
> mode, it clear my concern above.

Yeah OK I like your idea of limiting it to peripheral only for now.
Will repost with your other comments addressed also.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v11 08/14] usb: otg: add OTG/dual-role core
Date: Mon, 20 Jun 2016 19:49:04 +0800
Message-ID: <20160620114904.GC26936@shlinux2>
References: <1465564043-27163-1-git-send-email-rogerq@ti.com>
 <1465564043-27163-9-git-send-email-rogerq@ti.com>
 <575E672E.5070603@ti.com>
 <87h9coxq04.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87h9coxq04.fsf-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, Jun 20, 2016 at 10:45:31AM +0300, Felipe Balbi wrote:
> 
> Hi,
> 
> Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> writes:
> > It provides APIs for the following tasks
> >
> > - Registering an OTG/dual-role capable controller
> > - Registering Host and Gadget controllers to OTG core
> > - Providing inputs to and kicking the OTG state machine
> 
> I think I have already mentioned this, but after over 10 years of OTG,
> nobody seems to care about it, why are we still touching at all I don't
> know. For common non-OTG role-swapping we really don't need any of this
> and, quite frankly, I fail to see enough users for this.
> 
> Apparently there's only chipidea which, AFAICT, already had working
> dual-role before this OTG State Machine was added to the kernel.

Some users would like to know if vendor's platform is OTG compliance,
so we add it to pass usb.org USB OTG certification test.

For the real use case, some Carplay platforms need it.

> 
> > diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
> > index f4fc0aa..1d74fb8 100644
> > --- a/include/linux/usb/gadget.h
> > +++ b/include/linux/usb/gadget.h
> > @@ -328,6 +328,7 @@ struct usb_gadget_ops {
> >   * @in_epnum: last used in ep number
> >   * @mA: last set mA value
> >   * @otg_caps: OTG capabilities of this gadget.
> > + * @otg_dev: OTG controller device, if needs to be used with OTG core.
> 
> do you really know of any platform which has a separate OTG controller?
> 

It may not be a real separate OTG controller. It can be a hardware part
(external connector, external IC, SoC OTG register area, etc) to handle vbus
,id and other signals which are used for role swap.

-- 

Best Regards,
Peter Chen
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

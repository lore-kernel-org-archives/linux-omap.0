From: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v11 08/14] usb: otg: add OTG/dual-role core
Date: Tue, 21 Jun 2016 17:07:38 +0800
Message-ID: <20160621090738.GD5108@shlinux2>
References: <1465564043-27163-1-git-send-email-rogerq@ti.com>
 <1465564043-27163-9-git-send-email-rogerq@ti.com>
 <575E672E.5070603@ti.com>
 <87h9coxq04.fsf@linux.intel.com>
 <20160620114904.GC26936@shlinux2>
 <8737o8qd00.fsf@linux.intel.com>
 <20160621060517.GA5108@shlinux2>
 <877fdjovef.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <877fdjovef.fsf-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, Jun 21, 2016 at 10:26:00AM +0300, Felipe Balbi wrote:
> 
> Hi,
> 
> >> 
> >> So far, I haven't seen anybody talking about real USB OTG (the spec)
> >> when they say OTG. Usually they just mean "a method for swapping between
> >> host and peripheral roles, but we really don't want all the extra cost
> >> of the OTG specification".
> >> 
> >
> > That's what I thought before, but the request from the Marketing guy is
> > "To prove the SoC is OTG compliance, support HNP and SRP", don't you
> > see the SoC reference manual say "it supports HNP and SRP"?
> >
> > If there is no request, who else wants to implement so complicated FSM
> > but seldom use cases, and go to pass OTG compliance test (tested by PET).
> 
> I stand corrected :-)
> 
> So there is one user for this layer. And this user has its own role
> control registers. I'm not convinced we need this large generic layer
> for one user.
> 

You mean chipidea or dwc3? I have more comments below.

> >> > For the real use case, some Carplay platforms need it.
> >> 
> >> Carplay does *NOT* rely on OTG. Apple has its own proprietary and closed
> >> specification which is not OTG-compliant.
> >> 
> >
> > Yes, it is not OTG-compliant, but it can co-work with some standard OTG FSM
> > states to finish role swap.
> 
> What are you referring to as "finish role swap"? I don't get that.

Change current role from host to peripheral.

> 
> > Notice, it needs to swap role without disconnect cable.
> 
> right, I can swap role without changing cable, but that's not OTG. The
> mechanism for that, AFAICT, is not HNP. I don't know details about
> CarPlay because the spec isn't public, but my understanding is that
> CarPlay doesn't rely on anything from OTG spec.

Since it is non-public, I can't say much. Some flows of its role-swap
refers to On-The-Go and Embedded Host Supplement to the USB Revision 2.0
Specification. 

But OTG FSM is not the only way, the platform which can do role-swap
without disconnection can support it too.

> 
> >> >> > diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
> >> >> > index f4fc0aa..1d74fb8 100644
> >> >> > --- a/include/linux/usb/gadget.h
> >> >> > +++ b/include/linux/usb/gadget.h
> >> >> > @@ -328,6 +328,7 @@ struct usb_gadget_ops {
> >> >> >   * @in_epnum: last used in ep number
> >> >> >   * @mA: last set mA value
> >> >> >   * @otg_caps: OTG capabilities of this gadget.
> >> >> > + * @otg_dev: OTG controller device, if needs to be used with OTG core.
> >> >> 
> >> >> do you really know of any platform which has a separate OTG controller?
> >> >> 
> >> >
> >> > It may not be a real separate OTG controller. It can be a hardware part
> >> > (external connector, external IC, SoC OTG register area, etc) to handle vbus
> >> > ,id and other signals which are used for role swap.
> >> 
> >> That's already solved. EXTCON solved that years back and OMAP has been
> >> using EXTCON to program its UTMI mailbox.
> >> 
> >
> > No, that's not the same thing, it does not include the swap role.
> 
> Read your original comment:
> 
> "handle vbus, id and other signals which are *used for* role swap"
> 
> You didn't include role swap in your original comment. Semantics aside...
> 
> > Consider the use case the host driver is at host/ and udc driver is
> > at gadget/udc, how to finish to role swap?
> 
> ... why does the source code placement matter? And what do you mean by
> "finish role swap"?
> 

Well, it depends on your driver design, do you want the host driver's
API is still be called when current role is peripheral? One typical
problem you can refer below:

commit 11c011a5e777c83819078a18672543f04482b3ec
Author: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Date:   Thu May 19 11:12:56 2016 +0100

    usb: echi-hcd: Add ehci_setup check before echi_shutdown
        


In some cases, the USB code (gadget/hcd->start/stop) needs to be called
during the role swap. For example, if you have mux driver, you may
need to call usb_remove_hcd when ID from 0 to 1. Without Roger's framework,
how can we do that?

-- 

Best Regards,
Peter Chen
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

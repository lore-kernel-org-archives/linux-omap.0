From: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v11 08/14] usb: otg: add OTG/dual-role core
Date: Tue, 21 Jun 2016 21:05:12 +0800
Message-ID: <20160621130512.GF5108@shlinux2>
References: <1465564043-27163-1-git-send-email-rogerq@ti.com>
 <1465564043-27163-9-git-send-email-rogerq@ti.com>
 <575E672E.5070603@ti.com>
 <87h9coxq04.fsf@linux.intel.com>
 <20160620114904.GC26936@shlinux2>
 <8737o8qd00.fsf@linux.intel.com>
 <20160621060517.GA5108@shlinux2>
 <877fdjovef.fsf@linux.intel.com>
 <20160621090738.GD5108@shlinux2>
 <87h9cmoo4s.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87h9cmoo4s.fsf-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, Jun 21, 2016 at 01:02:59PM +0300, Felipe Balbi wrote:
> 
> Hi,
> 
> Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
> >> >> So far, I haven't seen anybody talking about real USB OTG (the spec)
> >> >> when they say OTG. Usually they just mean "a method for swapping between
> >> >> host and peripheral roles, but we really don't want all the extra cost
> >> >> of the OTG specification".
> >> >> 
> >> >
> >> > That's what I thought before, but the request from the Marketing guy is
> >> > "To prove the SoC is OTG compliance, support HNP and SRP", don't you
> >> > see the SoC reference manual say "it supports HNP and SRP"?
> >> >
> >> > If there is no request, who else wants to implement so complicated FSM
> >> > but seldom use cases, and go to pass OTG compliance test (tested by PET).
> >> 
> >> I stand corrected :-)
> >> 
> >> So there is one user for this layer. And this user has its own role
> >> control registers. I'm not convinced we need this large generic layer
> >> for one user.
> >> 
> >
> > You mean chipidea or dwc3? I have more comments below.
> 
> chipidea. From the point of OTG (or DRD) dwc3 is very
> self-sufficient. HW itself tracks state machine, much like MUSB does.

You mean HW can do state machine switch? If we are A device,
- Does the hardware knows if B device is HNP enabled or not?
- And if B device is HNP enabled, does it can switch itself from host
to peripheral when the B device is disconnected (a_suspend->a_peripheral)

Does hardware can really follow Figure 7-1: OTG A-device with HNP State
Diagram at On-The-Go and Embedded Host Supplement to the USB Revision
2.0 Specification? And can pass PET test?

> 
> >> >> > For the real use case, some Carplay platforms need it.
> >> >> 
> >> >> Carplay does *NOT* rely on OTG. Apple has its own proprietary and closed
> >> >> specification which is not OTG-compliant.
> >> >> 
> >> >
> >> > Yes, it is not OTG-compliant, but it can co-work with some standard OTG FSM
> >> > states to finish role swap.
> >> 
> >> What are you referring to as "finish role swap"? I don't get that.
> >
> > Change current role from host to peripheral.
> 
> Okay, we have two scenarios here:
> 
> 1. You need full OTG compliance
> 
> 	For this, granted, you need the state machine if your HW doesn't
> 	track it. This is a given. With only one user, however, perhaps
> 	we don't need a generic layer. There are not enough different
> 	setups to design a good enough generic layer. We will end up
> 	with a pseudo-generic framework which is coupled with its only
> 	user.
> 
> 2. Dual-role support, without OTG compliance
> 
> 	In this case, you don't need a stack. All you need is a signal
> 	to tell you state of ID pin and another to tell you state of
> 	VBUS level. If you have those, you don't need to walk an OTG
> 	state machine at all. You don't need any of those quirky OTG
> 	timers, agreed?
> 
> 	Given the above, why would you even want to use a subset of OTG
> 	state machine to implement something that's _usually_ as simple
> 	as:
> 
> 8<----------------------------------------------------------------------
> 	vbus = read(VBUS_STATE); /* could be a gpio_get_value() */
>         id = read(ID_STATE); /* could be a gpio_get_value() */
> 
>         set_role(id);
>         set_vbus(vbus);
> ------------------------------------------------------------------------
> 

In fact, the individual driver can do it by itself. The chipidea driver
handles OTG and dual-role well currently. By considering this OTG/DRD
framework is worthwhile or not, we would like to see if it can
simplify DRD design for each driver, and can benefit the platforms which
has different drivers for host and peripheral to finish the role switch
well.

- The common start/stop host and peripheral operation
eg, when switch from host to peripheral, all drivers can use
usb_remove_hcd to finish it.
- A common workqueue to handle vbus and id event
- sysfs for role switch

> >> > Notice, it needs to swap role without disconnect cable.
> >> 
> >> right, I can swap role without changing cable, but that's not OTG. The
> >> mechanism for that, AFAICT, is not HNP. I don't know details about
> >> CarPlay because the spec isn't public, but my understanding is that
> >> CarPlay doesn't rely on anything from OTG spec.
> >
> > Since it is non-public, I can't say much. Some flows of its role-swap
> > refers to On-The-Go and Embedded Host Supplement to the USB Revision 2.0
> > Specification. 
> >
> > But OTG FSM is not the only way, the platform which can do role-swap
> > without disconnection can support it too.
> 
> Right, all you need for CarPlay is what I wrote above. You don't need
> full OTG compliance for that, right?
> 

OTG FSM is not necessary, other dual-role switch also can satisfy its
requirement.

> >> 
> >> > Consider the use case the host driver is at host/ and udc driver is
> >> > at gadget/udc, how to finish to role swap?
> >> 
> >> ... why does the source code placement matter? And what do you mean by
> >> "finish role swap"?
> >> 
> >
> > Well, it depends on your driver design, do you want the host driver's
> > API is still be called when current role is peripheral? One typical
> > problem you can refer below:
> 
> That's a driver bug and those needs to be fixed. This has nothing to do
> with an OTG FSM, or lack thereof.
> 

To simplify the discussion, we consider dual-role switch first. If dual-role
needs a framework, then OTG can use the same one just different state
machine.

> (already implemented as gadget_wakeup())
> 
> > commit 11c011a5e777c83819078a18672543f04482b3ec
> > Author: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > Date:   Thu May 19 11:12:56 2016 +0100
> >
> >     usb: echi-hcd: Add ehci_setup check before echi_shutdown
> >         
> >
> >
> > In some cases, the USB code (gadget/hcd->start/stop) needs to be called
> > during the role swap. For example, if you have mux driver, you may
> > need to call usb_remove_hcd when ID from 0 to 1. Without Roger's framework,
> > how can we do that?
> 
> You don't really need to remove the gadget. Just mask its interrupts and
> ignore any calls to any gadget_driver ops, right? Likewise for
> XHCI. Just clear RUN/STOP and no events will ever reach XHCI. But, from
> the point of view of dwc3, it's simpler to unregister the platform
> device we create for xhci-plat.c. I need no changes in XHCI to do that
> and driver model will make sure to call xhci-plat's ->remove() which
> will handle everything for me correctly.
> 

I admit it can do in a IP driver, eg both host and peripheral for the
single IP, eg chipidea, dwc3, etc. But how can we clear RUN/STOP bit
or what else for HCD at mux driver?

-- 

Best Regards,
Peter Chen
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

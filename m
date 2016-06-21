From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v11 08/14] usb: otg: add OTG/dual-role core
Date: Tue, 21 Jun 2016 14:05:17 +0800
Message-ID: <20160621060517.GA5108@shlinux2>
References: <1465564043-27163-1-git-send-email-rogerq@ti.com>
 <1465564043-27163-9-git-send-email-rogerq@ti.com>
 <575E672E.5070603@ti.com>
 <87h9coxq04.fsf@linux.intel.com>
 <20160620114904.GC26936@shlinux2>
 <8737o8qd00.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8737o8qd00.fsf@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>
Cc: Roger Quadros <rogerq@ti.com>, peter.chen@freescale.com, tony@atomide.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com, mathias.nyman@linux.intel.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, robh@kernel.org, nsekhar@ti.com, b-liu@ti.com, joe@perches.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Jun 20, 2016 at 03:08:15PM +0300, Felipe Balbi wrote:
> 
> Hi,
> 
> Peter Chen <hzpeterchen@gmail.com> writes:
> >> Roger Quadros <rogerq@ti.com> writes:
> >> > It provides APIs for the following tasks
> >> >
> >> > - Registering an OTG/dual-role capable controller
> >> > - Registering Host and Gadget controllers to OTG core
> >> > - Providing inputs to and kicking the OTG state machine
> >> 
> >> I think I have already mentioned this, but after over 10 years of OTG,
> >> nobody seems to care about it, why are we still touching at all I don't
> >> know. For common non-OTG role-swapping we really don't need any of this
> >> and, quite frankly, I fail to see enough users for this.
> >> 
> >> Apparently there's only chipidea which, AFAICT, already had working
> >> dual-role before this OTG State Machine was added to the kernel.
> >
> > Some users would like to know if vendor's platform is OTG compliance,
> > so we add it to pass usb.org USB OTG certification test.
> 
> I strongly doubt that's really what they mean. IMHO, users want to know
> if they can swap roles. Ask them if they are really going for OTG
> certification. Ask them if they have an OPT tester. Ask them if they
> really want all those timers. If they want HNP polling, etc etc etc.
> 
> So far, I haven't seen anybody talking about real USB OTG (the spec)
> when they say OTG. Usually they just mean "a method for swapping between
> host and peripheral roles, but we really don't want all the extra cost
> of the OTG specification".
> 

That's what I thought before, but the request from the Marketing guy is
"To prove the SoC is OTG compliance, support HNP and SRP", don't you
see the SoC reference manual say "it supports HNP and SRP"?

If there is no request, who else wants to implement so complicated FSM
but seldom use cases, and go to pass OTG compliance test (tested by PET).

> > For the real use case, some Carplay platforms need it.
> 
> Carplay does *NOT* rely on OTG. Apple has its own proprietary and closed
> specification which is not OTG-compliant.
> 

Yes, it is not OTG-compliant, but it can co-work with some standard OTG FSM
states to finish role swap. Notice, it needs to swap role without
disconnect cable.

> >> > diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
> >> > index f4fc0aa..1d74fb8 100644
> >> > --- a/include/linux/usb/gadget.h
> >> > +++ b/include/linux/usb/gadget.h
> >> > @@ -328,6 +328,7 @@ struct usb_gadget_ops {
> >> >   * @in_epnum: last used in ep number
> >> >   * @mA: last set mA value
> >> >   * @otg_caps: OTG capabilities of this gadget.
> >> > + * @otg_dev: OTG controller device, if needs to be used with OTG core.
> >> 
> >> do you really know of any platform which has a separate OTG controller?
> >> 
> >
> > It may not be a real separate OTG controller. It can be a hardware part
> > (external connector, external IC, SoC OTG register area, etc) to handle vbus
> > ,id and other signals which are used for role swap.
> 
> That's already solved. EXTCON solved that years back and OMAP has been
> using EXTCON to program its UTMI mailbox.
> 

No, that's not the same thing, it does not include the swap role.
Consider the use case the host driver is at host/ and udc driver is
at gadget/udc, how to finish to role swap?

-- 

Best Regards,
Peter Chen

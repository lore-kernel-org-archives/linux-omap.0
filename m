From: Peter Chen <Peter.Chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [RFC][PATCH v2 00/13] USB: OTG/DRD Core functionality
Date: Tue, 21 Apr 2015 06:04:39 +0000
Message-ID: <BY1PR0301MB0855ACDA4337AE3FC7F616E081EF0@BY1PR0301MB0855.namprd03.prod.outlook.com>
References: <1429008120-5395-1-git-send-email-rogerq@ti.com>
 <20150420030531.GA30878@shlinux2> <5534AA8C.1070400@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5534AA8C.1070400-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "balbi-l0cyMroinI0@public.gmane.org" <balbi-l0cyMroinI0@public.gmane.org>, "stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org" <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, "dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Jun.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Jun.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "macpaul-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <macpaul-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

 
> 
> On 20/04/15 06:05, Peter Chen wrote:
> > On Tue, Apr 14, 2015 at 01:41:47PM +0300, Roger Quadros wrote:
> >> This is an attempt to centralize OTG/Dual-role functionality in the kernel.
> >> As of now I've got Dual-role functionality working pretty reliably on
> >> dra7-evm. xhci side of things for OTG/DRD use are fixed in
> >> http://thread.gmane.org/gmane.linux.kernel/1923161
> >
> > Hi Roger,
> >
> > Currently, there are two main problems for DRD/OTG framework.
> >
> > - For multi-platform supports, we may define CONFIG_USB_OTG, but the
> > gadget should not add its otg descriptor to its configuration
> > descriptors if it does not support one of otg features (SRP/HNP/ADP).
> > Macpaul Lin's patch set [1] is the right way to do it.
> 
> Agreed. That check (whether OTG descriptor can be added and which version
> of it) has to be done at runtime and it must be added only if hardware supports
> OTG _and_ kernel OTG support is enabled.
> 

Ok, let's put this patch set in mainline first, since your patch set may need some
information from it.
 
> > - We are lack of framework to handle OTG (DRD) switch, it is great you
> > are designing it. The main problem for this framework is how to handle
> > DRD/OTG FSM unify. My thought is we add two paths for them separate.
> > For easy, I suggest if the platform supports one of otg features, then
> > it goes to fully otg fsm, else it goes to simply otg fsm (like your
> > drd fsm). If you agree with it too, you may not need to add another
> "dr_mode"
> > value.
> 
> It would be nice that way but unfortunately it does't work in all cases.
> e.g. What if the SoC itself supports all OTG features but the board is not
> designed for OTG. Or the product designer simply is not interested in full OTG
> support but just dual-role. So we need some flexibility for the device
> tree/platform-data to specify that. This is where a new "dr_mode" == "dual-
> role" is needed.
> 

Since "dr_mode" has been widely used now, if we add a new property for it,  we
need to change all drivers.

Your OTG/DRD framework needs to (partial) use otg fsm, and we will not teach old
driver to use it since there are some driver related stuffs.

SRP/HNP/ADP support can be board level capabilities, and we may consider the
otg device which does not support otg fsm (hardware finishes fsm). So I suggest
we have below properties at dts:

- otg-support /* fully otg support */
- otg-fsm-support /* fully otg fsm support */
- otg-ver /* eh & otg supplement version */
- adp-support /* board adp support */ 
- srp-support /* board srp support */
- hnp-support /* board hnp support */

Currently, if CONFIG_USB_OTG and CONFIG_USB_OTG_FSM are enabled, we will
have otg fsm code (usb-otg-fsm.c).

if (otg-support & otg-fsm-support)
	this device has fully otg support, and will follow full otg fsm transitions. 
else
	this device is drd, and will follow simple otg fsm transtions. 

Peter

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

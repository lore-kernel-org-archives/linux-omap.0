From: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v11 08/14] usb: otg: add OTG/dual-role core
Date: Tue, 21 Jun 2016 17:14:37 +0800
Message-ID: <20160621091437.GE5108@shlinux2>
References: <1465564043-27163-1-git-send-email-rogerq@ti.com>
 <1465564043-27163-9-git-send-email-rogerq@ti.com>
 <575E672E.5070603@ti.com>
 <87h9coxq04.fsf@linux.intel.com>
 <5767C1B9.2060805@ti.com>
 <878ty0qd7q.fsf@linux.intel.com>
 <20160621063936.GB5108@shlinux2>
 <87d1nbovp7.fsf@linux.intel.com>
 <20160621080209.GC5108@shlinux2>
 <87mvmfneeq.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87mvmfneeq.fsf-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, Jun 21, 2016 at 11:18:21AM +0300, Felipe Balbi wrote:
> 
> Hi,
> 
> Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
> >> Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
> >> >> >>> +
> >> >> >>> +		/* start host */
> >> >> >>> +		ret = hcd_ops->add(otg->primary_hcd.hcd,
> >> >> >>> +				   otg->primary_hcd.irqnum,
> >> >> >>> +				   otg->primary_hcd.irqflags);
> >> >> >> 
> >> >> >> this is usb_add_hcd(), is it not? Why add an indirection?
> >> >> >
> >> >> > I've introduced the host and gadget ops interface to get around the
> >> >> > circular dependency issue we can't avoid.
> >> >> > otg needs to call host/gadget functions and host/gadget also needs to
> >> >> > call otg functions.
> >> >> 
> >> >> IMO, this shows a fragility of your design. You're, now, lying to
> >> >> usb_hcd and usb_udc and making them register into a virtual layer that
> >> >> doesn't exist. And that layer will end up calling the real registration
> >> >> function when some magic event happens.
> >> >> 
> >> >> This is only really needed for quirky devices like dwc3 (but see more on
> >> >> dwc3 below) where host and peripheral registers shadow each
> >> >> other. Otherwise we would be able to always keep hcd and udc always
> >> >> registered. They would get different interrupt statuses anyway and
> >> >> nothing would ever break.
> >> >> 
> >> >> However, when it comes to dwc3, we already have all the code necessary
> >> >> to workaround this issue by destroying the XHCI pdev when OTG interrupt
> >> >> says we should be peripheral (and vice-versa). DWC3 also keeps track of
> >> >> the OTG states for those folks who really care about OTG (Hint: nobody
> >> >> has cared for the past 10 years, why would they do so now?) and we don't
> >> >> need a SW state machine when the HW handles that for us, right?
> >> >> 
> >> >> As for chipidea, IIRC, that doesn't need a SW state machine either, but
> >> >> I know very little about that IP and don't even have documentation on
> >> >> it. My understanding, however, is that chipidea behaves kinda like MUSB,
> >> >> which changes roles automatically in HW based on ID pin state.
> >> >
> >> > Chipidea needs to set register for USB role manually.
> >> 
> >> okay, so chipidea has private control of role. Much like dwc3. That's good.
> >> 
> >> >> >>> + * @otg_dev: OTG controller device, if needs to be used with OTG core.
> >> >> >> 
> >> >> >> do you really know of any platform which has a separate OTG controller?
> >> >> >> 
> >> >> >
> >> >> > Andrew had pointed out in [1] that Tegra210 has separate blocks for OTG, host
> >> >> > and gadget.
> >> >> >
> >> >> > [1] http://article.gmane.org/gmane.linux.ports.tegra/22969
> >> >> 
> >> >> that's not an OTG controller, it's just a mux. No different than Intel's
> >> >> mux for swapping between XHCI and peripheral-only DWC3.
> >> >> 
> >> >> frankly, I would NEVER talk about OTG when type-C comes into play. They
> >> >> are two competing standards and, apparently, type-C is winning when it
> >> >> comes to role-swapping.
> >> >> 
> >> >
> >> > In fact, OTG is mis-used by people. Currently, if the port is dual-role,
> >> > It will be considered as an OTG port.
> >> 
> >> That's because "dual-role" is a non-standard OTG. Seen as people really
> >> didn't care about OTG, we (linux-usb folks) ended up naturally referring
> >> to "non-standard OTG" as "dual-role". Just to avoid confusion.
> >
> > So, unless we use OTG FSM defined in OTG spec, we should not mention
> > "OTG" in Linux, right?
> 
> to avoid confusion with the terminology, yes. With that settled, let's
> figure out how you can deliver what your marketting guys are asking of
> you.
> 

Since nxp SoC claims they are OTG compliance, we need to pass usb.org
test. The internal bsp has passed PET test, and formal compliance test
is on the way (should pass too). 

The dual-role and OTG compliance use the same zImage, but different
dtb.

-- 

Best Regards,
Peter Chen
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

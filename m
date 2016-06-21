From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v11 08/14] usb: otg: add OTG/dual-role core
Date: Tue, 21 Jun 2016 14:39:36 +0800
Message-ID: <20160621063936.GB5108@shlinux2>
References: <1465564043-27163-1-git-send-email-rogerq@ti.com>
 <1465564043-27163-9-git-send-email-rogerq@ti.com>
 <575E672E.5070603@ti.com>
 <87h9coxq04.fsf@linux.intel.com>
 <5767C1B9.2060805@ti.com>
 <878ty0qd7q.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <878ty0qd7q.fsf@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>
Cc: Roger Quadros <rogerq@ti.com>, peter.chen@freescale.com, yoshihiro.shimoda.uh@renesas.com, tony@atomide.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com, mathias.nyman@linux.intel.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, jun.li@freescale.com, grygorii.strashko@ti.com, robh@kernel.org, nsekhar@ti.com, b-liu@ti.com, joe@perches.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Jun 20, 2016 at 03:03:37PM +0300, Felipe Balbi wrote:
> 
> Hi,
> 
> >>> +
> >>> +		/* start host */
> >>> +		ret = hcd_ops->add(otg->primary_hcd.hcd,
> >>> +				   otg->primary_hcd.irqnum,
> >>> +				   otg->primary_hcd.irqflags);
> >> 
> >> this is usb_add_hcd(), is it not? Why add an indirection?
> >
> > I've introduced the host and gadget ops interface to get around the
> > circular dependency issue we can't avoid.
> > otg needs to call host/gadget functions and host/gadget also needs to
> > call otg functions.
> 
> IMO, this shows a fragility of your design. You're, now, lying to
> usb_hcd and usb_udc and making them register into a virtual layer that
> doesn't exist. And that layer will end up calling the real registration
> function when some magic event happens.
> 
> This is only really needed for quirky devices like dwc3 (but see more on
> dwc3 below) where host and peripheral registers shadow each
> other. Otherwise we would be able to always keep hcd and udc always
> registered. They would get different interrupt statuses anyway and
> nothing would ever break.
> 
> However, when it comes to dwc3, we already have all the code necessary
> to workaround this issue by destroying the XHCI pdev when OTG interrupt
> says we should be peripheral (and vice-versa). DWC3 also keeps track of
> the OTG states for those folks who really care about OTG (Hint: nobody
> has cared for the past 10 years, why would they do so now?) and we don't
> need a SW state machine when the HW handles that for us, right?
> 
> As for chipidea, IIRC, that doesn't need a SW state machine either, but
> I know very little about that IP and don't even have documentation on
> it. My understanding, however, is that chipidea behaves kinda like MUSB,
> which changes roles automatically in HW based on ID pin state.

Chipidea needs to set register for USB role manually.

> >>> + * @otg_dev: OTG controller device, if needs to be used with OTG core.
> >> 
> >> do you really know of any platform which has a separate OTG controller?
> >> 
> >
> > Andrew had pointed out in [1] that Tegra210 has separate blocks for OTG, host
> > and gadget.
> >
> > [1] http://article.gmane.org/gmane.linux.ports.tegra/22969
> 
> that's not an OTG controller, it's just a mux. No different than Intel's
> mux for swapping between XHCI and peripheral-only DWC3.
> 
> frankly, I would NEVER talk about OTG when type-C comes into play. They
> are two competing standards and, apparently, type-C is winning when it
> comes to role-swapping.
> 

In fact, OTG is mis-used by people. Currently, if the port is dual-role,
It will be considered as an OTG port.

You are right, if the connector is type-c, it will be called as "type-c
port" by people :)

-- 

Best Regards,
Peter Chen

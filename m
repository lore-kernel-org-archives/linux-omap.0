From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v11 08/14] usb: otg: add OTG/dual-role core
Date: Tue, 21 Jun 2016 21:12:05 +0800
Message-ID: <20160621131205.GG5108@shlinux2>
References: <575E672E.5070603@ti.com>
 <87h9coxq04.fsf@linux.intel.com>
 <5767C1B9.2060805@ti.com>
 <878ty0qd7q.fsf@linux.intel.com>
 <20160621063936.GB5108@shlinux2>
 <87d1nbovp7.fsf@linux.intel.com>
 <20160621080209.GC5108@shlinux2>
 <87mvmfneeq.fsf@linux.intel.com>
 <20160621091437.GE5108@shlinux2>
 <87fus6n2iz.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87fus6n2iz.fsf@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>
Cc: Roger Quadros <rogerq@ti.com>, peter.chen@freescale.com, yoshihiro.shimoda.uh@renesas.com, tony@atomide.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com, mathias.nyman@linux.intel.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, jun.li@freescale.com, grygorii.strashko@ti.com, robh@kernel.org, nsekhar@ti.com, b-liu@ti.com, joe@perches.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Jun 21, 2016 at 03:35:00PM +0300, Felipe Balbi wrote:
> 
> Hi,
> 
> Peter Chen <hzpeterchen@gmail.com> writes:
> >> >> >> >>> + * @otg_dev: OTG controller device, if needs to be used with OTG core.
> >> >> >> >> 
> >> >> >> >> do you really know of any platform which has a separate OTG controller?
> >> >> >> >> 
> >> >> >> >
> >> >> >> > Andrew had pointed out in [1] that Tegra210 has separate blocks for OTG, host
> >> >> >> > and gadget.
> >> >> >> >
> >> >> >> > [1] http://article.gmane.org/gmane.linux.ports.tegra/22969
> >> >> >> 
> >> >> >> that's not an OTG controller, it's just a mux. No different than Intel's
> >> >> >> mux for swapping between XHCI and peripheral-only DWC3.
> >> >> >> 
> >> >> >> frankly, I would NEVER talk about OTG when type-C comes into play. They
> >> >> >> are two competing standards and, apparently, type-C is winning when it
> >> >> >> comes to role-swapping.
> >> >> >> 
> >> >> >
> >> >> > In fact, OTG is mis-used by people. Currently, if the port is dual-role,
> >> >> > It will be considered as an OTG port.
> >> >> 
> >> >> That's because "dual-role" is a non-standard OTG. Seen as people really
> >> >> didn't care about OTG, we (linux-usb folks) ended up naturally referring
> >> >> to "non-standard OTG" as "dual-role". Just to avoid confusion.
> >> >
> >> > So, unless we use OTG FSM defined in OTG spec, we should not mention
> >> > "OTG" in Linux, right?
> >> 
> >> to avoid confusion with the terminology, yes. With that settled, let's
> >> figure out how you can deliver what your marketting guys are asking of
> >> you.
> >> 
> >
> > Since nxp SoC claims they are OTG compliance, we need to pass usb.org
> > test. The internal bsp has passed PET test, and formal compliance test
> > is on the way (should pass too). 
> >
> > The dual-role and OTG compliance use the same zImage, but different
> > dtb.
> 
> okay, that's good to know. Now, the question really is: considering we
> only have one user for this generic OTG FSM layer, do we really need to
> make it generic at all? I mean, just look at how invasive a change that
> is.
> 

If the chipidea is the only user for this roger's framework, I don't
think it is necessary. In fact, Roger introduces this framework, and
the first user is dwc3, we think it can be used for others. Let's
just discuss if it is necessary for dual-role switch.

-- 

Best Regards,
Peter Chen

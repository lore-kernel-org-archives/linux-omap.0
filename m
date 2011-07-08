From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC] dmaengine: Moving TI SDMA driver to dmaengine - design
 plan
Date: Fri, 8 Jul 2011 03:27:51 -0700
Message-ID: <20110708102751.GT5783@atomide.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E94030259CD17@dbde02.ent.ti.com>
 <20110708100410.GA4957@n2100.arm.linux.org.uk>
 <E0D41E29EB0DAC4E9F3FF173962E9E94030259CDC4@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94030259CDC4@dbde02.ent.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Raju, Sundaram" <sundaram@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Dan <dan.j.williams@intel.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Raju, Sundaram <sundaram@ti.com> [110708 03:09]:
> > -----Original Message-----
> > From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> > Sent: Friday, July 08, 2011 3:34 PM
> > To: Raju, Sundaram
> > Cc: linux-arm-kernel@lists.infradead.org; linux-omap@vger.kernel.org; Dan;
> > Shilimkar, Santosh; linux-kernel@vger.kernel.org
> > Subject: Re: [RFC] dmaengine: Moving TI SDMA driver to dmaengine - design
> > plan
> > 
> > On Fri, Jul 08, 2011 at 01:52:17PM +0530, Raju, Sundaram wrote:
> > > I am planning to move TI SDMA driver in OMAP tree
> > > into the dmaengine framework.
> > >
> > > The first immediate issue of concern I noticed is the
> > > huge number of client drivers that use the existing SDMA driver.
> > > More than 15 client drivers are using the current SDMA driver.
> > >
> > > Moving the SDMA driver along with all of these client drivers at a
> > > single stretch seems a humungous task.
> > > I noticed a model in the existing DMA drivers in dmaengine
> > > framework that will over come this issue.
> > 
> > It _is_ sane to build a dmaengine driver on top of the existing SoC
> > private API, then convert the drivers to DMA engine, and then cleanup
> > the resulting DMA engine driver.
> 
> Yes, that is what I thought. Thanks.

Yes that's what we did with the gpiolib changes. That allows then
converting the drivers over to the DMA engine API one function at
a time (or one driver at a time).

Regards,

Tony

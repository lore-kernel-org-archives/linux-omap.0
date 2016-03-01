From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v3 3/3] pci: dra7xx: use pdata callbacks to perform reset
Date: Tue, 1 Mar 2016 08:43:36 -0600
Message-ID: <20160301144335.GA11916@localhost>
References: <56BE1454.3030002@ti.com>
 <56C5D377.50901@ti.com>
 <56CAA82D.6000507@ti.com>
 <alpine.DEB.2.02.1602220631300.3418@utopia.booyaka.com>
 <56CADB23.8020202@ti.com>
 <56CC490F.3040301@ti.com>
 <alpine.DEB.2.02.1602231827300.27173@utopia.booyaka.com>
 <56CD4BE1.3010701@ti.com>
 <alpine.DEB.2.02.1603010825090.14948@utopia.booyaka.com>
 <56D5834C.5030800@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56D5834C.5030800@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Sekhar Nori <nsekhar@ti.com>, Suman Anna <s-anna@ti.com>, d-gerlach@ti.com, Tony Lindgren <tony@atomide.com>, Bjorn Helgaas <bhelgaas@google.com>, richardcochran@gmail.com, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Mar 01, 2016 at 05:25:56PM +0530, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Tuesday 01 March 2016 01:55 PM, Paul Walmsley wrote:
> > 
> > Folks, the following is what I've queued for this.
> 
> Thanks Paul.
> 
> Bjorn,
> 
> With this patch merged, enabling pci-dra7xx won't result in system freeze
> anymore. I can send a patch to revert depends on BROKEN.

Great!  Please send me that patch, and I'll merge it for v4.6.

> > From: Sekhar Nori <nsekhar@ti.com>
> > Date: Thu, 18 Feb 2016 16:49:56 +0530
> > Subject: [PATCH] ARM: DRA7: hwmod: Add custom reset handler for PCIeSS
> > 
> > Add a custom reset handler for DRA7x PCIeSS. This
> > handler is required to deassert PCIe hardreset lines
> > after they have been asserted.
> > 
> > This enables the PCIe driver to access registers after
> > PCIeSS has been runtime enabled without having to
> > deassert hardreset lines itself.
> > 
> > With this patch applied, used lspci to make sure
> > connected PCIe device enumerates on DRA74x and DRA72x
> > EVMs.
> > 
> > Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> > Reported-by: Richard Cochran <richardcochran@gmail.com>
> > Tested-by: Kishon Vijay Abraham I <kishon@ti.com>
> > Cc: Suman Anna <s-anna@ti.com>
> > Cc: Dave Gerlach <d-gerlach@ti.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Signed-off-by: Paul Walmsley <paul@pwsan.com>
> > ---
> >  arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> > 
> > diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> > index b61355e2a771..252b74633e31 100644
> > --- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> > +++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> > @@ -1526,8 +1526,31 @@ static struct omap_hwmod dra7xx_ocp2scp3_hwmod = {
> >   *
> >   */
> >  
> > +/*
> > + * As noted in documentation for _reset() in omap_hwmod.c, the stock reset
> > + * functionality of OMAP HWMOD layer does not deassert the hardreset lines
> > + * associated with an IP automatically leaving the driver to handle that
> > + * by itself. This does not work for PCIeSS which needs the reset lines
> > + * deasserted for the driver to start accessing registers.
> > + *
> > + * We use a PCIeSS HWMOD class specific reset handler to deassert the hardreset
> > + * lines after asserting them.
> > + */
> > +static int dra7xx_pciess_reset(struct omap_hwmod *oh)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < oh->rst_lines_cnt; i++) {
> > +		omap_hwmod_assert_hardreset(oh, oh->rst_lines[i].name);
> > +		omap_hwmod_deassert_hardreset(oh, oh->rst_lines[i].name);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static struct omap_hwmod_class dra7xx_pciess_hwmod_class = {
> >  	.name	= "pcie",
> > +	.reset	= dra7xx_pciess_reset,
> >  };
> >  
> >  /* pcie1 */
> > 

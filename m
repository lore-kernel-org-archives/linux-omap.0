From: Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>
Subject: Re: [RFC 10/18] omap3isp: Move the syscon register out of the ISP
 register maps
Date: Sun, 8 Mar 2015 01:43:34 +0200
Message-ID: <20150307234334.GH6539@valkosipuli.retiisi.org.uk>
References: <1425764475-27691-1-git-send-email-sakari.ailus@iki.fi>
 <1425764475-27691-11-git-send-email-sakari.ailus@iki.fi>
 <1726882.heQ7ZxmKYg@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1726882.heQ7ZxmKYg@avalon>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Laurent,

On Sun, Mar 08, 2015 at 01:34:17AM +0200, Laurent Pinchart wrote:
> Hi Sakari,
> 
> Thank you for the patch.
> 
> (CC'ing linux-omap and Tony)

Thanks.

> On Saturday 07 March 2015 23:41:07 Sakari Ailus wrote:
> > The syscon register isn't part of the ISP, use it through the syscom driver
> > regmap instead. The syscom block is considered to be from 343x on ISP
> > revision 2.0 whereas 15.0 is assumed to have 3630 syscon.
> > 
> > Signed-off-by: Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>
> > ---
> >  arch/arm/boot/dts/omap3.dtsi                |    2 +-
> >  arch/arm/mach-omap2/devices.c               |   10 ----------
> >  drivers/media/platform/omap3isp/isp.c       |   19 +++++++++++++++----
> >  drivers/media/platform/omap3isp/isp.h       |   19 +++++++++++++++++--
> >  drivers/media/platform/omap3isp/ispcsiphy.c |   20 +++++++++-----------
> 
> You might be asked to split the patch into two, let's see what Tony says.
> 
> >  5 files changed, 42 insertions(+), 28 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
> > index 01b7111..fe0b293 100644
> > --- a/arch/arm/boot/dts/omap3.dtsi
> > +++ b/arch/arm/boot/dts/omap3.dtsi
> > @@ -183,7 +183,7 @@
> > 
> >  		omap3_scm_general: tisyscon@48002270 {
> >  			compatible = "syscon";
> > -			reg = <0x48002270 0x2f0>;
> > +			reg = <0x48002270 0x2f4>;
> >  		};
> > 
> >  		pbias_regulator: pbias_regulator {
> > diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> > index 1afb50d..e945957 100644
> > --- a/arch/arm/mach-omap2/devices.c
> > +++ b/arch/arm/mach-omap2/devices.c
> > @@ -143,16 +143,6 @@ static struct resource omap3isp_resources[] = {
> >  		.flags		= IORESOURCE_MEM,
> >  	},
> >  	{
> > -		.start		= OMAP343X_CTRL_BASE + OMAP343X_CONTROL_CSIRXFE,
> > -		.end		= OMAP343X_CTRL_BASE + OMAP343X_CONTROL_CSIRXFE + 3,
> > -		.flags		= IORESOURCE_MEM,
> > -	},
> > -	{
> > -		.start		= OMAP343X_CTRL_BASE + OMAP3630_CONTROL_CAMERA_PHY_CTRL,
> > -		.end		= OMAP343X_CTRL_BASE + OMAP3630_CONTROL_CAMERA_PHY_CTRL + 3,
> > -		.flags		= IORESOURCE_MEM,
> > -	},
> > -	{
> >  		.start		= 24 + OMAP_INTC_START,
> >  		.flags		= IORESOURCE_IRQ,
> >  	}
> > diff --git a/drivers/media/platform/omap3isp/isp.c
> > b/drivers/media/platform/omap3isp/isp.c index 68d7edfc..4ff4bbd 100644
> > --- a/drivers/media/platform/omap3isp/isp.c
> > +++ b/drivers/media/platform/omap3isp/isp.c
> > @@ -51,6 +51,7 @@
> >  #include <linux/dma-mapping.h>
> >  #include <linux/i2c.h>
> >  #include <linux/interrupt.h>
> > +#include <linux/mfd/syscon.h>
> >  #include <linux/module.h>
> >  #include <linux/omap-iommu.h>
> >  #include <linux/platform_device.h>
> > @@ -94,8 +95,9 @@ static const struct isp_res_mapping isp_res_maps[] = {
> >  		       1 << OMAP3_ISP_IOMEM_RESZ |
> >  		       1 << OMAP3_ISP_IOMEM_SBL |
> >  		       1 << OMAP3_ISP_IOMEM_CSI2A_REGS1 |
> > -		       1 << OMAP3_ISP_IOMEM_CSIPHY2 |
> > -		       1 << OMAP3_ISP_IOMEM_343X_CONTROL_CSIRXFE,
> > +		       1 << OMAP3_ISP_IOMEM_CSIPHY2,
> > +		.syscon_offset = 0xdc,
> > +		.phy_type = ISP_PHY_TYPE_3430,
> >  	},
> >  	{
> >  		.isp_rev = ISP_REVISION_15_0,
> > @@ -112,8 +114,9 @@ static const struct isp_res_mapping isp_res_maps[] = {
> >  		       1 << OMAP3_ISP_IOMEM_CSI2A_REGS2 |
> >  		       1 << OMAP3_ISP_IOMEM_CSI2C_REGS1 |
> >  		       1 << OMAP3_ISP_IOMEM_CSIPHY1 |
> > -		       1 << OMAP3_ISP_IOMEM_CSI2C_REGS2 |
> > -		       1 << OMAP3_ISP_IOMEM_3630_CONTROL_CAMERA_PHY_CTRL,
> > +		       1 << OMAP3_ISP_IOMEM_CSI2C_REGS2,
> > +		.syscon_offset = 0x2f0,
> > +		.phy_type = ISP_PHY_TYPE_3630,
> >  	},
> >  };
> > 
> > @@ -2352,6 +2355,14 @@ static int isp_probe(struct platform_device *pdev)
> >  		}
> >  	}
> > 
> > +	isp->syscon = syscon_regmap_lookup_by_pdevname("syscon.0");
> > +	isp->syscon_offset = isp_res_maps[m].syscon_offset;
> > +	isp->phy_type = isp_res_maps[m].phy_type;
> 
> You could move those two lines after the error check to keep the check closer 
> to the source of error.

Ack.

> Apart from that,
> 
> Acked-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

Thanks for the acks!

-- 
Kind regards,

Sakari Ailus
e-mail: sakari.ailus-X3B1VOXEql0@public.gmane.org	XMPP: sailus-PCDdDYkjdNMDXYZnReoRVg@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

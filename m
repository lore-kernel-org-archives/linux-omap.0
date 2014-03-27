From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [RFC PATCH 03/12] pci: host: pcie-designware: Use *base-mask* for configuring the iATU
Date: Thu, 27 Mar 2014 18:32:11 +0100
Message-ID: <201403271832.11425.marex@denx.de>
References: <1395842272-15267-1-git-send-email-kishon@ti.com> <1395842272-15267-4-git-send-email-kishon@ti.com> <000001cf49b1$fcd8a810$f689f830$%han@samsung.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <000001cf49b1$fcd8a810$f689f830$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: 'Kishon Vijay Abraham I' <kishon-l0cyMroinI0@public.gmane.org>, 'Mohit Kumar' <mohit.kumar-qxv4g6HH51o@public.gmane.org>, 'Pratyush Anand' <pratyush.anand-qxv4g6HH51o@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, 'Richard Zhu' <r65037-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thursday, March 27, 2014 at 12:45:01 PM, Jingoo Han wrote:
> On Wednesday, March 26, 2014 10:58 PM, Kishon Vijay Abraham I wrote:
> > In DRA7, the cpu sees 32bit address, but the pcie controller can see only
> > 28bit address. So whenever the cpu issues a read/write request, the 4
> > most significant bits are used by L3 to determine the target controller.
> > For example, the cpu reserves 0x2000_0000 - 0x2FFF_FFFF for PCIe
> > controller but the PCIe controller will see only (0x000_0000 -
> > 0xFFF_FFF). So for programming the outbound translation window the
> > *base* should be programmed as 0x000_0000. Whenever we try to write to
> > say 0x2000_0000, it will be translated to whatever we have programmed in
> > the translation window with base as 0x000_0000.
> > 
> > Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> 
> (+cc Pratyush Anand, Marek Vasut, Richard Zhu)

Thanks.

> Acked-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

This patch has no impact on MX6, the mask on MX6 is ~0 . A few comments below 
...
[...]

> > diff --git a/drivers/pci/host/pcie-designware.c
> > b/drivers/pci/host/pcie-designware.c index 17ce88f..98b661c 100644
> > --- a/drivers/pci/host/pcie-designware.c
> > +++ b/drivers/pci/host/pcie-designware.c
> > @@ -464,6 +464,9 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
> > 
> >  		return -EINVAL;
> >  	
> >  	}
> > 
> > +	if (of_property_read_u64(np, "base-mask", &pp->base_mask))
> > +		pp->base_mask = ~(0x0ULL);

You can just use ~0x0ULL without the () I believe.

[...]

> > diff --git a/drivers/pci/host/pcie-designware.h
> > b/drivers/pci/host/pcie-designware.h index 3063b35..3fa12a6 100644
> > --- a/drivers/pci/host/pcie-designware.h
> > +++ b/drivers/pci/host/pcie-designware.h
> > @@ -35,6 +35,7 @@ struct pcie_port {
> > 
> >  	struct device		*dev;
> >  	u8			root_bus_nr;
> >  	void __iomem		*dbi_base;
> > 
> > +	u64			base_mask;
> > 
> >  	u64			cfg0_base;
> >  	void __iomem		*va_cfg0_base;
> >  	u64			cfg1_base;

This structure contains a lot of slop, check [1] please. We really should be 
more careful about the structures. I think a separate patch to clean this up 
would be fine though.

[1] http://www.catb.org/esr/structure-packing/
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

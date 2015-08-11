From: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v3] PCI: kill off set_irq_flags usage
Date: Tue, 11 Aug 2015 15:20:27 -0500
Message-ID: <20150811202027.GG13982@google.com>
References: <1438030523-15853-1-git-send-email-robh@kernel.org>
 <1438030523-15853-9-git-send-email-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1438030523-15853-9-git-send-email-robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pratyush Anand <pratyush.anand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, =?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, Jul 27, 2015 at 03:55:21PM -0500, Rob Herring wrote:
> set_irq_flags is ARM specific with custom flags which have genirq
> equivalents. Convert drivers to use the genirq interfaces directly, s=
o we
> can kill off set_irq_flags. The translation of flags is as follows:
>=20
> IRQF_VALID -> !IRQ_NOREQUEST
> IRQF_PROBE -> !IRQ_NOPROBE
> IRQF_NOAUTOEN -> IRQ_NOAUTOEN
>=20
> For IRQs managed by an irqdomain, the irqdomain core code handles cle=
aring
> and setting IRQ_NOREQUEST already, so there is no need to do this in
> .map() functions and we can simply remove the set_irq_flags calls. So=
me
> users also modify IRQ_NOPROBE and this has been maintained although i=
t
> is not clear that is really needed. There appears to be a great deal =
of
> blind copy and paste of this code.
>=20
> Signed-off-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> Acked-by: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
> Cc: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
> Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
> Cc: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Pratyush Anand <pratyush.anand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
> Cc: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
> Cc: "S=F6ren Brinkmann" <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
> Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> ---
> Thomas asked that this be merged thru subsystem trees instead of arm-=
soc,
> so please apply this to your tree.

Applied with Jingoo's ack to pci/irq for v4.3, thanks!

>  drivers/pci/host/pci-dra7xx.c      | 1 -
>  drivers/pci/host/pci-keystone-dw.c | 2 --
>  drivers/pci/host/pci-tegra.c       | 1 -
>  drivers/pci/host/pci-xgene-msi.c   | 1 -
>  drivers/pci/host/pcie-designware.c | 1 -
>  drivers/pci/host/pcie-rcar.c       | 1 -
>  drivers/pci/host/pcie-xilinx.c     | 2 --
>  7 files changed, 9 deletions(-)
>=20
> diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra=
7xx.c
> index 80db09e..1a0d124 100644
> --- a/drivers/pci/host/pci-dra7xx.c
> +++ b/drivers/pci/host/pci-dra7xx.c
> @@ -155,7 +155,6 @@ static int dra7xx_pcie_intx_map(struct irq_domain=
 *domain, unsigned int irq,
>  {
>  	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
>  	irq_set_chip_data(irq, domain->host_data);
> -	set_irq_flags(irq, IRQF_VALID);
>=20
>  	return 0;
>  }
> diff --git a/drivers/pci/host/pci-keystone-dw.c b/drivers/pci/host/pc=
i-keystone-dw.c
> index f34892e..f1d0749 100644
> --- a/drivers/pci/host/pci-keystone-dw.c
> +++ b/drivers/pci/host/pci-keystone-dw.c
> @@ -196,7 +196,6 @@ static int ks_dw_pcie_msi_map(struct irq_domain *=
domain, unsigned int irq,
>  	irq_set_chip_and_handler(irq, &ks_dw_pcie_msi_irq_chip,
>  				 handle_level_irq);
>  	irq_set_chip_data(irq, domain->host_data);
> -	set_irq_flags(irq, IRQF_VALID);
>=20
>  	return 0;
>  }
> @@ -277,7 +276,6 @@ static int ks_dw_pcie_init_legacy_irq_map(struct =
irq_domain *d,
>  	irq_set_chip_and_handler(irq, &ks_dw_pcie_legacy_irq_chip,
>  				 handle_level_irq);
>  	irq_set_chip_data(irq, d->host_data);
> -	set_irq_flags(irq, IRQF_VALID);
>=20
>  	return 0;
>  }
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegr=
a.c
> index 10c0571..81df0c1 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -1248,7 +1248,6 @@ static int tegra_msi_map(struct irq_domain *dom=
ain, unsigned int irq,
>  {
>  	irq_set_chip_and_handler(irq, &tegra_msi_irq_chip, handle_simple_ir=
q);
>  	irq_set_chip_data(irq, domain->host_data);
> -	set_irq_flags(irq, IRQF_VALID);
>=20
>  	tegra_cpuidle_pcie_irqs_in_use();
>=20
> diff --git a/drivers/pci/host/pci-xgene-msi.c b/drivers/pci/host/pci-=
xgene-msi.c
> index 2d31d4d..8e559d1 100644
> --- a/drivers/pci/host/pci-xgene-msi.c
> +++ b/drivers/pci/host/pci-xgene-msi.c
> @@ -223,7 +223,6 @@ static int xgene_irq_domain_alloc(struct irq_doma=
in *domain, unsigned int virq,
>  	irq_domain_set_info(domain, virq, msi_irq,
>  			    &xgene_msi_bottom_irq_chip, domain->host_data,
>  			    handle_simple_irq, NULL, NULL);
> -	set_irq_flags(virq, IRQF_VALID);
>=20
>  	return 0;
>  }
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pc=
ie-designware.c
> index 69486be..5c6b562 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -350,7 +350,6 @@ static int dw_pcie_msi_map(struct irq_domain *dom=
ain, unsigned int irq,
>  {
>  	irq_set_chip_and_handler(irq, &dw_msi_irq_chip, handle_simple_irq);
>  	irq_set_chip_data(irq, domain->host_data);
> -	set_irq_flags(irq, IRQF_VALID);
>=20
>  	return 0;
>  }
> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rca=
r.c
> index c086210..7678fe0 100644
> --- a/drivers/pci/host/pcie-rcar.c
> +++ b/drivers/pci/host/pcie-rcar.c
> @@ -664,7 +664,6 @@ static int rcar_msi_map(struct irq_domain *domain=
, unsigned int irq,
>  {
>  	irq_set_chip_and_handler(irq, &rcar_msi_irq_chip, handle_simple_irq=
);
>  	irq_set_chip_data(irq, domain->host_data);
> -	set_irq_flags(irq, IRQF_VALID);
>=20
>  	return 0;
>  }
> diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-x=
ilinx.c
> index f1a06a0..72015119 100644
> --- a/drivers/pci/host/pcie-xilinx.c
> +++ b/drivers/pci/host/pcie-xilinx.c
> @@ -338,7 +338,6 @@ static int xilinx_pcie_msi_map(struct irq_domain =
*domain, unsigned int irq,
>  {
>  	irq_set_chip_and_handler(irq, &xilinx_msi_irq_chip, handle_simple_i=
rq);
>  	irq_set_chip_data(irq, domain->host_data);
> -	set_irq_flags(irq, IRQF_VALID);
>=20
>  	return 0;
>  }
> @@ -377,7 +376,6 @@ static int xilinx_pcie_intx_map(struct irq_domain=
 *domain, unsigned int irq,
>  {
>  	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
>  	irq_set_chip_data(irq, domain->host_data);
> -	set_irq_flags(irq, IRQF_VALID);
>=20
>  	return 0;
>  }
> --
> 2.1.0
>=20

From: "Jingoo Han" <jingoohan1@gmail.com>
Subject: Re: [PATCH v2 09/13] PCI: kill off set_irq_flags usage
Date: Sun, 12 Jul 2015 23:34:10 +0900
Message-ID: <000001d0bcaf$d6ab17a0$840146e0$@com>
References: <1436711211-18223-1-git-send-email-robh@kernel.org> <1436711211-18223-10-git-send-email-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1436711211-18223-10-git-send-email-robh@kernel.org>
Content-Language: ko
Sender: linux-sh-owner@vger.kernel.org
To: 'Rob Herring' <robh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 'Russell King' <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, arm@kernel.org, 'Kishon Vijay Abraham I' <kishon@ti.com>, 'Murali Karicheri' <m-karicheri2@ti.com>, 'Thierry Reding' <thierry.reding@gmail.com>, 'Stephen Warren' <swarren@wwwdotorg.org>, 'Alexandre Courbot' <gnurou@gmail.com>, 'Pratyush Anand' <pratyush.anand@gmail.com>, 'Simon Horman' <horms@verge.net.au>, 'Michal Simek' <michal.simek@xilinx.com>, =?UTF-8?Q?'S=C3=B6ren_Brinkmann'?= <soren.brinkmann@xilinx.com>, linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org, linux-sh@vger.kernel.org, 'Jingoo Han' <jingoohan1@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Sunday, July 12, 2015 11:27 PM, Rob Herring wrote:
>=20
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
> users also set IRQ_NOPROBE and this has been maintained although it i=
s not
> clear that is really needed. There appears to be a great deal of blin=
d
> copy and paste of this code.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Murali Karicheri <m-karicheri2@ti.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: Jingoo Han <jingoohan1@gmail.com>

=46or pcie-designware.c,

Acked-by: Jingoo Han <jingoohan1@gmail.com>

I checked that "the irqdomain core code handles clearing and setting
IRQ_NOREQUEST already", as you said. Thank you.

Best regards,
Jingoo Han

> Cc: Pratyush Anand <pratyush.anand@gmail.com>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: "S=C3=B6ren Brinkmann" <soren.brinkmann@xilinx.com>
> Cc: linux-omap@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-tegra@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> ---
> v2:
> - Add xgene which was added in v4.2
>=20
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



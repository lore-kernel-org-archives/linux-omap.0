From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH] PCI: dra7xx: Fix return value in case of error
Date: Mon, 25 Jul 2016 12:30:47 -0500
Message-ID: <20160725173047.GC12484@localhost>
References: <1468531107-3639-1-git-send-email-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1468531107-3639-1-git-send-email-christophe.jaillet@wanadoo.fr>
Sender: kernel-janitors-owner@vger.kernel.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: kishon@ti.com, bhelgaas@google.com, linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Jul 14, 2016 at 11:18:27PM +0200, Christophe JAILLET wrote:
> In function 'dra7xx_pcie_init_irq_domain', the pattern used to check =
and
> return error is:
>=20
>    if (!var) {
>       dev_err(...);
>       return PTR_ERR(var);
>    }
>=20
> So the returned value in case of error is always 0, which means 'succ=
ess'.
> Change it to return -ENODEV instead.
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied with Kishon's reviewed-by to pci/host-dra7xx for v4.8, thanks!

> ---
>  drivers/pci/host/pci-dra7xx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra=
7xx.c
> index f441130..81b3949 100644
> --- a/drivers/pci/host/pci-dra7xx.c
> +++ b/drivers/pci/host/pci-dra7xx.c
> @@ -181,14 +181,14 @@ static int dra7xx_pcie_init_irq_domain(struct p=
cie_port *pp)
> =20
>  	if (!pcie_intc_node) {
>  		dev_err(dev, "No PCIe Intc node found\n");
> -		return PTR_ERR(pcie_intc_node);
> +		return -ENODEV;
>  	}
> =20
>  	pp->irq_domain =3D irq_domain_add_linear(pcie_intc_node, 4,
>  					       &intx_domain_ops, pp);
>  	if (!pp->irq_domain) {
>  		dev_err(dev, "Failed to get a INTx IRQ domain\n");
> -		return PTR_ERR(pp->irq_domain);
> +		return -ENODEV;
>  	}
> =20
>  	return 0;
> --=20
> 2.7.4
>=20
>=20
> ---
> L'absence de virus dans ce courrier =E9lectronique a =E9t=E9 v=E9rifi=
=E9e par le logiciel antivirus Avast.
> https://www.avast.com/antivirus
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe kernel-janito=
rs" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

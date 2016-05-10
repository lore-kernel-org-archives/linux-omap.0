From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v7 5/5] usb: dwc3: core: cleanup IRQ resources
Date: Tue, 10 May 2016 13:03:24 +0300
Message-ID: <877ff2i61f.fsf@linux.intel.com>
References: <1462873919-20532-1-git-send-email-rogerq@ti.com> <1462873919-20532-6-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462873919-20532-6-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, nsekhar@ti.com, b-liu@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq@ti.com> writes:
> Implementations might use different IRQs for
> host, gadget and OTG so use named interrupt resources
> to allow Device tree to specify the 3 interrupts.
>
> Following are the interrupt names
>
> Peripheral Interrupt - peripheral
> HOST Interrupt - host
> OTG Interrupt - otg
>
> We still maintain backward compatibility for a single named
> interrupt for all 3 interrupts (e.g. for dwc3-pci) and
> single unnamed interrupt for all 3 interrupts (e.g. old DT).

cool :-)

> @@ -748,6 +750,20 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
>  		}
>  		break;
>  	case USB_DR_MODE_OTG:
> +		dwc->otg_irq =3D platform_get_irq_byname(dwc3_pdev, "otg");
> +		if (dwc->otg_irq <=3D 0) {
> +			dwc->otg_irq =3D platform_get_irq_byname(dwc3_pdev,
> +							       "dwc_usb3");
> +			if (dwc->otg_irq <=3D 0) {
> +				res =3D platform_get_resource(dwc3_pdev,
> +							    IORESOURCE_IRQ, 0);
> +				if (!res) {
> +					dev_err(dwc->dev, "missing otg IRQ\n");
> +					return -ENODEV;
> +				}
> +				dwc->otg_irq =3D res->start;
> +			}
> +		}

I suppose this part can be removed and added only when OTG is
supported. Then dwc3_otg_init() (or whatever) can do this.

> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index 186a886..2e20892 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -716,6 +716,8 @@ struct dwc3_scratchpad_array {
>   * @maximum_speed: maximum speed requested (mainly for testing purposes)
>   * @revision: revision register contents
>   * @dr_mode: requested mode of operation
> + * @gadget_irq: IRQ number for Peripheral IRQs
> + * @otg_irq: IRQ number for OTG IRQs
>   * @usb2_phy: pointer to USB2 PHY
>   * @usb3_phy: pointer to USB3 PHY
>   * @usb2_generic_phy: pointer to USB2 PHY
> @@ -817,6 +819,9 @@ struct dwc3 {
>=20=20
>  	enum usb_dr_mode	dr_mode;
>=20=20
> +	int			gadget_irq;
> +	int			otg_irq;

while at that, let's add host_irq too and do proper changes to dwc3/host.c

> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index c3b0d01..8db8d13 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -1605,7 +1605,7 @@ static int dwc3_gadget_start(struct usb_gadget *g,
>  	int			irq;
>  	u32			reg;
>=20=20
> -	irq =3D platform_get_irq(to_platform_device(dwc->dev), 0);
> +	irq =3D dwc->gadget_irq;
>  	ret =3D request_threaded_irq(irq, dwc3_interrupt, dwc3_thread_interrupt,
>  			IRQF_SHARED, "dwc3", dwc->ev_buf);
>  	if (ret) {
> @@ -2781,6 +2781,23 @@ static irqreturn_t dwc3_interrupt(int irq, void *_=
evt)
>  int dwc3_gadget_init(struct dwc3 *dwc)
>  {
>  	int					ret;
> +	struct resource *res;
> +	struct platform_device *dwc3_pdev =3D to_platform_device(dwc->dev);
> +
> +	dwc->gadget_irq =3D platform_get_irq_byname(dwc3_pdev, "peripheral");
> +	if (dwc->gadget_irq <=3D 0) {
> +		dwc->gadget_irq =3D platform_get_irq_byname(dwc3_pdev,
> +							  "dwc_usb3");
> +		if (dwc->gadget_irq <=3D 0) {
> +			res =3D platform_get_resource(dwc3_pdev, IORESOURCE_IRQ,
> +						    0);
> +			if (!res) {
> +				dev_err(dwc->dev, "missing peripheral IRQ\n");
> +				return -ENODEV;
> +			}
> +			dwc->gadget_irq =3D res->start;
> +		}
> +	}
>=20=20
>  	dwc->ctrl_req =3D dma_alloc_coherent(dwc->dev, sizeof(*dwc->ctrl_req),
>  			&dwc->ctrl_req_addr, GFP_KERNEL);

you're regressing dwc3_gadget_stop().

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXMbHsAAoJEIaOsuA1yqREIs0P/RnyqV6j55EB+cg+4F+iJEAE
k8/lGzGVbG4a5uHBz3WAKS6+ipnoYHVlsCSAfRcTEtiwbmHFuTzcBT6y6A0P98d2
bYFiKv1ty0qTy9MoJFaY/gUhY2LrRLeqmwfIS3uxmJEfkSWpFnUEJ7os+pr/daYO
oIIkUlhjml6P6LbVWFGlhK09+AyO02ttN5O+WBxj0x+nRBlw0M9HjwuRuKfuBsCb
4K5o7B1hVEtxQdeMftAA1ro1Hacyusf/4n3/H7hvZCDeEM+76fB9t4QTS72UbETA
HRPJZKaFlTVntHW+5p+/S+ARlBB3NDZhDZytAAb0OiaB5LYiCGEnohB0qwLt/9Af
6sMs7MdzFjatpeYoIUw+zRKWW4ZW4waBp4syCrxZoI3t72nOWnn11iRsIsqvjnja
D9KOS5uFNgUAnQNRKaO94XUftyuoAJCeDWorYnJQkhV5fo1STeR9qaA9sCabvM2L
eVRAVVL8fMYiZzzkv8htqRK9EfNWo/IaICtLz1QHfnpnL5+IC/tzuYciHinCv+9K
R1D8DIUy51xg1rRtwfcnciSpAOAcFHI43V1qfLqfzTid98pg+CoGrlc31hb1DMIh
QyNM/1JpVhZpGFameduJXDEsofuuKV/FZC47cSNpSQ3z/uutuJzmoYOD3HlRn9HT
r7mACukXW/26U4JYzndv
=Omgj
-----END PGP SIGNATURE-----
--=-=-=--

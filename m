From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v9 5/5] usb: dwc3: core: cleanup IRQ resources
Date: Fri, 10 Jun 2016 12:18:37 +0300
Message-ID: <87bn39766q.fsf@linux.intel.com>
References: <1462977406-22806-1-git-send-email-rogerq@ti.com> <1462977406-22806-6-git-send-email-rogerq@ti.com> <574E92E8.5080201@ti.com> <57501E0D.4010007@ti.com> <575A7407.1090403@ti.com> <575A748A.4060009@ti.com> <87k2hx78yv.fsf@linux.intel.com> <575A7B0C.40103@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <575A7B0C.40103@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, yoshihiro.shimoda.uh@renesas.com, nsekhar@ti.com, b-liu@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq@ti.com> writes:
> On 10/06/16 11:18, Felipe Balbi wrote:
>>=20
>> Hi,
>>=20
>> Roger Quadros <rogerq@ti.com> writes:
>>>> 	dwc->xhci_resource[1] =3D *res;
>>>
>>> Probably not as we don't want to change parent/child members.
>>=20
>> oh, you had already replied. Sorry. This is correct
>>=20
> np :).
>
> So what i'll do is get the irq via platform_get_irq() and friends
> and if it was a success use platform_get_resource() and friends
> to get struct resource and just edit the relevant parts for the
> XHCI irq resource.
>
> Sounds OK?
>
> something like this.
>
> +	int			ret, irq;
> +	struct resource		*res;
> +	struct platform_device	*dwc3_pdev =3D to_platform_device(dwc->dev);
> +
> +	irq =3D platform_get_irq_byname(dwc3_pdev, "host");
> +	if (irq =3D=3D -EPROBE_DEFER)
> +		return irq;
> +
> +	if (irq <=3D 0) {
> +		irq =3D platform_get_irq_byname(dwc3_pdev, "dwc_usb3");
> +		if (irq =3D=3D -EPROBE_DEFER)
> +			return irq;
> +
> +		if (irq <=3D 0) {
> +			irq =3D platform_get_irq(dwc3_pdev, 0);
> +			if (irq <=3D 0) {
> +				if (irq !=3D -EPROBE_DEFER) {
> +					dev_err(dwc->dev,
> +						"missing host IRQ\n");
> +				}
> +				return irq;
> +			} else {
> +				res =3D platform_get_resource(dwc3_pdev,
> +							    IORESOURCE_IRQ, 0);
> +			}
> +		} else {
> +			res =3D platform_get_resource_byname(dwc3_pdev,
> +							   IORESOURCE_IRQ,
> +							   "dwc_usb3");
> +		}
> +
> +	} else {
> +		res =3D platform_get_resource_byname(dwc3_pdev, IORESOURCE_IRQ,
> +						   "host");
> +	}
> +
> +	dwc->xhci_resources[1].start =3D irq;
> +	dwc->xhci_resources[1].end =3D irq;
> +	dwc->xhci_resources[1].flags =3D res->flags;
> +	dwc->xhci_resources[1].name =3D res->name;

looks okay to me.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXWoXtAAoJEIaOsuA1yqREUo4P/0f6Jlwy8RF876Nx2pVpAeGB
+cO8KEU6lO7LMXEQn2zNlrd0Rm7N6YCuTXalvv7ZSxW6HLFO+xWm/e819jtqnkJC
qdWrKMblb7IHSJsOr3y7LzAadwUTjzO/7bRwCjTZ/S5B2FTDa73pkpjvnooxpJgR
RQ2RaCmJ5JyXmMGQhBeruOF/PoDLwvSoHHAAtLRM0BMFVXuwQqjl7VdKhuenCzzc
fCfGyNWA4uKkWxQ+rrQesgAjUzOzaVIuOQS6No7HudjDnuDxa76/ZOA6ErRUUM1T
8cxjJmdSoskujF1dgCPMWzusBu858zmsgHeOXZw8dqhj36KNQm1Xd8NoeJTsxJ3m
xvchmAGqSOeDPnydny8Vs5GWsCuUyLmr2khCxZq3d1LKH8RB29AdiABoQfUGW3uY
mQzKt+5vb5ItoqEPxp1lfS6CZJZHKQCzzPS2/XvavOBvgaY0VyVUyKG/oqG6KLdf
vRGwysmeq18dTDQy/l+12jjAUYGWZoYvctiQ+mAYzfYkT+xQPtlRD5BETfuAf/Nm
uFflWMaktQaBO+9jowwf4UvUj3Kd4kOodd253Q720pfanWORkpsG0Xj4fFv9J634
JR8ZM35OztciOmrlbVf0CrEUaJulF253OR/WxV0IgpJzWuaPAH6Ncp0kP/0DCJR4
GimSZvnDCCu2Qu1qsDLl
=s0T8
-----END PGP SIGNATURE-----
--=-=-=--

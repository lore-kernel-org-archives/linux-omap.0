From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/3] drivers: usb: dwc3: Add adjust_frame_length_quirk
Date: Thu, 23 Jul 2015 09:55:32 -0500
Message-ID: <20150723145532.GC21984@saruman.tx.rr.com>
References: <1437646295-1858-1-git-send-email-nikhil.badola@freescale.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LwW0XdcUbUexiWVK"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1437646295-1858-1-git-send-email-nikhil.badola@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nikhil Badola <nikhil.badola@freescale.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com, gregkh@linuxfoundation.org
List-Id: linux-omap@vger.kernel.org

--LwW0XdcUbUexiWVK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 23, 2015 at 03:41:35PM +0530, Nikhil Badola wrote:
> Add adjust_frame_length_quirk for writing to fladj register
> which adjusts (micro)frame length to value provided by
> "snps,configure-fladj" property thus avoiding USB 2.0 devices
> to time-out over a longer run
>=20
> Signed-off-by: Nikhil Badola <nikhil.badola@freescale.com>

just like the other patch, I won't take this without a glue layer making
use of it.

> ---
>  drivers/usb/dwc3/core.c | 12 ++++++++++++
>  drivers/usb/dwc3/core.h |  7 +++++++
>  2 files changed, 19 insertions(+)
>=20
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 5c110d8..72ba025 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -779,6 +779,7 @@ static int dwc3_probe(struct platform_device *pdev)
>  	u8			lpm_nyet_threshold;
>  	u8			tx_de_emphasis;
>  	u8			hird_threshold;
> +	u32			fladj_value;
> =20
>  	int			ret;
> =20
> @@ -886,6 +887,12 @@ static int dwc3_probe(struct platform_device *pdev)
>  				&tx_de_emphasis);
>  		of_property_read_string(node, "snps,hsphy_interface",
>  					&dwc->hsphy_interface);
> +		ret =3D of_property_read_u32(node, "snps,configure-fladj",

This is not the correct name for the property, it should be something
like 'snps,quirk-frame-length-adjustment'. Quirk because this is only
needed when the 30MHz sideband signal is invalid for some reason.

This is also something that's only needed for host side operation, so
consider what would you do if you weren't using dwc3, if all you had was
XHCI.

I hope freescale will fix this silicon bug.

One extra thing: everything that can be done via DT, should be available
for pdata users as well.

> +					   &fladj_value);
> +		if (!ret)
> +			dwc->adjust_frame_length_quirk =3D 1;
> +		else
> +			dwc->adjust_frame_length_quirk =3D 0;

this flag is unnecessary. Just initialize fladj_value to 0 and check for
that:

>  	} else if (pdata) {
>  		dwc->maximum_speed =3D pdata->maximum_speed;
>  		dwc->has_lpm_erratum =3D pdata->has_lpm_erratum;
> @@ -957,6 +964,11 @@ static int dwc3_probe(struct platform_device *pdev)
>  		goto err1;
>  	}
> =20
> +	/* Adjust Frame Length */
> +	if (dwc->adjust_frame_length_quirk)

	if (fladj) {
		u32 reg;
		u32 dft;

		reg =3D dwc3_readl(dwc->regs, DWC3_GFLADJ);
		dft =3D reg & 0x3f; /* needs a mask macro */

		if (!dev_WARN_ONCE(dwc->dev, dft =3D=3D fladj,
			"request value same as default, ignoring\n")) {
			reg &=3D ~0x3f; /* needs a mask macro */
			reg |=3D DWC3_GFLADJ_30MHZ_SDBND_SEL |
				DWC3_GFLADJ_30MHZ(fladj_value);

			dwc3_writel(dwc->regs, DWC3_GFLADJ, reg);
		}
	}

> +		dwc3_writel(dwc->regs, DWC3_GFLADJ, GFLADJ_30MHZ_REG_SEL |
> +			    GFLADJ_30MHZ(fladj_value));
> +
>  	if (IS_ENABLED(CONFIG_USB_DWC3_HOST))
>  		dwc->dr_mode =3D USB_DR_MODE_HOST;
>  	else if (IS_ENABLED(CONFIG_USB_DWC3_GADGET))
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index 0447788..b7a5119 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -124,6 +124,7 @@
>  #define DWC3_GEVNTCOUNT(n)	(0xc40c + (n * 0x10))
> =20
>  #define DWC3_GHWPARAMS8		0xc600
> +#define DWC3_GFLADJ		0xc630
> =20
>  /* Device Registers */
>  #define DWC3_DCFG		0xc700
> @@ -234,6 +235,10 @@
>  /* Global HWPARAMS6 Register */
>  #define DWC3_GHWPARAMS6_EN_FPGA			(1 << 7)
> =20
> +/* Global Frame Length Adjustment Register */
> +#define GFLADJ_30MHZ_REG_SEL		(1 << 7)

always prepend with DWC3_ like *all* other macros in this file.

Also, match docs to ease grepping. This should be called
DWC3_GFLADJ_30MHZ_SDBND_SEL

> +#define GFLADJ_30MHZ(n)			((n) & 0x3f)

> +
>  /* Device Configuration Register */
>  #define DWC3_DCFG_DEVADDR(addr)	((addr) << 3)
>  #define DWC3_DCFG_DEVADDR_MASK	DWC3_DCFG_DEVADDR(0x7f)
> @@ -712,6 +717,7 @@ struct dwc3_scratchpad_array {
>   * @rx_detect_poll_quirk: set if we enable rx_detect to polling lfps qui=
rk
>   * @dis_u3_susphy_quirk: set if we disable usb3 suspend phy
>   * @dis_u2_susphy_quirk: set if we disable usb2 suspend phy
> + * @adjust_frame_length_quirk: enables post-silicon frame length adjustm=
ent
>   * @tx_de_emphasis_quirk: set if we enable Tx de-emphasis quirk
>   * @tx_de_emphasis: Tx de-emphasis value
>   * 	0	- -6dB de-emphasis
> @@ -841,6 +847,7 @@ struct dwc3 {
>  	unsigned		rx_detect_poll_quirk:1;
>  	unsigned		dis_u3_susphy_quirk:1;
>  	unsigned		dis_u2_susphy_quirk:1;
> +	unsigned		adjust_frame_length_quirk:1;

unnecessary flag

--=20
balbi

--LwW0XdcUbUexiWVK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVsQBkAAoJEIaOsuA1yqREyd0P+wa0TdV4terQWUnJ00g1/UQh
jdNG3sC2FWqJ6aUnCtHeJDXWu4TEEw/PtxBvrq6XXgi+aqr79Co2ZZA6dnU0JZ/W
83Xsj/pXosG5uf+cdjjI4lfcj+8j8jxPp3CB/unK0cFmGin+c9FTbi0EgSOQyrG/
WM9/6QFG/ds9Ov2rrjjRxBDygBh3KtMUy4c67j5CEyZRIXxLoOoT2PYqcphM8EUl
ONsd0PTAnm6uA9Q+lf6p2PKU55AOlkmwRk+qRJwXKge4wlq4lkGrrnwD3+PIuV58
9UxA08nEV1hdBWNAHlLea2E9zGz5r0lw4wXJ/GT9gt8bhd2bsLr7VA4GG7qVlwfc
uuAvAqVGTm8E8eSt9q7ifiGkfcNm76SmlN3KN5l1HU/WyeibinqBmliFkmba/hhk
GTSAfg1yvpwHI7/6hYnQaDp2eJadXseAgH0a1irNhxHDhYZ3+/c+eg0D8qVNTb5u
iHfvD9XR3pt87zkQfMnc6i7HhGffx6+hLmw9fFis8FD8uqzAdyEBOLiQjKCqjRrs
Wesq7lDPcxLjL4z/mIfBPsmD17riQhlNS0b60aJDgePvq2yKQ2vWb0TBPx83vfwM
ORsjV03hCRn9PzgnyC697O76k6ZoSPdTELC+D1ClaBLjsgy8rDOjOw2llBMl814H
/ScZFBcXNU05ocRK0lL4
=in9l
-----END PGP SIGNATURE-----

--LwW0XdcUbUexiWVK--

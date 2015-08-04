From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] usb: musb: omap2430: use *syscon* framework API to write
 to mailbox register
Date: Tue, 4 Aug 2015 10:58:03 -0500
Message-ID: <20150804155803.GF23659@saruman.tx.rr.com>
References: <1438697169-32359-1-git-send-email-kishon@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RE3pQJLXZi4fr8Xo"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1438697169-32359-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: balbi@ti.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, nsekhar@ti.com, gregkh@linuxfoundation.org
List-Id: linux-omap@vger.kernel.org

--RE3pQJLXZi4fr8Xo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 04, 2015 at 07:36:09PM +0530, Kishon Vijay Abraham I wrote:
> Deprecate using phy-omap-control driver to write to the mailbox register
> and start using *syscon* framework to do the same.
>=20
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  Documentation/devicetree/bindings/usb/omap-usb.txt |    7 +-
>  drivers/usb/musb/omap2430.c                        |  115 ++++++++++++++=
++----
>  2 files changed, 99 insertions(+), 23 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/omap-usb.txt b/Documen=
tation/devicetree/bindings/usb/omap-usb.txt
> index 38d9bb8..c001306 100644
> --- a/Documentation/devicetree/bindings/usb/omap-usb.txt
> +++ b/Documentation/devicetree/bindings/usb/omap-usb.txt
> @@ -20,10 +20,15 @@ OMAP MUSB GLUE
>   - phy-names : the names of the PHY corresponding to the PHYs present in=
 the
>     *phy* phandle.
> =20
> -Optional properties:
> +Optional Properties:
> +Deprecated properties:
>   - ctrl-module : phandle of the control module this glue uses to write to
>     mailbox
> =20
> +Recommended properies:
> + - syscon-otghs : phandle/offset pair. Phandle to the system control mod=
ule and the
> +   register offset of the mailbox.
> +
>  SOC specific device node entry
>  usb_otg_hs: usb_otg_hs@4a0ab000 {
>  	compatible =3D "ti,omap4-musb";
> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> index 70f2b8a..a03cf1e 100644
> --- a/drivers/usb/musb/omap2430.c
> +++ b/drivers/usb/musb/omap2430.c
> @@ -39,16 +39,27 @@
>  #include <linux/usb/musb-omap.h>
>  #include <linux/phy/omap_control_phy.h>
>  #include <linux/of_platform.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/syscon.h>
> =20
>  #include "musb_core.h"
>  #include "omap2430.h"
> =20
> +#define OMAP2430_MUSB_MODE_MASK	0x1f
> +#define OMAP2430_MUSB_AVALID	BIT(0)
> +#define OMAP2430_MUSB_BVALID	BIT(1)
> +#define OMAP2430_MUSB_VBUSVALID	BIT(2)
> +#define OMAP2430_MUSB_SESSEND	BIT(3)
> +#define OMAP2430_MUSB_IDDIG	BIT(4)
> +
>  struct omap2430_glue {
>  	struct device		*dev;
>  	struct platform_device	*musb;
>  	enum omap_musb_vbus_id_status status;
>  	struct work_struct	omap_musb_mailbox_work;
>  	struct device		*control_otghs;
> +	struct regmap		*syscon_otghs; /* ctrl. reg. acces */
> +	unsigned int            otghs_reg; /* otghs reg. index within syscon */
>  };
>  #define glue_to_musb(g)		platform_get_drvdata(g->musb)
> =20
> @@ -253,6 +264,44 @@ void omap_musb_mailbox(enum omap_musb_vbus_id_status=
 status)
>  }
>  EXPORT_SYMBOL_GPL(omap_musb_mailbox);
> =20
> +static void omap2430_musb_set_usbmode(struct omap2430_glue *glue,
> +				      enum omap_control_usb_mode mode)
> +{
> +	u32 val;
> +	int ret;
> +

	if (!glue->syscon_otghs) {
		omap_control_usb_set_mode(glue->control_otghs, mode);
		return;
	}

	switch (mode) {
	case USB_MODE_HOST:
		val =3D OMAP2430_MUSB_AVALID | OMAP2430_MUSB_VBUSVALID;
		break;
	case USB_MODE_DEVICE:
		val =3D OMAP2430_MUSB_IDDIG | OMAP2430_MUSB_AVALID |
			OMAP2430_MUSB_VBUSVALID;
		break;
	case USB_MODE_DISCONNECT:
		val =3D OMAP2430_MUSB_IDDIG | OMAP2430_MUSB_SESSEND;
		break;
	default:
		dev_dbg(glue->dev, "Invalid mode\n");
		dev_err(glue->dev, "Failed to set mode to %d\n", mode);
	}

	ret =3D regmap_update_bits(glue->syscon_otghs,
				 glue->otghs_reg,
				 OMAP2430_MUSB_MODE_MASK, val);
	if (ret < 0)
		dev_err(glue->dev, "Failed to update regmap\n");

other than that, looks fine.

--=20
balbi

--RE3pQJLXZi4fr8Xo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVwOELAAoJEIaOsuA1yqREBWYQAIsVZVIr5V6hXT+jLXnxsP5t
MntExVVGel7LlxLP2h3gVN1oX0HWsA6PC6VEjfHrQysxT8gQ6Q2YavxTSv5PQBoX
tAd3dplJ6GUjEEtyCTRuqtDFmuVLfKHU/CJUpmPWUuwh8OqqSURzRLNAKASSXfm6
ljMUnmKCOi8DBEJCuReg3QmjKtKCbT29eaXISFEIs35nZfPTQM0hAo8hCxRwZ1/j
neFqYwfbCLt5PhfqTV89Kz+ssv+BZKkchVnpfnP//VmHadfsicl0FmMp5jqSICPV
Ay/2sR+uD8cjBNj9pnPjnyde10uWPe2ulRdGnoL9TERZNdNjDCtqs/OlEL+UFlVH
ptGJYqBq4xdFYpWgm7kcncVP02SFDr7bi0GVnp2gBPZOYbF0XiT36riRm/l2q0x4
068qq1kAr92q5xMbfp4aFTj+6kn/5zNKTWCrvmaP2ETcU9tzQDTbBhCaLD9rAbdc
FDxQ/okBiFjePSmhtYw9oCo1i3slr16Mr7pkvc67g7pdjXhr5tvds7LB6wV2qJnX
2CLSg5AWcGaaYuhA0dd3KhN24wbOCc5gjEcAsR4qdsKPDzedo9M+mJrv7HNQiPcj
HwsVrFeQBWZvNlrI2CBfd06pUZXobUpIAln5jBjB32eA41g/3jh8DfPzdpQ5GE0j
AyTcI8rKNxADZd2HPg+Y
=SPyv
-----END PGP SIGNATURE-----

--RE3pQJLXZi4fr8Xo--

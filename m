From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 3/5] usb: dwc3: Add quirk for Synopsis device
 disconnection errata
Date: Mon, 19 Jan 2015 08:50:50 -0600
Message-ID: <20150119145050.GF20386@saruman>
References: <1421654209-6486-1-git-send-email-Sneeker.Yeh@tw.fujitsu.com>
 <1421654209-6486-4-git-send-email-Sneeker.Yeh@tw.fujitsu.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ExXT7PjY8AI4Hyfa"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1421654209-6486-4-git-send-email-Sneeker.Yeh-l16TxrwUIHTQFUHtdCDX3A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sneeker Yeh <sneeker.yeh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Mathias Nyman <mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sneeker Yeh <Sneeker.Yeh-l16TxrwUIHTQFUHtdCDX3A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--ExXT7PjY8AI4Hyfa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 19, 2015 at 03:56:47PM +0800, Sneeker Yeh wrote:
> Synopsis Designware USB3 IP earlier than v3.00a which is configured in si=
licon
> with DWC_USB3_SUSPEND_ON_DISCONNECT_EN=3D1, would need a specific quirk t=
o prevent
> xhci host controller from dying when device is disconnected.
>=20
> Since DWC_USB3_SUSPEND_ON_DISCONNECT_EN is an IP configuration whose state
> cannot be checked from software in runtime, it has to be enabled via plat=
form
> data or device tree.
>=20
> Signed-off-by: Sneeker Yeh <Sneeker.Yeh-l16TxrwUIHTQFUHtdCDX3A@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/usb/dwc3.txt |   17 +++++++++++++++++
>  drivers/usb/dwc3/core.c                        |    6 ++++++
>  drivers/usb/dwc3/core.h                        |    1 +
>  drivers/usb/dwc3/host.c                        |    4 ++++
>  drivers/usb/dwc3/platform_data.h               |    1 +
>  5 files changed, 29 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentati=
on/devicetree/bindings/usb/dwc3.txt
> index cd7f045..1b78b29 100644
> --- a/Documentation/devicetree/bindings/usb/dwc3.txt
> +++ b/Documentation/devicetree/bindings/usb/dwc3.txt
> @@ -37,6 +37,23 @@ Optional properties:
>   - snps,is-utmi-l1-suspend: true when DWC3 asserts output signal
>  			utmi_l1_suspend_n, false when asserts utmi_sleep_n
>   - snps,hird-threshold: HIRD threshold
> + - snps,has_suspend_on_disconnect: true when IP is configured in silicon=
 with
> +			DWC_USB3_SUSPEND_ON_DISCONNECT_EN=3D1, it can inject a
> +			specific quirk to prevent xhci host controller from
> +			dying when usb device is disconnected from root hub.
> +			Since DWC_USB3_SUSPEND_ON_DISCONNECT_EN is an IP
> +			configuration whose state cannot be checked from
> +			software in runtime, it has to be enabled via platform
> +			data or device tree.
> +
> +			xhci host dying symptom here is caused by that
> +			DWC_USB3_SUSPEND_ON_DISCONNECT_EN=3D1
> +			configuration makes IP auto-suspended after PORTCSC is
> +			cleared when usb device detached, then an asynchronous
> +			disconnection procedure might fail using endpoint
> +			command that suspened IP won't have any response to.
> +
> +			this issue is fixed when IP version >=3D 3.00a.
> =20
>  This is usually a subnode to DWC3 glue to which it is connected.
> =20
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 25ddc39..fbceab1 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -838,6 +838,9 @@ static int dwc3_probe(struct platform_device *pdev)
>  				"snps,tx_de_emphasis_quirk");
>  		of_property_read_u8(node, "snps,tx_de_emphasis",
>  				&tx_de_emphasis);
> +
> +		dwc->suspend_on_disconnect_quirk =3D of_property_read_bool(node,
> +				"snps,has_suspend_on_disconnect");
>  	} else if (pdata) {
>  		dwc->maximum_speed =3D pdata->maximum_speed;
>  		dwc->has_lpm_erratum =3D pdata->has_lpm_erratum;
> @@ -864,6 +867,9 @@ static int dwc3_probe(struct platform_device *pdev)
>  		dwc->tx_de_emphasis_quirk =3D pdata->tx_de_emphasis_quirk;
>  		if (pdata->tx_de_emphasis)
>  			tx_de_emphasis =3D pdata->tx_de_emphasis;
> +
> +		dwc->suspend_on_disconnect_quirk =3D
> +			pdata->has_suspend_on_disconnect;
>  	}
> =20
>  	/* default to superspeed if no maximum_speed passed */
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index 8090249..d7458ff 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -832,6 +832,7 @@ struct dwc3 {
> =20
>  	unsigned		tx_de_emphasis_quirk:1;
>  	unsigned		tx_de_emphasis:2;
> +	unsigned		suspend_on_disconnect_quirk:1;

you're missing the comment on the structure and these should be
alphabetically sorted.

> diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
> index 12bfd3c..9c42074 100644
> --- a/drivers/usb/dwc3/host.c
> +++ b/drivers/usb/dwc3/host.c
> @@ -53,6 +53,10 @@ int dwc3_host_init(struct dwc3 *dwc)
>  	pdata.usb3_lpm_capable =3D 1;
>  #endif
> =20
> +	if ((dwc->revision < DWC3_REVISION_300A) &&
> +	    dwc->suspend_on_disconnect_quirk)
> +		pdata.delay_portcsc_clear =3D 1;
> +
>  	ret =3D platform_device_add_data(xhci, &pdata, sizeof(pdata));
>  	if (ret) {
>  		dev_err(dwc->dev, "couldn't add platform data to xHCI device\n");
> diff --git a/drivers/usb/dwc3/platform_data.h b/drivers/usb/dwc3/platform=
_data.h
> index a3a3b6d..69562f1 100644
> --- a/drivers/usb/dwc3/platform_data.h
> +++ b/drivers/usb/dwc3/platform_data.h
> @@ -44,4 +44,5 @@ struct dwc3_platform_data {
> =20
>  	unsigned tx_de_emphasis_quirk:1;
>  	unsigned tx_de_emphasis:2;
> +	unsigned has_suspend_on_disconnect:1;

needs a comment at the top of this structure and should sorted.

--=20
balbi

--ExXT7PjY8AI4Hyfa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUvRnKAAoJEIaOsuA1yqRE7EMP/2rVOXq7C1HMSV02qivbAe3X
ubhDvpPTD6z0GfuSB0uNgkCvqCIsDkOpfdK/w8+14BstW9U70SstaonDurkaqz8J
cokQRDpd7I8MXsUgNL9MhzeM0nXeLsY/kWixqXwSHPnXrZS3YCiLvl/b47VVjpBb
a551AHngvWgfSZI60EJ5oc9eEW5+okNYFTp+ZN2KTI9gmeT5tK4yXyLaw36OVfBC
fIKWbCFw4pSLHchnk1cJEnG+GOEhNkE7Yq82wsjGJB4tHL8DqWBljzPOnATnigyr
rs8VEALsETFkYr46fySZlCOpsFlA6uxLDjxIptFAW6W8tWvCH0xWRBDoYoOerTOb
68oetn9y7DCucwoJy4nsr+QQKxDz/dWzIR8X4CHBPOFoCXuU+4fIi/+c8fxs/wej
uOW+OiDDwJqfDL8OM5uueO39TR6EBhfD15bdjnw1EKu+5mPZWuzSAzbSA1xkKg+8
THNM/ZYwALk9We7AnSi0SRJ5TMQsFXTJnmVMPb4oDF4N6P7SV9GM0cjopKybkBex
L0QARDE2CzQj+M2GYV9N1zMmDi2gU1zz1otsI7wll2ZYd9ZVmNuPrPA2enJLmuNg
/Vokg5t9W6clQC0IvDT5gkxzsIwfyDNRzlqxYpXcSq72iqfiRgUltVxqwYiC9FQi
dixJwdY4/7DPYjHbmI8S
=cvzo
-----END PGP SIGNATURE-----

--ExXT7PjY8AI4Hyfa--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

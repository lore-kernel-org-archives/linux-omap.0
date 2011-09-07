From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 6/6 v2] usb: musb: Add support for ti81xx platform
Date: Wed, 7 Sep 2011 22:14:26 +0300
Message-ID: <20110907191425.GB6506@legolas.emea.dhcp.ti.com>
References: <1315414945-19829-1-git-send-email-ajay.gupta@ti.com>
 <1315414945-19829-7-git-send-email-ajay.gupta@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dTy3Mrz/UPE2dbVg"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1315414945-19829-7-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Ravi Babu <ravibabu-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 07, 2011 at 10:32:25PM +0530, Ajay Kumar Gupta wrote:
> +static int __devinit dsps_probe(struct platform_device *pdev)
> +{
> +	const struct platform_device_id *id =3D platform_get_device_id(pdev);
> +	const struct dsps_musb_wrapper *wrp =3D
> +				(struct dsps_musb_wrapper *)id->driver_data;
> +	struct dsps_glue *glue;
> +	struct resource *iomem;
> +	int ret;
> +
> +	/* allocate glue */
> +	glue =3D kzalloc(sizeof(*glue), GFP_KERNEL);
> +	if (!glue) {
> +		dev_err(&pdev->dev, "unable to allocate glue memory\n");
> +		ret =3D -ENOMEM;
> +		goto err0;
> +	}
> +
> +	/* get memory resource */
> +	iomem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!iomem) {
> +		dev_err(&pdev->dev, "failed to get usbss mem resourse\n");
> +		ret =3D -ENODEV;
> +		goto err1;
> +	}
> +
> +	glue->dev =3D &pdev->dev;
> +	glue->wrp =3D wrp;

wrp is marked __devinitconst, so I guess you need to copy it here,
instead of just pointing to it.

--=20
balbi

--dTy3Mrz/UPE2dbVg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOZ8KRAAoJEAv8Txj19kN12cUH/ii6dFYmAqQxKEZOKquKi2jj
aqdqnVWRjWvf7SGLpAb8a6NINFraVFxMweQYVTuOHiEhjw47+PBxabiQea43W4dc
fEGWRmx4m71BVDtDjKS5OfGu6V2q1spWWb0Hcp+RmuTXBkDLQ8cFxoKxY/fnFHhZ
WIwd/uzP5PZLVKy5qUwqfsPrT1Z4p+540NXoVRya3ECCKEoMLbEOD7CffhNKZJcl
zk0k0jqhqOYQy2HNXGamQELYU39TPtROQjEvnNm3hbVLBp89nQ4QOCEvYAe7nQET
roohC22LQTXbz6iphjSK/P4pJ2bMuOT26DQ4qE6MKlPRhrIXdnfmjV5avD72Zmc=
=4uoe
-----END PGP SIGNATURE-----

--dTy3Mrz/UPE2dbVg--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

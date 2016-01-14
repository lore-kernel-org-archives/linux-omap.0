From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1 1/2] usb:dwc3: Enable support for 64-bit system
Date: Thu, 14 Jan 2016 09:47:51 -0600
Message-ID: <87h9ig9n88.fsf@ti.com>
References: <1452748125-31639-1-git-send-email-tqnguyen@apm.com> <1452748125-31639-2-git-send-email-tqnguyen@apm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1452748125-31639-2-git-send-email-tqnguyen-qTEPVZfXA3Y@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Thang Nguyen <tqnguyen-qTEPVZfXA3Y@public.gmane.org>, Phong Vo <pvo-qTEPVZfXA3Y@public.gmane.org>, Loc Ho <lho-qTEPVZfXA3Y@public.gmane.org>, patches-qTEPVZfXA3Y@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

"Thang Q. Nguyen" <tqnguyen-qTEPVZfXA3Y@public.gmane.org> writes:
> Add 64-bit DMA operation support to the USB DWC3 driver.
> First attempt to set the coherent DMA mask for 64-bit DMA.
> If that failed, attempt again with 32-bit DMA.
>
> Signed-off-by: Thang Q. Nguyen <tqnguyen-qTEPVZfXA3Y@public.gmane.org>
> ---
>  drivers/usb/dwc3/core.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 22b47973..9818d6b 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -829,6 +829,21 @@ static int dwc3_probe(struct platform_device *pdev)
>  	dwc->mem =3D mem;
>  	dwc->dev =3D dev;
>=20=20
> +	/* Try to set 64-bit DMA first */
> +	if (WARN_ON(!pdev->dev.dma_mask))

why the WARN_ON() ?

> +		/* Platform did not initialize dma_mask */
> +		ret =3D dma_coerce_mask_and_coherent(&pdev->dev,
> +						   DMA_BIT_MASK(64));
> +	else
> +		ret =3D dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> +
> +	/* If seting 64-bit DMA mask fails, fall back to 32-bit DMA mask */
> +	if (ret) {

this will try 32-bit if 32-bit fails too.

> +		ret =3D dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> +		if (ret)
> +			return ret;
> +	}
> +
>  	res =3D platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>  	if (!res) {
>  		dev_err(dev, "missing IRQ\n");
> --=20
> 2.2.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWl8MoAAoJEIaOsuA1yqREImIP/0pnScXar++8ZDvb8OrstJdj
ZuAjzFdHjV+Q8B1cigMSAbP3eutJ/JLl6XT3wy0tutQjT9hrXl+AM+kMC/dEESxJ
cozC5Vual86h/WM1P4vGz+9rgYQYc+Kz7GH3UWRoDr7m4sEwYFXLsjO3KEV/eOA3
o2xFR01NVRVn++nXrm7K9BopJ5sbblDo4s99sZYcMBWgpr5OXT5RkuqB+3vctzwI
JQ+bYxQHeBg/mjcsNEEb3Qnc3GkmzgykTWDlJdhGqk6AwnjdeFu98h4DvCscAifc
0Q8OHswbLGCkL9033MdWjzu7B/ep90S6E61qcqRQy0B4vxsFJ6oUJN1orTD42e70
lDgopjXiLbCxO8K5i1tXJ/OufzLbXs019y+wmDcDfbq5zwYtNf9Mz7g+b0qEUcdx
RmMFugNFpK2JtJZITDTDsE5miVCZ6gPTSQGTBFxakK9Yv8PffMH/UL96iQowC8gz
Jh+GemIshZYZp99YEl77gUh1jADyteaV8/gwGBzKaTQmCeqy8foepNeb2yYDS3xY
HJIugbW1koCK/UMR0qoxb5ltTpSdjhA//xr3WihByje3quAaUPlo5/fNYy7nSFwI
5BCWKUUzpoTzdn1m7+cG0m3SJwulIt23EdpUlCHtJK20SAAAQe9T+F3lL3/4Em+p
AkKmKj+waYhWCEWiL0/H
=i0fd
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

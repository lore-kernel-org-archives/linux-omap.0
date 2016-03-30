From: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v3 1/2] usb:dwc3: Enable support for 64-bit system
Date: Wed, 30 Mar 2016 16:09:21 +0300
Message-ID: <87pouci03i.fsf@intel.com>
References: <1457594332-7490-1-git-send-email-tqnguyen@apm.com> <1457594332-7490-2-git-send-email-tqnguyen@apm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1457594332-7490-2-git-send-email-tqnguyen-qTEPVZfXA3Y@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Thang Nguyen <tqnguyen-qTEPVZfXA3Y@public.gmane.org>, Phong Vo <pvo-qTEPVZfXA3Y@public.gmane.org>, Loc Ho <lho-qTEPVZfXA3Y@public.gmane.org>, patches-qTEPVZfXA3Y@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

"Thang Q. Nguyen" <tqnguyen-qTEPVZfXA3Y@public.gmane.org> writes:
> From: "Thang Q. Nguyen" <tqnguyen-qTEPVZfXA3Y@public.gmane.org>
>
> Add 64-bit DMA operation support to the USB DWC3 driver.
> First attempt to set the coherent DMA mask for 64-bit DMA.
> If that failed, attempt again with 32-bit DMA.
>
> Changes from v2:
> 	- None.
>
> Changes from v1:
> 	- Remove WARN_ON if dma_mask is NULL

these changes lines should be between the tearline (---) and diffstat
below.

> Signed-off-by: Thang Q. Nguyen <tqnguyen-qTEPVZfXA3Y@public.gmane.org>
> ---
>  drivers/usb/dwc3/core.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index de5e01f..2479c24 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -831,6 +831,21 @@ static int dwc3_probe(struct platform_device *pdev)
>  	dwc->mem =3D mem;
>  	dwc->dev =3D dev;
>=20=20
> +	/* Try to set 64-bit DMA first */
> +	if (!pdev->dev.dma_mask)
> +		/* Platform did not initialize dma_mask */
> +		ret =3D dma_coerce_mask_and_coherent(&pdev->dev,
> +						   DMA_BIT_MASK(64));
> +	else
> +		ret =3D dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> +
> +	/* If seting 64-bit DMA mask fails, fall back to 32-bit DMA mask */
> +	if (ret) {
> +		ret =3D dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> +		if (ret)
> +			return ret;
> +	}

Also, why is it so that you need this now ? glue layers are copying dma
mask from parent device and that should be set properly. This really
shouldn't be necessary in dwc3-core; it would mean that glue layer
didn't set this device up properly.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW+9ACAAoJEIaOsuA1yqRETvIP+wRDh8ftL8ZWD4QA+PtQ2+gA
YXf2eNoaQQ+oiB5jQXEhdeQPElwYtD+vsN24VEqVYDBxE/jUgg67svw7vz9CF4Ph
/LPoxf4cHBeVGuaX0+wlTm5ZQydWEIgszxqNtc9dix3Diu0CBSlZsPs40d1CIHHg
i4dJpnQudQlV+0ZA7FGeRAU80dRVuwK08SwTiCmDjY1rB1gfbkGR16qF7DHth6jT
Y+qWauubGUXBO/p3NBWrNXLeTAeQdOMVYZ6SfPGSspb0jdGGUrTgdF0VRiv12vJf
BD7/76CC6Ro3ZVLf7FLLaA4qgCFrAQS5l6gAe/GJoOBUwk6zQ1ht3I2WzidMa5eH
O/8cRI40hT6RgIbApVaOuZ7oVaz/I3jSNCLD254XfJsxjZeVOFSv6/pkRSzfOx5n
OuvQ6WH8COJQJefIf8V+UAlPDVY2Tzv7uMH4QFMCI73lJQQKomfI/LmjBKX1lV3y
4lgTMFO+00akszO6/AXvvwREqyyOU8cpkv3JD8VgaXBZ7KgY9r8N+jBL+SCWQeDJ
V2HwjKnXdRICGqZYowJ8TLAV3MdKkgE/nnY9WfYID9ju9l+i6IwmiUvpoB6fDtgO
CHPorN44uzvqaXFHhWEQPDh2A9NQvE42K8p+kK/kVlRlcQOTKZfciD9RJvstTTAh
fmrcGZNMv8t3SY1N0FGo
=bzJv
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

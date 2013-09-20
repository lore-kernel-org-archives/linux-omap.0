From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/4] usb: musb: am335x: add second port to beagle bone
Date: Fri, 20 Sep 2013 10:44:49 -0500
Message-ID: <20130920154449.GX26101@radagast>
References: <1376580112-17677-1-git-send-email-bigeasy@linutronix.de>
 <1376580112-17677-3-git-send-email-bigeasy@linutronix.de>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dwN3S3mscniL3FCL"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39510 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359Ab3ITPqA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Sep 2013 11:46:00 -0400
Content-Disposition: inline
In-Reply-To: <1376580112-17677-3-git-send-email-bigeasy@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-usb@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Benoit Cousson <benoit.cousson@linaro.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

--dwN3S3mscniL3FCL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2013 at 05:21:50PM +0200, Sebastian Andrzej Siewior wrote:
> So I assumed that Beagle bone has only one USB port in host mode because
> the micro USB connector had an USB-UART there. I was wrong a little. The
> second port runs on host mode, but the micro USB plug is connected to an
> internal HUB with two ports: one to the USB-UART and one to musb
> instance one.
> For that reason, this patch enables both ports: the primary in device
> mode only and the second in host mode only.
>=20
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/boot/dts/am335x-bone.dts | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x=
-bone.dts
> index e8447a7..596d653 100644
> --- a/arch/arm/boot/dts/am335x-bone.dts
> +++ b/arch/arm/boot/dts/am335x-bone.dts
> @@ -131,9 +131,24 @@
>  				status =3D "okay";
>  			};
> =20
> +			usb-phy@47401b00 {
> +				status =3D "okay";
> +			};
> +
>  			usb@47401000 {
>  				status =3D "okay";
>  			};
> +
> +			usb@47401800 {
> +				status =3D "okay";
> +				usb@47401c00 {
> +					mg,port-mode =3D <1>;
> +				};
> +			};
> +
> +			dma-controller@07402000  {
> +				status =3D "okay";
> +			};
>  		};
> =20
>  		i2c0: i2c@44e0b000 {
> --=20
> 1.8.4.rc2
>=20

--=20
balbi

--dwN3S3mscniL3FCL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSPG1xAAoJEIaOsuA1yqREzdkP/1E57RcN53Rt+2rhw6lbV/qA
3GY032zgEOXBaXUpTrTyfOYDE5B6uoYOT5Mw+DIR8SlN5OfqW1RL3izawMpN3GF4
FneNAizg4OQX76mRnDQFX4LT77h4Sm+qHBxpI4qytXTkyA4ajYvgqr1m5dNB6+6s
fiM+iuDhUTcD0mWdhg3dCy33oifkqKwG7Hl9BY01Fc2daTp7FNaArRYBbl41YPVw
E2m2yzq/ImpDoB4DfRAoVbQqmRAxBxIGPKoaFW3zYGvyBFQMcAyY0QLiETZDvUYJ
lTeQtGrb3sJp1LLDoMiqHm/VRpL8SXfaY5jyL/CWFNkNEf4F6hiwv1LseDsL8SdX
g0Hkh4CwwTqiHYIy82g7PGvV7LfDzGrxJERzdU8JTyvYeGj//JgMQIioSq/aYXq+
vBCbXxX+pCk+WrlNn0ddUUPG5Uux2cqWKLIKyqPqAGBF37XNEQfKDo5/fpm8Iw7N
5gvoWCgeuzNP3STQ4Nx+IQygfjR+eiLcvNkABfhZEa1/Q2MlpodD3cTlMjE+fBks
igcjiqcQUJHyt3v2w0FZvq5Na75dKTDcVzwxMQCrLzZbF7s+RIR2y4D5EfzYGSGs
6k8it3Dpo7AcezD9gxRgz/yFMFg+DOTwbIr+fc7opP286war3AHyoQxGW6saDV/O
/NXQbzpdPWJ1sXnnqOSy
=cFBT
-----END PGP SIGNATURE-----

--dwN3S3mscniL3FCL--

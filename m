From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 3/4] usb: musb: am335x: Do not remove the session bit
 HOST-only mode
Date: Fri, 20 Sep 2013 10:45:06 -0500
Message-ID: <20130920154506.GY26101@radagast>
References: <1376580112-17677-1-git-send-email-bigeasy@linutronix.de>
 <1376580112-17677-4-git-send-email-bigeasy@linutronix.de>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/T5g/TLNXpBPJeG6"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49498 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752414Ab3ITPqL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Sep 2013 11:46:11 -0400
Content-Disposition: inline
In-Reply-To: <1376580112-17677-4-git-send-email-bigeasy@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-usb@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Benoit Cousson <benoit.cousson@linaro.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

--/T5g/TLNXpBPJeG6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2013 at 05:21:51PM +0200, Sebastian Andrzej Siewior wrote:
> This is what I observe:
> On the first connect, the musb starts with DEVCTL.Session set. On
> disconnect, musb_core calls try_idle. That functions removes the Session
> bit signalizing that the session is over (something that only in OTG is
> required). A new device, that is plugged, is no longer recognized.
> I've setup a timer and checked the DEVCTL register and I haven't seen a
> change in VBus and I saw the B-Device bit set. After setting the IDDIG
> into A mode and forcing the device to behave like a A device, I didn't
> see a change.
> Neither VBUS goes to 0b11 nor does a session start request comes.
> In the TI-v3.2 kernel they skip to call musb_platform_try_idle() in the
> OTG_STATE_A_WAIT_BCON state while not in OTG mode.
> Since the second port hast a standard A plug the patch changes the port
> to run in host mode only and skips the timer which would remove
> DEVCTL.Session so we can reconnect to another device later.
>=20
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/boot/dts/am335x-evm.dts | 3 +++
>  drivers/usb/musb/musb_dsps.c     | 2 ++
>  2 files changed, 5 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-=
evm.dts
> index 648a67e..794b38b9 100644
> --- a/arch/arm/boot/dts/am335x-evm.dts
> +++ b/arch/arm/boot/dts/am335x-evm.dts
> @@ -192,6 +192,9 @@
> =20
>  			usb@47401800 {
>  				status =3D "okay";
> +				musb1: usb@47401c00 {
> +					port-mode =3D <1>;
> +				};
>  			};
> =20
>  			dma-controller@07402000  {
> diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
> index 7368577..b7b2346 100644
> --- a/drivers/usb/musb/musb_dsps.c
> +++ b/drivers/usb/musb/musb_dsps.c
> @@ -230,6 +230,8 @@ static void dsps_musb_try_idle(struct musb *musb, uns=
igned long timeout)
>  		glue->last_timer =3D jiffies;
>  		return;
>  	}
> +	if (musb->port_mode =3D=3D MUSB_PORT_MODE_HOST)
> +		return;
> =20
>  	if (time_after(glue->last_timer, timeout) &&
>  				timer_pending(&glue->timer)) {
> --=20
> 1.8.4.rc2
>=20

--=20
balbi

--/T5g/TLNXpBPJeG6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSPG2BAAoJEIaOsuA1yqREW5oP/25tUNFNeeBcAtS9GgE72hf8
HEW52LokRwxLkOVUA75UhaWKaEM7SpAzLnHM46HdH6qTTDSzZziqTNreajSXq/Yq
EfWFAcGPMkWqu9tCcxbf6c9j8hC7XeXceIdnjmaCNAj3Bd26WPPyuD4v1M3wd3s/
9tOPuzjXr4XVzEOIsLZR2L90pbL1oqJ++keIC0L59QEXDlS+vlLzirxOXy/9sRaA
QQ4nvPJ/vqtQ9T+7ui/A8nRtXtWv29kqoMIilSd63b3MoRQ1+Qjw9QvZ5tzjqdmC
eoqOnUI4AZTm4J3K4xfJeF5uaafstbPP20KhD8as7+YiejwBIqc2tuWpB8zO4goL
qpVanZ1li5KqX6MFQ2R47B6YELrbGnhjzhopeD7pJo7bwDk5sKwXBv8SBT5grtHl
pnTQol1sykkJtO4/sE7cBrnwJhbIu8VsFEKt0th2SW6xJiTkxkQQqoih+18bzfVg
IIHLA2dIGgaT/u3kb2az6LiVk6iMDGqa6zNUT71olHy+3BhKlOEOk+MYdbEf3vaI
tVLiPLgrZ3fhtGh2oPveweNukhejsNUYVTLqs0FRop9Y3c87cF4PhZECTwAOcGRK
gysFjINulp5/3EDn1hwCz0eZYTPXK9oOkcS7FfypkoCSBfKniJDlgeAxK8smZppa
LMr+sWHz2yZpigtdgzGQ
=dN0g
-----END PGP SIGNATURE-----

--/T5g/TLNXpBPJeG6--

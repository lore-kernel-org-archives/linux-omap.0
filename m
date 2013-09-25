From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH usb 1/2] usb: musb: Add missing ATOMIC_INIT_NOTIFIER_HEAD
Date: Wed, 25 Sep 2013 10:17:38 +0200
Message-ID: <201309251017.39014@pali>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com> <20130918164816.GN21559@radagast> <201309181903.33243@pali>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3714314.3tRJqkthev";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201309181903.33243@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: Javier Martinez Canillas <martinez.javier@gmail.com>, Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>, Anton Vorontsov <anton@enomsg.org>, Russell King <linux@arm.linux.org.uk>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, freemangordon@abv.bg, Aaro Koskinen <aaro.koskinen@iki.fi>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--nextPart3714314.3tRJqkthev
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 18 September 2013 19:03:33 Pali Roh=C3=A1r wrote:
> &twl->phy.notifier is not initalized
>=20
> Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
>=20
> diff --git a/drivers/usb/phy/phy-twl4030-usb.c
> b/drivers/usb/phy/phy-twl4030-usb.c index 8f78d2d..efe6155
> 100644
> --- a/drivers/usb/phy/phy-twl4030-usb.c
> +++ b/drivers/usb/phy/phy-twl4030-usb.c
> @@ -705,6 +705,8 @@ static int twl4030_usb_probe(struct
> platform_device *pdev) if (device_create_file(&pdev->dev,
> &dev_attr_vbus)) dev_warn(&pdev->dev, "could not create sysfs
> file\n");
>=20
> +	ATOMIC_INIT_NOTIFIER_HEAD(&twl->phy.notifier);
> +
>  	/* Our job is to use irqs and status from the power module
>  	 * to keep the transceiver disabled when nothing's
> connected. *

I sent above patch week ago. Did you already included it?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart3714314.3tRJqkthev
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlJCnCIACgkQi/DJPQPkQ1KMzQCeIeAq4podweQ/jVyI4DQTQoV4
nMoAnRLhzlQLdiiPUjkl7/A8L7UNZWFl
=qonf
-----END PGP SIGNATURE-----

--nextPart3714314.3tRJqkthev--

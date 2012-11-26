From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH RFC] i2c: omap: Remove the OMAP_I2C_IP_VERSION_*
Date: Mon, 26 Nov 2012 13:52:08 +0200
Message-ID: <20121126115208.GA17605@arwen.pp.htv.fi>
References: <1353929982-13984-1-git-send-email-shubhrajyoti@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1353929982-13984-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 26, 2012 at 05:09:42PM +0530, Shubhrajyoti D wrote:
> The OMAP_I2C_IP_VERSION_1 and OMAP_I2C_IP_VERSION_2 was needed
> as on VER2 we were not reading all the 32-bits. Since now that
> we read the hi register we do not need the OMAP_I2C_IP_VERSION_*.
> Delete the same.
>=20
> The custom reset is also changed to detect VER2 based on the
> scheme.

looks like this should become a series IMO.

First patch would move the macros to common header, second patch would
switch the Reset part to use those macros and third patch gets rid of
OMAP_I2C_IP_VERSION_*

other than that, looks very good to me.

--=20
balbi

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQs1foAAoJEIaOsuA1yqREOTQP/ib97gwmTyw7B0iTMv5ppQJE
v2GKiZb3NW6nXCt81k1GpeymiLTCx/I6+qm9+dvOcBN5oKe3Noc3FFLzuQezauh6
lLGRSUiw7elmIfEqXWA/XmUo/n3eKkBNK9GZmzTWJhLbTA84JllA++IwyYDonBPf
xPUt6jhWWgX/LD3DJp7BsI2C8A4Vop6w1ALHgYv2QFmiPPAkkq730xNX8HxckWxQ
5QxLGsnhvLBATmGB32gJTyZ8qp0GIcmmYoLD89JYj7/4mWrjBEKeX9BI63iLa96e
m9+8DOarmjtOtdv3s/Q4jBjoOAbr9U2W6J7v50upL2HkCM9vj1g04zsosJngUig9
ylrbjqCjJIn8gJX7wNGkKCto6259NOa2/QrqKTdQ9+PPjf9XZKAiGf77jtH7d2po
R73rLKuL0ivhzKz1GjmABTLQr8Mk1fpBTrIAANVfRKtt13GOUxLnq/WdY8B5Mfdj
m1uWoMFKhwuhhte4swtqjpv7V29Adp1ymsKawfeiyx+Gyw1gHIesgzMtlL3vi/fB
Qum2J8V/O2x8YVTBrtKLX97krI5qX+QMaYt33o4oNHQBQuph09AxXGIG52QZ3yev
le8tgiHu3W4zer6YcK8QaNKfF0TaE5NMzCNo5f44RdKKpu68Flqaf6dS30vg0p2e
XUBF2s7SqhnDknFwkwUL
=8FGB
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--

From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: usb: musb: "(null)" in sysfs mode file after disabling a gadget
 (and at other times, system hangs)
Date: Fri, 2 Mar 2018 17:54:39 +0100
Message-ID: <20180302165439.62xw4slhhupy4vy5@pali>
References: <f7a8cfac-e70b-046a-b465-7b37630d5d86@wizzup.org>
 <20180302152712.GA22262@uda0271908>
 <d2ade131-d6d1-72f9-f2df-78e2bef82ca3@wizzup.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="kbba6go523codbpi"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d2ade131-d6d1-72f9-f2df-78e2bef82ca3@wizzup.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Merlijn Wajer <merlijn@wizzup.org>
Cc: Bin Liu <b-liu@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--kbba6go523codbpi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Friday 02 March 2018 17:47:52 Merlijn Wajer wrote:
> >> I would expect it to state "b_idle" instead of "(null)".
> >=20
> > Actually, I'd like to see (null) whenever a gadget driver is not loaded,
> > which indicates a gadget is not bound to the udc.
>=20
> Hm... Sounds fine to me. I'm using this mode in combination with the usb
> phy (vbus property) to detect if the phone is detect to a 'dumb' charger
> of a PC, but I can just always have a gadget loaded -- same as before,
> really.

For detection if wallcharger or pc usb charger is connected, there is
isp1704_charger driver. It uses some standard ULPI interface. It reports
current_max and type (DCP - dedicated, CDP or just usb).

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--kbba6go523codbpi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCWpmBzQAKCRCL8Mk9A+RD
UkciAJ9Q8KL6azfkLa9MCs6XjsP48qPTFgCgqhEEsflewq3nkYVu/ILmxF2paLc=
=qUKz
-----END PGP SIGNATURE-----

--kbba6go523codbpi--

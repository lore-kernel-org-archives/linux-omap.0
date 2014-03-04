From: Felipe Balbi <balbi@ti.com>
Subject: Re: Help needed USB hub disconnected at resume
Date: Tue, 4 Mar 2014 16:44:27 -0600
Message-ID: <20140304224427.GA31462@saruman.home>
References: <F690310232FDDF4AB457E8B3EF90DDE0AA85E10B@MARCM-SBS2011.marcmltd.local>
 <F690310232FDDF4AB457E8B3EF90DDE0AA85E1E7@MARCM-SBS2011.marcmltd.local>
 <F690310232FDDF4AB457E8B3EF90DDE0AA85E21F@MARCM-SBS2011.marcmltd.local>
 <53146225.8040403@ti.com>
 <531472B3.1060104@compulab.co.il>
 <F690310232FDDF4AB457E8B3EF90DDE0AA85E7F2@MARCM-SBS2011.marcmltd.local>
 <5315761D.8080103@compulab.co.il>
 <F690310232FDDF4AB457E8B3EF90DDE0AA85FF56@MARCM-SBS2011.marcmltd.local>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39786 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754888AbaCDWqG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Mar 2014 17:46:06 -0500
Content-Disposition: inline
In-Reply-To: <F690310232FDDF4AB457E8B3EF90DDE0AA85FF56@MARCM-SBS2011.marcmltd.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Murphy <marcmltd@marcm.co.uk>
Cc: 'Igor Grinberg' <grinberg@compulab.co.il>, Roger Quadros <rogerq@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 04, 2014 at 10:34:56PM +0000, Marc Murphy wrote:
> static __init void tam3517_ehci_init(void)
> {
>     /* Configure GPIO for EHCI port */
>     omap_mux_init_gpio(TAM3517_EHCI_RESET, OMAP_PIN_OUTPUT);
>=20
>     gpio_request(TAM3517_EHCI_RESET, "USB_RESET");
>     gpio_direction_output(TAM3517_EHCI_RESET, 1);
>     gpio_export(TAM3517_EHCI_RESET, 0);

why are you exporting this gpio ?

--=20
balbi

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTFldLAAoJEIaOsuA1yqREqWgP/09GpXoZrObd9Ow+5IFrYz3+
q3NjV4ByvODxvBA45PIVfMPWJJr/tATgdlfHlTqdyF0xdvVl1cPS2/YdH0M28bB6
KHQxmSJj2neOb8GXAxEgu1yQAM8gHab/xs8ceesXn6VeQfr7WJdy/VeQPbeJnMqQ
6FBkuesIeABT4Zg+xfLADpFcnPrnXYnW+oMKBM7BV/72TRmEfN2v93AvA8bhHF9J
Jwp3qtnLJZPEqMOv0uoBK5qiWCrVAT/zF1UBmlT027drLTjDV0pVpFxypI29joLL
EvjRX/Rn4Om4+Xom2xBRTufhhKa9b9zJZ28RNnq81R0WUMPf/Gi2PSt6pGXXq+CI
vrPwOXa0hoj4KZ2PnW5CRhD7myyWbzsnXbgA72iKAcX55l4jkt9bEcEYSiCXsiPZ
3dpHZ2l0MjyonXANLPwQpngZ3aoMZKAc9oI/M1ILNtckUcRl5iMqXJdynoLj88GJ
xbA8UYN5L3U4e3JjSykFamSX4zMrL61PDOVuPQIwHQUZvAaTVH8jZlbPw2i12YvA
f3QJ4h5+eTur3FbqsvtHoX/PYTyQAkylUGsDLybzLt2S6VhE3JGBodcl8bMAU1ie
OXhjUvNbT3K+qWm48nPiI16Qq48xDhcTlP7rfOI2KBKn3dC00IVu0Cu6kfzLT6Fb
f+PcWI5T6pAwUb9f23TL
=Ms1O
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--

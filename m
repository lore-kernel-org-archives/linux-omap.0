From: Felipe Balbi <balbi@ti.com>
Subject: Re: Section mismatch warning with linux next in usbhs_init_phys()
Date: Mon, 29 Apr 2013 13:16:01 +0300
Message-ID: <20130429101601.GF16881@arwen.pp.htv.fi>
References: <20130411183201.GB10155@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Yia77v5a8fyVHJSl"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36943 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754931Ab3D2KQl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Apr 2013 06:16:41 -0400
Content-Disposition: inline
In-Reply-To: <20130411183201.GB10155@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Roger Quadros <rogerq@ti.com>, Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org

--Yia77v5a8fyVHJSl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2013 at 11:32:01AM -0700, Tony Lindgren wrote:
> Hi Roger,
>=20
> Looks like there's a section mismatch issue in linux next:
>=20
> WARNING: vmlinux.o(.text+0x2a7b4): Section mismatch in reference from the=
 function usbhs_init_phys() to the function .init.text:usb_bind_phy()
> The function usbhs_init_phys() references
> the function __init usb_bind_phy().
> This is often because usbhs_init_phys lacks a __init=20
> annotation or the annotation of usb_bind_phy is wrong.
>=20
> Can you please take a look?

already taken care of, should be on today's linux-next:

http://git.kernel.org/cgit/linux/kernel/git/gregkh/usb.git/commit/?id=3D19d=
8ceddda8b3a806a0960106ae6aa4dcc21df3b

--=20
balbi

--Yia77v5a8fyVHJSl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRfkhhAAoJEIaOsuA1yqREPW8P/2+DKoMJX19G+CE5WJhKxdSi
CRvrCr94P/FrLwgnHg0U5INRsA31S7CwBYq+EPXTh2/56+lBvCNPlcTpvmOBI/yR
YWOnTnryytQpLmPE47inxwYsS0jhCLl/hr+Xb48QKtngGMmui2X66/P/TzYvQ+Pb
8McwzgXrT8vOuFJk123bljKKVXKSrKFETLdVgHMzF0iN3ilysAO3f6mUSpIBWEFG
29FAeRWGAIj4gYXHzVAFT9cYq8o3jT+IZ1aklBhKLw3KjGFwIRz2yYrZRG4ipxqO
RuDU1qbhnDeDJuRUfz10wFMuNUfiNre4d61Ltyg7sEUs3eGKEeSUoURERP42k/pN
k4t0ZBfdADoWYYWKKFsu+bLNzUuPSBbWXIw/iwHcYSAYRxAEVjtFZdKJPOvLXeRy
I1g9ZmZJpHl+XvhXwY9fTf34Z0x7kYHjBb8jZBaDXXbn0JJy/ZiTo1hZiu3javW2
sZ1R4sGKWo8oS4+rx5cM70exH/7pA2AVghpqvBhi6MJQ6rsC/S2rVhXlzWxriuLw
mPyRh0BLmbrCjpCFLL4SRlbfd+WQw/5VIy/aWuL+Rl9WPgeXjRYFlPTbnrspebWr
bWR3IDe/sLo8f73/xq0T1wx5H/PBfu5HVzBwIR2w17XFhWza3IoNAb1buo01uKlr
fO5BvN2JUs8R9t8qCEu3
=aH+U
-----END PGP SIGNATURE-----

--Yia77v5a8fyVHJSl--

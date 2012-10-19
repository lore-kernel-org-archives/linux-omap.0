From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2] arm: omap: move OMAP USB platform data to
 <linux/platform_data/omap-usb.h>
Date: Fri, 19 Oct 2012 09:55:00 +0300
Message-ID: <20121019065500.GD12235@arwen.pp.htv.fi>
References: <20121016230040.GP15569@atomide.com>
 <1350488838-6289-1-git-send-email-balbi@ti.com>
 <20121017203404.GY15569@atomide.com>
 <20121018054934.GE11137@arwen.pp.htv.fi>
 <20121019014917.GL30550@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jCrbxBqMcLqd4mOl"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56861 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754978Ab2JSHAg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Oct 2012 03:00:36 -0400
Content-Disposition: inline
In-Reply-To: <20121019014917.GL30550@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--jCrbxBqMcLqd4mOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 18, 2012 at 06:49:17PM -0700, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [121017 22:56]:
> > Hi,
> >=20
> > On Wed, Oct 17, 2012 at 01:34:04PM -0700, Tony Lindgren wrote:
> > > * Felipe Balbi <balbi@ti.com> [121017 08:54]:
> > > > In order to make single zImage work for ARM architecture,
> > > > we need to make sure we don't depend on private headers.
> > > >=20
> > > > Move USB platform_data to <linux/platform_data/omap-usb.h>
> > > > and keep only internal functions in <plat/usb.h>.
> > >=20
> > > Thanks, looks like I can't make this apply against v3.7-rc1:
> > >=20
> > > patching file arch/arm/plat-omap/include/plat/usb.h
> > > Hunk #1 FAILED at 1.
> > > Hunk #2 FAILED at 26.
> > > Hunk #3 FAILED at 44.
> > > Hunk #4 FAILED at 65.
> > > Hunk #5 FAILED at 81.
> > > Hunk #6 succeeded at 28 with fuzz 2 (offset -128 lines).
> > > 5 out of 6 hunks FAILED -- rejects in file arch/arm/plat-omap/include=
/plat/usb.h
> > >=20
> > > Can you please check it?
> >=20
> > Are you sure you have a clean v3.7-rc1 ?
>=20
> Yes. Figured it out, it fails to apply with quilt, but applies
> with git.

probably because of file rename.

> But it does not compile with all configs though, and does
> not remove plat/usb.h. Thanks anyways. I'll post a proper
> series shortly with your patch fixed up.

ok... I'll check it out. I kept the non-static functions in plat/usb.h
because they didn't belong on platform_data/usb-omap.h. What should be
done with those, then ? move to mach/ ?

--=20
balbi

--jCrbxBqMcLqd4mOl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQgPlEAAoJEIaOsuA1yqREEcMP/1JlTTwi8Fd4FQ0iPrH28BER
WX+TrZf5EE6Ob7rOA40RUw5zPRZ7/6rDM6B++XIOJVjTDGwj4NScQEJJw1bnthw8
G0x4FHGIRYWZmOuY5qqcJG9j0XE4emKUERwUIehs1oDK2En8NsoggYex1xegczWt
JoN4/IGD9103kDSbpoKw5CC3XneKc/J4GftaHZOpDxsHKT2VG0Sy7qeIwjeohZ4G
yAwPJgaV1/9EeGsdU7LtMAKqxxvJyi83hkir+BKC7dADaSQgnjfxuVmX2jDpsic4
0vnoEJSoZsT8Xzpy4KSnSzYsqTNxghqJqSzoAxRHD1RpLslEOvzqbJv2aMtpo9dy
Z3KvPJQgbvgyhw4i/2xXM6tRJlECEhgYADZDgiM4yxB4IB80BzUd3KxsOaQYJO4z
DSxvXViaLPn5+TTAjtx8BGiqC9qsFTZj8VAadDiU+uIGFUIPSPacppWhtUtLvenk
CZcmahqpQinywMkEi1yCD5HsQ6efwh6MGDMZhYc2V0x/2FcE25BVTgeNPMblHabS
GFZxr6mt9Q0YQ1GKWRhlUKXvJyPzP3p4fBZuTxO47+S1tPJ5c2VcFMPrZPP+WRet
qukrD4/9AqPVHBKSpyZfuzSi0s08dXabT+lV/c0ERiZfNUShAFCLCigyzJbTRJnO
WvtarW1PVCUYFiNbYEjO
=l7F+
-----END PGP SIGNATURE-----

--jCrbxBqMcLqd4mOl--

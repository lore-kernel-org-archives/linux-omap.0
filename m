From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 3/4] ARM: dts: Add cppi41 support for dm816x MUSB
Date: Wed, 18 Mar 2015 09:40:35 -0500
Message-ID: <20150318144035.GB1116@saruman.tx.rr.com>
References: <1426637961-4197-1-git-send-email-tony@atomide.com>
 <1426637961-4197-4-git-send-email-tony@atomide.com>
 <20150318003121.GA12911@saruman.tx.rr.com>
 <20150318011836.GK31346@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hHWLQfXTYDoKhP50"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52272 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933140AbbCROlq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Mar 2015 10:41:46 -0400
Content-Disposition: inline
In-Reply-To: <20150318011836.GK31346@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bin Liu <binmlist@gmail.com>, Brian Hutchinson <b.hutchman@gmail.com>, Matthijs van Duin <matthijsvanduin@gmail.com>

--hHWLQfXTYDoKhP50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2015 at 06:18:37PM -0700, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [150317 17:32]:
> > Hi,
> >=20
> > On Tue, Mar 17, 2015 at 05:19:20PM -0700, Tony Lindgren wrote:
> > > Looks like we have cppi41 on dm816x just like on am335x.
> > >=20
> > > Cc: Bin Liu <binmlist@gmail.com>
> > > Cc: Brian Hutchinson <b.hutchman@gmail.com>
> > > Cc: Felipe Balbi <balbi@ti.com>
> > > Cc: Matthijs van Duin <matthijsvanduin@gmail.com>
> > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> >=20
> > Any logs available ? Any throughput improvements with DMA ?
>=20
> So far I only logged with the debug option on. I can do some
> test runs with your for-next branch to a USB mass storage device
> if you prefer that, or got some other test in mind?

mass storage should be fine, just wanna know if you're getting
acceptable throughput.

--=20
balbi

--hHWLQfXTYDoKhP50
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVCY5jAAoJEIaOsuA1yqREsaAP/0uxmhcAaaGBZgfCloOZ9Jy1
D6t9Ht+EuFlE61zOec2L9o6H5yNtckhwSfuc2X6O6stomD9ybYViRjBW5iqxUXk4
OnEhDbDyzKRjjkjQHJXZc/ifU5YtFDTlvaqkO0m/cGpVRDmLBCxqXWFAUUyzq096
bxX7ilJBN0otHpb7AlkGw61Vj/7vzah6L587AET6M48i5AcRvq74Kv3/I6S7WOw/
LMvpWF6Y127Em8Y6JuGThGgvwvEmho9vP1BOnyluinOWXM1sl5AaPWPEAqf51LqB
KsUrgZ3HotLL2RSlSHxaVx2/LXfgm/l5/Z4QevDF5osEriY1n82coBydxLyr45Et
SKRaQJnoIuoV1B8lxGOi3h0rpraI2UPUxMS9MfprJQFy1D0MOiaz4NDtu7TrO3aD
j3p5zcFumDb6KSNzqEQ3SoRa3LR1dv4QVDLBkhdTLH8Kz8Xp6ENwBHFszmeUmYWV
OfiIOxLsma3mFWTF/LxJXIBfn8O7fplUqyjavUpic1h8jCbjlz8YcXvsQJNSUO9h
jXydog2dkmy4AunB6pCFcnXMaRZOrwbsm3Jg+hj06Jl1uxS/nCc+VbNejN5nDhEW
YZwmQaqNx+ltoptXtzXvej6rWKDe0L4crze/CgUeHxBYsvphxB4Knw4kdqgEZBrl
WqIhUozDKselCKXrUtdG
=oeKI
-----END PGP SIGNATURE-----

--hHWLQfXTYDoKhP50--

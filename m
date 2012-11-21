From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 13/16] mfd: omap-usb-host: Get rid of unnecessary spinlock
Date: Wed, 21 Nov 2012 21:50:33 +0200
Message-ID: <20121121195033.GE14290@arwen.pp.htv.fi>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com>
 <1352990054-14680-14-git-send-email-rogerq@ti.com>
 <20121121135732.GN10216@arwen.pp.htv.fi>
 <50ACF967.30703@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vv4Sf/kQfcwinyKX"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48516 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755883Ab2KUT5F (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Nov 2012 14:57:05 -0500
Content-Disposition: inline
In-Reply-To: <50ACF967.30703@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@ti.com, keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

--vv4Sf/kQfcwinyKX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 21, 2012 at 05:55:19PM +0200, Roger Quadros wrote:
> On 11/21/2012 03:57 PM, Felipe Balbi wrote:
> > Hi,
> >=20
> > On Thu, Nov 15, 2012 at 04:34:11PM +0200, Roger Quadros wrote:
> >> We don't really need a spinlock here, so get rid of it.
> >=20
> > can you prove it ? what if an IRQ happens right after disabling clocks
> > on ->runtime_suspend() but before it returns ? Will this not cause a
> > problem for you ?
> >
>=20
> Which IRQ are you referring to? I don't see any IRQ handler in
> omap-usb-hot.c

oops, silly old me ;-)

> In the original code, the spinlock is used only in
> runtime_suspend/resume and probe functions and it didn't make any sense
> to me why it was there in the first place.

fair enough, I should've looked at the code before assuming there was an
IRQ handler. Carry on :-)

--=20
balbi

--vv4Sf/kQfcwinyKX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQrTCJAAoJEIaOsuA1yqREbtYP/jfFrktGW7zwQVlGpsMfZg/+
jmC/IkMTz5AoqkPynH2i/QN7HbBnd2eGrordL/vOZ2XXAkrZAMF0gwMSeI2eQvr/
4AdgV/RBmBvxpK/pQB6e3ce/eEbtDlb0C6gKuL1yhhsDqUtyX4ahlJG+xsi8Q4Zw
snmGwPhm3jSh5nG7unBuAz0UOh4ghBI5kc+f6dkvHOL2xYALLh5vxN4gUWsEAJ4A
m2xXluBRt4hwzyKenAcgtCxLF67U9fz+zwHaW/WY2lx6QP4O5AFZ4AH6szgkVPRB
thPknyAkYJZNpzJltpG5KjMG20SgDTab7qLjoRVK4fAoVPrWVjS1ayVQNfgMLLtO
ENzMDa21xRlPCPUCnDMAo/rEtHyQ1Z51nXUpdDmzkc3fD5uJZmnmiqq/vfSCaknL
cVBIkq1Os5hGwKY3s/QJ3WLGE4bAhs7CLQoLRjYxKyLFeFcIFA0mrPP8LFouXdB1
jTjbhe+psx6iZJfCrQI5xIv3/llZCRygIEXid4L6XKVqiG3UJGoNgZ31VNTQQ4EG
MT5tmDclNOU5CmkV7e6UTa6yBsKK7+xCGkWTK3AzhsU3OlMM+bE98DuFrA8Oedeb
NgEG/l42EGNx6kvaGCWEOL6DEY4ggun54YTq6np3Gfa1FnPCTncLHGwMURahNZzZ
cLPI9AP+k7sOXsmc0gjM
=/APL
-----END PGP SIGNATURE-----

--vv4Sf/kQfcwinyKX--

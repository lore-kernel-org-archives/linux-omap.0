From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 0/4] ARM: OMAP2+: AM33XX: VDD CORE OPP50 support
Date: Thu, 29 Aug 2013 19:03:53 +0100
Message-ID: <20130829180353.GP10783@sirena.org.uk>
References: <1376487480.3889.64.camel@coredoba.hi.pengutronix.de>
 <CA+Bv8XYe0UzBkjqtO7bNkgNVTQtxiM7Hv93BOu8Lw1=pESOwLA@mail.gmail.com>
 <87txiasqhk.fsf@linaro.org>
 <CA+Bv8XZagHZ9mUuZB49hrH=901fXzoAcV8C0Fm3EfLa2eiBu0w@mail.gmail.com>
 <20130829110534.GV10783@sirena.org.uk>
 <CAGa+x85u0OpB9o71xUTs15wt8Te-o5f0C9o22GHzZwOjn5F6=w@mail.gmail.com>
 <20130829154929.GJ10783@sirena.org.uk>
 <CA+Bv8XYbpqQAYwJ3=vkP0gXDMTp7_VNVzB0NXLG6GHDi=Z1img@mail.gmail.com>
 <20130829173022.GN10783@sirena.org.uk>
 <CA+Bv8Xb38bwby78Q--nEGffBknj5ZD98x0OuRX5N1EFNjbh7zA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Jtzgsd50XOpelISN"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:56637 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754076Ab3H2SEQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Aug 2013 14:04:16 -0400
Content-Disposition: inline
In-Reply-To: <CA+Bv8Xb38bwby78Q--nEGffBknj5ZD98x0OuRX5N1EFNjbh7zA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <Russ.Dill@ti.com>
Cc: devicetree@vger.kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, Jan =?iso-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>


--Jtzgsd50XOpelISN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 29, 2013 at 10:47:04AM -0700, Russ Dill wrote:
> On Thu, Aug 29, 2013 at 10:30 AM, Mark Brown <broonie@kernel.org> wrote:

> > So this is done from cpuidle rather than system suspend.

> It is done for system suspend. It isn't possible to do this in a
> cpuidle use case as the memory controller would need to come out of
> idle automatically to service DMA requests.

OK, so it's all part of the core power down sequence for the SoC?  I'm
not sure that makes a big difference but it at least means that there
are fewer runtime interactions to worry about.

> > I mean describe the intended sequence of events in the system rather
> > than the raw register commands to accomplish them.

> I'm still not sure what you mean.

Say "set voltage X" or even "regulator X supplies Y" not "send this
bytestream to the device".

--Jtzgsd50XOpelISN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSH40GAAoJELSic+t+oim9nJMP+gLIcSKDdAyHLH/JL8JKzZo+
eSixyfavlXJSfK7qz1v3Y33P2cgKXdYMCFXCTRnzV6bsArgYbrMzWmg1sgyiMSUR
iQVFNi/vzjJT/RB6X08EB5cvxHcqSEQ/W0ZARR8XS4Bb7OMEXqw8wWBwWqZpWCh/
7mtmi/WyUMkm90DdvXgBLbZ24C4QKUH3k5tJQsJ5LM+Xdw32qbILVHuNQyY+lqH3
6tWL8WKUZ6m7mQvlnNmI+zsHw2RmNaUcjLfUGmjq8M6lhW/ZO5gd9GEX2OwWxZgC
maU7lz6BwkqSpR/jq/V38O+lcoQ/Y6noqMY9jF3nZIsigRXWnyVrPGUM25NG3z0o
0qkdzAdnsYC9TPS85dywnXN1BJDnCC+ju1rl3WRpSgY3rGoJEdfaX4WIT2NqbFSf
ChQwA6a9NMFUVhmF9RCzpmPWQSM5ZhAAUZQ+t/m5m+Ayc11HMDhHtmDjM0t4gwMc
VLH6b/GoJfDEKD3ygmsL0+rdU4rRmePJH4W9+1OSh6F3tAXKRvezIG8mknkau/nD
nfenzB9huW9X9DqLfHKWyYYrwJTymNKK4ceCjZbSJL6PIYJ0KclIbnVuZTuShJ1c
fLwr/daIV1X3lGWb4cZqJmozWyjaD1yc0xoRpFaZgM2sUAu7jGnXFZsf2BnmkpnI
2ARAiACMpoh3pxUglQf+
=ikwd
-----END PGP SIGNATURE-----

--Jtzgsd50XOpelISN--

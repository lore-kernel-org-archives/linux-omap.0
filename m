From: Felipe Balbi <balbi@ti.com>
Subject: Re: OMAP baseline test results for v3.7-rc1
Date: Tue, 30 Oct 2012 14:54:19 +0200
Message-ID: <20121030125419.GG29095@arwen.pp.htv.fi>
References: <CAORVsuWFzH3UmXCaY=iqmYsE72KOecLo40tG9BcTUBirJQ5iLA@mail.gmail.com>
 <alpine.DEB.2.00.1210231918500.27211@utopia.booyaka.com>
 <CAORVsuV9_4oc6+voEM9PkqzkXKHipor5XJqaXfDNxAWLofXcxg@mail.gmail.com>
 <20121025101212.GD21217@arwen.pp.htv.fi>
 <20121026201539.GD29548@arwen.pp.htv.fi>
 <alpine.DEB.2.00.1210262201500.11258@utopia.booyaka.com>
 <20121029200032.GD30152@arwen.pp.htv.fi>
 <alpine.DEB.2.00.1210301216330.12697@utopia.booyaka.com>
 <20121030123254.GD29095@arwen.pp.htv.fi>
 <alpine.DEB.2.00.1210301239310.12697@utopia.booyaka.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QWpDgw58+k1mSFBj"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45563 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932140Ab2J3NAZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Oct 2012 09:00:25 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1210301239310.12697@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Felipe Balbi <balbi@ti.com>, Jean Pihet <jean.pihet@newoldbits.com>, aaro.koskinen@iki.fi, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com

--QWpDgw58+k1mSFBj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 30, 2012 at 12:50:52PM +0000, Paul Walmsley wrote:
> On Tue, 30 Oct 2012, Felipe Balbi wrote:
>=20
> > the wmb() patch should help, but you said it doesn't, right ?
>=20
> Correct.  Not sure why you think that would help; the problem is almost=
=20

because of how the driver is behaving...

The only way for omap_i2c_wait_for_bb() to timeout is if the bus is
really still busy; meaning that either transfer hasn't fully completed
(some data still in FIFO), or we didn't send STOP or Repeated START
condition on the bus.

> certainly PM-idle related, given that the problem goes away by reverting=
=20
> Jean's commit 3db11feffc1ad2ab9dea27789e6b5b3032827adc "ARM: OMAP: conver=
t=20
> I2C driver to PM QoS for MPU latency constraints".
>=20
> The problem is consistent and easy to reproduce here.

I don't doubt that :-) What I think, however, is that PM QoS just made
the problem a bit easier to trigger for whatever reason. Maybe because
pm qos defers constraint updates, or something similar ?

> > without seeing debugging information on the failing case, it'll be very
> > difficult to sort this one out provided noone else seems to be able to
> > reproduce it.
>=20
> Aaro sees it also, so it's definitely not a local artifact.

Again I don't doubt it.

> It's not very surprising that the problem doesn't appear with the extra=
=20
> logging enabled, since the extra logging presumably keeps the system out=
=20
> of idle. =20
>=20
> Anyway, you are welcome to the userspace, bootloader, and X-loader here i=
f=20
> you would like to try to reproduce it.  They've been sent to Jean and=20
> Kevin and Shubhrajyoti already.  Simply request it and I will send links.

I can have a look, sure, but I don't have the same platform as you have.
I have a beagle XM revB (according to the stickers on the board) which I
could use to try to reproduce, if I manage to, then hooray :-)

In that case, please give me also a link to your uImage so I can make
sure to use the exact same setup.

cheers

--=20
balbi

--QWpDgw58+k1mSFBj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQj837AAoJEIaOsuA1yqREIUgP/2Hpy/gcr9txS1MwdtgvoPf4
D5t3gjs+qnv2SrHJIol0Y5U+p/QSQK1fLX7TmdpmWZAEcSByA7KcTmRTHJSXVE4Q
hDIEbF0fiSfFVJzhjJ+OsPX2Y40ozb9YpYzDti9s0l0nInjw+QzcX8IQNP69kDEj
1anf2NeA/mxcwMyq4k1MwdrK6xfQV2EAseCNG3SaGSVVxwagvO5lvAGMjMuVbi0b
42p9hT7oIWgAlHSBgLcOTEm7qBSqYO+GaSeTS/CuVpAFZClY4/aMRwGZ8zVZcQhl
lN41zYSjjYv60/trUDTGKh76FGXeV4Jewap6756oZOpHVxUXWMoV56IbNbycOAfO
Ep+/pNabyMgT0VxEpcgNck+sgmZmxbDgqf9SYSmEU37+rQqAB9r7AOE58dSk4XDm
Q6VJBHP8afjh711TolM+PY5SexyyfyVUIUSQ+x5LhndUGCMEmdH29GBuM4JoVaAx
MXeaThPoKfhRm6rHIuBUjRE3dhwPjy9bK7qRQ25IVO8MVxc6vTDC0RSRgI7mInFK
ogPhIc3D5Zzc0nHUzUh4zB46b7NK5qOwuRiaSpFM8O78z6TNlxjPsPuDTsLJPTJG
p4rdim/30bwNY2IOspP2JXDLXht2iwD5yx2vvsw18vPnETmYDLEiKFVAPIcU8fir
LQgsOHIq8T4nrSVcCUxe
=IGoA
-----END PGP SIGNATURE-----

--QWpDgw58+k1mSFBj--

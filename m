From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: omap: implement bus recovery
Date: Wed, 11 Mar 2015 16:22:50 +0100
Message-ID: <20150311152249.GA15562@katana>
References: <1424369209-26735-1-git-send-email-balbi@ti.com>
 <20150309163917.GI3739@saruman.tx.rr.com>
 <20150311015004.GB21726@saruman.tx.rr.com>
 <55004789.7080706@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:44056 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751343AbbCKPWi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Mar 2015 11:22:38 -0400
Content-Disposition: inline
In-Reply-To: <55004789.7080706@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: balbi@ti.com, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-i2c@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2015 at 03:47:53PM +0200, Grygorii Strashko wrote:
> Hi Felipe,
>=20
> On 03/11/2015 03:50 AM, Felipe Balbi wrote:
> >On Mon, Mar 09, 2015 at 11:39:17AM -0500, Felipe Balbi wrote:
> >>On Thu, Feb 19, 2015 at 12:06:49PM -0600, Felipe Balbi wrote:
> >>>If either SCL or SDA are stuck low, we need to
> >>>recover the bus using the procedure described
> >>>on section 3.1.16 of the I2C specification.
> >>>
> >>>Note that we're trying to implement the procedure
> >>>exactly as described by that section. First we
> >>>check which line is stuck low, then implement
> >>>one or the other procedure. If SDA recovery procedure
> >>>fails, we reset our IP in an attempt to make it work.
> >>>
> >>>Signed-off-by: Felipe Balbi <balbi@ti.com>
> >>>---
> >>>
> >>>Tested with AM437x IDK, AM437x SK, BeagleBoneBlack and Beagle X15 with
> >>>1000 iterations of i2cdetect on all available buses.
> >>>
> >>>That said, I couldn't get any device to hold the bus busy so I could
> >>>see this working. If anybody has any good way of forcing a condition
> >>>so that we need bus recovery, I'd be glad to look at.
> >>
> >>ping
> >
> >any comments here ?? Anybody at all ????
> >
>=20
> I think the I2C bus recovery infrastructure should be used here ;)
> As I did there https://lkml.org/lkml/2014/12/1/397, but
> there are no comments too :(

Sorry, guys, a lot of stuff going on in I2C. Bus recovery needs a more
generic look. I'll try, but can't promise for 4.1. If it fails 4.1., it
will get priority for 4.2.


--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVAF3JAAoJEBQN5MwUoCm2aJ4P/0yicustx36ntEKgx5Nr/zlB
4VBWkpM73JdL9ZRad7GalDxKAYOVXQnl53Q0zyNQ/cb++/UmrNOtLIL/cjYCDwQK
lYkk/yo6moqzaP1amT/NSDnPyHSxf5Z3V3c8+tt5gYdQ6uDeNzH+k8SpwGIxvYVN
UqL1K7+see1ZyVF1hZCco8j/V8wC8OcHVzpEVcAPtO4OkBTKVPUTTLBASliHIrDO
tSOzn/6FA0AU7jdMt0vbGWSXVPZdd0n6M77NaSyAz3lk9dm02Nx7zWj1+iM3Yzbq
4ZTmdFsL9taFKkrwsAyGzxctscwHplbCXW7S8QGGMe4Mppl2/7cyZ6++OLcWLoh4
atJh0E1kaZ+6B/UPBz5weMvgGP128yLz1zIul4VX1U5OZruOHzJ1CQK9Kpu9P9BS
rLevuL06OrRc65OHv3jrFijxFwLIU9H15CL6TntMB6TOCV5qsFUzrmhQ0/pN4dUE
exKqYCUjWsToAWtkukFM+r9VS5AsP/xHjls5N+YkdEx4sgBB6Yx2tgD5r4ulkBuj
2gFrdcwM4a3igeyJdYfBwffBESOdGjye6NGjJ4ddMr9NnXZuuMgpHO2N3Gyv1Vqg
WR0AkPcWBvY3Aqmtr69pfq8tQ5Mc8zrS/fYDVzxbYC3YKqDziWFuZZBz+POHvcEK
IOvvCIu33aSNzlVq5yTD
=sWb/
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--

From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH] mfd: Add TWL4030 PWM driver
Date: Wed, 21 Mar 2012 09:48:56 +0100
Message-ID: <20120321084856.GA17472@avionic-0098.mockup.avionic-design.de>
References: <1332262083-9375-1-git-send-email-walle@corscience.de>
 <201203202202.12060.arnd@arndb.de>
 <4F697201.1090206@bwalle.de>
 <201203210839.06258.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:49250 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752932Ab2CUItC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Mar 2012 04:49:02 -0400
Content-Disposition: inline
In-Reply-To: <201203210839.06258.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bernhard Walle <bernhard@bwalle.de>, Bernhard Walle <walle@corscience.de>, sameo@linux.intel.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Arnd Bergmann wrote:
> On Wednesday 21 March 2012, Bernhard Walle wrote:
> > Am 20.03.12 23:02, schrieb Arnd Bergmann:
> > > On Tuesday 20 March 2012, Bernhard Walle wrote:
> > >>
> > >> This PWM driver uses the PWM of the TWL4030. The driver for the TWL6=
030
> > >> PWM has been used as mode, but the PWM registers are different.
> > >>
> > >> The driver can be used and has been tested in conjunction with
> > >> pwm-backlight to control a backlight LED of a LCD touch screen.
> > >>
> > >> Signed-off-by: Bernhard Walle <walle@corscience.de>
> > >=20
> > > Since it's too late for v3.4 now and we will get a new pwm
> > > subsystem in v3.5, I suggest you change the driver to work
> > > register with that subsystem instead of just using the old
> > > header file. Note that drivers/mfd is not really the right
> > > place anyway, because this is not a multifunction driver but
> > > just one device driver that happens to be a slave of an mfd.
> >=20
> > Does that new subsystem already exist in some tree?
> =20
> Thierry Reding has been busily posting patches, so he probably has
> one that you can use, but I couldn't find it now.

I don't have a public tree anywhere. Does anyone have a recommendation where
I could set one up? github or gitorious are the first to come to my mind.

Thierry

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk9plfgACgkQZ+BJyKLjJp+oVwCgpj2ZSzvNTRmhsVW+1cmO07ek
4oEAoIPHh/23A5nbbK95PetCskZVUSN+
=gJls
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--

From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: PM(?) problems on v3.3-rc1 on OMAP3
Date: Tue, 24 Jan 2012 12:39:55 +0200
Message-ID: <1327401595.1838.13.camel@deskari>
References: <1327055619.1921.57.camel@deskari>
	 <CAAL8m4zYQmKAnzjfP2eQUyO3hJ3pig2H_jenC_WAWAogQ1JTbw@mail.gmail.com>
	 <1327060886.1921.63.camel@deskari>
	 <CAORVsuVenz_fUPp3o_x+xrN3JJXDUyreMNvqjCPGzLrQf71EnQ@mail.gmail.com>
	 <1327063256.1921.68.camel@deskari>
	 <CAORVsuVGT1AaMzo0r6T4vWe7zz7Uk=o-DydAcGdMzE+utDoUww@mail.gmail.com>
	 <1327071609.1921.82.camel@deskari> <20120122221132.32bd4d44@notabene.brown>
	 <1327308790.1916.30.camel@deskari>
	 <alpine.DEB.2.00.1201230154430.29673@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-o2+JXth9JDGiIDrYhzsH"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:53697 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755654Ab2AXKkB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jan 2012 05:40:01 -0500
Received: by mail-lpp01m010-f45.google.com with SMTP id o5so798120lah.4
        for <linux-omap@vger.kernel.org>; Tue, 24 Jan 2012 02:40:00 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1201230154430.29673@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: NeilBrown <neilb@suse.de>, Jean Pihet <jean.pihet@newoldbits.com>, Govindraj <govindraj.ti@gmail.com>, Kevin Hilman <khilman@ti.com>, t-kristo@ti.com, linux-omap mailing list <linux-omap@vger.kernel.org>, Joe Woodward <jw@terrafix.co.uk>


--=-o2+JXth9JDGiIDrYhzsH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-01-23 at 02:04 -0700, Paul Walmsley wrote:
> On Mon, 23 Jan 2012, Tomi Valkeinen wrote:
>=20
> > Then I noticed that the DISPC's ENWAKEUP is not set. Setting ENWAKEUP
> > (with SIDLEMODE/IDLEMODE in smart mode) also removes the problem.
>=20
> Sounds like you've nailed it.

By the way, there's still something funny with DSS powerdomain. As I
said in the original post:

> Second, I compile DSS as modules, and don't load them. Looking at
> debugfs/pm_debug/time, I can see that both RET and ON for dss_pwrdm are
> increasing. What is making DSS powerdomain switch back and forth?

I can see the above also after I've loaded and then unloaded the DSS
modules.

There seems to be usecount of one for dss_pwrdm (pm_debug/count shows
dss_clkdm->dss_pwrdm (1)) and usecount of 4 for dss_ick.

Any ideas? I remember somebody (Benoit?) saying that the
hwmod/omap_device code keeps ick allocated, but even so I'd presume that
DSS stays in RET is it's not used.

 Tomi


--=-o2+JXth9JDGiIDrYhzsH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPHop7AAoJEPo9qoy8lh71uUIQAIDbxNZaRe1eQa2Oqy/hK46k
LEugtZjlv7B0p9IvEUmmpWnEpURVqZ3pxHUauQ7wVTP50TNB+3F52DFiTRgVNe7b
U9QrV0LyzHAJB/OsCbvLkh08Qqzk/xFR4A6vFAWuEo1hOANBMGxbHp/PYVjZgJ6I
9RInaYF1R7z6uwpvaUPlFx5V5z+cwoJTHjX7JgwLtPWZs0A6BuPur0MsYl5LQjAJ
97HGoUxMlAYGnzk90trRV0yFkeaqcoX78OJ/e/zijJ7d5tiHo4+HeMcNpRjFv2+p
WCUnQfXgfRvNBZwIxXnErrQ1i1KKXBcVIjBLbZHcT7LxTxv9ZXKmo+0djdRiIzMt
Sa7h/PcbmuXHO1PP6ljPsXCEKz9kTa6J+yAimjLiDs01ijCKvhr/9gldFmX3wPym
/u5C8dpcIJfdYwn1OJ4GPg359h5nm4f40OHz2j2KF2mVfZ1PPE/jOI4Fn7ZZpS4r
xfu8zoTpIHbkMIVluKJjCbFJ7L2wIC0Z1jMkGoczXaZMEwIQQFvCk0eRb2iXxTSy
vKkFK0Fnlld9hihvii7vVH8pACAy0WREBD7xcbkzcZ0Q1jLffdCYIST8sqPRm8jR
Q+Lteotaa3lj25hDICsrpjk7RG76D4iYg9PYVyY+lo6kweYr+rH9LwC1agkYvU+n
9vlxDMBJIqnJ0IJ03k8g
=CaE2
-----END PGP SIGNATURE-----

--=-o2+JXth9JDGiIDrYhzsH--


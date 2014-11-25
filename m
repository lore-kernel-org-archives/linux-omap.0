From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: runtime check for omap-aes bus access permission (was: Re: 3.13-rc3 (commit 7ce93f3) breaks Nokia N900 DT boot)
Date: Tue, 25 Nov 2014 22:08:17 +0100
Message-ID: <201411252208.17594@pali>
References: <20131206213613.GA19648@earth.universe> <20131207230305.GA9103@earth.universe> <20131207232205.GS26766@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart202424656.jWZ6r7TPVW";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:44949 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751058AbaKYVIy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Nov 2014 16:08:54 -0500
Received: by mail-wi0-f173.google.com with SMTP id r20so10518359wiv.0
        for <linux-omap@vger.kernel.org>; Tue, 25 Nov 2014 13:08:53 -0800 (PST)
In-Reply-To: <20131207232205.GS26766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Joel Fernandes <joelf@ti.com>, Sebastian Reichel <sre@ring0.de>, Pavel Machek <pavel@ucw.cz>

--nextPart202424656.jWZ6r7TPVW
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sunday 08 December 2013 00:22:06 Tony Lindgren wrote:
> * Sebastian Reichel <sre@ring0.de> [131207 15:04]:
> > On Sat, Dec 07, 2013 at 01:11:37PM -0800, Tony Lindgren=20
wrote:
> > > > I asked Pali to send me his copy of the updated NOLO
> > > > bootloader, so that I can test this. I just checked the
> > > > omap documentation (I only have access to the public
> > > > one) and crypto related stuff is not documented for the
> > > > L3_PM_READ_PERMISSION register. There are a couple of
> > > > reserved bits, which may be used for this, though.
> > > >=20
> > > > I also CC'd Joel Fernandes, since he worked on the
> > > > driver before and may have access to the documentation.
> > >=20
> > > Looks like at least the 36xx public version referenced
> > > here has them:
> > >=20
> > > http://www.spinics.net/lists/linux-omap/msg21857.html
> > >=20
> > > I'd assume the registers are the same for 34xx since we
> > > don't have them defined separately in the kernel.
> >=20
> > I can't find it in the omap36xx documentation either. Maybe
> > I search at the wrong position. I tried to find something
> > crypto related in
> >=20
> > Table 9-89. L3_PM_READ_PERMISSION_i
>=20
> Hmm maybe it's done based on the address in
> L3_PM_ADDR_MATCH_k?
>=20
> I guess the thing to do would be to compare the register
> output between the two different firmware versions.
>=20
> Regards,
>=20
> Tony

Tony, if you can tell me how to read those registers I can=20
provide output from both bootloaders (one that enable aes support=20
in L3 firewall and one which not).

Also I can test other patches or provide other logs if you need=20
something more...

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart202424656.jWZ6r7TPVW
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlR078EACgkQi/DJPQPkQ1JHnACgtQ53vqzhiyWq/9+IRcOc0dH1
nTsAn00unw6BBnq5jo5yHSNhWINXe032
=18bD
-----END PGP SIGNATURE-----

--nextPart202424656.jWZ6r7TPVW--

From: green <greenfreedom10@gmail.com>
Subject: Re: n810 internal mmc boot
Date: Wed, 25 Mar 2009 15:26:31 -0600
Message-ID: <20090325212631.GG29844@swansys>
References: <20090228012717.GB4366@swansys> <20090321193355.GG20072@swansys> <20090325132610.a859abaf.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PyMzGVE0NRonI6bs"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.235]:48574 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719AbZCYV0Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Mar 2009 17:26:25 -0400
Received: by rv-out-0506.google.com with SMTP id g37so2399769rvb.5
        for <linux-omap@vger.kernel.org>; Wed, 25 Mar 2009 14:26:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090325132610.a859abaf.jarkko.nikula@nokia.com>
Content-Language: en
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux-OMAP List <linux-omap@vger.kernel.org>


--PyMzGVE0NRonI6bs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Jarkko Nikula wrote at 2009-03-25 05:26 -0600:
> green <greenfreedom10@gmail.com> wrote:
> > green wrote at 2009-02-27 18:27 -0700:
> > > Any news on booting n810 from internal mmc?  It hasn't worked for a
> > > while.
> >=20
> > The kernel detects the external mmc fine (for root=3D), but not the
> > internal... I'm just wondering whether any progress is being made or
> > expected.  Sorry if I'm being a nuisance.
>=20
> So it has been working at least sometime in linux-omap? I've been using
> prototype version of N810 with slightly different internal mmc and I
> have never noticed that internal mmc is working in linux-omap.

Yes, I was booting from internal mmc for a while.

If I remember correctly:
401b285 DOES work
cb4befa does NOT work

That is before/after the v2.6.29-rc1 merge.

I hope to verify this soon.  At least it is somewhere around those commits.

--PyMzGVE0NRonI6bs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknKoYcACgkQ682C+dBP+oTbpgCeN0Bn3mUAD5xQL+Q6hOp874QD
RooAoKhSE0sSkA1gX6vW3XdL9Mb2kyvu
=Nnle
-----END PGP SIGNATURE-----

--PyMzGVE0NRonI6bs--

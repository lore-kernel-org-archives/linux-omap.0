From: green <greenfreedom10@gmail.com>
Subject: Re: n810 internal mmc boot
Date: Mon, 18 May 2009 17:34:50 -0600
Message-ID: <20090518233450.GI23063@swansys>
References: <20090228012717.GB4366@swansys> <20090321193355.GG20072@swansys> <20090325132610.a859abaf.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qM81t570OJUP5TU/"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:53883 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740AbZERXeu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 May 2009 19:34:50 -0400
Received: by qw-out-2122.google.com with SMTP id 5so2752381qwd.37
        for <linux-omap@vger.kernel.org>; Mon, 18 May 2009 16:34:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090325132610.a859abaf.jarkko.nikula@nokia.com>
Content-Language: en
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux-OMAP List <linux-omap@vger.kernel.org>


--qM81t570OJUP5TU/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Jarkko Nikula wrote at 2009-03-25 05:26 -0600:
> On Sat, 21 Mar 2009 20:33:55 +0100 greenfreedom10@gmail.com wrote:
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

It must be 0cde345ce0861d8ac087e87cfbf6680f9b224a46 that broke it.  That co=
mmit=20
removes drivers/i2c/chips/menelaus.c, the linux-omap version of menelaus.  =
The=20
mainline version doesn't work for internal mmc on the n810.

--qM81t570OJUP5TU/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkoR8JoACgkQ682C+dBP+oSaSQCglTlZijqAV1ywx+EnY8M3bu13
tfEAnjFycifXO9gJPEoeJU7GT/YUh+Ec
=wSdN
-----END PGP SIGNATURE-----

--qM81t570OJUP5TU/--

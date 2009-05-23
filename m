From: green <greenfreedom10@gmail.com>
Subject: Re: n810 internal mmc boot
Date: Fri, 22 May 2009 21:44:15 -0600
Message-ID: <20090523034415.GP23063@swansys>
References: <20090228012717.GB4366@swansys> <20090321193355.GG20072@swansys> <20090325132610.a859abaf.jarkko.nikula@nokia.com> <20090325212631.GG29844@swansys>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0pkK7MCEo5hACTvx"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f176.google.com ([209.85.219.176]:64165 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755976AbZEWDo3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 May 2009 23:44:29 -0400
Received: by ewy24 with SMTP id 24so2194113ewy.37
        for <linux-omap@vger.kernel.org>; Fri, 22 May 2009 20:44:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090325212631.GG29844@swansys>
Content-Language: en
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux-OMAP List <linux-omap@vger.kernel.org>


--0pkK7MCEo5hACTvx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

green wrote at 2009-03-25 15:26 -0600:
> Jarkko Nikula wrote at 2009-03-25 05:26 -0600:
> > green <greenfreedom10@gmail.com> wrote:
> > > green wrote at 2009-02-27 18:27 -0700:
> > > > Any news on booting n810 from internal mmc?  It hasn't worked for a
> > > > while.
> > >=20
> > > The kernel detects the external mmc fine (for root=3D), but not the
> > > internal... I'm just wondering whether any progress is being made or
> > > expected.  Sorry if I'm being a nuisance.
> >=20
> > So it has been working at least sometime in linux-omap? I've been using
> > prototype version of N810 with slightly different internal mmc and I
> > have never noticed that internal mmc is working in linux-omap.
>=20
> Yes, I was booting from internal mmc for a while.
>=20
> If I remember correctly:
> 401b285 DOES work
> cb4befa does NOT work
>=20
> That is before/after the v2.6.29-rc1 merge.

At 401b285, does internal mmc work for you?

--0pkK7MCEo5hACTvx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkoXcQ8ACgkQ682C+dBP+oTnzwCfZoKmhr985wFrExZxuEcM3PXL
nYsAnjUWWXEbQMo806RxI8jLv4V3dU2S
=pHbt
-----END PGP SIGNATURE-----

--0pkK7MCEo5hACTvx--

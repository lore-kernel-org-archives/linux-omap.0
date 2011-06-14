From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 0/2] CBUS Patches
Date: Tue, 14 Jun 2011 16:14:16 +0300
Message-ID: <20110614131415.GM2353@legolas.emea.dhcp.ti.com>
References: <1307994058-25486-1-git-send-email-balbi@ti.com>
 <20110614100643.GM3352@atomide.com>
 <20110614131139.GE23145@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JHQpHJLVc+MIx2nb"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:53796 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751594Ab1FNNRH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Jun 2011 09:17:07 -0400
Received: by mail-ey0-f177.google.com with SMTP id 6so2373320eyh.36
        for <linux-omap@vger.kernel.org>; Tue, 14 Jun 2011 06:17:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110614131139.GE23145@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>


--JHQpHJLVc+MIx2nb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 14, 2011 at 06:11:39AM -0700, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [110614 03:02]:
> > * Felipe Balbi <balbi@ti.com> [110613 12:36]:
> > > Hi Tony,
> > >=20
> > > the following two patches get rid of
> > > the static global variable holding the
> > > bus context. It's not needed at all.
> > >=20
> > > This will allow us to have multiple
> > > CBUS buses by using different GPIOs.
> > >=20
> > > Will never be useful, but that's it
> > > should've been done anyway :-p
> >=20
> > OK cool applying to cbus branch.
>=20
> Hmm the second patch "cbus: pass device as argument" breaks
> booting on n800. Anyways pushed out already so that will
> need to be fixed in a separate patch.

any good dmesg output for me to take a look at ?

--=20
balbi

--JHQpHJLVc+MIx2nb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJN916nAAoJEAv8Txj19kN1YTgIAJe/n+Yb+0xe604MHcnKewk8
Kg2erSt8dbZl/c2HjcALUm6AHlXMlNjrKtQcMwotrn2iAOUhwXoxZ7UUzc11mJ9Z
OtGz3IGRK9Y6a4YT2x3xTGZ6XDKrAygnfOB/DKJkWK7wFPcxo3ct6B34HZYkph0w
yUVzJqFfTYr/SuDY40mH6uPUOV+s/hh4mkWLNLQngoujzuoOdRYaE9/JYE280e0e
IueTyv4a3vLHFUJKPhDNoUv1POdY2E91W/R7fXwJtQX0Y/KSxHzWZNraS6w1FUN/
7u9tM1FhyrE3i3hZ1plbLr0xwOEGy4W8d5cdBx2CUHL+DOVZqrIOLYIie6InC3E=
=CADi
-----END PGP SIGNATURE-----

--JHQpHJLVc+MIx2nb--

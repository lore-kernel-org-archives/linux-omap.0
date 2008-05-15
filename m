From: green <greenfreedom10@gmail.com>
Subject: Re: N810: linux-2.6.26-rc2-omap1 with muru.com N810 patches
Date: Thu, 15 May 2008 13:19:15 -0500
Message-ID: <20080515181915.GD8875@swansys>
References: <20080515140914.GA30594@swansys> <4530c67662adea689bad79e193a9323a@felipebalbi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3607uds81ZQvwCD0"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:53007 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764298AbYEOSZf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 May 2008 14:25:35 -0400
Received: by py-out-1112.google.com with SMTP id u52so471210pyb.10
        for <linux-omap@vger.kernel.org>; Thu, 15 May 2008 11:25:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4530c67662adea689bad79e193a9323a@felipebalbi.com>
Content-Language: en
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux-OMAP List <linux-omap@vger.kernel.org>


--3607uds81ZQvwCD0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2008.05.15, 136, Felipe Balbi wrote:
> > Always, one of these two happens after I flash the compiled zImage:
> >  - The NOKIA splash screen is displayed for about 20 seconds and then t=
he
> > N810=20
> > powers off.
> >  - The splash screen is shown for <1 second and the device resets (loop=
);
> > I=20
> > have to remove the battery.
>=20
> flasher --enable-rd-mode --set-rd-flags=3Dserial-console,no-lifeguard-res=
et
> -f

I had already done that, though not the serial-console one; I don't have an=
y=20
way to use it:

> > I have enable R&D mode on the N810 and disabled the lifeguard-reset fla=
g.

> > I've used 'make n800_defconfig' (2.6.26-rc2-omap1 +N810) and changed on=
ly
> > the=20
> > default cmdline without success.  Also I've used 'make
> > nokia_2420_defconfig'=20
> > with the maemo kernel.
>=20
> try also
> flasher --set-root-device mmc

I've tried this before, but can it really make any difference to whether th=
e=20
custom kernel boots?  The root device doesn't matter until after I have=20
successfully booted a kernel.

> > Oh, and one more question that I ought to know the answer to by now:
> > Is it okay to do 'make zImage', then change the config, then 'make
> zImage'
> >=20
> > again without doing a 'make clean', so long as nothing in the source has
> > been=20
> > changed?  That saves a lot of time.
>=20
> Yes, it's ok. ;-)

Great, thanks!

--3607uds81ZQvwCD0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFILH6j682C+dBP+oQRAqhiAKC58F7BgZZJDOKG1uCE65WXUVX4ywCbBY31
87i1k4SLF+UtoTYviDCkGCE=
=TucW
-----END PGP SIGNATURE-----

--3607uds81ZQvwCD0--

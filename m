From: "Maximilian Schwerin" <Maximilian.Schwerin@tigris.de>
Subject: AW: Beagleboard xM crashes when being set to 800MHz with smartreflex on linux-omap-3.6-rc6
Date: Mon, 8 Oct 2012 10:50:00 +0200
Message-ID: <5448984682E7954C9BFF27F747A9C6CA56E4CC@dolphin.TIGRIS.local>
References: <87391xbv52.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="=-MGQQCwjJBm8C2Hp400Yx"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www45.your-server.de ([213.133.104.45]:47222 "EHLO
	www45.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752628Ab2JHIuM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Oct 2012 04:50:12 -0400
Received: from [217.91.135.48] (helo=IT-AstaroSecurityGateway)
	by www45.your-server.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.74)
	(envelope-from <prvs=0628286935=maximilian.schwerin@tigris.de>)
	id 1TL92Q-0004fb-Hp
	for linux-omap@vger.kernel.org; Mon, 08 Oct 2012 10:50:10 +0200
In-Reply-To: <87391xbv52.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

--=-MGQQCwjJBm8C2Hp400Yx
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> -----Urspr=FCngliche Nachricht-----
> Von: Kevin Hilman [mailto:khilman@deeprootsystems.com]=20
> Gesendet: Dienstag, 2. Oktober 2012 02:00
> An: Maximilian Schwerin
> Cc: linux-omap@vger.kernel.org
> Betreff: Re: Beagleboard xM crashes when being set to 800MHz=20
> with smartreflex on linux-omap-3.6-rc6
>=20
> "Maximilian Schwerin" <Maximilian.Schwerin@tigris.de> writes:
>=20
> > Hi,
> >
> > I've just built a linux-omap kernel at 3.6-rc6 using=20
> omap2plus_defconfig
> > as basis for the kernel config.
> >
> > When I enable smartreflex and switch to 800MHz via
> >
> > echo 1 > /sys/kernel/debug/smartreflex/smartreflex_core/autocomp
> > echo 1 > /sys/kernel/debug/smartreflex/smartreflex_mpu_iva/autocomp
> > cpufreq-set -f 800MHz
> >
> > the board crashes. If I switch to 800MHz and enable=20
> smartreflex later
> > nothing happens. This used to work in my 3.3 based kernel.
>=20
> SmartReflex is kwown to be unstable in mainline and there are several
> errata that still need fixing for it to be stable.
>=20
> I strongly recommend you simply leave SR disabled.
>=20
> Kevin
>=20

So what does this mean for 800MHz and 1GHz? Is this not usable at all? =
Is there another kernel branch, that supports both frequencies? My =
customer needs 800MHz and 1GHz.

Cheers, m.=20

--=-MGQQCwjJBm8C2Hp400Yx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAlByk74ACgkQ6nqkzTWctv5OGQCbBIMEY0rysr1Q4bR9z5/1rB7T
U88An1CLXmTKtFBRzrJSP3YJto6eVuwQ
=8hpD
-----END PGP SIGNATURE-----

--=-MGQQCwjJBm8C2Hp400Yx--

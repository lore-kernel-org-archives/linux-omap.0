From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: some hwmod data patches for v3.16
Date: Fri, 16 May 2014 11:38:12 +0300
Message-ID: <5375CE74.6000603@ti.com>
References: <alpine.DEB.2.02.1405160444200.29738@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="DMiOGbnX7iUWaQlgmBl5ECIFdAQefGSnb"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42553 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756529AbaEPIik (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2014 04:38:40 -0400
In-Reply-To: <alpine.DEB.2.02.1405160444200.29738@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--DMiOGbnX7iUWaQlgmBl5ECIFdAQefGSnb
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On 16/05/14 07:45, Paul Walmsley wrote:
> Hi Tony
>=20
> The following changes since commit d1db0eea852497762cab43b905b879dfcd3b=
8987:
>=20
>   Linux 3.15-rc3 (2014-04-27 19:29:27 -0700)
>=20
> are available in the git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git fo=
r-v3.16/hwmod-a
>=20
> for you to fetch changes up to 433480707967187a74ced38bd38edba749998013=
:
>=20
>   ARM: OMAP2+: hwmod: OMAP5 DSS hwmod data (2014-05-14 12:26:10 -0600)
>=20
> ----------------------------------------------------------------
> First (and possibly last) set of hwmod data changes for v3.16.  This
> set should clean up some obsolete OMAP4 hwmod data, and add OMAP5 DSS
> support.

What about the AM43xx hwmod data I sent in the same series:

http://article.gmane.org/gmane.linux.ports.arm.omap/114192

 Tomi


--DMiOGbnX7iUWaQlgmBl5ECIFdAQefGSnb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTdc50AAoJEPo9qoy8lh71+zkP/R7Visw5kCv6CAJul/syyXnH
D2U1PnwBEe+8j1q2mUBU8eldCY0+Fkj2/uih0mMBPseFfWHg0c2XYQ8pbsvGZj4C
9TtEPnwCub/r5yGggZJ2UgYo8kTvDypF+VBCxqGYsMmsF0NPtOZbtom+ctPlUDBd
Xa6GRIkWgDlTa+66kh7qxUf6BkS+wksI9LCvQDwSP3BM0q3fhUXxM6bTiwTPR37v
b2+H9DtV9WKIHNgHXFM1W4b5q62ftrbiVEyhhctzUD4sBaOctbHR2wJRUgV6aO5o
lNsmulBrBvjWoZV+FbywnRTqD+YABBqOqQ/vRO8rwvnh8F472C5T0Cs0NrELRK+K
kMeam5ffJed0jXwcwML6oqL+sCHdMQ8VZGVQtP49ztd0W8jiky57DKlhDI5VjNGQ
JhNHIZ/tMWRECgi4oJVMMOt/iV7m27keeCNxWu4uMMXmQDxucVEtvfFfZofaZ3hH
pwTeX4wuFzE1iUqZI4eyolEux5vYMHn/Glwhfc1tO9rHVnW8UQrHeGzh2zSKdLEk
dEZHf8lGs3Z4y0wOoll/+lUUyIaP0b1lTWfrLcKpVrWclQBOlGmxqyjocP/dKal6
EtdkDz7G8ihgc2ylVB8G19ZzbmAbCBHJ+9z8wmh955Ce0CdKfqC1KlL5l392xuX9
pKSLiHh3XEv7ib6wSZmx
=Gb2a
-----END PGP SIGNATURE-----

--DMiOGbnX7iUWaQlgmBl5ECIFdAQefGSnb--

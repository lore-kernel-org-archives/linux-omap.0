From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: PM: core support for SMPS regulators for
 v3.4
Date: Fri, 9 Mar 2012 11:47:36 +0000
Message-ID: <20120309114731.GA3273@opensource.wolfsonmicro.com>
References: <877gywjhht.fsf@ti.com>
 <20120308021843.GQ12083@atomide.com>
 <87399jc6cj.fsf@ti.com>
 <20120309003217.GB12083@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:52746 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752299Ab2CILsA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Mar 2012 06:48:00 -0500
Content-Disposition: inline
In-Reply-To: <20120309003217.GB12083@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 08, 2012 at 04:32:18PM -0800, Tony Lindgren wrote:
> * Kevin Hilman <khilman@ti.com> [120308 09:37]:
> > Tony Lindgren <tony@atomide.com> writes:

> > Oh, that's because it depends on the regulator core changes that are in
> > Mark's regulator tree.  You need the for-next branch of :

> > git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git=20

> > For this to compile correctly.

> > Sorry, I should've been more clear above about the build dependency.

> Hmm just checking.. Recently Mark replied to Peter:

=2E..

> So can you guys please confirm that if is indeed an immutable
> commit to use as a base to merge in something?

Absolutely not, the for-next branch is rebuilt frequently especially
since it includes stuff sent to Linus and he complained about bugfixes
merged up into development code.  What is the actual dependency here?
The topic branches are more or less static, though some more than
others.

In general you should warn people if you've got a dependency on their
tree, it makes life easier.

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPWe3MAAoJEBus8iNuMP3dbwMP/3XANr+asMek4uWaF/x1zItR
A63wz4U/jRYtSbhrnI8enFhviqkV1iDpBYXtpscG7DxdnNk7aVIe1E7eDmGzaLnb
BirBbgISQCr0wlUtdel4KTaZUpxonZKKn50rgOlCrC5gxot9Htn840y0nw0QRuS7
xoo3Qp7VMhZuE264A+Nsp7/PTsJ0+FdZDkOSFQX2qOGxP14DhRrzgLtXfcbVNmjL
zM4okwaihx5FIl44Oa2Fa0RzSLzpcNWBk4NidMa0D0TtoIxD6iOd91ZQnd/DTcEk
oOtiwc/NaafNQ+QBy4xlMkx0gk8tiU99AozFw/AUXG9+GL7f37c+DXZ6dvDQi1Ut
ccLAiQTPwwKMHR2mZ2OuDaQz5sVU7HdQpwEo+g6bDkRbbFAmBK5/0xNqMVuWNRaF
vIdUjz9vx+T4639GKUKmT1uAmr8i57L0TR5ohgBN2wWFJXPXfc9q1Awshc4A4u83
2TBphHPFHe7uCeIQ6v/24fL1uCiTfb5lSvO0gRLQ9ueMEbamTK1Gt3KLptbGoBMG
xj1BF7nGU4tYLWh4RSTUrDW5zK8d5ldxWyYWc9YUQ83Fa8g5D4wCxrfwRqvXby8H
hsSlv21iaJjq3hfr+3+t8KlQ/rtoJPrZsBaH35AiOs7e0V+UEExk3/8mMijT9HKp
+nm5Tx+MtPY+fUelEgXN
=J7tu
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--

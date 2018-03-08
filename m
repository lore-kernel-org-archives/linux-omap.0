From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 00/45] arm Spectre fix backport review for LTS 4.9
Date: Thu, 8 Mar 2018 13:27:15 +0100
Message-ID: <20180308122715.GB21514@amd>
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Shi <alex.shi@linaro.org>, pali.rohar@gmail.com, sre@kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Resent without non-upstream patches.
>=20
> This backport patchset fixed the spectre issue, it's original branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=3D=
kpti
> A few dependency or fixingpatches are also picked up, if they are necessa=
ry
>  and no functional changes.
>=20
> No bug found from kernelci.org and lkft testing. It also could be gotten =
=66rom:
>=20
> git://git.linaro.org/kernel/linux-linaro-stable.git v4.9-spectre-upstream=
-only
>=20
> Comments are appreciated!

Not entirely related to this patched, but... I have few older ARM
boards here, and Nokia N9000 I really care about.

AFAICT Meltdown is arm64 only?

Spectre affects the older boards, too, right? Was there any work done
on that? cpuinfo says "ARMv7" for N900.

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqhLCMACgkQMOfwapXb+vKjNACeKpHd2stS7slqeiar3+0Blbi4
1jAAoIAlanyNXlwN2zVblKniBvT3FDbK
=OKfP
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--

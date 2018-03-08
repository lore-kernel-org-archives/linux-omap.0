From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 00/45] arm Spectre fix backport review for LTS 4.9
Date: Thu, 8 Mar 2018 18:01:53 +0100
Message-ID: <20180308170153.376gcwwudwkq3gs7@pali>
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
 <20180308122715.GB21514@amd>
 <20180308132139.apabmgw4magrp3d7@pali>
 <07d4709b-df73-0107-ce0f-5af55e34913e@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="xkebunayz44ustzl"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <07d4709b-df73-0107-ce0f-5af55e34913e@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Pavel Machek <pavel@ucw.cz>, Alex Shi <alex.shi@linaro.org>, sre@kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, Will Deacon <will.deacon@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--xkebunayz44ustzl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thursday 08 March 2018 13:35:49 Marc Zyngier wrote:
> On 08/03/18 13:21, Pali Roh=C3=A1r wrote:
> > On Thursday 08 March 2018 13:27:15 Pavel Machek wrote:
> >> Hi!
> >>
> >>> Resent without non-upstream patches.
> >>>
> >>> This backport patchset fixed the spectre issue, it's original branch:
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?=
h=3Dkpti
> >>> A few dependency or fixingpatches are also picked up, if they are nec=
essary
> >>>  and no functional changes.
> >>>
> >>> No bug found from kernelci.org and lkft testing. It also could be got=
ten from:
> >>>
> >>> git://git.linaro.org/kernel/linux-linaro-stable.git v4.9-spectre-upst=
ream-only
> >>>
> >>> Comments are appreciated!
> >>
> >> Not entirely related to this patched, but... I have few older ARM
> >> boards here, and Nokia N9000 I really care about.
> >>
> >> AFAICT Meltdown is arm64 only?
> >=20
> > IIRC ARMv7 is not affected by meltdown.
> >=20
> >> Spectre affects the older boards, too, right? Was there any work done
> >> on that? cpuinfo says "ARMv7" for N900.
> >=20
> > I remember that I saw some spectre patches for ARMv7 on LKML.

This is that patch series:
https://www.spinics.net/lists/arm-kernel/msg632065.html

> > In general for ARMv7 it is problematic as mitigation needs to change IBE
>=20
> Not quite. IBE is part of ACTLR, which is an implementation defined
> register, so generalizing this statement to "ARMv7" is plain wrong. Case
> in point: A9, A12/A17 do not need any bit to be set. A8 needs IBE to
> allow BPIALL to work, A15 needs it for ICIALLUI to perform a BP
> invalidation.

Ok, Nokia N900 has Cortex A8.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--xkebunayz44ustzl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCWqFsfgAKCRCL8Mk9A+RD
UsW0AJ99fseDeZ/ryk68VFMT4t/bAcrRpACeP5hLbA3/wfZZ80zRd7UwHmHFcwY=
=x89Z
-----END PGP SIGNATURE-----

--xkebunayz44ustzl--

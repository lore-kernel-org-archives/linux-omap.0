From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 00/45] arm Spectre fix backport review for LTS 4.9
Date: Thu, 8 Mar 2018 14:21:39 +0100
Message-ID: <20180308132139.apabmgw4magrp3d7@pali>
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
 <20180308122715.GB21514@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180308122715.GB21514@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Alex Shi <alex.shi@linaro.org>, sre@kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thursday 08 March 2018 13:27:15 Pavel Machek wrote:
> Hi!
>=20
> > Resent without non-upstream patches.
> >=20
> > This backport patchset fixed the spectre issue, it's original branch:
> > https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=
=3Dkpti
> > A few dependency or fixingpatches are also picked up, if they are neces=
sary
> >  and no functional changes.
> >=20
> > No bug found from kernelci.org and lkft testing. It also could be gotte=
n from:
> >=20
> > git://git.linaro.org/kernel/linux-linaro-stable.git v4.9-spectre-upstre=
am-only
> >=20
> > Comments are appreciated!
>=20
> Not entirely related to this patched, but... I have few older ARM
> boards here, and Nokia N9000 I really care about.
>=20
> AFAICT Meltdown is arm64 only?

IIRC ARMv7 is not affected by meltdown.

> Spectre affects the older boards, too, right? Was there any work done
> on that? cpuinfo says "ARMv7" for N900.

I remember that I saw some spectre patches for ARMv7 on LKML.

In general for ARMv7 it is problematic as mitigation needs to change IBE
bit which is not possible on OMAP HS devices. But for Nokia N900 there
is special code which do it via smc instruction (function
rx51_secure_update_aux_cr(), see also nokia_n900_legacy_init()).

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

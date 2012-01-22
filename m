From: NeilBrown <neilb@suse.de>
Subject: Re: PM(?) problems on v3.3-rc1 on OMAP3
Date: Sun, 22 Jan 2012 22:11:32 +1100
Message-ID: <20120122221132.32bd4d44@notabene.brown>
References: <1327055619.1921.57.camel@deskari>
	<CAAL8m4zYQmKAnzjfP2eQUyO3hJ3pig2H_jenC_WAWAogQ1JTbw@mail.gmail.com>
	<1327060886.1921.63.camel@deskari>
	<CAORVsuVenz_fUPp3o_x+xrN3JJXDUyreMNvqjCPGzLrQf71EnQ@mail.gmail.com>
	<1327063256.1921.68.camel@deskari>
	<CAORVsuVGT1AaMzo0r6T4vWe7zz7Uk=o-DydAcGdMzE+utDoUww@mail.gmail.com>
	<1327071609.1921.82.camel@deskari>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/8.W._=263HEx73BuR3_RmJz"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:46884 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751804Ab2AVLLw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 22 Jan 2012 06:11:52 -0500
In-Reply-To: <1327071609.1921.82.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, Govindraj <govindraj.ti@gmail.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, t-kristo@ti.com, linux-omap mailing list <linux-omap@vger.kernel.org>, Joe Woodward <jw@terrafix.co.uk>

--Sig_/8.W._=263HEx73BuR3_RmJz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 20 Jan 2012 17:00:09 +0200 Tomi Valkeinen <tomi.valkeinen@ti.com>
wrote:


> Hmm, So CPU_IDLE is also about other power domains than mpu? What does
> it do? The CONFIG_CPU_IDLE help text doesn't say much.

On OMAP3x, CPU_IDLE is about the MPU and CORE power domains .. and about PER
to some extent I think.

Different CPU_IDLE states put one or both of MPU and CORE into lower power
states (RET or OFF).  If a domain is turned off, then the code restores stu=
ff
afterwards.

But CPU_IDLE also does stuff with clocks, and I think this is where the iss=
ue
is.

I modified my kernel to refuse any CPU_IDLE state where MPU or CORE were
anything but ON - so only C1 and C2 were allowed.
I still had problems with DSS SYNC.

I then modified the C2 state so that it didn't allow the clocks to
auto-idle.  This is the main difference between C1 and C2 I think.

i.e. in omap3_enter_idle() in cpuidle34xx.c, I enforced the

		pwrdm_for_each_clkdm(mpu_pd, _cpuidle_deny_idle);
		pwrdm_for_each_clkdm(core_pd, _cpuidle_deny_idle);

and=20

		pwrdm_for_each_clkdm(mpu_pd, _cpuidle_allow_idle);
		pwrdm_for_each_clkdm(core_pd, _cpuidle_allow_idle);

loops for C1 - they are normally only active for C1.

This allowed DSS to work fine.  It also removed my issues with HDQ.

This code disables the auto-idling of some clocks ... not entirely sure of
the details.

So it seems that it isn't a low power state but rather some clock being
allowed to turn off which is the problem.

I guess I could selective try denying idle on each clock domain until I find
the one that is the problem..

NeilBrown

--Sig_/8.W._=263HEx73BuR3_RmJz
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBTxvu5Dnsnt1WYoG5AQKzoRAAlmQEvjhCqv+y6ctGAbyh+3vRQ/DChGww
warCh0+tffjdxwRb4/VrMgajiBiZ4I6beq69kb7UjZ3vhqB2yJSCRRSFx1jBm0IX
rcQRCMHmLdL15ORwieoS4A+z5KViDbf62BhOWHwS7z8xpFOruSmemmAH2kI74SuU
o7wPkZdQsgYBnjPNFlG5Aqg7qqBtF+bTjykvk5SwVICHqW4v4T54yRZWHMPtnRzy
rP1KPuoq6uMrHVN/Gfg5O+2+p2V4VIvaRgJMcKyGQwC3gLvCgIbMExmt++7E0RTE
2rM2IdsYdh9xu6Cr3+FzAq96M8MeHSdaIiYV6eLqRQEOpK7bl5ZGdZAnfW1xt6EU
Bhe1d3oYKyjZKlAMCNlXFtC7HDeEV1qMFMjXTVCZZJ58ACHW8HmhNMbtcXOquE2l
OMWEqyo+OAz/0Ka00/UZgfOFj1bBVFH3LoesGkopKUnKuDycoW3YN7l6gA4MeIf8
WOqikZJR74y/5TB7gAx7DlTPkgJY3nfaCI1Iy7kJ/Dt/VkhZJWqVvYH5UktLxogr
eFefT5xgGU7siWI/PcDe5RDEdG7s68HauB/w3jJxSMtyFBQBgVN8LzOKmBgtgktp
Y0N9AVd/RVDTHCDt3bzhAt0LcuUilO+dwjrdSNfV7DCgh37zEAHKUXNiUdnE5Jop
v2TrWPwKfjg=
=rMSW
-----END PGP SIGNATURE-----

--Sig_/8.W._=263HEx73BuR3_RmJz--

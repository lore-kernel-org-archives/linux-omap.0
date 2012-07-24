From: NeilBrown <neilb@suse.de>
Subject: Re: bisected regression: arm: omap3: voltage: fix channel
 configuration
Date: Tue, 24 Jul 2012 17:34:53 +1000
Message-ID: <20120724173453.01078466@notabene.brown>
References: <20120723210635.25e0a0d8@notabene.brown>
	<1343053494.30247.22.camel@sokoban>
	<20120724113057.5f38806e@notabene.brown>
	<1343111304.30247.43.camel@sokoban>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/wz04O7PJmG35mmDipPBAehC"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:45905 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755084Ab2GXHgt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jul 2012 03:36:49 -0400
In-Reply-To: <1343111304.30247.43.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org

--Sig_/wz04O7PJmG35mmDipPBAehC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 24 Jul 2012 09:28:24 +0300 Tero Kristo <t-kristo@ti.com> wrote:

> On Tue, 2012-07-24 at 11:30 +1000, NeilBrown wrote:

> > Might there be some way to get it to scale higher than 600MHz?
> > The first message from U-boot says:
> >=20
> > OMAP3630/3730-GP ES2.1, CPU-OPP2, L3-165MHz, Max CPU Clock 1 Ghz
> >=20
> > and the board manufacturer thinks it should be capable of 800MHz.
>=20
> You need to enable 800MHz OPP similarly to what is done in=20
> beagle_opp_init() in board-omap3beagle.c. I am not sure what your board
> is detected as, depends on your boot loader (check /proc/cpuinfo.)

Thanks!
Yes, my board identifies as cpu_is_omap3630() so that code looks relevant.
I copied the opp_init across to my board file, it runs without complaining
but it now gets to

[ ok ] Loading cpufreq kernel modules...done (none).
[....] CPUFreq Utilities: Setting ondemand CPUFreq governor...CPU0...


and hangs.  magic SYSRQ doesn't respond.

Any hints?

Thanks,
NeilBrown


#
# CPU Power Management
#

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=3Dy
CONFIG_CPU_FREQ_TABLE=3Dy
CONFIG_CPU_FREQ_STAT=3Dy
CONFIG_CPU_FREQ_STAT_DETAILS=3Dy
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE=3Dy
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=3Dy
CONFIG_CPU_FREQ_GOV_POWERSAVE=3Dy
CONFIG_CPU_FREQ_GOV_USERSPACE=3Dy
CONFIG_CPU_FREQ_GOV_ONDEMAND=3Dy
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=3Dy

#
# ARM CPU frequency scaling drivers
#
CONFIG_ARM_OMAP2PLUS_CPUFREQ=3Dy
# CONFIG_ARM_EXYNOS4210_CPUFREQ is not set
# CONFIG_ARM_EXYNOS4X12_CPUFREQ is not set
# CONFIG_ARM_EXYNOS5250_CPUFREQ is not set
CONFIG_CPU_IDLE=3Dy
CONFIG_CPU_IDLE_GOV_LADDER=3Dy
CONFIG_CPU_IDLE_GOV_MENU=3Dy

--Sig_/wz04O7PJmG35mmDipPBAehC
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIUAwUBUA5QHTnsnt1WYoG5AQI6pQ/4v0rNyb0oDhU9VJpAqIAEinCaiY2Y7sX+
p7ueFQ/E3x3GmqYzV0R3mpma0ppjumN3qHnscIrx5shPQBnA36JVmWtQzPneBh8C
1IhrH4MFb7JBsPr5ojuah8meqo8YvXekOPkhMq9pPfC/qBBXJvehNuBQmsq2f+a2
0spJqVSJYbLh86quXIrwHKMQUDLnuzeaGh3eSsPykmpcz+GrhYfDkA+GNbzGyrbO
lSEI48ktgqsp9Lt60Dd9SKirVoXTH1qyddXNFKGEsXsLDs7hf/amxkMcqNoyyJxu
7VlGjHqqGfH5iG3qoXZhWduVEPYTBdSALiaGIp80C7J0MGnmJXq58p0GjfdJ0Oq+
dGkY6x7QsffCMMVLaPbLeFU+vaMdFYJVxTiWHuAVtnXurdDqovTWmuXETBUrcJwT
lLjS+uPeZi3EIeTw/zUxztnyFTGltkWAqaJyYRZSvPIo2qreKWGw5ppL6jmB8WwO
SEla4FvT6uRAzGu9AaxL3ZM9xFiU5y4f+b4342xdhFISqh7YGqeXLYklpTuz7orI
jsft0zq/e0aSS+Ch1JEhGBdWTuu6M13fefM6/JUqYF17ceIuX0qZs3jtseatkMEE
BfyvjyMBe9TrTn+8sCl8utMv7thCUYtW/qxOQljr92yedkNzxZJ3R9cKHVL8aAg1
t/xcK+LXvw==
=gtjm
-----END PGP SIGNATURE-----

--Sig_/wz04O7PJmG35mmDipPBAehC--

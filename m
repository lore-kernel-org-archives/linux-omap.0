From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [git pull] Consolidate cpuidle functionality
Date: Fri, 9 Mar 2012 17:40:17 +1100
Message-ID: <20120309174017.081154936f57039b37c50435@canb.auug.org.au>
References: <1330562578-3410-1-git-send-email-rob.lee@linaro.org>
	<87y5reivhb.fsf@ti.com>
	<CAMXH7KEwQM37R++8moXB8Q41_fBXOnVY2hXJGFQmTQ20oeFPEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Fri__9_Mar_2012_17_40_17_+1100_s.1cezz0iw7EXb7M"
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CAMXH7KEwQM37R++8moXB8Q41_fBXOnVY2hXJGFQmTQ20oeFPEQ@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Rob Lee <rob.lee@linaro.org>
Cc: rjw@sisk.pl, len.brown@intel.com, nicolas.pitre@linaro.org, venki@google.com, linaro-dev@lists.linaro.org, linux-sh@vger.kernel.org, tony@atomide.com, nicolas.ferre@atmel.com, linux@arm.linux.org.uk, ccross@google.com, kernel@wantstofly.org, kgene.kim@samsung.com, mturquette@linaro.org, daniel.lezcano@linaro.org, magnus.damm@gmail.com, arnd.bergmann@linaro.org, jon-hunter@ti.com, patches@linaro.org, nsekhar@ti.com, jean.pihet@newoldbits.com, Baohua.Song@csr.com, vincent.guittot@linaro.org, linux-omap@vger.kernel.org, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org, deepthi@linux.vnet.ibm.com, g.trinabh@gmail.com, linux-pm@vger.kernel.org, broonie@opensource.wolfsonmicro.com, amit.kucheria@linaro.org, lethal@linux-sh.org, amit.kachhap@linaro.org, Kevin Hilman <khilman@ti.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

--Signature=_Fri__9_Mar_2012_17_40_17_+1100_s.1cezz0iw7EXb7M
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On Thu, 8 Mar 2012 19:58:23 -0600 Rob Lee <rob.lee@linaro.org> wrote:
>
>   git://git.linaro.org/people/rob_lee/linux.git cpuidle_consol_pull
>=20
> These changes move various functionality duplicated in platform
> cpuidle drivers to the core cpuidle driver and common arch arm code. Also,
> the irq disabling in the platform code was removed as all calls into
> cpuidle_call_idle() will have already called local_irq_disable().
>=20
> This patchset is bisect safe.  Also, the core cpuidle and arch changes of=
 the
> first commit do not require any changes to the arch and platform cpuidle
> drivers, though those arch and platform change should be made to take
> advantage of the new consolidation function.
>=20
> Stephen, this patch has been reviewed, tested, and ACK'd per the list abo=
ve but
> cpuidle maintainer Len Brown has been out on vacation for a couple of wee=
ks so
> I am sending you this pull request as time is running out to get this into
> v3.4.  I've had a brief communication with Andrew Morton about
> this as well so he is aware of this situation.  I am fairly new to the
> community so please let me know if you see anything that needs my attenti=
on or
> anything I should be doing differently.

I will add this tree from today.  Lets see if anyone screams.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgment of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
	Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

Legal Stuff:
By participating in linux-next, your subsystem tree contributions are
public and will be included in the linux-next trees.  You may be sent
e-mail messages indicating errors or other issues when the
patches/commits from your subsystem tree are merged and tested in
linux-next.  These messages may also be cross-posted to the linux-next
mailing list, the linux-kernel mailing list, etc.  The linux-next tree
project and IBM (my employer) make no warranties regarding the linux-next
project, the testing procedures, the results, the e-mails, etc.  If you
don't agree to these ground rules, let me know and I'll remove your tree
from participation in linux-next.

--Signature=_Fri__9_Mar_2012_17_40_17_+1100_s.1cezz0iw7EXb7M
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPWaXRAAoJEECxmPOUX5FEG8wP/3yuuKTi0q50yYdS5P5YTniy
kcqPNEPr6BFSSwn/Xl2jPl84y4TwnSon4vb1jTnSL6fLvynGih9gpQiHq+HqA16C
VuxoqO/j73IDppj5Iwo1x7mBt7A9wpD5hKyktkAvhgdcebgPvWIKFMGzwN4nSgzz
NJM4I/D1oLfi98Z9dYiku3Ke4CFX62MjEBp5GM2BYeOsiSbJS5pEnY2xPOxfQ+Tl
75OhNj1QAQpX5rFQmLcrQtkq65B7XBwmNln34o1QQR3XUm1aC4z5TWTKnyA0jg0n
1LgDZitrmRcHfyTdo/VAHwPHL0O0WLRpurz8CXgZ1CI0WTbWnDvzqN2PBaKWe8vm
gN97Sb+KLpx7BS/j5e/erE+qL9IsGtck738u1RCnm8BLqOIUUpr4zbaBR2hNHWzD
kjU6fvbF/BXy0LM6E33ijmV1lUGTPGu4NrGRw0v9RQXZCKQQcbyE4a8edVp81FHP
opMra2iEPVczhBZpHWB/RcuczA2RK426uI+QMcCBCWinWkzduLPw96+FxeSsmB3z
uOkExrqAvhQtdwsPKiq4nJgwdiCzYfNPBqhTJxBZruYMenRbmoHFjCCCMd5w4Ihr
GUZThNtZ/qsBBEIKteFMCYQsLfQRw/z9KQkWA1D0o1Bztg81iU6rYW7RLzeXmz1Q
UUWG9shxJzD3auGISdWm
=cCwu
-----END PGP SIGNATURE-----

--Signature=_Fri__9_Mar_2012_17_40_17_+1100_s.1cezz0iw7EXb7M--

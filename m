From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 6/8] ARM: time: Provide read_boot_clock64() and
 read_persistent_clock64()
Date: Wed, 11 Mar 2015 09:53:58 +0100
Message-ID: <20150311085357.GC19577@ulmo.nvidia.com>
References: <1426044277-22170-1-git-send-email-xlpang@126.com>
 <1426044277-22170-2-git-send-email-xlpang@126.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Fig2xvG2VGoz8o/s"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1426044277-22170-2-git-send-email-xlpang@126.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xunlei Pang <xlpang@126.com>
Cc: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com, Thomas Gleixner <tglx@linutronix.de>, Alessandro Zummo <a.zummo@towertech.it>, John Stultz <john.stultz@linaro.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-tegra@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, linux390@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Ralf Baechle <ralf@linux-mips.org>, Arnd Bergmann <arnd@arndb.de>, Xunlei Pang <pang.xunlei@linaro.org>
List-Id: linux-omap@vger.kernel.org


--Fig2xvG2VGoz8o/s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2015 at 11:24:35AM +0800, Xunlei Pang wrote:
> From: Xunlei Pang <pang.xunlei@linaro.org>
>=20
> As part of addressing "y2038 problem" for in-kernel uses, this
> patch converts read_boot_clock() to read_boot_clock64() and
> read_persistent_clock() to read_persistent_clock64() using
> timespec64 by converting clock_access_fn to use timespec64.
>=20
> Signed-off-by: Xunlei Pang <pang.xunlei@linaro.org>
> ---
>  arch/arm/include/asm/mach/time.h    |  3 +--
>  arch/arm/kernel/time.c              |  6 +++---
>  arch/arm/plat-omap/counter_32k.c    | 10 +---------
>  drivers/clocksource/tegra20_timer.c | 10 +---------
>  4 files changed, 6 insertions(+), 23 deletions(-)

For the Tegra part:

Acked-by: Thierry Reding <treding@nvidia.com>

--Fig2xvG2VGoz8o/s
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVAAKlAAoJEN0jrNd/PrOhmOIQAKG1KccIgobtNXnI0FEYailH
6s6NI2k9Le8h0/+//4LTfreJ5FY0HgOtWKC1x+/CvDrOporofJzUEEhI+y2xB5Qb
FSOCUuGa7efmN6QqG9hzzI7BMjQp2N02N95S8MWTVAmhtG1O55xrH4QMu9Xxmxsb
q7uADlgyql8mR6ux3YtMuNwDzoXUktD7g9lImLipVOjLUuX1eOhEzr1/dUcbXaro
TLivSzpcytBrRih6iQe52N25KiBlAmdJzQHwtgyZvhhpioxMW7+kqiF3XrI1pAHO
5irQUyIaUTa5aWiF7jqePw0fjNvcEQ4DfWfv8z7jYT2U/W7sK4bMpgJUGEXaDlP3
0MRTlm59Y7guJdLOC7eK291a7DZ59uQqCsoxhOby+EE5/SLNgPvXa2GGeLgQEQBe
YDVjCe1leeAeTmI2f8TmrFtdbgo5yi0Tj3qN9mdh9uSIq9bqH9U6CXSbgZ3uqDqq
tQyhzbhJmiB64J4gDhxTXaK+mZITJyXXPqkldQ18SeIlKNpxKWEM8x5RR6Z/vKFn
Opn9rcm9tlIgKPPtYXe/PAICDr4v4osiyqJ0KmnNVHxtFQPxmUu0heS7IVSRaK2z
87AdxNUYopiFlcHA9XZKFlrSxUCx4rh0PPlixFkklZ/ANQ2WgBwhX+j55vE6TL6R
eg3aCiOjPdeiCYER0TN1
=zTtO
-----END PGP SIGNATURE-----

--Fig2xvG2VGoz8o/s--

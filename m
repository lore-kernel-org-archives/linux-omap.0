From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 5/8] ARM: tegra: clock: Provide y2038-safe
 tegra_read_persistent_clock() replacement
Date: Wed, 11 Mar 2015 09:52:20 +0100
Message-ID: <20150311085218.GB19577@ulmo.nvidia.com>
References: <1426044277-22170-1-git-send-email-xlpang@126.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NDin8bjvE/0mNLFQ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1426044277-22170-1-git-send-email-xlpang@126.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xunlei Pang <xlpang@126.com>
Cc: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com, Thomas Gleixner <tglx@linutronix.de>, Alessandro Zummo <a.zummo@towertech.it>, John Stultz <john.stultz@linaro.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-tegra@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, linux390@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Ralf Baechle <ralf@linux-mips.org>, Arnd Bergmann <arnd@arndb.de>, Xunlei Pang <pang.xunlei@linaro.org>
List-Id: linux-omap@vger.kernel.org


--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2015 at 11:24:34AM +0800, Xunlei Pang wrote:
> From: Xunlei Pang <pang.xunlei@linaro.org>
>=20
> As part of addressing "y2038 problem" for in-kernel uses, this
> patch adds the y2038-safe tegra_read_persistent_clock64() using
> timespec64.
>=20
> Because we rely on some subsequent changes to convert arm multiarch
> support, tegra_read_persistent_clock() will be removed then.
>=20
> Signed-off-by: Xunlei Pang <pang.xunlei@linaro.org>
> ---
>  drivers/clocksource/tegra20_timer.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--NDin8bjvE/0mNLFQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVAAJCAAoJEN0jrNd/PrOhjfEP/0kAwCDVBYdY0lhoqPZBpKWD
FADLjCfUVObEYDL3vQmdBan6N0OshCRcKsXIO3SNvaDRlrZb+6/BQGfiZc0wfcIc
661n7hqYcoiZR8Fwl5TCJCFGBu0RtZv60VktdTRHigFNz60kjJiaDkg6AkoCOKRA
zbDTWlYWgN6J6HDgmhsrSvt2mmyRAhsF07iiyEQGvZFYf73mp1bUcXqHtPHXSImp
wIyTtc9jXFnEVVSdWkK+5/rtIe39eaI5qRXo/vIfD6ZMOGJj0nc92NSqxzV5ycoK
Ygs84OeM8Lw1ag3s3zYw7DImOyliDCzN5a1Qj3P45GmbTImbgcR3Pvf9tno4Zp/f
ex66Rtbo8AYN6GXna6M43QtQrHRgr3KQOwYhUu+A6DJXClb4kb4Fs5tXrFQUkbN+
WjXIogIHqp1/zq14u9oSbPZFWZDQUHK3baNTGQrbeVpWAl4aWOZM34Eixvx8En3u
wOCpD552nGYcYmQHBQKt5wTi/tyA2PW6jgFNmJHZ3CLGM+SW7otYL1XpBF9H4w59
xH8bN2SDT0a0ojNHL5+UA0H06K0SM9yJvK9TSk59DPGlFYfjzI1td+CCH0D13fHt
UeYXNL+xdWntw36egkUtZKmwwEFOYYHOsc8dT6nX6H7eaoUxoFWltrXdkkD3iCta
DmulVxXg3lqOP4z179TL
=8Bdv
-----END PGP SIGNATURE-----

--NDin8bjvE/0mNLFQ--

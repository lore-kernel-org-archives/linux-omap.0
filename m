From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/4] pwm: omap-dmtimer: fix inaccurate period/duty_cycle
 calculation
Date: Fri, 4 Mar 2016 16:17:48 +0100
Message-ID: <20160304151748.GD26400@ulmo.nvidia.com>
References: <1454128014-22866-1-git-send-email-drivshin.allworx@gmail.com>
 <1454128014-22866-2-git-send-email-drivshin.allworx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="d9ADC0YsG2v16Js0"
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1454128014-22866-2-git-send-email-drivshin.allworx@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
To: "David Rivshin (Allworx)" <drivshin.allworx@gmail.com>
Cc: linux-pwm@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Grant Erickson <marathon96@gmail.com>, NeilBrown <neilb@suse.de>, Joachim Eastwood <manabian@gmail.com>
List-Id: linux-omap@vger.kernel.org


--d9ADC0YsG2v16Js0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 29, 2016 at 11:26:51PM -0500, David Rivshin (Allworx) wrote:
> From: David Rivshin <drivshin@allworx.com>
>=20
> Fix the calculation of load_value and match_value. Currently they
> are slightly too low, which produces a noticeably wrong PWM rate with
> sufficiently short periods (i.e. when 1/period approaches clk_rate/2).
>=20
> Example:
>  clk_rate=3D32768Hz, period=3D122070ns, duty_cycle=3D61035ns (8192Hz/50% =
PWM)
>  Correct values: load =3D 0xfffffffc, match =3D 0xfffffffd
>  Current values: load =3D 0xfffffffa, match =3D 0xfffffffc
>  effective PWM: period=3D183105ns, duty_cycle=3D91553ns (5461Hz/50% PWM)
>=20
> Fixes: 6604c6556db9 ("pwm: Add PWM driver for OMAP using dual-mode timers=
")
> Signed-off-by: David Rivshin <drivshin@allworx.com>
> ---
>  drivers/pwm/pwm-omap-dmtimer.c | 27 ++++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 7 deletions(-)

Applied, thanks.

Thierry

--d9ADC0YsG2v16Js0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJW2accAAoJEN0jrNd/PrOhLEIP/1mPWKKyRJ7eU6XGcUhlkDJP
FfQ90nkLZRTEEKBT9xT58nt3va8EY2gTRu67tsP6gyzuvac08lXcAMr6egqQziW3
wx1EplEw1PkySbgDaToXKejmNQS+VYComeK0jPXbFlZRl1WF0VS61h39CoN75gCX
BaBap5IzMccaC2nCWfSQk964zUG2OBOmb+rEJrmp0ZLFqyXH3lLN3G1Kd5wd3nRh
MlvghLrykPm79zW+XDOfa5+/gRhMMt/kVAG40x74vWsTLGQm+zpms7R9PBuNJV1n
HjTbAoE4klPryroSf6gIUhqVD2QyyM/vsaR+8kExR4HU6YWAYfG0rdtuhTbzPul+
T6KNo3JJxmkfDWle/rzzE3cKJ/1DDzET97wWftM3q1TrL5dICIhCxuiPHERTi5mM
32P2o0gT2cFJ9S/A6U+A9RMSEQiDhQl1HCTy1zpLR/EsmBdbIBxqGbY/ArafwGfK
McC+Hhw9G6OTPH5x5letGdHxBR25FkglGOrPd2oGwPRrEq+VKg/Tk9+c0D65eQu6
GmKL3Cf/jYp+ibgmteZ+EszsAL/8zplyCVOTwMvgj9VxG5bri6+Cp9OoK3qpZp3x
anfDlvQLasGJG3bgDjGujL0Nve2NiSnBdR7qCjS8E0wGvF1Bf7H/es0mMEywqXww
PTI6TGbrgC2+H+Q7DnEL
=9JMa
-----END PGP SIGNATURE-----

--d9ADC0YsG2v16Js0--

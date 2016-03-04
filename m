From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 3/4] pwm: omap-dmtimer: round load and match values
 rather than truncate
Date: Fri, 4 Mar 2016 16:18:04 +0100
Message-ID: <20160304151804.GE26400@ulmo.nvidia.com>
References: <1454128014-22866-1-git-send-email-drivshin.allworx@gmail.com>
 <1454128014-22866-4-git-send-email-drivshin.allworx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MIdTMoZhcV1D07fI"
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1454128014-22866-4-git-send-email-drivshin.allworx@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
To: "David Rivshin (Allworx)" <drivshin.allworx@gmail.com>
Cc: linux-pwm@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Grant Erickson <marathon96@gmail.com>, NeilBrown <neilb@suse.de>, Joachim Eastwood <manabian@gmail.com>
List-Id: linux-omap@vger.kernel.org


--MIdTMoZhcV1D07fI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 29, 2016 at 11:26:53PM -0500, David Rivshin (Allworx) wrote:
> From: David Rivshin <drivshin@allworx.com>
>=20
> When converting period and duty_cycle from nanoseconds to fclk cycles,
> the error introduced by the integer division can be appreciable, especial=
ly
> in the case of slow fclk or short period. Use DIV_ROUND_CLOSEST_ULL() so
> that the error is kept to +/- 0.5 clock cycles.
>=20
> Fixes: 6604c6556db9 ("pwm: Add PWM driver for OMAP using dual-mode timers=
")
> Signed-off-by: David Rivshin <drivshin@allworx.com>
> ---
>  drivers/pwm/pwm-omap-dmtimer.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

Applied, thanks.

Thierry

--MIdTMoZhcV1D07fI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJW2acsAAoJEN0jrNd/PrOhbK8P/RQgnMBY3In60Amg/a06NVbJ
srQHnMecJ6EZj8sFBfg44cjyLvzdrm0Q2OC6NmtV4A9lsZ6uCGdW4OQSlwUd+ElQ
n+nhYNQrF63nB18hKZf/KtuuqrngPgAq860M10n2pRpHrTxrP6F23iacy4sH6vdF
sMOOVoAqTt7d1/61sIXgalnJkM2OjQhNyXcB/kbFMfLiPjPrp4ryTS0/bCmVss33
U2XBUbe9MvYcwQTbqFiE91cVT0KCA9Ca2tle6pBhOPadC37HIDHU+b6bp9jkHt6h
ijZ6KPzHDI9yN4q3U1AyPBPx8/Z9Ip/bmc5xp+v7xSFSIncvyU1AH4/i0VbKHxnG
Yct1O/Pq+Y+ZQ9DWr6OPlgKeGQrw9doEdYfZewKBbCNl9Tx3MrRopYITsWo2aP8s
/FkdG1RKf0HVYcBfGfFhPVsHsK36m9s2eQqhwFhf7iKCpxvF4cCy3H69oqq63kih
+g+H9KfxMYP24lDXis4rqKl+QfyxRkMeOwSadvNX8yxDfz9apYOpzeJYKyufZ0ID
Msn2vHYKxcvUt4QtEqyPKs3AP4cKgC8JdqvF/RbfiVAKVrI1zhCZUosN1rzKEFNI
QXaFH3253nzHOed8EOa3QfNBNMKd5OM/loKDKGoc25igBblLAZcts/wqWBsJcDGd
8ptiLpo5s824PDMkpsuw
=VAH1
-----END PGP SIGNATURE-----

--MIdTMoZhcV1D07fI--

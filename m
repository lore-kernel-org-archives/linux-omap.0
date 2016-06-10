From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 3/3] pwm: pwm-tiehrpwm: Update dt binding document to
 use generic node name
Date: Fri, 10 Jun 2016 14:37:57 +0200
Message-ID: <20160610123757.GC27142@ulmo.ba.sec>
References: <1458263723-25770-1-git-send-email-fcooper@ti.com>
 <1458263723-25770-4-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KDt/GgjP6HVcx58l"
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1458263723-25770-4-git-send-email-fcooper@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Franklin S Cooper Jr <fcooper@ti.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, bcousson@baylibre.com, tony@atomide.com, linux@arm.linux.org.uk, t-kristo@ti.com, mturquette@baylibre.com, sboyd@codeaurora.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--KDt/GgjP6HVcx58l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 17, 2016 at 08:15:23PM -0500, Franklin S Cooper Jr wrote:
> Now that the node name has been changed from ehrpwm to pwm the document
> should show this proper usage. Also change the unit address in the example
> from 0 to the proper physical address value that should be used.
>=20
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> ---
> Version 3 changes:
> N/A
>=20
> Version 2 changes:
> Changed the unit address for da850 to match the value in the reg property.
>=20
>  Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

Thierry

--KDt/GgjP6HVcx58l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXWrSjAAoJEN0jrNd/PrOhltEP/2Sj6ewFRIuy/jeWy82CsRdZ
l8rHNHpSm/mTHupAuDlLLkkEZVV1rxUkAnHRjUSCP7McirTHvL9KwOb52KOIzBBM
ODOJrJJQxZOGLgZkb2jKA6bAhHs8t1ziob8gTFMjZ4hQfJbwdNav5oWK9OhJMCBI
rmPWKcwlQMeE2PM1YdiSqfcfZQnBRSvhSZkX1PfXl0mSAKMke0LSWUyZwtKK38af
yhk9iRoB2c9j+tyKjnZzjQt33bygUIF80mpwbkKFaOTKxQ9xb3hY8qfTvYZ9gRaQ
hQJQvZQ7BHTY0zQTLz6AFkdTh5UDBpz0HmoaUXRhivGdrVh0wGXoSBcOOj3vfUj4
4jl3PioIYufjjsXVk0hFYorrbNd1QI247cBH948N4vcdFYyB2fnL/+JdOTtPGbsy
mZ+O7dP0JntU231yjEyiJRbuZ+gTPBbQ+M+HGUwq0HsB0901MJ/LJG9Ly7O82Vdv
J/PQ85KhY1snpCplGG966XfiM8k2HnJeTGyOUEZbmysO30SCr1LnRMGXiEuqmWKI
tP14X42iQ1/iwLEIlwJ/zj5J9ivkuK8fyoZInYt9zcYnaanBeXnRuLgyR2iJl+aP
BNnXJtiox9krY5e5ndOdztT7DnjzWv6OQRM3cTP69YFp0EwQjy34D5RhNJHJ/4m9
k1qRDz7wLlCRr/JpLkam
=2+ii
-----END PGP SIGNATURE-----

--KDt/GgjP6HVcx58l--

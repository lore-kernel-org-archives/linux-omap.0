From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 2/2] clk: Convert __clk_get_name(hw->clk) to
 clk_hw_get_name(hw)
Date: Thu, 13 Aug 2015 11:07:32 +0200
Message-ID: <20150813090731.GC21716@ulmo>
References: <1439421161-17868-1-git-send-email-sboyd@codeaurora.org>
 <1439421161-17868-2-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oJ71EGRlYNjSvfq7"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1439421161-17868-2-git-send-email-sboyd@codeaurora.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Mike Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, Tero Kristo <t-kristo@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Bresticker <abrestic@chromium.org>, Ezequiel Garcia <ezequiel.garcia@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, Kevin Cernekee <cernekee@chromium.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kernel.orglinu
List-Id: linux-omap@vger.kernel.org


--oJ71EGRlYNjSvfq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2015 at 04:12:41PM -0700, Stephen Boyd wrote:
> Use the provider based method to get a clock's name so that we
> can get rid of the clk member in struct clk_hw one day. Mostly
> converted with the following coccinelle script.
>=20
> @@
> struct clk_hw *E;
> @@
>=20
> -__clk_get_name(E->clk)
> +clk_hw_get_name(E)
>=20
[...]
>  drivers/clk/tegra/clk-pll.c          |  8 ++++----

Acked-by: Thierry Reding <treding@nvidia.com>

--oJ71EGRlYNjSvfq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVzF5SAAoJEN0jrNd/PrOhHT0P/iJrUUYIutPfBNvH8txerL+7
xnmwuEmllVmcxsJsk8a+CogZtFbkZQvYifmGh2IlSy9XcsOsDruHgdsp1330NSr0
Fuh7nla7Ygt7L98jGh+8Dplpiy9le6F3n4Wr5YWgsXZ2cUgpihp8hSRynx4arTYn
zmK//oqvSarKhzChh4bjUwHH0f5GZwt9amftL1QY1nwinuVHN3VTz2j6GFoGki3J
KC6+PD9KvHiqxjmZbiDe8PNk3gph6qZj2g6g9BZAn1oHy2HwIYPyG964kgjuVwSw
g4wfSg51pDuQW/LQgh53bRo9wrnbCc3Lb8DwlWzlc99fwIKuPC09A7pC01/8sQl8
09WOSh9v9O5+Df+lMzp0wV0021KrfEWeZTHlMo5zKHVF5yTbF6q0pxrJ5kysxkKz
MtbpCqWXtpER0OVPl7Ekj0l3f3b7N4ZeqWvqcaHD3WTPrS9h2tmE4SLyErtfEaMH
NW7icXmC3vZ2keQL6ffjQgrNs110h3zSy1yC0znHl2ofFsJSmlGvk5qiS81oW0j5
QE5pSbT5tacz6EvOQA92waF4rDPn2gWzy0vyPhhHHIEQUmDrkGotzGyorAgULLqO
s1ka0NDRwZ+DswuRd+KEKU/XC5IyBp/9EK2fAIzx5qG4spBwj5pN3gDEmY7WzuiG
IYTtgeucC9Ose6KTNzjn
=QsVn
-----END PGP SIGNATURE-----

--oJ71EGRlYNjSvfq7--

From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH] clk: Convert to using %pOF instead of full_name
Date: Wed, 19 Jul 2017 08:23:01 +0200
Message-ID: <20170719062301.bextqsjufe7gjozt@flea>
References: <20170718214339.7774-12-robh@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="l25m4zfpvpydcgma"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170718214339.7774-12-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Russell King <linux@armlinux.org.uk>, Matthias Brugger <matthias.bgg@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Chen-Yu Tsai <wens@csie.org>, Emilio =?iso-8859-1?Q?L=F3pez?= <emilio@elopez.com.ar>, Peter De Schrijver <pdeschrijver@nvidia.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Tero Kristo <t-kristo@ti.com>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-renesas-soc
List-Id: linux-omap@vger.kernel.org


--l25m4zfpvpydcgma
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 18, 2017 at 04:42:52PM -0500, Rob Herring wrote:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: "Emilio L=F3pez" <emilio@elopez.com.ar>
> Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
> Cc: Prashant Gaikwad <pgaikwad@nvidia.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mediatek@lists.infradead.org
> Cc: linux-renesas-soc@vger.kernel.org
> Cc: linux-tegra@vger.kernel.org
> Cc: linux-omap@vger.kernel.org
> ---
>  drivers/clk/berlin/bg2.c             |  3 +--
>  drivers/clk/berlin/bg2q.c            |  7 +++----
>  drivers/clk/clk-asm9260.c            |  4 ++--
>  drivers/clk/clk-conf.c               | 16 ++++++++--------
>  drivers/clk/clk-moxart.c             | 12 ++++++------
>  drivers/clk/clk-qoriq.c              |  7 +++----
>  drivers/clk/clk-stm32f4.c            |  4 ++--
>  drivers/clk/clk-xgene.c              | 15 ++++++---------
>  drivers/clk/clk.c                    |  4 ++--
>  drivers/clk/clkdev.c                 |  4 ++--
>  drivers/clk/mediatek/clk-cpumux.c    |  2 +-
>  drivers/clk/mediatek/clk-mtk.c       |  2 +-
>  drivers/clk/mediatek/reset.c         |  2 +-
>  drivers/clk/renesas/clk-mstp.c       |  2 +-
>  drivers/clk/renesas/clk-rcar-gen2.c  |  3 +--
>  drivers/clk/sunxi-ng/ccu-sun5i.c     |  3 +--
>  drivers/clk/sunxi-ng/ccu-sun6i-a31.c |  3 +--
>  drivers/clk/sunxi-ng/ccu-sun8i-a23.c |  3 +--
>  drivers/clk/sunxi-ng/ccu-sun8i-a33.c |  3 +--
>  drivers/clk/sunxi-ng/ccu-sun8i-h3.c  |  3 +--
>  drivers/clk/sunxi-ng/ccu-sun8i-r.c   |  3 +--
>  drivers/clk/sunxi-ng/ccu-sun8i-v3s.c |  3 +--
>  drivers/clk/sunxi/clk-sunxi.c        | 17 +++++++----------

For the sunxi and sunxi-ng clocks:
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--l25m4zfpvpydcgma
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZbvrFAAoJEBx+YmzsjxAgYCIQAIG0Ck1n/kBpT7SJHMICc1Pk
JvosVmqrSK8FMljtVqFNa7wTxpbhiwtkWPBfFrvvv4lNN/9eyCFsJjlkjFYmPj9z
EtIQNMK6gZVRWSD+apOrPbOz8PPpnW5g7IyZhKrzc2XTw5ypsGO+Uz0pbYfG1oui
b+YODRsG/GFA9M4JG3pM0WCBFzoC3Je1PMo27jOjxWO7E0VeJWQVVkqXShw1rZaV
QEz3EhYZ79x+Wn7kV6L3jxRG6oljmJRKuqVqOiHoMgfM6oSOcuDTrhse/JfBqkoT
p1FummTm0I+1LcztAiqGQWePjS2dIYluueX3OdCsANfd8/OHwGdKPzcyQ0cOIR3o
o3s2udAKdQI8CWl2SEbUp9qyTwF+CjkAzICcY5RF05iHdL2WrAbbZ3G6MHjNQC39
/Y2mfVZ5iRv+Crtuue+uytZ6xbKb7sp5j0+SQwYaPi+vmnONQK+tiPPgTxi0deaD
Wt+8+2YovasnYHSMBfN4DtIEbESRN3vnEYUiTbg5NYqTrVNw6SeqIbwhIMYFEM7f
kn1SvLfqcDdMq4qQd3cguiKKEJnCAlh4JtO3wWPocJNA73J7SgaM8tmPoQNQ+6V/
2y7hSSjLNh1Is6o888H58cjQ0DNnTHDWOhezIk9Y7jVtVyEj/dPoZ1MJL9j5miQt
si9tNGjJSr2RAVVdbnYk
=PpBl
-----END PGP SIGNATURE-----

--l25m4zfpvpydcgma--

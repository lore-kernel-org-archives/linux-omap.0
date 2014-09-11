From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH] clk: don't use __initconst for non-const arrays
Date: Thu, 11 Sep 2014 23:48:12 +0200
Message-ID: <5412189C.2040802@gmail.com>
References: <1410469471-31027-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1410469471-31027-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>, Mike Turquette <mturquette@linaro.org>
Cc: linux-samsung-soc@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Tero Kristo <t-kristo@ti.com>, linux-rockchip@lists.infradead.org, kernel@pengutronix.de, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

[adding Sylwester and removing my samsung.com e-mail which is no longer
valid]

On 11.09.2014 23:04, Uwe Kleine-K=C3=B6nig wrote:
> The statement
>=20
> 	static const char *name[];
>=20
> defines a modifiable array of pointers to constant chars. That is
>=20
> 	*name[0] =3D 'f';
>=20
> is forbidden, but
>=20
> 	name[0] =3D "f";
>=20
> is not. So marking an array that is defined as above with __initconst=
 is
> wrong. Either an additional const must be added such that the whole
> definition reads:
>=20
> 	static const char *const name[] __initconst;
>=20
> or where this is not possible __initdata must be used.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/clk/hisilicon/clk-hix5hd2.c |  6 ++--
>  drivers/clk/mxs/clk-imx23.c         | 12 ++++----
>  drivers/clk/mxs/clk-imx28.c         | 18 ++++++------
>  drivers/clk/rockchip/clk.h          |  2 +-
>  drivers/clk/samsung/clk-s5pv210.c   | 56 ++++++++++++++++++---------=
----------

=46or drivers/clk/samsung/*

Acked-by: Tomasz Figa <tomasz.figa@gmail.com>

Best regards,
Tomasz

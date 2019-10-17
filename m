From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2] clk/ti/adpll: allocate room for terminating null
Date: Thu, 17 Oct 2019 08:48:53 -0700
Message-ID: <20191017154854.5285220869@mail.kernel.org>
References: <cec235b3e2e4e3b206fa9444b643fa56@sk2.org> <20190927180559.18162-1-steve@sk2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190927180559.18162-1-steve@sk2.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Tero Kristo <t-kristo@ti.com>, Tony Lindgren <tony@atomide.com>, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
List-Id: linux-omap@vger.kernel.org

Quoting Stephen Kitt (2019-09-27 11:05:59)
> The buffer allocated in ti_adpll_clk_get_name doesn't account for the
> terminating null. This patch switches to ka_sprintf to avoid
> overflowing.
>=20
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> ---
>  drivers/clk/ti/adpll.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/clk/ti/adpll.c b/drivers/clk/ti/adpll.c
> index fdfb90058504..021cf9e2b4db 100644
> --- a/drivers/clk/ti/adpll.c
> +++ b/drivers/clk/ti/adpll.c
> @@ -195,14 +195,8 @@ static const char *ti_adpll_clk_get_name(struct ti_a=
dpll_data *d,
>                         return NULL;
>         } else {
>                 const char *base_name =3D "adpll";

This is used once.

> -               char *buf;
> -
> -               buf =3D devm_kzalloc(d->dev, 8 + 1 + strlen(base_name) + =
1 +
> -                                   strlen(postfix), GFP_KERNEL);
> -               if (!buf)
> -                       return NULL;
> -               sprintf(buf, "%08lx.%s.%s", d->pa, base_name, postfix);
> -               name =3D buf;
> +               name =3D devm_kasprintf(d->dev, GFP_KERNEL, "%08lx.%s.%s",

So why not make this "%08lx.adpll.%s"?

> +                                     d->pa, base_name, postfix);
>         }

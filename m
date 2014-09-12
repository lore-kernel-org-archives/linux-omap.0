From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] clk: don't use __initconst for non-const arrays
Date: Fri, 12 Sep 2014 09:59:52 +0200
Message-ID: <20140912075952.GR3755@pengutronix.de>
References: <1410469471-31027-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20140911220445.GQ3755@pengutronix.de>
 <CAKv+Gu9LubyPHoYJsRfRoqgONAApb3nEoXAxUa9g6tecP=McOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56164 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752791AbaILIAH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Sep 2014 04:00:07 -0400
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9LubyPHoYJsRfRoqgONAApb3nEoXAxUa9g6tecP=McOw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Mike Turquette <mturquette@linaro.org>, linux-samsung-soc@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, Tomasz Figa <tomasz.figa@gmail.com>, Tero Kristo <t-kristo@ti.com>, linux-rockchip@lists.infradead.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, kernel@pengutronix.de, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hello Ard,

On Fri, Sep 12, 2014 at 09:42:29AM +0200, Ard Biesheuvel wrote:
> On 12 September 2014 00:04, Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > Hello,
> >
> > On Thu, Sep 11, 2014 at 11:04:31PM +0200, Uwe Kleine-K=F6nig wrote:
> >>  /* Mux parent lists. */
> >> -static const char *fin_pll_p[] __initconst =3D {
> >> +static const char *fin_pll_p[] __initdata =3D {
> >>       "xxti",
> >>       "xusbxti"
> >>  };
> > As discussed with Tomasz on irc: The sad thing here is that for thi=
s
> > array only 8 bytes are freed when .init.rodata is thrown away (that=
 is
> > two pointers). The actual data---5 + 8 bytes + maybe aligning---isn=
't
> > freed though.
> >
> > We wondered if there is a nice and easy way to throw away the
> > characters, too.
> >
> > The only way I currently see is:
> >
> >         const char xxti[] __initconst =3D "xxti";
> >         ...
> >
> >         static const char *fin_pll_p[] __initdata =3D {
> >                 xxti,
> >                 ...
> >         };
> >
> > but this definitively doesn't qualify as "nice and easy". Is there =
an
> > alternative?
> >
>=20
> What about doing
>=20
> static const char fin_pll_p[][8] __initconst =3D {
>      "xxti",
>      "xusbxti"
> };
This results in the strings being moved to .init.rodata and so they are
discarded. But it also results in:

	drivers/clk/samsung/clk-s5pv210.c:412:2: warning: initialization from =
incompatible pointer type [enabled by default]
	  MUX_F(FIN_PLL, "fin_pll", fin_pll_p, OM_STAT, 0, 1,
	  ^
	drivers/clk/samsung/clk-s5pv210.c:412:2: warning: (near initialization=
 for 'early_mux_clks[0].parent_names') [enabled by default]

That's because early_mux_clks[0].parent_names is of type const char **
while fin_pll_p as suggested doesn't provide an array of pointers to th=
e
start of the contained strings.
I don't see a way to fix that unless we fix the maximal clock name
length globally and so waste much memory.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH 1/2] clk: change clk_ops' ->round_rate() prototype
Date: Sun, 19 Apr 2015 17:30:06 +0200
Message-ID: <20150419173006.0ce6cfe0@bbrezillon>
References: <1429255769-13639-1-git-send-email-boris.brezillon@free-electrons.com>
	<1429255769-13639-2-git-send-email-boris.brezillon@free-electrons.com>
	<7408975.lBcgZIN9hf@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7408975.lBcgZIN9hf@diego>
Sender: linux-kernel-owner@vger.kernel.org
To: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
Cc: Mike Turquette <mturquette@linaro.org>, Mikko Perttunen <mikko.perttunen@kapsi.fi>, Jonathan Corbet <corbet@lwn.net>, Shawn Guo <shawn.guo@linaro.org>, ascha Hauer <kernel@pengutronix.de>, David Brown <davidb@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, Bryan Huntsman <bryanh@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Max Filippov <jcmvbkbc@gmail.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Barry Song <baohua@kernel.org>, Viresh Kumar <viresh.linux@gmail.com>, Emilio =?UTF-8?B?TMOzcGV6?= <emilio@elopez.com.ar>, Maxime Ripard <maxime.ripard@free-electrons.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Prashant
List-Id: linux-omap@vger.kernel.org

Hi Heiko,

On Sun, 19 Apr 2015 14:13:04 +0200
Heiko St=C3=BCbner <heiko@sntech.de> wrote:

> Hi Boris,
>=20
> Am Freitag, 17. April 2015, 09:29:28 schrieb Boris Brezillon:
> > Clock rates are stored in an unsigned long field, but ->round_rate(=
)
> > (which returns a rounded rate from a requested one) returns a long
> > value (errors are reported using negative error codes), which can l=
ead
> > to long overflow if the clock rate exceed 2Ghz.
> >=20
> > Change ->round_rate() prototype to return 0 or an error code, and p=
ass the
> > requested rate as a pointer so that it can be adjusted depending on
> > hardware capabilities.
> >=20
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > ---
>=20
> On a rk3288-veyron-pinky with the fix described below:
> Tested-by: Heiko Stuebner <heiko@sntech.de>
>=20
>=20
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index fa5a00e..1462ddc 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -1640,8 +1643,10 @@ static struct clk_core *clk_calc_new_rates(s=
truct
> > clk_core *clk, &parent_hw);
> >  		parent =3D parent_hw ? parent_hw->core : NULL;
> >  	} else if (clk->ops->round_rate) {
> > -		new_rate =3D clk->ops->round_rate(clk->hw, rate,
> > -						&best_parent_rate);
> > +		if (clk->ops->round_rate(clk->hw, &new_rate,
> > +					 &best_parent_rate))
> > +			return NULL;
> > +
> >  		if (new_rate < min_rate || new_rate > max_rate)
> >  			return NULL;
> >  	} else if (!parent || !(clk->flags & CLK_SET_RATE_PARENT)) {
>=20
> This is using new_rate uninitialized when calling into the round_rate
> callback. Which in turn pushed my PLLs up to 2.2GHz :-)

Indeed, thanks for the fix.

[...]

>=20
>=20
> And as I've stumbled onto this recently too, the clock-maintainership=
 has
> expanded to Stephen Boyd and linux-clk@vger.kernel.org .

Noted. I'll add Stephen and the new linux-clk ML in the recipient list
next time.

Best Regards,

Boris


--=20
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

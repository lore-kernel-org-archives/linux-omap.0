From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v3] clk: change clk_ops' ->determine_rate() prototype
Date: Thu, 4 Jun 2015 08:44:34 +0200
Message-ID: <20150604084434.48939141@bbrezillon>
References: <1432138345-19044-1-git-send-email-boris.brezillon@free-electrons.com>
	<20150603233728.GA490@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20150603233728.GA490@codeaurora.org>
Sender: linux-doc-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Mike Turquette <mturquette@linaro.org>, linux-clk@vger.kernel.org, Mikko Perttunen <mikko.perttunen@kapsi.fi>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Jonathan Corbet <corbet@lwn.net>, Tony Lindgren <tony@atomide.com>, Ralf Baechle <ralf@linux-mips.org>, Emilio L??pez <emilio@elopez.com.ar>, Maxime Ripard <maxime.ripard@free-electrons.com>, Tero Kristo <t-kristo@ti.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mips@linux-mips.org
List-Id: linux-omap@vger.kernel.org

Hi Stefen,

On Wed, 3 Jun 2015 16:37:28 -0700
Stephen Boyd <sboyd@codeaurora.org> wrote:

> On 05/20, Boris Brezillon wrote:
> > Clock rates are stored in an unsigned long field, but ->determine_r=
ate()
> > (which returns a rounded rate from a requested one) returns a long
> > value (errors are reported using negative error codes), which can l=
ead
> > to long overflow if the clock rate exceed 2Ghz.
> >=20
> > Change ->determine_rate() prototype to return 0 or an error code, a=
nd pass
> > a pointer to a clk_rate_request structure containing the expected t=
arget
> > rate and the rate constraints imposed by clk users.
> >=20
> > The clk_rate_request structure might be extended in the future to c=
ontain
> > other kind of constraints like the rounding policy, the maximum clo=
ck
> > inaccuracy or other things that are not yet supported by the CCF
> > (power consumption constraints ?).
> >=20
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> >=20
> > CC: Jonathan Corbet <corbet@lwn.net>
> > CC: Tony Lindgren <tony@atomide.com>
> > CC: Ralf Baechle <ralf@linux-mips.org>
> > CC: "Emilio L=C3=B3pez" <emilio@elopez.com.ar>
> > CC: Maxime Ripard <maxime.ripard@free-electrons.com>
> > CC: Tero Kristo <t-kristo@ti.com>
> > CC: linux-doc@vger.kernel.org
> > CC: linux-kernel@vger.kernel.org
> > CC: linux-arm-kernel@lists.infradead.org
> > CC: linux-omap@vger.kernel.org
> > CC: linux-mips@linux-mips.org
> > ---
> >=20
> > Hi Stephen,
> >=20
> > This patch is based on clk-next and contains the changes you sugges=
ted
> > in your previous review.
> >=20
> > It was tested on sama5d4 and compile tested on several ARM platform=
s
> > (those enabled in multi_v7_defconfig).
> >=20
>=20
> Thanks. I think we should wait until the next -rc1 drops to apply the
> patch for the next merge window. That will make it least likely to co=
nflict
> with other trees, and we can provide it on a stable branch should the=
re
> be clock providers going through other trees somewhere. Please
> remind me if I forget.

No problem.

>=20
> > @@ -1186,15 +1191,21 @@ EXPORT_SYMBOL_GPL(__clk_determine_rate);
> >   */
> >  unsigned long __clk_round_rate(struct clk *clk, unsigned long rate=
)
> >  {
> > -	unsigned long min_rate;
> > -	unsigned long max_rate;
> > +
> > +	struct clk_rate_request req;
> > +	int ret;
> > =20
> >  	if (!clk)
> >  		return 0;
> > =20
> > -	clk_core_get_boundaries(clk->core, &min_rate, &max_rate);
> > +	clk_core_get_boundaries(clk->core, &req.min_rate, &req.max_rate);
> > +	req.rate =3D rate;
> > +
> > +	ret =3D clk_core_round_rate_nolock(clk->core, &req);
> > +	if (ret)
> > +		return ret;
>=20
> This returns a negative int for unsigned long. Is that intentional?

Nope, should be replaced by 'return 0;'.

Thanks,

Boris


--=20
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

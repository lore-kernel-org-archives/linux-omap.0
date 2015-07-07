From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v4] clk: change clk_ops' ->determine_rate() prototype
Date: Tue, 7 Jul 2015 07:10:11 +0200
Message-ID: <20150707071011.399b9b78@bbrezillon>
References: <1436202872-26533-1-git-send-email-boris.brezillon@free-electrons.com>
        <20150706213210.GB20866@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20150706213210.GB20866@codeaurora.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Mike Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Tony Lindgren <tony@atomide.com>, Ralf Baechle <ralf@linux-mips.org>, Emilio =?UTF-8?B?TMOzcGV6?= <emilio@elopez.com.ar>, Maxime Ripard <maxime.ripard@free-electrons.com>, Tero Kristo <t-kristo@ti.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mips@linux-mips.org, linux-tegra@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Stephen,

On Mon, 6 Jul 2015 14:32:10 -0700
Stephen Boyd <sboyd@codeaurora.org> wrote:

> On 07/06, Boris Brezillon wrote:
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
>=20
> Which files did you compile?=20
>=20
> drivers/clk/mmp/clk-mix.c: In function =E2=80=98mmp_clk_mix_determine=
_rate=E2=80=99:
> drivers/clk/mmp/clk-mix.c:221:13: error: =E2=80=98rate=E2=80=99 undec=
lared (first use in this function)
>=20

Hm, I only compile tested the multi_v5 and multi_v7 defconfigs, and
obviously it was a bad idea (just thought all the impacted platforms
were already converted to multiplatform support).

[...]

> > -long omap3_noncore_dpll_determine_rate(struct clk_hw *hw, unsigned=
 long rate,
> > -				       unsigned long min_rate,
> > -				       unsigned long max_rate,
> > -				       unsigned long *best_parent_rate,
> > -				       struct clk_hw **best_parent_clk)
> > +int omap3_noncore_dpll_determine_rate(struct clk_hw *hw,
> > +				      struct clk_rate_request *req)
> >  {
> >  	struct clk_hw_omap *clk =3D to_clk_hw_omap(hw);
> >  	struct dpll_data *dd;
> > =20
> > -	if (!hw || !rate)
> > +	if (!hw || !req || !req->rate)
>=20
> Why do we need to check for req? It shouldn't be NULL.

We don't, I'll remove this test.

[...]

> > -long omap4_dpll_regm4xen_determine_rate(struct clk_hw *hw, unsigne=
d long rate,
> > -					unsigned long min_rate,
> > -					unsigned long max_rate,
> > -					unsigned long *best_parent_rate,
> > -					struct clk_hw **best_parent_clk)
> > +int omap4_dpll_regm4xen_determine_rate(struct clk_hw *hw,
> > +				       struct clk_rate_request *req)
> >  {
> >  	struct clk_hw_omap *clk =3D to_clk_hw_omap(hw);
> >  	struct dpll_data *dd;
> > =20
> > -	if (!hw || !rate)
> > +	if (!hw || !req || !req->rate)
>=20
> Same comment here. And why would we care about hw being NULL
> either for that matter.

Yes, but I'm not sure this removal should be done in the same patch.
Let me know if you think otherwise.


> > -static long mmc_clk_determine_rate(struct clk_hw *hw, unsigned lon=
g rate,
> > -			      unsigned long min_rate,
> > -			      unsigned long max_rate,
> > -			      unsigned long *best_parent_rate,
> > -			      struct clk_hw **best_parent_p)
> > +static int mmc_clk_determine_rate(struct clk_hw *hw,
> > +				  struct clk_rate_request *req)
> >  {
> >  	struct clk_mmc *mclk =3D to_mmc(hw);
> > -	unsigned long best =3D 0;
> > =20
> > -	if ((rate <=3D 13000000) && (mclk->id =3D=3D HI3620_MMC_CIUCLK1))=
 {
> > -		rate =3D 13000000;
> > -		best =3D 26000000;
> > -	} else if (rate <=3D 26000000) {
> > -		rate =3D 25000000;
> > -		best =3D 180000000;
> > -	} else if (rate <=3D 52000000) {
> > -		rate =3D 50000000;
> > -		best =3D 360000000;
> > -	} else if (rate <=3D 100000000) {
> > -		rate =3D 100000000;
> > -		best =3D 720000000;
> > +	req->best_parent_hw =3D __clk_get_hw(__clk_get_parent(hw->clk));
> > +
>=20
> Where did this come from? We weren't setting the best_parent_p
> pointer before.

It comes from a previous version where I was not assigning the
->best_parent_hw field to the current parent in the core code.
I fixed it in the meantime, but forgot to remove this assignment.


> > -static long
> > -clk_pll_determine_rate(struct clk_hw *hw, unsigned long rate,
> > -		       unsigned long min_rate, unsigned long max_rate,
> > -		       unsigned long *p_rate, struct clk_hw **p)
> > +static int
> > +clk_pll_determine_rate(struct clk_hw *hw, struct clk_rate_request =
*req)
> >  {
> > +	struct clk *parent =3D __clk_get_parent(hw->clk);
> >  	struct clk_pll *pll =3D to_clk_pll(hw);
> >  	const struct pll_freq_tbl *f;
> > =20
> > -	f =3D find_freq(pll->freq_tbl, rate);
> > +	req->best_parent_hw =3D __clk_get_hw(parent);
> > +	req->best_parent_rate =3D __clk_get_rate(parent);
> > +
> > +	f =3D find_freq(pll->freq_tbl, req->rate);
> >  	if (!f)
> > -		return clk_pll_recalc_rate(hw, *p_rate);
> > +		req->rate =3D clk_pll_recalc_rate(hw, req->best_parent_rate);
> > +	else
> > +		req->rate =3D f->freq;
> > =20
> >  	return f->freq;
>=20
> return 0?
>=20

Yes, I'll fix that one too.

Thanks,

Boris

--=20
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v5] clk: change clk_ops' ->determine_rate() prototype
Date: Wed, 8 Jul 2015 11:00:05 +0200
Message-ID: <20150708110005.704c49ff@bbrezillon>
References: <1436294888-25752-1-git-send-email-boris.brezillon@free-electrons.com>
	<20150708005748.GG30412@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150708005748.GG30412-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Mike Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Emilio =?UTF-8?B?TMOzcGV6?= <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Prashant Gaikwad <pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Stephen,

On Tue, 7 Jul 2015 17:57:48 -0700
Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:

> On 07/07, Boris Brezillon wrote:
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
> > Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> >=20
> > CC: Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>
> > CC: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> > CC: Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
> > CC: "Emilio L=C3=B3pez" <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
> > CC: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> > CC: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
> > CC: Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > CC: Prashant Gaikwad <pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > CC: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
> > CC: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > CC: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > CC: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > CC: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > CC: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> > CC: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > CC: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org
> > CC: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >=20
> > ---
>=20
> I'll throw this patch into -next now to see if any other problems
> shake out. I'm hoping we get some more acks though, so it'll be
> on it's own branch and become immutable in a week or so. One
> question below.
>=20
> > diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composit=
e.c
> > index 616f5ae..9e69f34 100644
> > --- a/drivers/clk/clk-composite.c
> > +++ b/drivers/clk/clk-composite.c
> > @@ -99,33 +99,33 @@ static long clk_composite_determine_rate(struct=
 clk_hw *hw, unsigned long rate,
> > =20
> >  			parent_rate =3D __clk_get_rate(parent);
> > =20
> > -			tmp_rate =3D rate_ops->round_rate(rate_hw, rate,
> > +			tmp_rate =3D rate_ops->round_rate(rate_hw, req->rate,
> >  							&parent_rate);
> >  			if (tmp_rate < 0)
> >  				continue;
> > =20
> > -			rate_diff =3D abs(rate - tmp_rate);
> > +			rate_diff =3D abs(req->rate - tmp_rate);
> > =20
> > -			if (!rate_diff || !*best_parent_p
> > +			if (!rate_diff || !req->best_parent_hw
> >  				       || best_rate_diff > rate_diff) {
> > -				*best_parent_p =3D __clk_get_hw(parent);
> > -				*best_parent_rate =3D parent_rate;
> > +				req->best_parent_hw =3D __clk_get_hw(parent);
> > +				req->best_parent_rate =3D parent_rate;
> >  				best_rate_diff =3D rate_diff;
> >  				best_rate =3D tmp_rate;
> >  			}
> > =20
> >  			if (!rate_diff)
> > -				return rate;
> > +				return 0;
> >  		}
> > =20
> > -		return best_rate;
> > +		req->rate =3D best_rate;
> > +		return 0;
> >  	} else if (mux_hw && mux_ops && mux_ops->determine_rate) {
> >  		__clk_hw_set_clk(mux_hw, hw);
> > -		return mux_ops->determine_rate(mux_hw, rate, min_rate,
> > -					       max_rate, best_parent_rate,
> > -					       best_parent_p);
> > +		return mux_ops->determine_rate(mux_hw, req);
> >  	} else {
> >  		pr_err("clk: clk_composite_determine_rate function called, but n=
o mux or rate callback set!\n");
> > +		req->rate =3D 0;
> >  		return 0;
>=20
> Shouldn't this return an error now? And then assigning req->rate
> wouldn't be necessary. Sorry I must have missed this last round.
>=20

Actually I wanted to keep the existing behavior: return a 0 rate (not
an error) when there is no mux or rate ops.

That's something we can change afterwards, but it might reveals
new bugs if some users are checking for a 0 rate to detect errors.

Best Regards,

Boris

--=20
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

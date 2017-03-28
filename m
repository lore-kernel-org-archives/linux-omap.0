From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] regmap: irq: Fix lost interrupts by introducing
 handle_reread
Date: Tue, 28 Mar 2017 16:18:49 +0100
Message-ID: <20170328151849.uvj2ljkbts4cwksq@sirena.org.uk>
References: <20170322171052.7006-1-tony@atomide.com>
 <20170322171052.7006-2-tony@atomide.com>
 <20170327174952.jsfleql654m2h45i@sirena.org.uk>
 <20170328003648.GS10760@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="id3suyvanignckd3"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170328003648.GS10760@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Lee Jones <lee.jones@linaro.org>, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>
List-Id: linux-omap@vger.kernel.org


--id3suyvanignckd3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 27, 2017 at 05:36:48PM -0700, Tony Lindgren wrote:
> * Mark Brown <broonie@kernel.org> [170327 10:52]:

> > So, I see your use case but the fact is that as Charles observed this is
> > exactly the code used for emulating level triggered IRQs with edge
> > triggered interrupt controllers.  This means someone is doubtless going
> > to end up using it for precisely that.  This makes me uncomfortable, we
> > do have this open coded into various drivers already but this is more of
> > a core thing and it feels like this should be in genirq rather than
> > here...  that said, looking at the code:

> Yes.. But then again we might avoid piling up yet more driver
> specific hacks. I don't know what the genirq solution would look

Right, my thinking here is that by pushing into genirq we minimise the
need even further since it'll also be available to drivers not using
regmap-irq.

> like, handle until we get IRQ_NONE? :)

Well, that's what the per driver emulation does so...  yeah.  Probably
with an upper limit on the number of times we do that.

> > There's no protection against screaming interrupts here, I'd really like
> > to see that.  Also some tracing of the number of times we spin.

> Good idea. How about something like below where handle_reread checks
> for the total time spent in the thread loop with a large enough
> timeout? Or do you have some better ideas in mind?

> I tested I can hit that warning with timeout set to much lower
> 10 ms with retries being 1 or 2 at that point.

That looks sensible, yes.

--id3suyvanignckd3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljaftgACgkQJNaLcl1U
h9DtWAf7BcEjKjxo74aRr0tUJkw8GVWs5AbGf4dYcQcSkziPCHdi4+6Sruqvw/y/
hxW3gKVsw1UpNmws5wv1Qxpm5TOBlgFC2MkAPrdZT8ftGe6PAGF3ihkJNju0RE9J
wP1ak12zBEP0xXl97cmFDKgq2AYItFV8dWNJKYwVa2l0RSvgp98Cgmd8HrSDNZCx
s5j1U+RboXeV19NhMvnUCESc9CCRygbx0vlSZVjJHHJUnQ0CPDsxQqUVloeMuAA7
SCgbjYm/tkif4a5ltXzmvY17FYB/mwT3nR40NpYZlVmHq3/1zdUScMG5dTDnGqr4
tR5KBUu/9j7ZKuQMnN6zwjX1RCmTqA==
=Axp/
-----END PGP SIGNATURE-----

--id3suyvanignckd3--

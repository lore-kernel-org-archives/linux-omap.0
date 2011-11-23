From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Re: [PATCH 2/5] ASoC: OMAP4: omap-dmic: Initial support for OMAP
 DMIC
Date: Wed, 23 Nov 2011 10:58:07 +0000
Message-ID: <20111123105806.GA21073@opensource.wolfsonmicro.com>
References: <1321970520-8909-1-git-send-email-peter.ujfalusi@ti.com>
 <1321970520-8909-3-git-send-email-peter.ujfalusi@ti.com>
 <20111122160105.GC30583@opensource.wolfsonmicro.com>
 <1619032.uInsqOQfdX@barack>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:41717 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752085Ab1KWK6K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Nov 2011 05:58:10 -0500
Content-Disposition: inline
In-Reply-To: <1619032.uInsqOQfdX@barack>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

On Wed, Nov 23, 2011 at 10:48:24AM +0200, P=E9ter Ujfalusi wrote:
> On Tuesday 22 November 2011 16:01:05 Mark Brown wrote:

> > > +	dmic_clk =3D clk_get(dmic->dev, "dmic_fck");
> > > +	if (IS_ERR(dmic_clk)) {
> > > +		dev_err(dmic->dev, "cant get dmic_fck\n");
> > > +		return -ENODEV;
> > > +	}

> > Why aren't we getting and holding a reference to the clock over the
> > entire lifetime of the driver?

> We only need the reference for the dmic_fclk for reparenting which wi=
ll happen=20
> only once in most cases (or not at all, if pad_clks_ck is going to be=
 used). I=20
> don't think we should hold the reference for the dmic_fclk.
> The clock handling is done via pm_runtime_get/put_sync().

This just seems like it's making the code needlessly complex - there's
no harm in holding the reference if you don't enable/disable the clock
and it makes this function much simpler.

> > > +	/* disable clock while reparenting */
> > > +	pm_runtime_put_sync(dmic->dev);
> > > +	ret =3D clk_set_parent(dmic_clk, parent_clk);
> > > +	pm_runtime_get_sync(dmic->dev);

> > Since we're only allowing reclocking while idle shouldn't the clock
> > already be disabled?  Seems like it ought to be good for power if
> > nothing else...

> We enable the clocks at dai_startup for the DMIC (and disable them on=
=20
> dai_shutdown). We can not reparent while the clocks are enabled.
> This is the reason for this part.

That sounds like the enable is happening too early, then.

> > > +static int omap_dmic_set_clkdiv(struct snd_soc_dai *dai,
> > > +				int div_id, int div)
> > > +{

> > DMIC clocking is usually fairly simple so it seems surprising that =
the
> > driver isn't able to figure this out for itself.

> The clock towards the external digital mics are based on the DMIC_FCL=
K rate.
> In case of DMIC_FCLK =3D 19.2MHz, 24.576MHz we can select between two=
 dividers=20
> which will result different clocks for the external microphones.
> I would rather leave this decision to the machine driver which knows =
the=20
> external components, and can pick the best divider for them.

If that's what you're doing then it seems like the machine drivers
should be use set_sysclk() (or perhaps even the clk API) to set up the
rate they're looking for from the visible clock rather than fiddling
about with magic divider values.  That way they can say exactly what
they want directly in terms of the result they're looking for.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

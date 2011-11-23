From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Re: [PATCH 2/5] ASoC: OMAP4: omap-dmic: Initial support for OMAP DMIC
Date: Wed, 23 Nov 2011 10:48:24 +0200
Message-ID: <1619032.uInsqOQfdX@barack>
References: <1321970520-8909-1-git-send-email-peter.ujfalusi@ti.com> <1321970520-8909-3-git-send-email-peter.ujfalusi@ti.com> <20111122160105.GC30583@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:46100 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750953Ab1KWIsz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Nov 2011 03:48:55 -0500
Received: by bkbzs2 with SMTP id zs2so1284484bkb.34
        for <linux-omap@vger.kernel.org>; Wed, 23 Nov 2011 00:48:53 -0800 (PST)
In-Reply-To: <20111122160105.GC30583@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

On Tuesday 22 November 2011 16:01:05 Mark Brown wrote:
> On Tue, Nov 22, 2011 at 04:01:57PM +0200, Peter Ujfalusi wrote:
> > +	switch (params_rate(params)) {
> > +	case 96000:
> > +	case 192000:
> > +		break;
>=20
> Why doesn't the driver need to tell the hardware what sample rate to =
run
> at?

Because the OMAP4 DMIC can only support on 96KHz...
Will be fixed.

>=20
> > +	dmic_clk =3D clk_get(dmic->dev, "dmic_fck");
> > +	if (IS_ERR(dmic_clk)) {
> > +		dev_err(dmic->dev, "cant get dmic_fck\n");
> > +		return -ENODEV;
> > +	}
>=20
> Why aren't we getting and holding a reference to the clock over the
> entire lifetime of the driver?

We only need the reference for the dmic_fclk for reparenting which will=
 happen=20
only once in most cases (or not at all, if pad_clks_ck is going to be u=
sed). I=20
don't think we should hold the reference for the dmic_fclk.
The clock handling is done via pm_runtime_get/put_sync().

> > +	/* disable clock while reparenting */
> > +	pm_runtime_put_sync(dmic->dev);
> > +	ret =3D clk_set_parent(dmic_clk, parent_clk);
> > +	pm_runtime_get_sync(dmic->dev);
>=20
> Since we're only allowing reclocking while idle shouldn't the clock
> already be disabled?  Seems like it ought to be good for power if
> nothing else...

We enable the clocks at dai_startup for the DMIC (and disable them on=20
dai_shutdown). We can not reparent while the clocks are enabled.
This is the reason for this part.
=20
> > +static int omap_dmic_set_clkdiv(struct snd_soc_dai *dai,
> > +				int div_id, int div)
> > +{
>=20
> DMIC clocking is usually fairly simple so it seems surprising that th=
e
> driver isn't able to figure this out for itself.

The clock towards the external digital mics are based on the DMIC_FCLK =
rate.
In case of DMIC_FCLK =3D 19.2MHz, 24.576MHz we can select between two d=
ividers=20
which will result different clocks for the external microphones.
I would rather leave this decision to the machine driver which knows th=
e=20
external components, and can pick the best divider for them.

--
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

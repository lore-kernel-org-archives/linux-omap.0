From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Re: [PATCH v2 2/5] ASoC: OMAP4: omap-dmic: Initial support for OMAP DMIC
Date: Fri, 25 Nov 2011 11:31:53 +0200
Message-ID: <9246733.S00T0fgtUG@barack>
References: <1322142889-12017-1-git-send-email-peter.ujfalusi@ti.com> <1322142889-12017-3-git-send-email-peter.ujfalusi@ti.com> <20111124171019.GQ8470@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:39345 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751223Ab1KYJby convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Nov 2011 04:31:54 -0500
Received: by mail-bw0-f54.google.com with SMTP id zs8so6150260bkb.27
        for <linux-omap@vger.kernel.org>; Fri, 25 Nov 2011 01:31:51 -0800 (PST)
In-Reply-To: <20111124171019.GQ8470@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

On Thursday 24 November 2011 17:10:19 Mark Brown wrote:
> On Thu, Nov 24, 2011 at 03:54:46PM +0200, Peter Ujfalusi wrote:
> > +	/*
> > +	 * 192KHz rate is only supported with 19.2MHz/3.84MHz clock
> > +	 * configuration. Fix the dmic clock divider for 192KHz
> > +	 */
> > +	if (params_rate(params) =3D=3D 192000) {
> > +		if (dmic->fclk_freq =3D=3D 19200000 && dmic->clk_div =3D=3D 0x1)=
 {
> > +			dmic->clk_div =3D 0x6;
> > +		} else {
> > +			dev_err(dmic->dev,
> > +				"invalid clock configuration for 192KHz\n");
> > +			return -EINVAL;
> > +		}
> > +	}
>=20
> That's a bit wierd, magic numbers there and it'll mean we're trashing
> the user's configuration.  Why not just return an error if the clock
> setup is broken,

192KHz rate is supported only with one clock configuration:
19.2MHz input clock, and 3.84MHz output clock. With the same clock=20
configuration the 96KHz rate is also valid. The difference is that we n=
eed to=20
use different divider value for 96KHz (0x1) versus 192KHz (0x6).
The Machine driver configures three things: clock source, source clock =
speed,=20
and the desired output speed.
In the omap_dmic_select_divider() the driver configures the dividers, b=
ut=20
there it does not know if the stream is 96 or 192 KHz. Since for both t=
he=20
machine provided configuration is the same I can fix up the divider in =
case=20
the stream is 192KHz, and the machine driver was asking for a clock=20
configuration matching with the requirements.
Basically the omap_dmic_select_divider() configures the divider for 96K=
Hz,=20
here the driver does the fixup for 192KHz.
I'll update the comment to be more verbose on what is going on here.

> or alternatively aren't there other invalid
> configurations we should be trapping and fixing up (looking at the
> divider setting code it seems unlikely that if the user doesn't
> configure things we're not going to have a valid divider setup)?

So far this is the only configuration need special care.

>=20
> > +static int omap_dmic_set_dai_sysclk(struct snd_soc_dai *dai, int
> > clk_id,
> > +				    unsigned int freq, int dir)
> > +{
> > +	struct omap_dmic *dmic =3D snd_soc_dai_get_drvdata(dai);
> > +
> > +	if (dir =3D=3D SND_SOC_CLOCK_IN)
> > +		return omap_dmic_select_fclk(dmic, clk_id, freq);
> > +	else if (dir =3D=3D SND_SOC_CLOCK_OUT)
> > +		return omap_dmic_select_divider(dmic, freq);
>=20
> Might be better to specify using clk_id in case the next revision of =
the
> IP has more clocks or something.

The fclk selection is using clk_id. I can add clk_id for the dmic_out c=
lock.

>=20
> > +	dmic =3D kzalloc(sizeof(struct omap_dmic), GFP_KERNEL);
> > +	if (!dmic)
> > +		return -ENOMEM;
>=20
> devm_ would save you having to clean stuff up later.

Yes, handy. Changed.

>=20
> > +static int __init snd_omap_dmic_init(void)
> > +{
> > +	return platform_driver_register(&asoc_dmic_driver);
> > +}
> > +module_init(snd_omap_dmic_init);
> > +
> > +static void __exit snd_omap_dmic_exit(void)
> > +{
> > +	platform_driver_unregister(&asoc_dmic_driver);
> > +}
> > +module_exit(snd_omap_dmic_exit);
>=20
> module_platform_driver.

Sure.

--
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

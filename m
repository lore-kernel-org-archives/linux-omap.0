From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Re: [PATCH v3 2/5] ASoC: OMAP4: omap-dmic: Initial support for OMAP DMIC
Date: Mon, 28 Nov 2011 09:49:19 +0200
Message-ID: <2729071.3pgFW4tmaY@barack>
References: <1322223636-31623-1-git-send-email-peter.ujfalusi@ti.com> <1322223636-31623-3-git-send-email-peter.ujfalusi@ti.com> <20111127195040.GC25598@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:39218 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751877Ab1K1HtM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Nov 2011 02:49:12 -0500
Received: by mail-bw0-f41.google.com with SMTP id 17so8217639bke.28
        for <linux-omap@vger.kernel.org>; Sun, 27 Nov 2011 23:49:07 -0800 (PST)
In-Reply-To: <20111127195040.GC25598@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

On Sunday 27 November 2011 19:50:41 Mark Brown wrote:
> On Fri, Nov 25, 2011 at 02:20:33PM +0200, Peter Ujfalusi wrote:
> > +	/*
> > +	 * 192KHz rate is only supported with 19.2MHz/3.84MHz clock
> > +	 * configuration. The same clock configuration allows 96KHz sampl=
ing
> > +	 * rate as well. omap_dmic_select_divider() function configures t=
he
> > +	 * dividers for 96KHz, if the current stream is running in 192KHz=
 we
> > +	 * can change the divider value, while respecting the machine dri=
ver
> > +	 * requested clock configuration.
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
> So what happens if the user starts recording at 192kHz then goes back=
 to
> 96kHz?  This all feels a bit clunky and fragile.

I expect another HW param calls. The stream is stopped, and I reconfigu=
re the=20
divider for 96KHz (I will not change the divider here, since the stream=
 is=20
96KHz). I don't see any issue here.

The comment explains the situation, and the reasoning behind of this ch=
eck,=20
and divider reconfiguration.

> It seems like the
> neatest solution here is to just record the desired DMICCLK rate when
> the user sets it and then apply it here rather than doing this patchi=
ng
> later on.

I'm applying the divider in omap_dmic_dai_prepare callback.

--
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

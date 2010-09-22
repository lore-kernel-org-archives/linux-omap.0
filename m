From: hermann pitton <hermann-pitton@arcor.de>
Subject: Re: [PATCH v2 1/6] SoC Camera: add driver for OMAP1 camera
	interface
Date: Wed, 22 Sep 2010 02:10:43 +0200
Message-ID: <1285114243.5561.31.camel@pc07.localdom.local>
References: <201009110317.54899.jkrzyszt@tis.icnet.pl>
	 <201009110321.25852.jkrzyszt@tis.icnet.pl>
	 <Pine.LNX.4.64.1009211639410.11896@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1009211639410.11896@axis700.grange>
Sender: linux-media-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Linux Media Mailing List <linux-media@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Discussion of the Amstrad E3 emailer hardware/software <e3-hacking@earth.li>
List-Id: linux-omap@vger.kernel.org

Hi,

Am Mittwoch, den 22.09.2010, 01:23 +0200 schrieb Guennadi Liakhovetski:
> On Sat, 11 Sep 2010, Janusz Krzysztofik wrote:
> 
> > This is a V4L2 driver for TI OMAP1 SoC camera interface.

[snip]

> > +
> > +	} else {
> > +		dev_warn(dev, "%s: unhandled camera interrupt, status == "
> > +				"0x%0x\n", __func__, it_status);
> 
> Please, don't split strings

sorry for any OT interference.

But, are there any new rules out?

Maybe I missed them.

Either way, the above was forced during the last three years.

Not at all ?

Cheers,
Hermann

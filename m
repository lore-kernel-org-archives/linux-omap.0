From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: ALSA SoC for TWL4030
Date: Fri, 16 May 2008 08:57:24 +0300
Message-ID: <20080516085724.d4997266.jarkko.nikula@nokia.com>
References: <5e088bd90805150818h1c2a5d8ep263811c8baed333a@mail.gmail.com>
	<8AF7AD1D-C577-4C88-9F87-05F742FE2895@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:41099 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946AbYEPF5K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2008 01:57:10 -0400
In-Reply-To: <8AF7AD1D-C577-4C88-9F87-05F742FE2895@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Koen Kooi <k.kooi@student.utwente.nl>
Cc: Steve Sakoman <sakoman@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 15 May 2008 17:39:32 +0200
"ext Koen Kooi" <k.kooi@student.utwente.nl> wrote:

> Op 15 mei 2008, om 17:18 heeft Steve Sakoman het volgende geschreven:
> > I'm thinking of tackling audio support for the OMAP3 EVM next.
> >
> > I'd like to make sure that I'm not duplicating work :-)
> >
> > Is anyone aware of any existing efforts to support the TWL4030 audio
> > functionality?  I've seen the TI work in the 2.6.22 kernel, but it
> > is not an SoC driver and seems to use a different mcbsp
> > implementation than is in the current linux-omap tree.
> 
It would be great to get ASoC driver for TWL4030 since it's the biggest
task to get ASoC audio on OMAP3 EVM. AFAIK TWL4030 is used also in
other EVMs as well so those boards can be supported also by just adding
own ASoC machine drivers for them.

Currently ASoC for OMAP doesn't support yet OMAP3 but it's not very big
issue to add it after low-level McBSP driver supports it. Eduardo
Valentin is currently updating it.

> There does seem to be an ASoC driver for the McBSP2 I2S side, but
> the KConfig entry:
> 
> - --
> 
> config SND_OMAP_SOC_MCBSP
>          tristate
>          select OMAP_MCBSP
> 
> - --
> 
> doesn't show up in menuconfig :(
> 
Convention in ASoC is that only machines are shown and their entries
will then select the codec and link drivers. E.g

config SND_OMAP_SOC_N810
	tristate "SoC Audio support for Nokia N810"
	depends on SND_OMAP_SOC && MACH_NOKIA_N810
	select SND_OMAP_SOC_MCBSP
	select SND_SOC_TLV320AIC3X
	help
	  Say Y if you want to add support for SoC audio on Nokia N810.


Jarkko

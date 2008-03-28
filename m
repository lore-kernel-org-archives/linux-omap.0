From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/4] Add support for TWL4030 codec on 3430 platform
Date: Fri, 28 Mar 2008 10:38:23 +0200
Message-ID: <20080328083822.GI24896@atomide.com>
References: <B082902A12CAEE4EA7FE2ED20609013B02903E4A@dlee15.ent.ti.com> <20080125095255.6db16b18.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55192 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731AbYC1Ii3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Mar 2008 04:38:29 -0400
Content-Disposition: inline
In-Reply-To: <20080125095255.6db16b18.jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: "ext Lopez Cruz, Misael" <x0052729@ti.com>, linux-omap@vger.kernel.org

* Jarkko Nikula <jarkko.nikula@nokia.com> [080125 10:57]:
> On Thu, 24 Jan 2008 15:28:22 -0600
> "ext Lopez Cruz, Misael" <x0052729@ti.com> wrote:
> 
> > Hi,
> > 
> > This patch from OMAP3430 ALSA series was missing since the number of
> > characters in the patch is higher than the allowed by Majordomo.
> > 
> > The patch can be found at link shown below:
> > 
> > http://linux.omap.com/pub/patches/rfc/audio_34xx_support_20071220.patch
> > 
> Hi, my two sents
> 
> We shall stop growing the sound/arm/omap and switch to ASoC model as
> there is the embedded ALSA development going.
> 
> http://alsa-project.org/main/index.php/ASoC
> 
> I'm currently developing SoC support for OMAP. Very early stage still
> but I can start sharing the code when it is in that shape :-)
> 
> Idea is to have one generic OMAP platform driver for DMA engine
> (with non-chained and chained DMA support) and DAI link drivers for
> links we have (most common is McBSP-I2S I think) + machine drivers for
> board specifics and configuration data.
> 
> The platfrom I'm using for this is our N810 since it is the easiest
> platfrom to start with. E.g. there exist a SoC codec driver for AIC33:
> 
> http://mailman.alsa-project.org/pipermail/alsa-devel/2007-November/004148.html
> 
> But as I said, this is in very early stage but I'll share the code here
> first in order to cover most OMAPs but actual merging should go through
> the alsa-devel list.

Yeah, that's the way to go. Misael, can you take a look at Jarkko's
asoc patches and see what it would take to convert to that?

We should get rid of all the non-mainline audio stuff as soon as asoc is
merged.

Tony

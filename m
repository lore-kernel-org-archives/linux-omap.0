From: Tony Lindgren <tony@atomide.com>
Subject: Re: [alsa-devel] [PATCHv4 00/20] OMAP ASoC changes in DMA
	utilization
Date: Mon, 24 Aug 2009 17:00:21 +0300
Message-ID: <20090824140020.GE5165@atomide.com>
References: <1250509879-6703-1-git-send-email-eduardo.valentin@nokia.com> <20090817170549.f0adf2a4.jhnikula@gmail.com> <20090819074011.GA25559@esdhcp037198.research.nokia.com> <20090819074835.GB25559@esdhcp037198.research.nokia.com> <20090819082632.GA19168@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63075 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752468AbZHXOAa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Aug 2009 10:00:30 -0400
Content-Disposition: inline
In-Reply-To: <20090819082632.GA19168@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Eduardo Valentin <eduardo.valentin@nokia.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>

* Mark Brown <broonie@opensource.wolfsonmicro.com> [090819 11:27]:
> On Wed, Aug 19, 2009 at 10:48:35AM +0300, Eduardo Valentin wrote:
> > On Wed, Aug 19, 2009 at 09:40:12AM +0200, Valentin Eduardo (Nokia-D/Helsinki) wrote:
> 
> > > About these changes. I have one doubt. What is the correct tree to base them?
> > > There are changes under arch/arm/plat-omap/ and under sound/soc/omap/.
> 
> ...
> 
> > > Please do not apply this version. Let's define this first, then I send
> > > the correct version.
> 
> > There is 1 Jarkko's patch which changes arch/arm/plat-omap/ which is already
> > in Takashi's tree, IIRC.
> 
> I believe there's colisons with the OMAP1 stuff too.  Might be worth
> applying these on a branch and then providing merges into both the ASoC
> and OMAP trees?

I'm fine with these all going in via the alsa tree. If there are conflicts,
let's get those parts into the omap for-next branch first.

Tony

From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 1/2] McBSP: OMAP3: Add sidetone feature
Date: Thu, 18 Feb 2010 09:16:18 -0800
Message-ID: <20100218171618.GQ21755@atomide.com>
References: <1266417960-22787-1-git-send-email-ilkka.koskinen@nokia.com>
 <1266417960-22787-2-git-send-email-ilkka.koskinen@nokia.com>
 <20100218002543.GG21755@atomide.com>
 <alpine.DEB.2.00.1002181244400.13895@tumpelo.nmp.nokia.com>
 <20100218110106.GC3542@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61488 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758377Ab0BRRPi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 12:15:38 -0500
Content-Disposition: inline
In-Reply-To: <20100218110106.GC3542@rakim.wolfsonmicro.main>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Ilkka Koskinen <ikoskine@nokia.com>, "Koskinen Ilkka (Nokia-D/Tampere)" <ilkka.koskinen@nokia.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "jhnikula@gmail.com" <jhnikula@gmail.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>

* Mark Brown <broonie@opensource.wolfsonmicro.com> [100218 02:58]:
> On Thu, Feb 18, 2010 at 12:58:55PM +0200, Ilkka Koskinen wrote:
> 
> > Is that easiest way to do that? I mean, I'm afraid that the ALSA
> > tree doesn't have Janusz Krzysztofik's McBSP register cache patches
> > nor does it have your "omap3: Replace ARCH_OMAP34XX with ARCH_OMAP3"
> > patch either.
> 
> > Anyway, I'll send the updated patches still today.
> 
> Given that the merge window is likely to open within a week it might be
> simplest to just wait until that's sorted through, or if the patches
> will both apply in the OMAP tree and merge cleanly with ASoC then I'd be
> happy with pushing them that way (I'd expect, I'd need to review the
> second one).

Yeah I can add them once they're OK from ASoC point of view.
Or we can wait and you can merge them later. Either way works
just fine for me.

Regards,

Tony

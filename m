From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 0/5] FIFO caused playback delay (latency) handling in
 soc/omap
Date: Thu, 11 Mar 2010 14:26:55 -0800
Message-ID: <20100311222655.GP2900@atomide.com>
References: <1267621689-30337-1-git-send-email-peter.ujfalusi@nokia.com>
 <20100303133806.GA15105@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52556 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758481Ab0CKWZj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Mar 2010 17:25:39 -0500
Content-Disposition: inline
In-Reply-To: <20100303133806.GA15105@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, lrg@slimlogic.co.uk, jhnikula@gmail.com, ext-eero.nurkkala@nokia.com

* Mark Brown <broonie@opensource.wolfsonmicro.com> [100303 05:34]:
> On Wed, Mar 03, 2010 at 03:08:03PM +0200, Peter Ujfalusi wrote:
> 
> > Peter Ujfalusi (5):
> >   ASoC: core: fix tailing whitespace in soc_pcm_apply_symmetry
> >   ASoC: core: soc level wrapper for pcm_pointer callback
> >   ASoC: core: Add delay operation to snd_soc_dai_ops
> 
> I'll apply these just now, thanks!
> 
> >   OMAP3: McBSP: Add interface for FIFO caused delay query
> >   ASoC: OMAP3: Report delay caused by the internal FIFO
> 
> These also look OK to me but there's the arch/arm dependency.

I think the only one is the McBSP patch above.

Care to take that too to keep things working?

Acked-by: Tony Lindgren <tony@atomide.com>

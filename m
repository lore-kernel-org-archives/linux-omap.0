From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/2] ASoC: omap-mcpdm updates for 3.7
Date: Thu, 18 Oct 2012 15:52:37 -0700
Message-ID: <20121018225237.GJ30550@atomide.com>
References: <1349339236-3622-1-git-send-email-peter.ujfalusi@ti.com>
 <20121017195525.GX15569@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:36924 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750724Ab2JRWwn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Oct 2012 18:52:43 -0400
Content-Disposition: inline
In-Reply-To: <20121017195525.GX15569@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>

* Tony Lindgren <tony@atomide.com> [121017 13:01]:
> Hi Mark,
> 
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [121004 01:27]:
> > Hello Mark, Tony,
> > 
> > Change since v1:
> > - Fixed the second patch to keep the omap_mcpdm_open_stream() - after a coffee
> > 
> > The mcpdm driver no longer needs to include any plat/*.h file, clearing the way
> > for the single kernel image.
> > 
> > Regards,
> > Peter
> > ---
> > Peter Ujfalusi (1):
> >   ASoC: omap-mcpdm: Remove OMAP revision check
> > 
> > Tony Lindgren (1):
> >   ASoC: Fix wrong include for McPDM
> > 
> >  sound/soc/omap/omap-mcpdm.c | 9 ++-------
> >  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> Is it OK for me to merge in your ASoC for-3.7 branch at commit
> 68214d99 (ASoC: omap-mcpdm: Remove OMAP revision check) also
> into my omap cleanup branch for v3.8?
> 
> I need that to avoid compile errors with some of my test configs.

Never mind, that seems to be merged now.

Thanks,

Tony

From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 2/9] ARM: OMAP: mcbsp: Enable FIFO use for OMAP2430
Date: Wed, 22 Aug 2012 14:01:14 -0700
Message-ID: <20120822210114.GL11011@atomide.com>
References: <1345124468-8876-1-git-send-email-peter.ujfalusi@ti.com>
 <1345124468-8876-3-git-send-email-peter.ujfalusi@ti.com>
 <20120822191139.GI7995@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:47889 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933315Ab2HVVBX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Aug 2012 17:01:23 -0400
Content-Disposition: inline
In-Reply-To: <20120822191139.GI7995@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>

* Mark Brown <broonie@opensource.wolfsonmicro.com> [120822 12:12]:
> On Thu, Aug 16, 2012 at 04:41:01PM +0300, Peter Ujfalusi wrote:
> > On OMAP2430 all McBSP ports have 128 word long buffer, enable the use of
> > the FIFO for the audio stack.
> > 
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
> 
> I applied this - Tony, from the thread it seemed you were OK even though
> you didn't explicitly ack it?

Ah yes sorry, I'm fine with it. Sounds like you already applied it,
so too late to ack. But just in case:

Acked-by: Tony Lindgren <tony@atomide.com>

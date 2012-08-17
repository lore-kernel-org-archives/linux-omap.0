From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 1/9] ARM/ASoC: omap-mcbsp: Move OMAP2+ clock
 parenting code to ASoC driver
Date: Fri, 17 Aug 2012 06:06:20 -0700
Message-ID: <20120817130619.GY11011@atomide.com>
References: <1345124468-8876-1-git-send-email-peter.ujfalusi@ti.com>
 <1345124468-8876-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:17447 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754506Ab2HQNG1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Aug 2012 09:06:27 -0400
Content-Disposition: inline
In-Reply-To: <1345124468-8876-2-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120816 06:41]:
> Move the McBSP CLKS re-parenting code to ASoC driver from
> arch/arm/mach-omap2.
> The call fort the re-parenting has been already limited to OMAP2+ SoC in
> the ASoC driver. There is no longer need to have callback function for it.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>

Acked-by: Tony Lindgren <tony@atomide.com>

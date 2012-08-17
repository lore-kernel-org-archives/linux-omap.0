From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 3/9] ARM: OMAP: board-am3517evm: Configure McBSP1
 CLKR/FSR signal source
Date: Fri, 17 Aug 2012 06:07:45 -0700
Message-ID: <20120817130744.GA11011@atomide.com>
References: <1345124468-8876-1-git-send-email-peter.ujfalusi@ti.com>
 <1345124468-8876-4-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:18436 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756794Ab2HQNHu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Aug 2012 09:07:50 -0400
Content-Disposition: inline
In-Reply-To: <1345124468-8876-4-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120816 06:41]:
> am3517evm board uses McBSP1 for audio with 4pin configuration.
> The CLKR/FSR signals need to be connected to CLKX/FSX pin of the SoC in
> this case.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>

Acked-by: Tony Lindgren <tony@atomide.com>

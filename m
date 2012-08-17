From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 5/9] ARM/ASoC: omap-mcbsp: Remove CLKR/FSR mux
 configuration code
Date: Fri, 17 Aug 2012 06:08:33 -0700
Message-ID: <20120817130833.GC11011@atomide.com>
References: <1345124468-8876-1-git-send-email-peter.ujfalusi@ti.com>
 <1345124468-8876-6-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:18996 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753173Ab2HQNIj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Aug 2012 09:08:39 -0400
Content-Disposition: inline
In-Reply-To: <1345124468-8876-6-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120816 06:41]:
> Remove the feature to configure the CLKR/FSR mux on McBSP port with 6pin
> configuration.
> When moving to devicetree these callback can no longer be used in a clean
> way anymore.
> If a board require to change the 6pin port to work in 4pin setup it needs
> to set up the mux in the board file.
> For OMAP2/3:
> u32 devconf0;
> 
> /* McBSP1 CLKR/FSR signal to be connected to CLKX/FSX pin */
> devconf0 = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
> devconf0 |=  OMAP2_MCBSP1_CLKR_MASK | OMAP2_MCBSP1_FSR_MASK;
> omap_ctrl_writel(devconf0, OMAP2_CONTROL_DEVCONF0);
> 
> For OMAP4:
> u32 mcbsp_pad;
> 
> /* McBSP4 CLKR/FSR signal to be connected to CLKX/FSX pin */
> mcbsp_pad = omap4_ctrl_pad_readl(OMAP2_CONTROL_DEVCONF0);
> mcbsp_pad |=  ((1 << 31) | (1 << 30));
> omap4_ctrl_pad_writel(mcbsp_pad, OMAP2_CONTROL_DEVCONF0);
> 
> In case when the kernel is booted with DT blob the pinctrl-single will be
> provided as soon as it is enabled on the platform.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>

Acked-by: Tony Lindgren <tony@atomide.com>

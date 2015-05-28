From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCHv3 10/10] CLK: TI: always enable DESHDCP clock
Date: Thu, 28 May 2015 15:49:23 -0700
Message-ID: <20150528224923.GJ24204@codeaurora.org>
References: <1430906938-26128-1-git-send-email-tomi.valkeinen@ti.com>
 <1430906938-26128-11-git-send-email-tomi.valkeinen@ti.com>
 <555C744C.6070901@ti.com>
 <555C74E8.5010105@ti.com>
 <555CE1BF.4050506@codeaurora.org>
 <20150528042213.22384.12243@quantum>
 <5566B4D1.3050707@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:55563 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932215AbbE1WtY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 May 2015 18:49:24 -0400
Content-Disposition: inline
In-Reply-To: <5566B4D1.3050707@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Michael Turquette <mturquette@linaro.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>

On 05/28, Tero Kristo wrote:
> On 05/28/2015 07:22 AM, Michael Turquette wrote:
> >Just chiming in on the "critical clock" discussion. I'm not planning to
> >merge something that lets Devicetree nodes call clk_enable on a clock.
> >That's what drivers are for.
> >
> >The assigned-rate and assigned-parent stuff that Tero mentioned is more
> >like configuration data for a downstream clock consumer. Clock
> >gating/ungating does not fall under this type of configuration data in
> >my opinion.
> >
> >I think that Tomi's patch to call clk_prepare_enable from
> >dra7xx_dt_clk_init is a reasonable solution to the problem.
> 
> Yea, after this discussion I am fine with this approach also, seeing
> it apparently doesn't cause any ill side-effects.

Well hopefully when the clk is prepared and enabled it isn't
orphaned. Or we're going to be in the same problem as we're
currently in with Sunxi and trying to make EPROBE_DEFER come out
of clk_get().

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

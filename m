From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: clock/PRCM/hwmod fixes for v3.14-rc
Date: Fri, 21 Feb 2014 15:03:01 -0800
Message-ID: <20140221230300.GA5342@atomide.com>
References: <alpine.DEB.2.02.1402192120200.8777@utopia.booyaka.com>
 <53052219.9060109@ti.com>
 <alpine.DEB.2.02.1402200257060.25798@utopia.booyaka.com>
 <53061D61.6000105@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:57864 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754766AbaBUXDO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Feb 2014 18:03:14 -0500
Content-Disposition: inline
In-Reply-To: <53061D61.6000105@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Nishanth Menon <nm@ti.com> [140220 07:24]:
> On 02/19/2014 08:58 PM, Paul Walmsley wrote:
> > On Wed, 19 Feb 2014, Nishanth Menon wrote:
> > 
> >> Paul,
> >> On 02/19/2014 03:22 PM, Paul Walmsley wrote:
> >> [...]
> >>>
> >>> - ----------------------------------------------------------------
> >>> Illia Smyrnov (1):
> >>>       ARM: OMAP4: hwmod: Fix SOFTRESET logic for OMAP4
> >>>
> >>> Suman Anna (1):
> >>>       ARM: DRA7: hwmod data: correct the sysc data for spinlock
> >>>
> >>> Tomi Valkeinen (1):
> >>>       ARM: OMAP2+: clock: fix clkoutx2 with CLK_SET_RATE_PARENT
> >>>
> >>> Vaibhav Bedia (1):
> >>>       ARM: OMAP5: PRM: Fix reboot handling
> >>>
> >>
> >> https://patchwork.kernel.org/patch/3585321/ missing?
> > 
> > If that fixes a bug, then that should be documented in the commit 
> > description.
> > 
> > Otherwise it's 3.15 material.
> Fair enough, this'd be something that might be called an optimization,
> thanks for queueing it.

Thanks pulling this into omap-for-v3.14/fixes.

Tony

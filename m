From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP4: hwmod data: ipu and dsp to use parent clocks
 instead of leaf clocks
Date: Wed, 14 Nov 2012 15:44:21 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1211141542280.16047@utopia.booyaka.com>
References: <1352860750-20100-1-git-send-email-omar.luna@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:54057 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755064Ab2KNPoW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Nov 2012 10:44:22 -0500
In-Reply-To: <1352860750-20100-1-git-send-email-omar.luna@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.luna@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi

On Tue, 13 Nov 2012, Omar Ramirez Luna wrote:

> This prevents hwmod _enable_clocks...omap2_dflt_clk_enable path
> from enabling modulemode inside CLKCTRL using its clk->enable_reg
> field. Instead is left to _omap4_enable_module though soc_ops, as
> the one in charge of this setting.
> 
> According to comments received[1] for related patches the idea is
> to get rid of leaf clocks in future. So remove these two while at it.
> 
> [1] http://lkml.org/lkml/2012/8/20/226
> 
> Signed-off-by: Omar Ramirez Luna <omar.luna@linaro.org>

Does this one belong as part of the "OMAP: iommu: hwmod, reset 
handling and runtime PM" series?  Looks like applying this one separately 
might cause these clocks not to be disabled by either the clock code's 
disable-unused-clocks code, or the hwmod code?


- Paul

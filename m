From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] OMAP3 PM: move omap3 sleep to ddr
Date: Fri, 24 Sep 2010 12:09:30 -0700
Message-ID: <20100924190930.GH4211@atomide.com>
References: <1285325785-6163-1-git-send-email-vishwanath.bs@ti.com>
 <1285325785-6163-2-git-send-email-vishwanath.bs@ti.com>
 <20100924190125.GG4211@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:65226 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179Ab0IXTJa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 15:09:30 -0400
Content-Disposition: inline
In-Reply-To: <20100924190125.GG4211@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath BS <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org, Kevin Hillman <khilman@deeprootsystems.com>

* Tony Lindgren <tony@atomide.com> [100924 11:53]:
> * Vishwanath BS <vishwanath.bs@ti.com> [100924 03:50]:
> > There is no need to keep omap3 sleep code in SRAM. This code can be run very
> > well on DDR. This would help us to instrument CPUIdle latencies.
> 
> Uhh, are you sure about this? To me it sounds like you're then
> relying on the code running from the cache for off-idle?

Actually the caches are off too for off-idle..

Tony

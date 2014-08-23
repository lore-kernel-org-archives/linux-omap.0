From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: Remove twl6030 clk32g "regulator"
Date: Fri, 22 Aug 2014 17:20:24 -0700
Message-ID: <20140823002024.GD17254@atomide.com>
References: <1407865760-15448-1-git-send-email-broonie@kernel.org>
 <20140822231259.GC17254@atomide.com>
 <20140823000403.GG24407@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:35606 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752083AbaHWAU2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Aug 2014 20:20:28 -0400
Content-Disposition: inline
In-Reply-To: <20140823000403.GG24407@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-omap@vger.kernel.org, linaro-kernel@lists.linaro.org

* Mark Brown <broonie@kernel.org> [140822 17:07]:
> On Fri, Aug 22, 2014 at 04:13:00PM -0700, Tony Lindgren wrote:
> > * Mark Brown <broonie@kernel.org> [140812 10:52]:
> 
> > > The kernel has never supported clk32g as a regulator since it is a clock
> > > and not a regulator. Fortunately nothing actually references this node so
> > > we can just remove it.
> 
> > If not too late:
> 
> > Acked-by: Tony Lindgren <tony@atomide.com>
> 
> Definitely not too late - indeed I'd have expected you to apply this.

Sure, let me know if you prefer me to pick it up.

Tony

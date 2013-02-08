From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: smp_twd: convert to use CLKSRC_OF init
Date: Fri, 8 Feb 2013 08:45:10 -0800
Message-ID: <20130208164509.GD7556@atomide.com>
References: <1360270385-24335-1-git-send-email-robherring2@gmail.com>
 <5114D13E.5020308@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:26524 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1946624Ab3BHQpS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Feb 2013 11:45:18 -0500
Content-Disposition: inline
In-Reply-To: <5114D13E.5020308@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Rob Herring <robherring2@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, John Stultz <johnstul@us.ibm.com>, Linus Walleij <linus.walleij@linaro.org>, spear-devel@list.st.com, Rob Herring <rob.herring@calxeda.com>, arm@kernel.org, Viresh Kumar <viresh.linux@gmail.com>, Sascha Hauer <kernel@pengutronix.de>, Thomas Gleixner <tglx@linutronix.de>, Shawn Guo <shawn.guo@linaro.org>

* Santosh Shilimkar <santosh.shilimkar@ti.com> [130208 02:22]:
> On Friday 08 February 2013 02:23 AM, Rob Herring wrote:
> >From: Rob Herring <rob.herring@calxeda.com>
> >
> >Now that we have OF based init with CLKSRC_OF, convert smp_twd init
> >function to use it and covert all callers of
> >twd_local_timer_of_register.
> >
> >Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> 
> [..]
> 
> >  arch/arm/mach-omap2/timer.c         |    2 +-
> 
> For OMAP,
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com> 

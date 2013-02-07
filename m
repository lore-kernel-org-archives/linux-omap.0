From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] ARM: smp_twd: convert to use CLKSRC_OF init
Date: Thu, 07 Feb 2013 14:57:31 -0700
Message-ID: <5114234B.20003@wwwdotorg.org>
References: <1360270385-24335-1-git-send-email-robherring2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:56020 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422658Ab3BGV5f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Feb 2013 16:57:35 -0500
In-Reply-To: <1360270385-24335-1-git-send-email-robherring2@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Tony Lindgren <tony@atomide.com>, John Stultz <johnstul@us.ibm.com>, Linus Walleij <linus.walleij@linaro.org>, spear-devel@list.st.com, Rob Herring <rob.herring@calxeda.com>, arm@kernel.org, Viresh Kumar <viresh.linux@gmail.com>, Sascha Hauer <kernel@pengutronix.de>, Thomas Gleixner <tglx@linutronix.de>, Shawn Guo <shawn.guo@linaro.org>

On 02/07/2013 01:53 PM, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Now that we have OF based init with CLKSRC_OF, convert smp_twd init
> function to use it and covert all callers of
> twd_local_timer_of_register.

Reviewed-by: Stephen Warren <swarren@nvidia.com>

Thanks for cleaning these up. I really should have gone through all the
timer objects and converted them when I implemented the CLKSRC_OF
feature in the first place.

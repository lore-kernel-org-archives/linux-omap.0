From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: smp_twd: convert to use CLKSRC_OF init
Date: Fri, 8 Feb 2013 15:49:42 +0530
Message-ID: <5114D13E.5020308@ti.com>
References: <1360270385-24335-1-git-send-email-robherring2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60754 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760070Ab3BHKTK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Feb 2013 05:19:10 -0500
In-Reply-To: <1360270385-24335-1-git-send-email-robherring2@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Tony Lindgren <tony@atomide.com>, John Stultz <johnstul@us.ibm.com>, Linus Walleij <linus.walleij@linaro.org>, spear-devel@list.st.com, Rob Herring <rob.herring@calxeda.com>, arm@kernel.org, Viresh Kumar <viresh.linux@gmail.com>, Sascha Hauer <kernel@pengutronix.de>, Thomas Gleixner <tglx@linutronix.de>, Shawn Guo <shawn.guo@linaro.org>

On Friday 08 February 2013 02:23 AM, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
>
> Now that we have OF based init with CLKSRC_OF, convert smp_twd init
> function to use it and covert all callers of
> twd_local_timer_of_register.
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>

[..]

>   arch/arm/mach-omap2/timer.c         |    2 +-

For OMAP,
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>


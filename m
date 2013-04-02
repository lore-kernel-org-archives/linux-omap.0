From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v2 02/13] ARM: convert arm/arm64 arch timer to use CLKSRC_OF
 init
Date: Tue, 2 Apr 2013 08:53:58 +0530
Message-ID: <515A4F4E.3060107@ti.com>
References: <1364854883-5961-1-git-send-email-robherring2@gmail.com> <1364854883-5961-3-git-send-email-robherring2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46388 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759353Ab3DBDWo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Apr 2013 23:22:44 -0400
In-Reply-To: <1364854883-5961-3-git-send-email-robherring2@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@arm.linux.org.uk>, John Stultz <john.stultz@linaro.org>, arm@kernel.org, Marc Zyngier <marc.zyngier@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Kukjin Kim <kgene.kim@samsung.com>, Tony Lindgren <tony@atomide.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org

On Tuesday 02 April 2013 03:51 AM, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> This converts arm and arm64 to use CLKSRC_OF DT based initialization for
> the arch timer. A new function arch_timer_arch_init is added to allow for
> arch specific setup.
> 
> This has a side effect of enabling sched_clock on omap5 and exynos5. There
> should not be any reason not to use the arch timers for sched_clock.
> 
Absolutely.

> Signed-off-by: Rob Herring <rob.herring@calxeda.com>

[..]

>  arch/arm/mach-omap2/timer.c                  |    5 +----

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>


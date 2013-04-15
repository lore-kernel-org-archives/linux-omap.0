From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2 02/13] ARM: convert arm/arm64 arch timer to use
 CLKSRC_OF init
Date: Mon, 15 Apr 2013 10:39:58 +0100
Message-ID: <20130415093958.GA29528@arm.com>
References: <1364854883-5961-1-git-send-email-robherring2@gmail.com>
 <1364854883-5961-3-git-send-email-robherring2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1364854883-5961-3-git-send-email-robherring2@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Rutland <Mark.Rutland@arm.com>, Russell King <linux@arm.linux.org.uk>, John Stultz <john.stultz@linaro.org>, "arm@kernel.org" <arm@kernel.org>, Marc Zyngier <Marc.Zyngier@arm.com>, Linus Walleij <linus.walleij@linaro.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Kukjin Kim <kgene.kim@samsung.com>, Tony Lindgren <tony@atomide.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Will Deacon <Will.Deacon@arm.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Apr 01, 2013 at 11:21:12PM +0100, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> This converts arm and arm64 to use CLKSRC_OF DT based initialization for
> the arch timer. A new function arch_timer_arch_init is added to allow for
> arch specific setup.
> 
> This has a side effect of enabling sched_clock on omap5 and exynos5. There
> should not be any reason not to use the arch timers for sched_clock.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-omap@vger.kernel.org
> Cc: linux-sh@vger.kernel.org

Unless you pushed the patches already (I've been away for two weeks),
for arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

From: Mark Greer <mgreer@animalcreek.com>
Subject: Re: [PATCH 5/6] power: bq24190_charger: Check the interrupt status
 on resume
Date: Mon, 16 Jan 2017 12:15:19 -0700
Message-ID: <20170116191519.GI27262@animalcreek.com>
References: <20170112004154.31568-1-tony@atomide.com>
 <20170112004154.31568-6-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170112004154.31568-6-tony@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 11, 2017 at 04:41:53PM -0800, Tony Lindgren wrote:
> Some SoCs like omap3 can configure GPIO irqs to use Linux generic
> dedicated wakeirq support. If the dedicated wakeirq is configured,
> the SoC will use a always-on interrupt controller to produce wake-up
> events.
> 
> If bq24190 is configured for dedicated wakeirq, we need to check the
> interrupt status on PM runtime resume. This is because the Linux
> generic wakeirq will call pm_runtime_resume() on the device on a
> wakeirq. And as the bq24190 interrupt is falling edge sensitive
> and only active for 250 us, there will be no device interrupt seen
> by the runtime SoC IRQ controller.
> 
> Note that this can cause spurious interrupts on omap3 devices with
> bq24190 connected to gpio banks 2 - 5 as there's a glitch on those
> pins waking from off mode as listed in "Advisory 1.45". Devices
> with this issue should not configure the optional wakeirq interrupt
> in the dts file.
> 
> Cc: Mark A. Greer <mgreer@animalcreek.com>
> Cc: Matt Ranostay <matt@ranostay.consulting>
> Cc: Liam Breck <kernel@networkimprov.net>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---

Looks good except for what Liam pointed out so assuming that gets fixed:

Acked-by: Mark Greer <mgreer@animalcreek.com>

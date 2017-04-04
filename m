From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] mfd: cpcap: Fix interrupt to use level interrupt
Date: Tue, 4 Apr 2017 10:04:10 +0100
Message-ID: <20170404090410.GX6986@localhost.localdomain>
References: <20170404031556.5093-1-tony@atomide.com>
 <20170404031556.5093-2-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170404031556.5093-2-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Apr 03, 2017 at 08:15:54PM -0700, Tony Lindgren wrote:
> I made a mistake assuming the device tree configuration for interrupt
> triggering was somehow passed to the SPI device but it's not.
> 
> In the Motorola Linux kernel tree CPCAP PMIC is configured as a rising
> edge triggered interrupt, but then then it's interrupt handler keeps
> looping until the GPIO line goes down. So the CPCAP interrupt is clearly
> a level interrupt and not an edge interrupt.
> 
> Earlier when I tried to configure it as level interrupt using the
> device tree, I did not account that the triggering only gets passed
> to the SPI core and it also needs to be specified in the CPCAP driver
> when we do devm_regmap_add_irq_chip().
> 
> Fixes: 56e1d40d3bea ("mfd: cpcap: Add minimal support")
> Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> Cc: Marcel Partap <mpartap@gmx.net>
> Cc: Michael Scott <michael.scott@linaro.org>
> Cc: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---

Thanks for looking into that further, I thought that might be
what was going on.

Reviewed-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles

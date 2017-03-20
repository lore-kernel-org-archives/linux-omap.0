From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] regmap: irq: Fix lost interrupts by introducing
 handle_reread
Date: Mon, 20 Mar 2017 15:14:13 +0000
Message-ID: <20170320151413.GT6986@localhost.localdomain>
References: <20170317003633.7361-1-tony@atomide.com>
 <20170317003633.7361-2-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170317003633.7361-2-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Mar 16, 2017 at 05:36:30PM -0700, Tony Lindgren wrote:
> At least Motorola CPCAP PMIC needs it's device interrupts re-read
> until there are no more interrupts. Otherwise the PMIC interrupt to
> the SoC will eventually stop toggling.
> 
> Let's allow doing that by introducing a flag for handle_reread
> and by splitting regmap_irq_thread() into two separate functions
> for regmap_read_irq_status() and regmap_irq_handle_pending().
> 

Is this actually a property of this hardware or is this just a
result of connecting a device that generates level IRQs to a host
that is expecting an edge triggered IRQ?

Thanks,
Charles

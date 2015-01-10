From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v2 02/21] irqchip: tegra: add DT-based support for  legacy interrupt controller
Date: Sat, 10 Jan 2015 12:24:19 +0000
Message-ID: <ed9e71ffc86ab2f2716ac99163434638@www.loen.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from inca-roads.misterjones.org ([213.251.177.50]:46367 "EHLO
	inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751991AbbAJMvF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 10 Jan 2015 07:51:05 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Nishanth Menon <nm@ti.com>, Alexandre Courbot <gnurou@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, Sascha Hauer <kernel@pengutronix.de>, Stephen Warren <swarren@wwwdotorg.org>, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, Simon Horman <horms@verge.net.au>, Benoit Cousson <bcousson@baylibre.com>, Santosh Shilimkar <ssantosh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Shawn Guo <shawn.guo@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Jason Cooper <jason@lakedaemon.net>

On 2015-01-08 10:13, Thierry Reding wrote:
> On Wed, Jan 07, 2015 at 05:42:37PM +0000, Marc Zyngier wrote:
>> Tegra's LIC (Legacy Interrupt Controller) has been so far only
>> supported as a weird extension of the GIC, which is not exactly
>> pretty.
>>
>> The stacked irq domain framework fits this pretty well, and allows
>
> Nit: s/irq/IRQ/
>
>> the LIC code to be turned into a standalone irqchip. In the process,
>> make the driver DT aware, something that was sorely missing from
>> the mach-tegra implementation.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  drivers/irqchip/Makefile    |   1 +
>>  drivers/irqchip/irq-tegra.c | 335 
>> ++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 336 insertions(+)
>>  create mode 100644 drivers/irqchip/irq-tegra.c
>
> This matches largely what I have in a local patch (modulo the stacked
> domains vs. gic_arch_extn). A few comments below.

[snip]

Thanks for the extensive review. I've implemented all of this, except 
for the hunk below:

>
>> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
>> index 9516a32..59f34be 100644
>> --- a/drivers/irqchip/Makefile
>> +++ b/drivers/irqchip/Makefile
>> @@ -6,6 +6,7 @@ obj-$(CONFIG_ARCH_HIP04)		+= irq-hip04.o
>>  obj-$(CONFIG_ARCH_MMP)			+= irq-mmp.o
>>  obj-$(CONFIG_ARCH_MVEBU)		+= irq-armada-370-xp.o
>>  obj-$(CONFIG_ARCH_MXS)			+= irq-mxs.o
>> +obj-$(CONFIG_ARCH_TEGRA)		+= irq-tegra.o
>>  obj-$(CONFIG_ARCH_S3C24XX)		+= irq-s3c24xx.o
>
> Should these be sorted alphabetically?

Well, the left side is (up to S3C24xx, and then it all goes down the 
drain).
Do you have a suggestion?

Thanks,

         M.
-- 
Fast, cheap, reliable. Pick two.

From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v4 13/21] ARM: omap: convert wakeupgen to stacked domains
Date: Wed, 21 Jan 2015 17:22:38 +0000
Message-ID: <54BFE05E.9080403@arm.com>
References: <1421660655-21394-1-git-send-email-marc.zyngier@arm.com> <1421660655-21394-14-git-send-email-marc.zyngier@arm.com> <20150121163031.GR7718@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:40333 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753678AbbAURWs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Jan 2015 12:22:48 -0500
In-Reply-To: <20150121163031.GR7718@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Kukjin Kim <kgene.kim@samsung.com>, Pankaj Dubey <pankaj.dubey@samsung.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>, Stefan Agner <stefan@agner.ch>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-o

On 21/01/15 16:30, Tony Lindgren wrote:
> * Marc Zyngier <marc.zyngier@arm.com> [150119 01:48]:
>> OMAP4/5 has been (ab)using the gic_arch_extn to provide
>> wakeup from suspend, and it makes a lot of sense to convert
>> this code to use stacked domains instead.
>>
>> This patch does just this, updating the DT files to actually
>> reflect what the HW provides.
>>
>> BIG FAT WARNING: because the DTs were so far lying by not
>> exposing the WUGEN HW block, kernels with this patch applied
>> won't have any suspend-resume facility when booted with old DTs,
>> and old kernels with updated DTs won't even boot.
>>
>> On a platform with this patch applied, the system looks like
>> this:
>>
>> root@bacon-fat:~# cat /proc/interrupts
>>             CPU0       CPU1
>>  16:          0          0     WUGEN  37  gp_timer
>>  19:     233799     155916       GIC  27  arch_timer
>>  23:          0          0     WUGEN   9  l3-dbg-irq
>>  24:          1          0     WUGEN  10  l3-app-irq
>>  27:        282          0     WUGEN  13  omap-dma-engine
>>  44:          0          0  4ae10000.gpio  13  DMA
> 
> You may want to update this part for the fix :)

Ah, yes. Thanks for noticing this.

> I gave this a quick boot test on am437x-gp-evm and the
> interrupts look OK with the fix also applied:
> 
> # cat /proc/interrupts 
>             CPU0       
>  16:        657     WUGEN  68  gp_timer
>  18:          0     WUGEN   9  l3-dbg-irq
>  19:          0     WUGEN  10  l3-app-irq
>  20:          5     WUGEN  12  edma
>  22:          0     WUGEN  14  edma_error
>  23:         96     WUGEN  72  OMAP UART0
>  33:          0  44e07000.gpio   6  mmc0
> 158:         52     WUGEN  70  44e0b000.i2c
> 159:          0     WUGEN  71  4802a000.i2c
> 160:         35     WUGEN  64  mmc0
> 161:          0     WUGEN  40  4a100000.ethernet
> 162:       7739     WUGEN  41  4a100000.ethernet
> 163:       7608     WUGEN  42  4a100000.ethernet
> 164:          0     WUGEN  43  4a100000.ethernet
> 170:          0     WUGEN 100  gpmc
> 180:          0     WUGEN   7  tps65218
> IPI0:          0  CPU wakeup interrupts
> IPI1:          0  Timer broadcast interrupts
> IPI2:          0  Rescheduling interrupts
> IPI3:          0  Function call interrupts
> IPI4:          0  Single function call interrupts
> IPI5:          0  CPU stop interrupts
> IPI6:          0  IRQ work interrupts
> IPI7:          0  completion interrupts
> Err:          0

Interesting. No TWD timer on this one?

> Also verified that suspend and resume to a serial console event
> works on omap4430-sdp. So please feel free to add:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

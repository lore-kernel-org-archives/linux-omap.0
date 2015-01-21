From: santosh shilimkar <santosh.shilimkar@oracle.com>
Subject: Re: [PATCH v4 13/21] ARM: omap: convert wakeupgen to stacked domains
Date: Wed, 21 Jan 2015 12:12:34 -0800
Message-ID: <54C00832.1070807@oracle.com>
References: <1421660655-21394-1-git-send-email-marc.zyngier@arm.com> <1421660655-21394-14-git-send-email-marc.zyngier@arm.com> <20150121163031.GR7718@atomide.com> <54BFE05E.9080403@arm.com> <20150121183615.GS7718@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:41667 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768AbbAUUNs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Jan 2015 15:13:48 -0500
In-Reply-To: <20150121183615.GS7718@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Marc Zyngier <marc.zyngier@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Kukjin Kim <kgene.kim@samsung.com>, Pankaj Dubey <pankaj.dubey@samsung.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>, Stefan Agner <stefan@agner.ch>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-o

On 1/21/2015 10:36 AM, Tony Lindgren wrote:
> * Marc Zyngier <marc.zyngier@arm.com> [150121 09:25]:
>> On 21/01/15 16:30, Tony Lindgren wrote:
>>
>>> I gave this a quick boot test on am437x-gp-evm and the
>>> interrupts look OK with the fix also applied:
>>>
>>> # cat /proc/interrupts
>>>              CPU0
>>>   16:        657     WUGEN  68  gp_timer
>>>   18:          0     WUGEN   9  l3-dbg-irq
>>>   19:          0     WUGEN  10  l3-app-irq
>>>   20:          5     WUGEN  12  edma
>>>   22:          0     WUGEN  14  edma_error
>>>   23:         96     WUGEN  72  OMAP UART0
>>>   33:          0  44e07000.gpio   6  mmc0
>>> 158:         52     WUGEN  70  44e0b000.i2c
>>> 159:          0     WUGEN  71  4802a000.i2c
>>> 160:         35     WUGEN  64  mmc0
>>> 161:          0     WUGEN  40  4a100000.ethernet
>>> 162:       7739     WUGEN  41  4a100000.ethernet
>>> 163:       7608     WUGEN  42  4a100000.ethernet
>>> 164:          0     WUGEN  43  4a100000.ethernet
>>> 170:          0     WUGEN 100  gpmc
>>> 180:          0     WUGEN   7  tps65218
>>> IPI0:          0  CPU wakeup interrupts
>>> IPI1:          0  Timer broadcast interrupts
>>> IPI2:          0  Rescheduling interrupts
>>> IPI3:          0  Function call interrupts
>>> IPI4:          0  Single function call interrupts
>>> IPI5:          0  CPU stop interrupts
>>> IPI6:          0  IRQ work interrupts
>>> IPI7:          0  completion interrupts
>>> Err:          0
>>
>> Interesting. No TWD timer on this one?
>
> Good question, adding Felipe to cc. It eems to be there in
> the TRM in "Table 2-3.  L4_PER Peripheral Memory Map" as
> MPU_PRV_TIMERS. Also seems to actually work with the
> attached patch:
>
TWD is useless on this machine since single core and TWD
as know die in low power states. All the broadcast stuff
is for SMP machines.

Above is expected and correct and no patching is needed.

Regards,
Santosh

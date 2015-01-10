From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v2 13/21] DT: omap4/5: add binding for the wake-up  generator
Date: Sat, 10 Jan 2015 13:22:39 +0000
Message-ID: <8ca5707842bd054bbf4f015734fd253b@www.loen.fr>
References: <1420652576-22309-1-git-send-email-marc.zyngier@arm.com>
 <1420652576-22309-14-git-send-email-marc.zyngier@arm.com>
 <20150108165246.GC25986@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from inca-roads.misterjones.org ([213.251.177.50]:36718 "EHLO
	inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752441AbbAJNWw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 10 Jan 2015 08:22:52 -0500
In-Reply-To: <20150108165246.GC25986@kahuna>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Alexandre Courbot <gnurou@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, Sascha Hauer <kernel@pengutronix.de>, Simon Horman <horms@verge.net.au>, Stephen Warren <swarren@wwwdotorg.org>, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Santosh Shilimkar <ssantosh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org, Jason Cooper <jason@lakedaemon.net>

On 2015-01-08 16:52, Nishanth Menon wrote:
> On 17:42-20150107, Marc Zyngier wrote:
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  .../interrupt-controller/ti,omap4-wugen-mpu        | 32 
>> ++++++++++++++++++++++
>>  1 file changed, 32 insertions(+)
>>  create mode 100644 
>> Documentation/devicetree/bindings/interrupt-controller/ti,omap4-wugen-mpu
>>
>> diff --git 
>> a/Documentation/devicetree/bindings/interrupt-controller/ti,omap4-wugen-mpu 
>> b/Documentation/devicetree/bindings/interrupt-controller/ti,omap4-wugen-mpu
>> new file mode 100644
>> index 0000000..16149d9
>> --- /dev/null
>> +++ 
>> b/Documentation/devicetree/bindings/interrupt-controller/ti,omap4-wugen-mpu
>> @@ -0,0 +1,32 @@
>> +TI OMAP4 Wake-up Generator
>> +
>> +All TI OMAP4/5 (and their derivatives) an interrupt controllerthat
> controller that
>> +routes interrupts to the GIC, and also serves as a wakeup source. 
>> It
>> +is also refered to as "WUGEN-MPU", hence the name of the binding.
>> +
>> +Reguired properties:
>> +
>> +- compatible : should contain at least "ti,omap4-wugen-mpu"
> Could we also document ti,omap5-wugen-mpu. In addition, if you could
> make this patch prior to patch #12, it helps the checkpatch at the 
> very
> least ;)

Sure.

> also saw a few checkpatch warnings:
> +WARNING: 'refered' may be misspelled - perhaps 'referred'?
> +#22: FILE:
> 
> Documentation/devicetree/bindings/interrupt-controller/ti,omap4-wugen-mpu:5:
> ++is also refered to as "WUGEN-MPU", hence the name of the binding.
> +WARNING: 'explicitely' may be misspelled - perhaps 'explicitly'?
> +#39: FILE:
> 
> Documentation/devicetree/bindings/interrupt-controller/ti,omap4-wugen-mpu:22:
> ++  are explicitely forbiden.
>
>> +- reg : Specifies base physical address and size of the registers.
>> +- interrupt-controller : Identifies the node as an interrupt 
>> controller.
>> +- #interrupt-cells : Specifies the number of cells needed to encode 
>> an
>> +  interrupt source. The value must be 3.
>> +- interrupt-parent : a phandle to the GIC these interrupts are 
>> routed
>> +  to.
>> +
>> +Notes:
>> +
>> +- Because this HW ultimately routes interrupts to the GIC, the
>> +  interrupt specifier must be that of the GIC.
>> +- Only SPIs can use the ictlr as an interrupt parent. SGIs and PPIs
>
> I think you mean interrupt controller and not nvidia ictlr here.. :)

-ECOPYPASTE... ;-)

Thanks,

          M.
-- 
Fast, cheap, reliable. Pick two.

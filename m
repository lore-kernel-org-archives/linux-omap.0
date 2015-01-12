From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v2 00/21] irqchip: gic: killing gic_arch_extn and co,
 slowly
Date: Mon, 12 Jan 2015 15:39:11 +0000
Message-ID: <54B3EA9F.3030501@arm.com>
References: <1420652576-22309-1-git-send-email-marc.zyngier@arm.com> <CAL_JsqLLGn1mZr7eNuLA1=M7BcwFRdOQ6xQGo+bbc2aScAVrnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqLLGn1mZr7eNuLA1=M7BcwFRdOQ6xQGo+bbc2aScAVrnQ@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Kukjin Kim <kgene.kim@samsung.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 12/01/15 14:14, Rob Herring wrote:
> On Wed, Jan 7, 2015 at 11:42 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> The gic_arch_extn hack that a number of platform use has been nagging
>> me for too long. It is only there for the benefit of a few platform,
>> and yet it impacts all GIC users. Moreover, it gives people the wrong
>> idea ("let's use it to put some new custom hack in there"...).
>>
>> But now that stacked irq domains have landed in -next, the time has
>> come for gic_arch_extn to meet the Big Bit Bucket.
> 
> [...]
> 
>> - This actively *breaks* existing setups. Once you boot a new kernel
>>   with an old DT, suspend/resume *will* be broken. Old kernels on a
>>   new DT won't even boot! You've been warned. This really outline the
>>   necessity of actually describing the HW in device trees...
> 
> Just to be clear, you need some agreement from the maintainers of
> those platforms before doing this. It doesn't appear there is
> disagreement, but I don't see any explicit agreement either.

I'm not trying to go behind anyone's back, if that's your concern. I
fully intend to obtain every maintainer's explicit acknowledgement
before removing any feature from the kernel. The warning above is there
to get the maintainers attention on the disrupting effect of this series.

> This seems to model the interrupts as chained, but at least for some
> cases aren't these auxiliary controllers in parallel to the GIC? In

>From looking at the various TRMs, they all look to be chained interrupt
controllers (at least Tegra, OMAP and IMX6 show this). I have not been
able to find a publicly available TRM for any of the Samsung platforms,
so this one could be different (but I really doubt it somehow).

> other words, do the they require configuration for interrupts to work
> for the normal non-wakeup use? I'm not sure that the h/w is being
> modeled any more accurately if that is the case. However, we don't
> really have a way to describe an interrupt line is connected to 2
> interrupt parents in DT, so I'm not sure what else you could do here.

The main problem is that they are not general-purpose interrupt
controllers. They all come first on the interrupt path, and somehow feed
two signals into the GIC: the actual interrupt, and the bypass signal.

None of that is representable in DT. I'm willing to take any idea though.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

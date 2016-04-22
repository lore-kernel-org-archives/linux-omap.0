From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH V2 13/14] dt-bindings: arm-gic: Add documentation for
 Tegra210 AGIC
Date: Fri, 22 Apr 2016 15:57:12 +0100
Message-ID: <571A3BC8.90906@nvidia.com>
References: <1461150237-15580-1-git-send-email-jonathanh@nvidia.com>
 <1461150237-15580-14-git-send-email-jonathanh@nvidia.com>
 <20160422100052.GA10606@leverpostej> <571A0739.3090502@nvidia.com>
 <20160422112239.GF10606@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160422112239.GF10606@leverpostej>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Linus Walleij <linus.walleij@linaro.org>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


On 22/04/16 12:22, Mark Rutland wrote:
> On Fri, Apr 22, 2016 at 12:12:57PM +0100, Jon Hunter wrote:
>>
>> On 22/04/16 11:00, Mark Rutland wrote:
>>> On Wed, Apr 20, 2016 at 12:03:56PM +0100, Jon Hunter wrote:
>>>> The Tegra AGIC interrupt controller is compatible with the ARM GIC-400
>>>> interrupt controller.
>>>
>>> The cover letter says it _is_ a GIC-400, just used in a slightly unusual
>>> manner (i.e. not directly connected to CPUs).
>>
>> Correct.
>>
>>>> The Tegra AGIC requires two clocks, namely the
>>>> "ape" (functional) and "apb2ape" (interface) clocks, to operate. Add
>>>> the compatible string and clock information for the AGIC to the GIC
>>>> device-tree binding documentation.
>>>
>>> The GIC-400 spec only describes "CLK" (which is what I imagine "ape" is.
>>> There isn't an APB clock described, and the manual seems to show GIC-400
>>> directly connected to AXI rather than APB, so that doesn't seem to even
>>> be the usual "apb_pclk".
>>>
>>> Is there some wrapper logic around a GIC-400 to giove it an APB
>>> interface? Or am I misudnerstanding the spec?
>>
>> Looking at the Tegra documentation what we have is ...
>>
>> APB --> AXI switch --> AGIC (GIC400)
>>
>> I am not sure how such a switch would typically be modeled in DT but we
>> need the apb clock to interface to the GIC registers. I am not sure if
>> something like simple-pm-bus is appropriate here.
> 
> I think we need some representation of that AXI switch in the DT;
> whether simple-pm-bus is appropriate is another question. We probably
> need a specific compatible string / binding regardless.

OK, I will have a look at that.

>>> The clock-names don't seem right to me, as they sound like provide names
>>> or global clock line names rather than consumer-side names ("clk" and
>>> "apb_pclk").
>>
>> Yes that would be fine with me.
> 
> Ok; if we model the apb_pclk as owned by the AXI switch (which it is),
> then there's no change for the GIC binding, short of the additional
> compatible string as an extension of "arm,gic-400", as we already model
> that clock in the GIC-400 binding.

Yes that makes sense.

Thanks
Jon

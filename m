From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v2 04/21] ARM: tegra: update DTs to expose legacy  interrupt controller
Date: Sat, 10 Jan 2015 12:37:58 +0000
Message-ID: <d6fe000bdc6f2fbfc18f0695ce88c321@www.loen.fr>
References: <1420652576-22309-1-git-send-email-marc.zyngier@arm.com>
 <1420652576-22309-5-git-send-email-marc.zyngier@arm.com>
 <20150108104141.GF1987@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20150108104141.GF1987@ulmo.nvidia.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Nishanth Menon <nm@ti.com>, Alexandre Courbot <gnurou@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, Sascha Hauer <kernel@pengutronix.de>, Stephen Warren <swarren@wwwdotorg.org>, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, Simon Horman <horms@verge.net.au>, Benoit Cousson <bcousson@baylibre.com>, Santosh Shilimkar <ssantosh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Shawn Guo <shawn.guo@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Jason Cooper <jason@lakedaemon.net>
List-Id: linux-omap@vger.kernel.org

On 2015-01-08 10:41, Thierry Reding wrote:
> On Wed, Jan 07, 2015 at 05:42:39PM +0000, Marc Zyngier wrote:
>> Describe the legacy interrupt controller in every tegra DTSI files,
>> and make it the parent of most interrupts.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm/boot/dts/tegra114.dtsi | 16 +++++++++++++++-
>>  arch/arm/boot/dts/tegra124.dtsi | 16 +++++++++++++++-
>>  arch/arm/boot/dts/tegra20.dtsi  | 15 ++++++++++++++-
>>  arch/arm/boot/dts/tegra30.dtsi  | 16 +++++++++++++++-
>>  4 files changed, 59 insertions(+), 4 deletions(-)
>>

I've updated the patch to reflect the requested changes. See below for 
the few contentious points:

[...]

>> @@ -134,6 +134,19 @@
>>  		      <0x50046000 0x2000>;
>>  		interrupts = <GIC_PPI 9
>>  			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
>> +		interrupt-parent = <&gic>;
>
> Is this allowed? It makes the GIC its own parent. I guess we need it 
> to
> stop a loop from GIC -> LIC -> GIC, but it doesn't look quite right.

This seems to be the expected construct to override a parent interrupt 
controller. Actually, this is already what happens when you have a 
single interrupt-controller and a global interrupt-parent property.

[...]

>>  	timer@60005000 {
>> @@ -766,5 +779,6 @@
>>  				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>>  			<GIC_PPI 10
>>  				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>> +		interrupt-parent = <&gic>;
>
> Why does this get to have a non-default parent?

The per-cpu timers are using PPIs.  As such,. they are not routed 
through the LIC, but are wired to the GIC instead.

[...]

>>  	timer@60005000 {
>>  		compatible = "nvidia,tegra20-timer";
>>  		reg = <0x60005000 0x60>;
>
> Why doesn't the Tegra timer get to keep the GIC as parent like for
> Tegra114 and Tegra124? Instead I see that the Cortex-A9 TWD timer 
> gets
> to keep the parent instead.

The Tegra timer is using SPI (and can probably be used as a wake-up 
source). As such, it is connected to the LIC, not to the GIC.

Per-CPU timers (arch timer for A15 and TWD for A9) are all using PPIs, 
and are directly wired to the GIC.

[...]

>>  	timer@60005000 {
>>  		compatible = "nvidia,tegra30-timer", "nvidia,tegra20-timer";
>>  		reg = <0x60005000 0x400>;
>
> Like for Tegra20, the Tegra timer is now switched to the LIC as 
> parent.

Which, in my understanding, is the right thing to do. Unless I missed 
something obvious about this?

Thanks,

         M.
-- 
Fast, cheap, reliable. Pick two.

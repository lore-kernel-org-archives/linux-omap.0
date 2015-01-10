From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH v2 14/21] ARM: imx6: convert GPC to stacked domains
Date: Sat, 10 Jan 2015 15:16:16 +0100
Message-ID: <48c8974495836a5c73b6c11e379a8a73@agner.ch>
References: <1420652576-22309-1-git-send-email-marc.zyngier@arm.com>
 <1420652576-22309-15-git-send-email-marc.zyngier@arm.com>
 <e8cdeef8763e808940d08f4c1b12b71c@agner.ch>
 <322c674668ee442ea24740a01ef6f758@www.loen.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <322c674668ee442ea24740a01ef6f758@www.loen.fr>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Nishanth Menon <nm@ti.com>, Alexandre Courbot <gnurou@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, Sascha Hauer <kernel@pengutronix.de>, Simon Horman <horms@verge.net.au>, Stephen Warren <swarren@wwwdotorg.org>, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Santosh Shilimkar <ssantosh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Shawn Guo <shawn.guo@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Jason Cooper <jason@lakedaemon.net>
List-Id: linux-omap@vger.kernel.org

On 2015-01-10 14:34, Marc Zyngier wrote:
> On 2015-01-09 17:40, Stefan Agner wrote:
>> Hi Marc,
>>
>> On 2015-01-07 18:42, Marc Zyngier wrote:
>>> IMX6 has been (ab)using the gic_arch_extn to provide
>>> wakeup from suspend, and it makes a lot of sense to convert
>>> this code to use stacked domains instead.
>>>
>>> This patch does just this, updating the DT files to actually
>>> reflect what the HW provides.
>>>
>>> BIG FAT WARNING: because the DTs were so far lying by not
>>> exposing the fact that the GPC block is actually the first
>>> interrupt controller in the chain, kernels with this patch
>>> applied wont have any suspend-resume facility when booted
>>> with old DTs, and old kernels with updated DTs won't even boot.
>>>
>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>> ---
>>>  arch/arm/boot/dts/imx6qdl.dtsi  |   6 +-
>>>  arch/arm/boot/dts/imx6sl.dtsi   |   5 +-
>>>  arch/arm/boot/dts/imx6sx.dtsi   |   5 +-
>>>  arch/arm/mach-imx/common.h      |   1 -
>>>  arch/arm/mach-imx/gpc.c         | 127 ++++++++++++++++++++++++++++++++--------
>>>  arch/arm/mach-imx/mach-imx6q.c  |   1 -
>>>  arch/arm/mach-imx/mach-imx6sl.c |   1 -
>>>  arch/arm/mach-imx/mach-imx6sx.c |   1 -
>>>  8 files changed, 116 insertions(+), 31 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
>>> index 4fc03b7..c16d428 100644
>>> --- a/arch/arm/boot/dts/imx6qdl.dtsi
>>> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
>>> @@ -53,6 +53,7 @@
>>>  		interrupt-controller;
>>>  		reg = <0x00a01000 0x1000>,
>>>  		      <0x00a00100 0x100>;
>>> +		interrupt-parent = <&intc>;
>>>  	};
>>>
>>>  	clocks {
>>> @@ -82,7 +83,7 @@
>>>  		#address-cells = <1>;
>>>  		#size-cells = <1>;
>>>  		compatible = "simple-bus";
>>> -		interrupt-parent = <&intc>;
>>> +		interrupt-parent = <&gpc>;
>>>  		ranges;
>>>
>>>  		dma_apbh: dma-apbh@00110000 {
>>> @@ -122,6 +123,7 @@
>>>  			compatible = "arm,cortex-a9-twd-timer";
>>>  			reg = <0x00a00600 0x20>;
>>>  			interrupts = <1 13 0xf01>;
>>> +			interrupt-parent = <&intc>;
>>>  			clocks = <&clks IMX6QDL_CLK_TWD>;
>>>  		};
>>>
>>> @@ -694,8 +696,10 @@
>>>  			gpc: gpc@020dc000 {
>>>  				compatible = "fsl,imx6q-gpc";
>>>  				reg = <0x020dc000 0x4000>;
>>> +				interrupt-controller;
>>
>> #interrupt-cells = <3>; is missing here.
> 
> Ah, nice catch!
> 
>> I tested the patchset on a Colibri iMX6, but the module stopped booting
>> at some point. No error, no warn, but it looked like IRQ's are not
>> working:
>>
>> [    1.623939] platform sound: Driver imx-sgtl5000 requests probe
>> deferral
>> [    1.630677] backlight supply power not found, using dummy regulator
>> [    1.637067] pwm-backlight backlight: unable to request PWM, trying
>> legacy API
>> [    1.644271] pwm-backlight backlight: unable to request legacy PWM
>> [    1.650534] platform backlight: Driver pwm-backlight requests probe
>> deferral
>> [    1.658080] platform 2028000.ssi: Driver fsl-ssi-dai requests probe
>> deferral
>> [    1.665441] fec 2188000.ethernet eth0: Freescale FEC PHY driver
>> [Micrel KSZ8041] (mii_bus:phy_addr=2188000.ethernet:00, irq=-1)
>> [    1.677157] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
>> [freeze]
>>
>> I figured out that the GPC code did not get called. After digging
>> through the parsing code, I found the reason: irq_find_host always opted
>> to intc because this was missing... So, interrupt-cells mandatory for
>> all interrupt-controller? Maybe we could add a warn somewhere..?
> 
> interrupt-cells has a default of 1, I believe. I suppose I could add a
> WARN_ON in the xlate/alloc functions...
> 

I think the problem was in of_irq_find_parent (of drivers/of/irq.c). In
that while, interrupt-controller without interrupt-cells just get
ignored.

>> With that in place, it worked fine:
>>
>> Tested-by: Stefan Agner <stefan@agner.ch>
> 
> Thanks!
> 
>>
>>>  				interrupts = <0 89 IRQ_TYPE_LEVEL_HIGH>,
>>>  					     <0 90 IRQ_TYPE_LEVEL_HIGH>;
>>> +				interrupt-parent = <&intc>;
>>>  			};
>>>
>>>  			gpr: iomuxc-gpr@020e0000 {
>>> diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
>>> index 36ab8e0..35099b7 100644
>>> --- a/arch/arm/boot/dts/imx6sl.dtsi
>>> +++ b/arch/arm/boot/dts/imx6sl.dtsi
>>> @@ -72,6 +72,7 @@
>>>  		interrupt-controller;
>>>  		reg = <0x00a01000 0x1000>,
>>>  		      <0x00a00100 0x100>;
>>> +		interrupt-parent = <&intc>;
>>>  	};
>>>
>>>  	clocks {
>>> @@ -95,7 +96,7 @@
>>>  		#address-cells = <1>;
>>>  		#size-cells = <1>;
>>>  		compatible = "simple-bus";
>>> -		interrupt-parent = <&intc>;
>>> +		interrupt-parent = <&gpc>;
>>>  		ranges;
>>>
>>>  		ocram: sram@00900000 {
>>> @@ -603,7 +604,9 @@
>>>  			gpc: gpc@020dc000 {
>>>  				compatible = "fsl,imx6sl-gpc", "fsl,imx6q-gpc";
>>>  				reg = <0x020dc000 0x4000>;
>>> +				interrupt-controller;
>>>  				interrupts = <0 89 IRQ_TYPE_LEVEL_HIGH>;
>>> +				interrupt-parent = <&intc>;
>>>  			};
>>>
>>>  			gpr: iomuxc-gpr@020e0000 {
>>> diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
>>> index 7a24fee..c476e67 100644
>>> --- a/arch/arm/boot/dts/imx6sx.dtsi
>>> +++ b/arch/arm/boot/dts/imx6sx.dtsi
>>> @@ -88,6 +88,7 @@
>>>  		interrupt-controller;
>>>  		reg = <0x00a01000 0x1000>,
>>>  		      <0x00a00100 0x100>;
>>> +		interrupt-parent = <&intc>;
>>>  	};
>>>
>>>  	clocks {
>>> @@ -131,7 +132,7 @@
>>>  		#address-cells = <1>;
>>>  		#size-cells = <1>;
>>>  		compatible = "simple-bus";
>>> -		interrupt-parent = <&intc>;
>>> +		interrupt-parent = <&gpc>;
>>>  		ranges;
>>>
>>>  		pmu {
>>> @@ -700,7 +701,9 @@
>>>  			gpc: gpc@020dc000 {
>>>  				compatible = "fsl,imx6sx-gpc", "fsl,imx6q-gpc";
>>>  				reg = <0x020dc000 0x4000>;
>>> +				interrupt-controller;
>>>  				interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
>>> +				interrupt-parent = <&intc>;
>>>  			};
>>>
>>>  			iomuxc: iomuxc@020e0000 {
>>> diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
>>> index cfcdb62..7052302 100644
>>> --- a/arch/arm/mach-imx/common.h
>>> +++ b/arch/arm/mach-imx/common.h
>>> @@ -102,7 +102,6 @@ static inline void imx_scu_map_io(void) {}
>>>  static inline void imx_smp_prepare(void) {}
>>>  #endif
>>>  void imx_src_init(void);
>>> -void imx_gpc_init(void);
>>>  void imx_gpc_pre_suspend(bool arm_power_off);
>>>  void imx_gpc_post_resume(void);
>>>  void imx_gpc_mask_all(void);
>>> diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
>>> index 5f3602e..240109b 100644
>>> --- a/arch/arm/mach-imx/gpc.c
>>> +++ b/arch/arm/mach-imx/gpc.c
>>> @@ -22,6 +22,7 @@
>>>  #define GPC_PGC_CPU_PDN		0x2a0
>>>
>>>  #define IMR_NUM			4
>>> +#define GPC_MAX_IRQS		(IMR_NUM * 32)
>>>
>>>  static void __iomem *gpc_base;
>>>  static u32 gpc_wake_irqs[IMR_NUM];
>>> @@ -56,17 +57,17 @@ void imx_gpc_post_resume(void)
>>>
>>>  static int imx_gpc_irq_set_wake(struct irq_data *d, unsigned int on)
>>>  {
>>> -	unsigned int idx = d->hwirq / 32 - 1;
>>> +	unsigned int idx = d->hwirq / 32;
>>>  	u32 mask;
>>>
>>> -	/* Sanity check for SPI irq */
>>> -	if (d->hwirq < 32)
>>> -		return -EINVAL;
>>> -
>>>  	mask = 1 << d->hwirq % 32;
>>>  	gpc_wake_irqs[idx] = on ? gpc_wake_irqs[idx] | mask :
>>>  				  gpc_wake_irqs[idx] & ~mask;
>>>
>>> +	/*
>>> +	 * Do *not* call into the parent, as the GIC doesn't have any
>>> +	 * wake-up facility...
>>> +	 */
>>>  	return 0;
>>>  }
>>>
>>> @@ -96,7 +97,7 @@ void imx_gpc_hwirq_unmask(unsigned int hwirq)
>>>  	void __iomem *reg;
>>>  	u32 val;
>>>
>>> -	reg = gpc_base + GPC_IMR1 + (hwirq / 32 - 1) * 4;
>>> +	reg = gpc_base + GPC_IMR1 + hwirq / 32 * 4;
>>>  	val = readl_relaxed(reg);
>>>  	val &= ~(1 << hwirq % 32);
>>>  	writel_relaxed(val, reg);
>>> @@ -107,7 +108,7 @@ void imx_gpc_hwirq_mask(unsigned int hwirq)
>>>  	void __iomem *reg;
>>>  	u32 val;
>>>
>>> -	reg = gpc_base + GPC_IMR1 + (hwirq / 32 - 1) * 4;
>>> +	reg = gpc_base + GPC_IMR1 + hwirq / 32 * 4;
>>>  	val = readl_relaxed(reg);
>>>  	val |= 1 << (hwirq % 32);
>>>  	writel_relaxed(val, reg);
>>> @@ -115,37 +116,115 @@ void imx_gpc_hwirq_mask(unsigned int hwirq)
>>>
>>>  static void imx_gpc_irq_unmask(struct irq_data *d)
>>>  {
>>> -	/* Sanity check for SPI irq */
>>> -	if (d->hwirq < 32)
>>> -		return;
>>> -
>>>  	imx_gpc_hwirq_unmask(d->hwirq);
>>> +	irq_chip_unmask_parent(d);
>>>  }
>>>
>>>  static void imx_gpc_irq_mask(struct irq_data *d)
>>>  {
>>> -	/* Sanity check for SPI irq */
>>> -	if (d->hwirq < 32)
>>> -		return;
>>> -
>>>  	imx_gpc_hwirq_mask(d->hwirq);
>>> +	irq_chip_mask_parent(d);
>>> +}
>>
>> This two function end up very small, can't we just alter
>> imx_gpc_hwirq_unmask to use struct irq_data directly?
> 
> Unfortunately, pm-imx6.c directly uses the HW irq number.
> 

Now I see... 

--
Stefan

>> Code looks fine to me:
>>
>> Acked-by: Stefan Agner <stefan@agner.ch>
> 
> Thanks again,
> 
>         M.

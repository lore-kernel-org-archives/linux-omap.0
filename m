From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v2 12/21] ARM: omap: convert wakeupgen to stacked domains
Date: Sat, 10 Jan 2015 13:17:27 +0000
Message-ID: <cf3e1930e8e62b8354b2aa514f3f8ebb@www.loen.fr>
References: <1420652576-22309-1-git-send-email-marc.zyngier@arm.com>
 <1420652576-22309-13-git-send-email-marc.zyngier@arm.com>
 <20150108164420.GB25986@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20150108164420.GB25986@kahuna>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Alexandre Courbot <gnurou@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, Sascha Hauer <kernel@pengutronix.de>, Simon Horman <horms@verge.net.au>, Stephen Warren <swarren@wwwdotorg.org>, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Santosh Shilimkar <ssantosh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org, Jason Cooper <jason@lakedaemon.net>
List-Id: linux-omap@vger.kernel.org

On 2015-01-08 16:44, Nishanth Menon wrote:
> On 17:42-20150107, Marc Zyngier wrote:
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
>> 294:          0          0     WUGEN  20  gpmc
>> 297:        506          0     WUGEN  56  48070000.i2c
>> 298:          0          0     WUGEN  57  48072000.i2c
>> 299:          0          0     WUGEN  61  48060000.i2c
>> 300:          0          0     WUGEN  62  4807a000.i2c
>> 301:          8          0     WUGEN  60  4807c000.i2c
>> 308:       2439          0     WUGEN  74  OMAP UART2
>> 312:        362          0     WUGEN  83  mmc2
>> 313:        502          0     WUGEN  86  mmc0
>> 314:         13          0     WUGEN  94  mmc1
>> 350:          0          0      PRCM  pinctrl, pinctrl
>> 406:   35155709          0       GIC 109  ehci_hcd:usb1
>> 407:          0          0     WUGEN   7  palmas
>> 409:          0          0     WUGEN 119  twl6040
>> 410:          0          0   twl6040   5  twl6040_irq_ready
>> 411:          0          0   twl6040   0  twl6040_irq_th
>> IPI0:          0          1  CPU wakeup interrupts
>> IPI1:          0          0  Timer broadcast interrupts
>> IPI2:      95334     902334  Rescheduling interrupts
>> IPI3:          0          0  Function call interrupts
>> IPI4:        479        648  Single function call interrupts
>> IPI5:          0          0  CPU stop interrupts
>> IPI6:          0          0  IRQ work interrupts
>> IPI7:          0          0  completion interrupts
>> Err:          0
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm/boot/dts/am4372.dtsi             |  11 ++-
>>  arch/arm/boot/dts/dra7.dtsi               |  12 ++-
>>  arch/arm/boot/dts/dra72x.dtsi             |   2 +-
>>  arch/arm/boot/dts/dra74x.dtsi             |   2 +-
>>  arch/arm/boot/dts/omap4-duovero.dtsi      |   2 -
>>  arch/arm/boot/dts/omap4-panda-common.dtsi |   8 +-
>>  arch/arm/boot/dts/omap4-sdp.dts           |   8 +-
>>  arch/arm/boot/dts/omap4-var-som-om44.dtsi |   2 -
>>  arch/arm/boot/dts/omap4.dtsi              |  18 ++++-
>>  arch/arm/boot/dts/omap5-cm-t54.dts        |   1 -
>>  arch/arm/boot/dts/omap5-uevm.dts          |   2 -
>>  arch/arm/boot/dts/omap5.dtsi              |  24 ++++--
>>  arch/arm/mach-omap2/omap-wakeupgen.c      | 125 
>> +++++++++++++++++++++++-------
>>  arch/arm/mach-omap2/omap-wakeupgen.h      |   1 -
>>  arch/arm/mach-omap2/omap4-common.c        |   1 -
>>  15 files changed, 154 insertions(+), 65 deletions(-)
>
> 	we may need the following changes as well:
>
> diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts
> b/arch/arm/boot/dts/am437x-gp-evm.dts
> index 7eaae4cf9f89..69f2313a49d1 100644
> --- a/arch/arm/boot/dts/am437x-gp-evm.dts
> +++ b/arch/arm/boot/dts/am437x-gp-evm.dts
> @@ -280,7 +280,6 @@
>  		reg = <0x24>;
>  		compatible = "ti,tps65218";
>  		interrupts = <GIC_SPI 7 IRQ_TYPE_NONE>; /* NMIn */
> -		interrupt-parent = <&gic>;
>  		interrupt-controller;
>  		#interrupt-cells = <2>;
>
> diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts
> b/arch/arm/boot/dts/am437x-sk-evm.dts
> index 53bbfc90b26a..029badefad3d 100644
> --- a/arch/arm/boot/dts/am437x-sk-evm.dts
> +++ b/arch/arm/boot/dts/am437x-sk-evm.dts
> @@ -334,7 +334,6 @@
>  	tps@24 {
>  		compatible = "ti,tps65218";
>  		reg = <0x24>;
> -		interrupt-parent = <&gic>;
>  		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
>  		interrupt-controller;
>  		#interrupt-cells = <2>;
> diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts
> b/arch/arm/boot/dts/am43x-epos-evm.dts
> index 662261d6b2ca..2d26bc11bad6 100644
> --- a/arch/arm/boot/dts/am43x-epos-evm.dts
> +++ b/arch/arm/boot/dts/am43x-epos-evm.dts
> @@ -333,7 +333,6 @@
>  		reg = <0x24>;
>  		compatible = "ti,tps65218";
>  		interrupts = <GIC_SPI 7 IRQ_TYPE_NONE>; /* NMIn */
> -		interrupt-parent = <&gic>;
>  		interrupt-controller;
>  		#interrupt-cells = <2>;
>
> diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts
> b/arch/arm/boot/dts/am57xx-beagle-x15.dts
> index 49edbda68cd5..c2241c2e5d9d 100644
> --- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
> +++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
> @@ -335,7 +335,6 @@
>  	mcp_rtc: rtc@6f {
>  		compatible = "microchip,mcp7941x";
>  		reg = <0x6f>;
> -		interrupt-parent = <&gic>;
>  		interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_LOW>;  /* IRQ_SYS_1N */
>
>  		pinctrl-names = "default";
> @@ -358,7 +357,7 @@
>
>  &uart3 {
>  	status = "okay";
> -	interrupts-extended = <&gic GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
> +	interrupts-extended = <&crossbar_mpu GIC_SPI 69 
> IRQ_TYPE_LEVEL_HIGH>,
>  			      <&dra7_pmx_core 0x248>;
>
>  	pinctrl-names = "default";
> diff --git a/arch/arm/boot/dts/omap5.dtsi 
> b/arch/arm/boot/dts/omap5.dtsi
> index f9c75c782c48..b056156e2a7a 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -893,14 +893,12 @@
>  			usbhsohci: ohci@4a064800 {
>  				compatible = "ti,ohci-omap3";
>  				reg = <0x4a064800 0x400>;
> -				interrupt-parent = <&gic>;
>  				interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
>  			};
>
>  			usbhsehci: ehci@4a064c00 {
>  				compatible = "ti,ehci-omap";
>  				reg = <0x4a064c00 0x400>;
> -				interrupt-parent = <&gic>;
>  				interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
>  			};
>  		};

Applied, thanks.

         M.
-- 
Fast, cheap, reliable. Pick two.

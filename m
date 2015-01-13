From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v3 14/21] ARM: imx6: convert GPC to stacked domains
Date: Tue, 13 Jan 2015 18:34:46 +0000
Message-ID: <54B56546.9050407@arm.com>
References: <1421087187-26988-1-git-send-email-marc.zyngier@arm.com> <1421087187-26988-15-git-send-email-marc.zyngier@arm.com> <069e9a2b9e74856273b2faef90a97c87@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:33247 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753329AbbAMSe4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2015 13:34:56 -0500
In-Reply-To: <069e9a2b9e74856273b2faef90a97c87@agner.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Kukjin Kim <kgene.kim@samsung.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.ker>

On 12/01/15 19:00, Stefan Agner wrote:
> Hi Marc,
> 
> On 2015-01-12 19:26, Marc Zyngier wrote:
>> IMX6 has been (ab)using the gic_arch_extn to provide
>> wakeup from suspend, and it makes a lot of sense to convert
>> this code to use stacked domains instead.
>>
>> This patch does just this, updating the DT files to actually
>> reflect what the HW provides.
>>
>> BIG FAT WARNING: because the DTs were so far lying by not
>> exposing the fact that the GPC block is actually the first
>> interrupt controller in the chain, kernels with this patch
>> applied wont have any suspend-resume facility when booted
>> with old DTs, and old kernels with updated DTs won't even boot.
>>
>> Tested-by: Stefan Agner <stefan@agner.ch>
>> Acked-by: Stefan Agner <stefan@agner.ch>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm/boot/dts/imx6qdl.dtsi  |   7 ++-
>>  arch/arm/boot/dts/imx6sl.dtsi   |   5 +-
>>  arch/arm/boot/dts/imx6sx.dtsi   |   5 +-
>>  arch/arm/mach-imx/common.h      |   1 -
>>  arch/arm/mach-imx/gpc.c         | 127 ++++++++++++++++++++++++++++++++--------
>>  arch/arm/mach-imx/mach-imx6q.c  |   1 -
>>  arch/arm/mach-imx/mach-imx6sl.c |   1 -
>>  arch/arm/mach-imx/mach-imx6sx.c |   1 -
>>  8 files changed, 117 insertions(+), 31 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
>> index 4fc03b7..aff9ded 100644
>> --- a/arch/arm/boot/dts/imx6qdl.dtsi
>> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
>> @@ -53,6 +53,7 @@
>>               interrupt-controller;
>>               reg = <0x00a01000 0x1000>,
>>                     <0x00a00100 0x100>;
>> +             interrupt-parent = <&intc>;
>>       };
>>
>>       clocks {
>> @@ -82,7 +83,7 @@
>>               #address-cells = <1>;
>>               #size-cells = <1>;
>>               compatible = "simple-bus";
>> -             interrupt-parent = <&intc>;
>> +             interrupt-parent = <&gpc>;
>>               ranges;
>>
>>               dma_apbh: dma-apbh@00110000 {
>> @@ -122,6 +123,7 @@
>>                       compatible = "arm,cortex-a9-twd-timer";
>>                       reg = <0x00a00600 0x20>;
>>                       interrupts = <1 13 0xf01>;
>> +                     interrupt-parent = <&intc>;
>>                       clocks = <&clks IMX6QDL_CLK_TWD>;
>>               };
>>
>> @@ -694,8 +696,11 @@
>>                       gpc: gpc@020dc000 {
>>                               compatible = "fsl,imx6q-gpc";
>>                               reg = <0x020dc000 0x4000>;
>> +                             interrupt-controller;
>> +                             #interrupt-cells = <3>;
>>                               interrupts = <0 89 IRQ_TYPE_LEVEL_HIGH>,
>>                                            <0 90 IRQ_TYPE_LEVEL_HIGH>;
>> +                             interrupt-parent = <&intc>;
>>                       };
>>
>>                       gpr: iomuxc-gpr@020e0000 {
>> diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
>> index 36ab8e0..35099b7 100644
>> --- a/arch/arm/boot/dts/imx6sl.dtsi
>> +++ b/arch/arm/boot/dts/imx6sl.dtsi
>> @@ -72,6 +72,7 @@
>>               interrupt-controller;
>>               reg = <0x00a01000 0x1000>,
>>                     <0x00a00100 0x100>;
>> +             interrupt-parent = <&intc>;
>>       };
>>
>>       clocks {
>> @@ -95,7 +96,7 @@
>>               #address-cells = <1>;
>>               #size-cells = <1>;
>>               compatible = "simple-bus";
>> -             interrupt-parent = <&intc>;
>> +             interrupt-parent = <&gpc>;
>>               ranges;
>>
>>               ocram: sram@00900000 {
>> @@ -603,7 +604,9 @@
>>                       gpc: gpc@020dc000 {
>>                               compatible = "fsl,imx6sl-gpc", "fsl,imx6q-gpc";
>>                               reg = <0x020dc000 0x4000>;
>> +                             interrupt-controller;
> 
> GPC is in three base device trees, and missing in all of them. So the
> first is fixed
> 
> this one...
> 
>>                               interrupts = <0 89 IRQ_TYPE_LEVEL_HIGH>;
>> +                             interrupt-parent = <&intc>;
>>                       };
>>
>>                       gpr: iomuxc-gpr@020e0000 {
>> diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
>> index 7a24fee..c476e67 100644
>> --- a/arch/arm/boot/dts/imx6sx.dtsi
>> +++ b/arch/arm/boot/dts/imx6sx.dtsi
>> @@ -88,6 +88,7 @@
>>               interrupt-controller;
>>               reg = <0x00a01000 0x1000>,
>>                     <0x00a00100 0x100>;
>> +             interrupt-parent = <&intc>;
>>       };
>>
>>       clocks {
>> @@ -131,7 +132,7 @@
>>               #address-cells = <1>;
>>               #size-cells = <1>;
>>               compatible = "simple-bus";
>> -             interrupt-parent = <&intc>;
>> +             interrupt-parent = <&gpc>;
>>               ranges;
>>
>>               pmu {
>> @@ -700,7 +701,9 @@
>>                       gpc: gpc@020dc000 {
>>                               compatible = "fsl,imx6sx-gpc", "fsl,imx6q-gpc";
>>                               reg = <0x020dc000 0x4000>;
>> +                             interrupt-controller;
> 
> 
> ... and this one is still missing.
> 
> Sorry I did not see that the first review.

I thought I had them fixed on Sunday, but it looks like I've dropped the
fixup when rebasing. Oh well.

Thanks for the heads up, I'll squash that into the existing patch.

	M.
-- 
Jazz is not dead. It just smells funny...

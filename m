From: Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: Re: [PATCH v4 15/21] ARM: exynos4/5: convert pmu wakeup to stacked
 domains
Date: Tue, 20 Jan 2015 13:12:53 +0530
Message-ID: <54BE06FD.2020702@samsung.com>
References: <1421660655-21394-1-git-send-email-marc.zyngier@arm.com>
 <1421660655-21394-16-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:33235 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722AbbATHm2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Jan 2015 02:42:28 -0500
In-reply-to: <1421660655-21394-16-git-send-email-marc.zyngier@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Kukjin Kim <kgene.kim@samsung.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>
Cc: Stefan Agner <stefan@agner.ch>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>

Hi Marc,

On Monday 19 January 2015 03:14 PM, Marc Zyngier wrote:
> Exynos has been (ab)using the gic_arch_extn to provide
> wakeup from suspend, and it makes a lot of sense to convert
> this code to use stacked domains instead.
>
> This patch does just this, updating the DT files to actually
> reflect what the HW provides.
>
> BIG FAT WARNING: because the DTs were so far lying by not
> exposing the fact that the PMU block is actually the first
> interrupt controller in the chain for RTC, kernels with this patch
> applied wont have any suspend-resume facility when booted
> with old DTs, and old kernels with updated DTs may not even boot.
>
> Also, I stronly suspect that there is more than two wake-up
> interrupts on these platforms, but I leave it to the maintainers
> to fix their mess.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---

I tested this patch series on SMDK5250 board.

With the addition of "#interrupt-cells = <3>;"in PMU device node S2R is 
working on Exynos5250 based SMDK board.

>   arch/arm/boot/dts/exynos4.dtsi    |   4 ++
>   arch/arm/boot/dts/exynos5250.dtsi |   4 ++
>   arch/arm/boot/dts/exynos5420.dtsi |   4 ++
>   arch/arm/mach-exynos/exynos.c     |  14 ++---
>   arch/arm/mach-exynos/suspend.c    | 122 ++++++++++++++++++++++++++++++++++----
>   5 files changed, 129 insertions(+), 19 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
> index b8168f1..0e7d74e 100644
> --- a/arch/arm/boot/dts/exynos4.dtsi
> +++ b/arch/arm/boot/dts/exynos4.dtsi
> @@ -141,6 +141,9 @@
>   	pmu_system_controller: system-controller@10020000 {
>   		compatible = "samsung,exynos4210-pmu", "syscon";
>   		reg = <0x10020000 0x4000>;
> +		interrupt-controller;
> +		#interrupt-cells = <3>;
> +		interrupt-parent = <&gic>;
>   	};
>
>   	dsi_0: dsi@11C80000 {
> @@ -253,6 +256,7 @@
>   	rtc@10070000 {
>   		compatible = "samsung,s3c6410-rtc";
>   		reg = <0x10070000 0x100>;
> +		interrupt-parent = <&pmu_system_controller>;
>   		interrupts = <0 44 0>, <0 45 0>;
>   		clocks = <&clock CLK_RTC>;
>   		clock-names = "rtc";
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> index 0a229fc..1dc5f6b 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -194,6 +194,9 @@
>   		clock-names = "clkout16";
>   		clocks = <&clock CLK_FIN_PLL>;
>   		#clock-cells = <1>;
> +		interrupt-controller;
> +		#interrupt-cells = <3>;
> +		interrupt-parent = <&gic>;
>   	};
>
>   	sysreg_system_controller: syscon@10050000 {
> @@ -230,6 +233,7 @@
>   	rtc: rtc@101E0000 {
>   		clocks = <&clock CLK_RTC>;
>   		clock-names = "rtc";
> +		interrupt-parent = <&pmu_system_controller>;
>   		status = "disabled";
>   	};
>
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> index 517e50f..35ecd36 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -309,6 +309,7 @@
>   	rtc: rtc@101E0000 {
>   		clocks = <&clock CLK_RTC>;
>   		clock-names = "rtc";
> +		interrupt-parent = <&pmu_system_controller>;
>   		status = "disabled";
>   	};
>
> @@ -748,6 +749,9 @@
>   		clock-names = "clkout16";
>   		clocks = <&clock CLK_FIN_PLL>;
>   		#clock-cells = <1>;
> +		interrupt-controller;
> +		#interrupt-cells = <3>;
> +		interrupt-parent = <&gic>;
>   	};
>
>   	sysreg_system_controller: syscon@10050000 {
> diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
> index c13d083..e417fdc 100644
> --- a/arch/arm/mach-exynos/exynos.c
> +++ b/arch/arm/mach-exynos/exynos.c
> @@ -175,16 +175,15 @@ static void __init exynos_init_io(void)
>   	exynos_map_io();
>   }
>
> +/*
> + * Apparently, these SoCs are not able to wake-up from suspend using
> + * the PMU. Too bad. Should they suddenly become capable of such a
> + * feat, the matches below should be moved to suspend.c.
> + */
>   static const struct of_device_id exynos_dt_pmu_match[] = {
>   	{ .compatible = "samsung,exynos3250-pmu" },

As I know Exynos3250, S2R support has been added in kgene/for-next and 
should work as expected so we may need to do update "exynos_wkup_irq" 
for exynos3250 and remove it from this list, so that it's S2R should not 
break. I am adding concern engineer (+cc: Chanwoo Choi) in the loop.

> -	{ .compatible = "samsung,exynos4210-pmu" },
> -	{ .compatible = "samsung,exynos4212-pmu" },
> -	{ .compatible = "samsung,exynos4412-pmu" },
> -	{ .compatible = "samsung,exynos4415-pmu" },
> -	{ .compatible = "samsung,exynos5250-pmu" },
>   	{ .compatible = "samsung,exynos5260-pmu" },
>   	{ .compatible = "samsung,exynos5410-pmu" },
> -	{ .compatible = "samsung,exynos5420-pmu" },
>   	{ /*sentinel*/ },
>   };
>

Thanks,
Pankaj Dubey

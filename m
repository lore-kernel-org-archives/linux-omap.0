From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH] PM / OPP: Remove ARCH_HAS_OPP
Date: Fri, 6 Jun 2014 21:14:01 +0900
Message-ID: <CANqRtoTy_LwSiZgRFEw5Ly4ojfinoCichxrX7cO6m2XB9JGoww@mail.gmail.com>
References: <1402051016-28853-1-git-send-email-broonie@kernel.org>
	<20140606111411.GD25896@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20140606111411.GD25896@verge.net.au>
Sender: linux-pm-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Russell King <linux@arm.linux.org.uk>, Kukjin Kim <kgene.kim@samsung.com>, Rob Herring <robh@kernel.org>, Shawn Guo <shawn.guo@freescale.com>, Sascha Hauer <kernel@pengutronix.de>, Tony Lindgren <tony@atomide.com>, Michal Simek <michal.simek@xilinx.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc@vger.kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, SH-Linux <linux-sh@vger.kernel.org>, Mark Brown <broonie@linaro.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Jun 6, 2014 at 8:14 PM, Simon Horman <horms@verge.net.au> wrote:
> On Fri, Jun 06, 2014 at 11:36:56AM +0100, Mark Brown wrote:
>> From: Mark Brown <broonie@linaro.org>
>>
>> Since the OPP layer is a kernel library which has been converted to be
>> directly selectable by its callers rather than user selectable and
>> requiring architectures to enable it explicitly the ARCH_HAS_OPP symbol
>> has become redundant and can be removed. Do so.
>>
>> Signed-off-by: Mark Brown <broonie@linaro.org>
>> ---
>>  Documentation/power/opp.txt    | 3 ---
>>  arch/arm/mach-exynos/Kconfig   | 1 -
>>  arch/arm/mach-highbank/Kconfig | 1 -
>>  arch/arm/mach-imx/Kconfig      | 1 -
>>  arch/arm/mach-omap2/Kconfig    | 1 -
>>  arch/arm/mach-shmobile/Kconfig | 2 --
>>  arch/arm/mach-vexpress/Kconfig | 1 -
>>  arch/arm/mach-zynq/Kconfig     | 1 -
>>  drivers/devfreq/Kconfig        | 1 -
>>  kernel/power/Kconfig           | 3 ---
>>  10 files changed, 15 deletions(-)
>
> shmobile portion:
>
> Acked-by: Simon Horman <horms+renesas@verge.net.au>

Hi Simon, Mark,

Nice to see cleanups in this area. Reducing the number of Kconfig
symbols must be a good thing.

I'm not sure about the expected merge order for this kind of change vs
queued up stuff in the renesas git tree, but I believe the following
patch selects ARCH_HAS_OPP:

[PATCH v3] ARM: shmobile: Mark all SoCs in shmobile as CPUFreq, capable

Cheers,

/ magnus

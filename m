From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH] PM / OPP: Remove ARCH_HAS_OPP
Date: Fri, 6 Jun 2014 22:01:05 +0900
Message-ID: <CANqRtoRyUwqbWrFny0qpSUrkkNw7wGbdOU2UGxXRXvd-9z7Wmg@mail.gmail.com>
References: <1402051016-28853-1-git-send-email-broonie@kernel.org>
	<20140606111411.GD25896@verge.net.au>
	<CANqRtoTy_LwSiZgRFEw5Ly4ojfinoCichxrX7cO6m2XB9JGoww@mail.gmail.com>
	<20140606125003.GA13332@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:41877 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407AbaFFNBH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jun 2014 09:01:07 -0400
In-Reply-To: <20140606125003.GA13332@verge.net.au>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Russell King <linux@arm.linux.org.uk>, Kukjin Kim <kgene.kim@samsung.com>, Rob Herring <robh@kernel.org>, Shawn Guo <shawn.guo@freescale.com>, Sascha Hauer <kernel@pengutronix.de>, Tony Lindgren <tony@atomide.com>, Michal Simek <michal.simek@xilinx.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc@vger.kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, SH-Linux <linux-sh@vger.kernel.org>, Mark Brown <broonie@linaro.org>

On Fri, Jun 6, 2014 at 9:50 PM, Simon Horman <horms@verge.net.au> wrote:
> On Fri, Jun 06, 2014 at 09:14:01PM +0900, Magnus Damm wrote:
>> On Fri, Jun 6, 2014 at 8:14 PM, Simon Horman <horms@verge.net.au> wrote:
>> > On Fri, Jun 06, 2014 at 11:36:56AM +0100, Mark Brown wrote:
>> >> From: Mark Brown <broonie@linaro.org>
>> >>
>> >> Since the OPP layer is a kernel library which has been converted to be
>> >> directly selectable by its callers rather than user selectable and
>> >> requiring architectures to enable it explicitly the ARCH_HAS_OPP symbol
>> >> has become redundant and can be removed. Do so.
>> >>
>> >> Signed-off-by: Mark Brown <broonie@linaro.org>
>> >> ---
>> >>  Documentation/power/opp.txt    | 3 ---
>> >>  arch/arm/mach-exynos/Kconfig   | 1 -
>> >>  arch/arm/mach-highbank/Kconfig | 1 -
>> >>  arch/arm/mach-imx/Kconfig      | 1 -
>> >>  arch/arm/mach-omap2/Kconfig    | 1 -
>> >>  arch/arm/mach-shmobile/Kconfig | 2 --
>> >>  arch/arm/mach-vexpress/Kconfig | 1 -
>> >>  arch/arm/mach-zynq/Kconfig     | 1 -
>> >>  drivers/devfreq/Kconfig        | 1 -
>> >>  kernel/power/Kconfig           | 3 ---
>> >>  10 files changed, 15 deletions(-)
>> >
>> > shmobile portion:
>> >
>> > Acked-by: Simon Horman <horms+renesas@verge.net.au>
>>
>> Hi Simon, Mark,
>>
>> Nice to see cleanups in this area. Reducing the number of Kconfig
>> symbols must be a good thing.
>>
>> I'm not sure about the expected merge order for this kind of change vs
>> queued up stuff in the renesas git tree, but I believe the following
>> patch selects ARCH_HAS_OPP:
>>
>> [PATCH v3] ARM: shmobile: Mark all SoCs in shmobile as CPUFreq, capable
>
> I propose that we fix that up by adding an incremental patch to
> mach-shmobile via my renesas tree once the dependency (assuming there is
> one) is in Linus's tree.

Sounds good. Thanks!

/ magnus

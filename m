From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv10 00/41] ARM: TI SoC clock DT conversion
Date: Tue, 26 Nov 2013 09:57:59 -0800
Message-ID: <20131126175758.GG26766@atomide.com>
References: <1385453182-24421-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58410 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752983Ab3KZR6C (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Nov 2013 12:58:02 -0500
Content-Disposition: inline
In-Reply-To: <1385453182-24421-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [131126 00:09]:
> Hi,
> 
> Changes compared to v9:
> - rebased on top of 3.13-rc1
> - modified the low level clk register API to provide SoC specific clk_readl
>   and clk_writel support which can be registered during boot, TI SoC variant
>   uses regmap on low level
> - dropped regmap parameter from clock init calls, instead a helper is used
>   for getting regmap index along with the register offset from DT
> - dropped regmap parameter from clock structs, instead platform specific
>   clk_readl / clk_writel are used to parse reg parameter according to
>   platform, for TI SoC:s, this is encoded as:
>   struct clk_omap_reg {
>     u16 offset; /* register offset */
>     u16 index; /* regmap index */
>   }
> - Nishanth's comments to v9 mostly addressed, except for the CLK_OF_DECLARE
>   tweak which I would actually want some feedback upon, basically the problem
>   is I need to return status from the clk init functions so I can see if
>   -EAGAIN is passed, in which case init will be retried later, maybe some of
>   this can be made generic, like converting all the CLK_OF_DECLARE type
>   functions to return status
> 
> Testing done:
> - omap3-beagle : boot + suspend/resume
> - omap3-beagle-xm : boot (thanks to Nishanth)
> - omap4-panda-es : boot + suspend/resume
> - omap5-uevm : boot
> - dra7-evm : boot
> - am335x-bone : boot
> 
> Separate branches available at https://github.com/t-kristo/linux-pm.git
> 
> - full: 3.13-rc1-dt-clks-v10 (should be merged last, contains everything)

FYI, I noticed you still have few hack pathces in this branch that you
should drop before it's pullable.

You can drop "HACK: force enable uart3 rx iochain wakeup" and replace it
with "ARM: dts: Fix omap serial wake-up when booted with device tree" I
posted few days ago. You may also want to use the latest attempt of patch
"of/platform: Fix no irq domain found errors when populating interrupts"
to avoid some new warnings. That way you can test off-idle on omap3 with
DT, but it's best to keep those out of your branch.

Then the "HACK: Makefile: Build a uImage with dtb already appended" you
can just replace with a shell script to leave that one out :)

> - clk driver only: 3.13-rc1-dt-clks-v10-for-mike
> - DT data only: 3.13-rc1-dt-clks-v10-for-benoit

I pulled these on top of my patches to make mach-omap2 boot in DT only
mode, and there's just a trivial merge conflict with the DT data which
is no problem.

And looks like off-idle keeps working for me on omap3 :) So for the
patches that don't have it yet, please feel free to add:

Acked-by: Tony Lindgren <tony@atomide.com>

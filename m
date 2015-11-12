From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 0/3] ARM: OMAP2+ McASP(3) support for DRA7xx family
Date: Thu, 12 Nov 2015 10:00:27 -0800
Message-ID: <20151112180027.GP3218@atomide.com>
References: <1447313579-23873-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1447313579-23873-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: paul@pwsan.com, balbi@ti.com, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [151111 23:33]:
> Hi Tony,
> 
> Changes since v3:
> - rebased on mainline's HEAD
> - Added Tested-by from Felipe
> - Added Acked-by from Paul for the hwmod patches
> 
> Changes since v2:
> - DTS patch added which is needed because of the clock handling changes
> 
> Felip Balbi reported that linux-next is broken right now since the DTS part of
> the earlier series has been applied, but we do not have the mcasp hwmod in the
> kernel:
> ...
> [    0.181029] platform 48468000.mcasp: Cannot lookup hwmod 'mcasp3'
> ...
> [    6.121072] davinci-mcasp 48468000.mcasp: _od_fail_runtime_resume: FIXME: missing hwmod/omap_dev info
> [    6.130790] ------------[ cut here ]------------
> [    6.135643] WARNING: CPU: 0 PID: 244 at drivers/bus/omap_l3_noc.c:147 l3_interrupt_handler+0x220/0x34c()
> [    6.145576] 44000000.ocp:L3 Custom Error: MASTER MPU TARGET L4_PER2_P3 (Read): Data Access in User mode during Functional access


Thanks applying all three into omap-for-v4.4/fixes.

Tony

> ...
> 
> This is the followup series for the hwmod changes needed to get audio working
> on DRA7xx family based boards.
> The DTS patches has been applied by Tony from the original series:
> http://www.spinics.net/lists/linux-omap/msg121473.html
> 
> I have addressed your comments in the hwmod data and did some research also
> regarding to the use of ahclkx as fclk in the original submission.
> It turned out that McASP _needs_ all clocks to be enabled (fclk, iclk and
> ahclkx/r) to be able to access registers. The original patch where we handled
> the ahclkx as fclk worked, because the fclk clock got enabled in the HW w/o
> any SW interaction.
> All in all, the McASP found in DRA7 needs all clocks to be enabled.
> To satisfy this I have introduced a new flag to hwmod, which means that the
> listed optional clocks need to be handled alongside with the fclk clock.
> 
> Regards,
> Peter
> ---
> Peter Ujfalusi (3):
>   ARM: DTS: dra7: Fix McASP3 node regarding to clocks
>   ARM: OMAP2+: hwmod: Add hwmod flag for HWMOD_OPT_CLKS_NEEDED
>   ARM: OMAP: DRA7: hwmod: Add data for McASP3
> 
>  arch/arm/boot/dts/dra7.dtsi               |  4 +-
>  arch/arm/mach-omap2/omap_hwmod.c          | 66 +++++++++++++++++--------------
>  arch/arm/mach-omap2/omap_hwmod.h          |  3 ++
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 56 ++++++++++++++++++++++++++
>  4 files changed, 97 insertions(+), 32 deletions(-)
> 
> -- 
> 2.6.2
> 

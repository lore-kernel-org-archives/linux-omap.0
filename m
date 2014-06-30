From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap fixes against v3.16-rc1
Date: Mon, 30 Jun 2014 00:08:57 -0700
Message-ID: <20140630070857.GK28884@atomide.com>
References: <20140617145854.GT17845@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:17687 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752595AbaF3HI7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jun 2014 03:08:59 -0400
Content-Disposition: inline
In-Reply-To: <20140617145854.GT17845@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [140617 08:01]:
> The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:
> 
>   Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.16/fixes-against-rc1
> 
> for you to fetch changes up to edc56f871eefbc56baf1fd981eeff35ef447925c:
> 
>   ARM: dts: dra7-evm: remove interrupt binding (2014-06-17 01:22:55 -0700)
> 
> ----------------------------------------------------------------
> Fixes for omaps for issues discovered during the merge window and
> enabling of a few features that had to wait for the driver
> dependencies to clear.
> 
> The fixes included are:
> 
> - Fix am43xx hard reset flags
> 
> - Fix SoC detection for DRA722
> 
> - Fix CPU OPP table for omap5
> 
> - Fix legacy mux parser bug if requested muxname is a prefix of
>   multiple mux entries
> 
> - Fix qspi interrupt binding that relies on the irq crossbar
>   that has not yet been enabled
> 
> - Add missing phy_sel for am43x-epos-evm
> 
> - Drop unused gic_init_irq() that is no longer needed
> 
> And the enabling of features that had driver dependencies are:
> 
> - Change dra7 to use Audio Tracking Logic clock instead of a fixed
>   clock now that the clock driver for it has been merged
> 
> - Enable off idle configuration for selected omaps as all the kernel
>   dependencies for device tree based booting are finally merged as
>   this is needed to get the automated PM tests working finally with
>   device tree based booting
> 
> - Add hwmod entry for ocp2scp3 for omap5 to get sata working as
>   all the driver dependencies are now in the kernel and this patch
>   fell through the cracks during the merge window

Ping, it's already -rc3 and these are still pending?

Regards,

Tony

 
> ----------------------------------------------------------------
> Brian Norris (1):
>       ARM: OMAP2+: drop unused function
> 
> Dave Gerlach (1):
>       ARM: OMAP2+: hwmod: Change hardreset soc_ops for AM43XX
> 
> David R. Piegdon (1):
>       ARM: OMAP2+: Fix parser-bug in platform muxing code
> 
> George Cherian (1):
>       ARM: dts: am43x-epos-evm: Add Missing cpsw-phy-sel for am43x-epos-evm
> 
> Keshava Munegowda (1):
>       ARM: OMAP5: hwmod: Add ocp2scp3 and sata hwmods
> 
> Nishanth Menon (2):
>       ARM: DRA722: add detection of SoC information
>       ARM: dts: omap5: Update CPU OPP table as per final production Manual
> 
> Peter Ujfalusi (1):
>       ARM: DTS: dra7/dra7xx-clocks: ATL related changes
> 
> Sourav Poddar (1):
>       ARM: dts: dra7-evm: remove interrupt binding
> 
> Tony Lindgren (2):
>       ARM: dts: Enable twl4030 off-idle configuration for selected omaps
>       Merge tag 'for-v3.16-rc/omap-fixes-a' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v3.16/fixes
> 
>  arch/arm/boot/dts/am43x-epos-evm.dts       |  4 ++
>  arch/arm/boot/dts/dra7.dtsi                | 12 ++++-
>  arch/arm/boot/dts/dra7xx-clocks.dtsi       | 16 +++----
>  arch/arm/boot/dts/omap3-beagle-xm.dts      |  6 +++
>  arch/arm/boot/dts/omap3-evm-common.dtsi    |  7 +++
>  arch/arm/boot/dts/omap3-n900.dts           |  5 ++
>  arch/arm/boot/dts/omap5.dtsi               |  1 -
>  arch/arm/mach-omap2/Makefile               |  6 ++-
>  arch/arm/mach-omap2/cm33xx.h               |  2 +-
>  arch/arm/mach-omap2/common.h               |  1 -
>  arch/arm/mach-omap2/id.c                   | 12 +++++
>  arch/arm/mach-omap2/mux.c                  |  6 ++-
>  arch/arm/mach-omap2/omap4-common.c         | 20 --------
>  arch/arm/mach-omap2/omap_hwmod.c           |  6 +--
>  arch/arm/mach-omap2/omap_hwmod_54xx_data.c | 73 ++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/soc.h                  |  1 +
>  16 files changed, 139 insertions(+), 39 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

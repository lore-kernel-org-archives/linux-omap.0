From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [GIT PULL] DRA7xx core support
Date: Tue, 13 Aug 2013 17:08:36 +0530
Message-ID: <520A1ABC.20604@ti.com>
References: <5208C832.2060007@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34651 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756542Ab3HMLjC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Aug 2013 07:39:02 -0400
In-Reply-To: <5208C832.2060007@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

Hi Tony,

Heres an updated pull request dropping the dts files.

The following changes since commit d4e4ab86bcba5a72779c43dc1459f71fea3d89c8:

  Linux 3.11-rc5 (2013-08-11 18:04:20 -0700)

are available in the git repository at:

  git://github.com/rrnayak/linux.git tags/dra7-core-support-minus-dt

for you to fetch changes up to 8dd21c93197cc465ae87e142435b3f7f262eade9:

  ARM: DRA7: Add the build support in omap2plus (2013-08-13 16:58:16 +0530)

----------------------------------------------------------------
DRA7xx based SoC core support

----------------------------------------------------------------
R Sricharan (7):
      ARM: DRA7: Reuse all of PRCM and MPUSS SMP infra
      ARM: DRA7: Reuse io tables and add a new .init_early
      ARM: DRA7: Resue the clocksource, clockevent support
      ARM: DRA7: board-generic: Add basic DT support
      ARM: DRA7: Kconfig: Make ARCH_NR_GPIO default to 512
      ARM: DRA7: id: Add cpu detection support for DRA7xx based SoCs'
      ARM: DRA7: Add the build support in omap2plus

Rajendra Nayak (1):
      ARM: DRA7: hwmod: Reuse the soc_ops used for OMAP4/5

 .../devicetree/bindings/arm/omap/omap.txt          |    3 +++
 arch/arm/Kconfig                                   |    2 +-
 arch/arm/configs/omap2plus_defconfig               |    1 +
 arch/arm/mach-omap1/include/mach/soc.h             |    1 +
 arch/arm/mach-omap2/Kconfig                        |   12 ++++++++++--
 arch/arm/mach-omap2/Makefile                       |    6 ++++++
 arch/arm/mach-omap2/board-generic.c                |   18 ++++++++++++++++++
 arch/arm/mach-omap2/common.h                       |    1 +
 arch/arm/mach-omap2/id.c                           |    4 ++--
 arch/arm/mach-omap2/io.c                           |   20 ++++++++++++++++++--
 arch/arm/mach-omap2/omap54xx.h                     |    4 ++++
 arch/arm/mach-omap2/omap_hwmod.c                   |    2 +-
 arch/arm/mach-omap2/soc.h                          |   17 +++++++++++++++++
 arch/arm/mach-omap2/timer.c                        |    3 ++-
 arch/arm/plat-omap/Kconfig                         |    2 +-
 15 files changed, 86 insertions(+), 10 deletions(-)


On Monday 12 August 2013 05:04 PM, Rajendra Nayak wrote:
> Hi Tony,
> 
> Heres the pull request for the dra7xx core support patches.
> 
> The following changes since commit d4e4ab86bcba5a72779c43dc1459f71fea3d89c8:
> 
>   Linux 3.11-rc5 (2013-08-11 18:04:20 -0700)
> 
> are available in the git repository at:
> 
>   git://github.com/rrnayak/linux.git tags/dra7-core-support-v3
> 
> for you to fetch changes up to 41f2119b3037e50482cb14eaa39e6b5c52113fb5:
> 
>   ARM: DRA7: Add the build support in omap2plus (2013-08-12 15:25:38 +0530)
> 
> ----------------------------------------------------------------
> DRA7xx based SoC core support
> 
> ----------------------------------------------------------------
> R Sricharan (8):
>       ARM: DRA7: Reuse all of PRCM and MPUSS SMP infra
>       ARM: DRA7: Reuse io tables and add a new .init_early
>       ARM: DRA7: Resue the clocksource, clockevent support
>       ARM: DRA7: board-generic: Add basic DT support
>       ARM: DRA7: Kconfig: Make ARCH_NR_GPIO default to 512
>       ARM: DRA7: dts: Add the dts files for dra7 SoC and dra7-evm board
>       ARM: DRA7: id: Add cpu detection support for DRA7xx based SoCs'
>       ARM: DRA7: Add the build support in omap2plus
> 
> Rajendra Nayak (1):
>       ARM: DRA7: hwmod: Reuse the soc_ops used for OMAP4/5
> 
>  .../devicetree/bindings/arm/omap/omap.txt          |    3 +
>  arch/arm/Kconfig                                   |    2 +-
>  arch/arm/boot/dts/Makefile                         |    3 +-
>  arch/arm/boot/dts/dra7-evm.dts                     |  140 +++++
>  arch/arm/boot/dts/dra7.dtsi                        |  567 ++++++++++++++++++++
>  arch/arm/configs/omap2plus_defconfig               |    1 +
>  arch/arm/mach-omap1/include/mach/soc.h             |    1 +
>  arch/arm/mach-omap2/Kconfig                        |   12 +-
>  arch/arm/mach-omap2/Makefile                       |    6 +
>  arch/arm/mach-omap2/board-generic.c                |   18 +
>  arch/arm/mach-omap2/common.h                       |    1 +
>  arch/arm/mach-omap2/id.c                           |    4 +-
>  arch/arm/mach-omap2/io.c                           |   20 +-
>  arch/arm/mach-omap2/omap54xx.h                     |    4 +
>  arch/arm/mach-omap2/omap_hwmod.c                   |    2 +-
>  arch/arm/mach-omap2/soc.h                          |   17 +
>  arch/arm/mach-omap2/timer.c                        |    3 +-
>  arch/arm/plat-omap/Kconfig                         |    2 +-
>  18 files changed, 795 insertions(+), 11 deletions(-)
>  create mode 100644 arch/arm/boot/dts/dra7-evm.dts
>  create mode 100644 arch/arm/boot/dts/dra7.dtsi
> 


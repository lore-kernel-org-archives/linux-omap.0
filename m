From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] SoC changes for omap4470, ti814x, am33xx for v3.3
 merge window
Date: Wed, 14 Dec 2011 11:48:43 -0800
Message-ID: <20111214194843.GL32251@atomide.com>
References: <20111214193547.GI32251@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60974 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755122Ab1LNTsr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Dec 2011 14:48:47 -0500
Content-Disposition: inline
In-Reply-To: <20111214193547.GI32251@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [111214 11:04]:
> Hi Arnd & Olof,
> 
> Please pull support for new omap variants from:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap

Sorry the link above should be:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap soc

As below in the pull request.

Regards,

Tony

 
> This adds minimal support for omap4470, am33xx and ti814x.
> Note that these changes do not contain mux/clock/hwmod changes
> so only minimal boot support is added.
> 
> Also, these do not have a dependency after all to the
> previously pulled omap4 branch unlike what I mentioned earlier
> 
> The dependency is just Russell's devel-stable at commit
> deee6d5359969a0ce4e2760cfd7b9f379bd5698a as most omap
> patches have.
> 
> Regards,
> 
> Tony
> 
> 
> The following changes since commit deee6d5359969a0ce4e2760cfd7b9f379bd5698a:
>   Tony Lindgren (1):
>         ARM: 7194/1: OMAP: Fix build after a merge between v3.2-rc4 and ARM restart changes
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap soc
> 
> Afzal Mohammed (2):
>       ARM: OMAP: am33xx: Update common omap platform files
>       ARM: OMAP: am33xx: Update common OMAP machine specific sources
> 
> David Anders (1):
>       ARM: OMAP: id: add chip id recognition for omap4430 es2.3
> 
> Hemant Pedanekar (2):
>       ARM: OMAP: TI81XX: Prepare for addition of TI814X support
>       ARM: OMAP: TI814X: Add cpu type macros and detection support
> 
> Leonid Iziumtsev (1):
>       ARM: OMAP: ID: Chip detection for OMAP4470
> 
>  arch/arm/mach-omap2/Kconfig                        |   11 +++-
>  arch/arm/mach-omap2/board-ti8168evm.c              |   11 +---
>  arch/arm/mach-omap2/clock.c                        |    2 +-
>  arch/arm/mach-omap2/clock.h                        |    2 +-
>  arch/arm/mach-omap2/clock3xxx_data.c               |    6 ++-
>  arch/arm/mach-omap2/common.c                       |   48 +++++++++++++----
>  arch/arm/mach-omap2/common.h                       |   23 ++++++--
>  arch/arm/mach-omap2/control.h                      |    8 ++--
>  arch/arm/mach-omap2/id.c                           |   52 ++++++++++++++++---
>  arch/arm/mach-omap2/include/mach/debug-macro.S     |   12 ++--
>  arch/arm/mach-omap2/io.c                           |   38 +++++++++++---
>  arch/arm/mach-omap2/irq.c                          |    2 +-
>  arch/arm/mach-omap2/opp2xxx.h                      |    2 +-
>  arch/arm/mach-omap2/serial.c                       |    6 +-
>  arch/arm/plat-omap/Makefile                        |    1 -
>  .../plat-omap/include/plat/{ti816x.h => am33xx.h}  |   20 +++----
>  arch/arm/plat-omap/include/plat/clock.h            |    4 +-
>  arch/arm/plat-omap/include/plat/cpu.h              |   56 ++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/hardware.h         |    3 +-
>  arch/arm/plat-omap/include/plat/io.h               |   12 ++++
>  arch/arm/plat-omap/include/plat/omap34xx.h         |    2 +
>  arch/arm/plat-omap/include/plat/serial.h           |   14 +++---
>  .../plat-omap/include/plat/{ti816x.h => ti81xx.h}  |   18 +++---
>  arch/arm/plat-omap/include/plat/uncompress.h       |    8 ++--
>  24 files changed, 267 insertions(+), 94 deletions(-)
>  copy arch/arm/plat-omap/include/plat/{ti816x.h => am33xx.h} (53%)
>  rename arch/arm/plat-omap/include/plat/{ti816x.h => ti81xx.h} (60%)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

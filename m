From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] pending DT patches and cleanup for map_io for v3.2
 merge window
Date: Fri, 28 Oct 2011 11:39:21 +0200
Message-ID: <20111028093907.GD26205@atomide.com>
References: <20111024091704.GF31337@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:44410 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899Ab1J1Jj3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Oct 2011 05:39:29 -0400
Content-Disposition: inline
In-Reply-To: <20111024091704.GF31337@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>, Russell King <linux@arm.linux.org.uk>

* Tony Lindgren <tony@atomide.com> [111024 10:42]:
> Arnd,
> 
> As discussed in the ARM kernel meeting yesterday, here's are
> the pending omap things to pull for v3.2 merge window.
> 
> These would be nice to get still in as other people's work
> such as Nico's map_io changes need #2 below.
> 
> 1. Initial DT support posted few weeks ago
> 
>    Please see the earlier pull request at:
> 
>    http://lkml.org/lkml/2011/10/4/441
> 
> 2. Cleanup for map_io posted few weeks ago
> 
>    This depends on the #1 above, and also requires
>    the ioremap_exec patch. Russell said he has applied
>    into devel-stable (But not pushed out yet?).
> 
>    When you have the ioremap_exec patch from Russell,
>    please pull this from:
> 
>    git://github.com/tmlind/linux.git sram-map-io

FYI, the ioremap_exec patch seems is available as commit
6c5482d53f195d3ca61c9ec1be25b0f4a92575fe (ARM: 7129/1:
Add __arm_ioremap_exec for mapping external memory)
in Russell's for-linus branch.
 
>    Pull request against #1 attached below.
> 
> Regards,
> 
> Tony
> 
> 
> The following changes since commit 3ae3e253db7385238dd9d6c67c085afa3e770a56:
>   Tony Lindgren (1):
>         Merge branch 'for_3.2/3_omap_devicetree' of git://gitorious.org/omap-pm/linux into dt
> 
> are available in the git repository at:
> 
>   git://github.com/tmlind/linux.git sram-map-io
> 
> Tony Lindgren (6):
>       ARM: OMAP1: Use generic map_io, init_early and init_irq
>       ARM: OMAP: Avoid cpu_is_omapxxxx usage until map_io is done
>       ARM: OMAP: Remove calls to SRAM allocations for framebuffer
>       ARM: OMAP: Map SRAM later on with ioremap_exec()
>       ARM: OMAP: Move set_globals initialization to happen in init_early
>       ARM: OMAP: Warn if omap_ioremap is called before SoC detection
> 
>  arch/arm/mach-omap1/board-ams-delta.c    |   16 +---
>  arch/arm/mach-omap1/board-fsample.c      |   76 +++++++++---------
>  arch/arm/mach-omap1/board-generic.c      |   16 +---
>  arch/arm/mach-omap1/board-h2.c           |   16 +---
>  arch/arm/mach-omap1/board-h3.c           |   16 +---
>  arch/arm/mach-omap1/board-htcherald.c    |   12 +--
>  arch/arm/mach-omap1/board-innovator.c    |   36 ++++-----
>  arch/arm/mach-omap1/board-nokia770.c     |   34 +++-----
>  arch/arm/mach-omap1/board-osk.c          |   16 +---
>  arch/arm/mach-omap1/board-palmte.c       |   16 +---
>  arch/arm/mach-omap1/board-palmtt.c       |   16 +---
>  arch/arm/mach-omap1/board-palmz71.c      |   18 +----
>  arch/arm/mach-omap1/board-perseus2.c     |   75 +++++++++---------
>  arch/arm/mach-omap1/board-sx1.c          |   17 +---
>  arch/arm/mach-omap1/board-voiceblue.c    |   16 +---
>  arch/arm/mach-omap1/devices.c            |    3 +
>  arch/arm/mach-omap1/io.c                 |   57 ++++++--------
>  arch/arm/mach-omap2/board-omap3beagle.c  |    7 +--
>  arch/arm/mach-omap2/board-ti8168evm.c    |    1 -
>  arch/arm/mach-omap2/common.c             |   50 ++++++------
>  arch/arm/mach-omap2/control.c            |   16 +---
>  arch/arm/mach-omap2/io.c                 |  127 +++++++++++++++---------------
>  arch/arm/mach-omap2/io.h                 |    7 --
>  arch/arm/mach-omap2/omap-smp.c           |    7 +-
>  arch/arm/mach-omap2/prcm.c               |   19 ++---
>  arch/arm/mach-omap2/sdrc.c               |   13 +--
>  arch/arm/plat-omap/include/plat/common.h |   17 +++--
>  arch/arm/plat-omap/include/plat/io.h     |   29 ++++++-
>  arch/arm/plat-omap/io.c                  |   10 +++
>  arch/arm/plat-omap/sram.c                |   85 +++++---------------
>  30 files changed, 335 insertions(+), 509 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

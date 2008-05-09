From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/5] sparse, checkpatch cleanup in mach-omap2
Date: Fri, 9 May 2008 14:42:28 -0700
Message-ID: <20080509214227.GB5976@atomide.com>
References: <20080507171204.17732.97601.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:64798 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbYEIVm3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 May 2008 17:42:29 -0400
Content-Disposition: inline
In-Reply-To: <20080507171204.17732.97601.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [080507 12:51]:
> It's springtime in the Northern Hemisphere; time for plants to flower,
> students to graduate, or not, and Linux hackers to generate cleanup
> patches against the source tree...
> 
> These patches fix all of the sparse warnings against the
> arch/arm/mach-omap2 directory, and fix some of the checkpatch.pl
> warnings also.  The individual patch descriptions discuss the main
> changes involved.  sparse did find a few stinkers - I think the worst 
> was a shadowed variable in clock.c.
> 
> There are a few other minor changes involved.  The main one was that
> the unlikely() and likely() branch predictor hints got removed.
> 
> The sparse fixes do have one downside: some additional uglification, caused
> by the addition of __force to pointer->integer and integer->pointer casts.
> The rest of the kernel seems to have accepted this tradeoff.
> 
> Compile-tested with OSK5912, N800, 2430SDP, and 3430SDP configs;
> boot-tested on 3430SDP ES2.

Pushing today.

Tony


> 
> 
> - Paul
> 
> ---
> 
> diffstat:
>  arch/arm/mach-omap2/clock.c               |  107 ++++++++++++++---------------
>  arch/arm/mach-omap2/clock.h               |    4 +
>  arch/arm/mach-omap2/clock24xx.c           |   23 +++---
>  arch/arm/mach-omap2/clockdomain.c         |    5 +
>  arch/arm/mach-omap2/cm.h                  |    4 +
>  arch/arm/mach-omap2/control.c             |   13 ++--
>  arch/arm/mach-omap2/devices.c             |   10 +--
>  arch/arm/mach-omap2/gpmc.c                |   42 ++++++-----
>  arch/arm/mach-omap2/id.c                  |    9 +-
>  arch/arm/mach-omap2/io.c                  |   15 ++--
>  arch/arm/mach-omap2/irq.c                 |   58 ++++++++++------
>  arch/arm/mach-omap2/memory.h              |    7 ++
>  arch/arm/mach-omap2/mux.c                 |   14 ++--
>  arch/arm/mach-omap2/pm.c                  |   37 ++++++----
>  arch/arm/mach-omap2/powerdomain.c         |    2 -
>  arch/arm/mach-omap2/prcm.c                |   12 ++-
>  arch/arm/mach-omap2/prm.h                 |    6 +-
>  arch/arm/mach-omap2/sdrc.h                |    4 +
>  arch/arm/mach-omap2/serial.c              |   21 +++---
>  arch/arm/mach-omap2/usb-ehci.c            |    2 -
>  include/asm-arm/arch-omap/board-3430sdp.h |    1 
>  include/asm-arm/arch-omap/board.h         |    6 +-
>  include/asm-arm/arch-omap/clock.h         |    7 +-
>  include/asm-arm/arch-omap/control.h       |   16 ++--
>  include/asm-arm/arch-omap/cpu.h           |    6 +-
>  include/asm-arm/arch-omap/mmc.h           |    4 +
>  include/asm-arm/arch-omap/omap24xx.h      |    1 
>  include/asm-arm/arch-omap/omapfb.h        |    1 
>  include/asm-arm/arch-omap/powerdomain.h   |    1 
>  include/asm-arm/arch-omap/prcm.h          |    5 +
>  include/asm-arm/arch-omap/sram.h          |    1 
>  include/asm-arm/arch-omap/system.h        |    4 +
>  include/asm-arm/arch-omap/timex.h         |    2 +
>  include/asm-arm/arch-omap/usb.h           |    3 +
>  34 files changed, 247 insertions(+), 206 deletions(-)
> 
> size:
>    text    data     bss     dec     hex filename
> 3271533  155216  101256 3528005  35d545 vmlinux.3430sdp.orig
> 3271501  155216  101256 3527973  35d525 vmlinux.3430sdp.patched
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

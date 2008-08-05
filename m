From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] mach-omap2: resolve remaining sparse issues
Date: Tue, 5 Aug 2008 14:49:57 +0300
Message-ID: <20080805114956.GW7193@atomide.com>
References: <20080718024832.20613.30050.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61087 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757121AbYHELuA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Aug 2008 07:50:00 -0400
Content-Disposition: inline
In-Reply-To: <20080718024832.20613.30050.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [080718 06:13]:
> This series fixes the current set of sparse warnings in
> arch/arm/mach-omap2 for the omap2_evm_defconfig, n800_defconfig,
> and omap_3430sdp_defconfig configs.  A few checkpatch issues are
> also addressed.
> 
> Boot-tested on N800 and 3430SDP ES2.

Pushing these patches today.

Tony

> 
> - Paul
> 
> size:
>    text    data     bss     dec     hex filename
> 2922973  134480  100984 3158437  3031a5 vmlinux.omap2evm.orig
> 2922941  134480  100984 3158405  303185 vmlinux.omap2evm
> 
> ---
> 
> Paul Walmsley (4):
>       SmartReflex: fix sparse issues
>       mach-omap2: fix sparse warnings, some style issues for OMAP2 builds
>       mach-omap2: mark casts between integers and pointers with __force
>       Add prototypes for public functions or declare private functions static:
> 
> 
>  arch/arm/mach-omap2/board-2430sdp-flash.c |   28 ++++++++++++++--------------
>  arch/arm/mach-omap2/board-n800-audio.c    |   14 ++++++++------
>  arch/arm/mach-omap2/board-n800-camera.c   |    2 ++
>  arch/arm/mach-omap2/board-n800.h          |    2 ++
>  arch/arm/mach-omap2/clock24xx.c           |    2 +-
>  arch/arm/mach-omap2/clock24xx.h           |    6 ++++--
>  arch/arm/mach-omap2/clock34xx.h           |    9 ++++++---
>  arch/arm/mach-omap2/gpmc.c                |   11 +++++++----
>  arch/arm/mach-omap2/irq.c                 |    4 ++--
>  arch/arm/mach-omap2/mailbox.c             |    4 ++--
>  arch/arm/mach-omap2/mcbsp.c               |    2 +-
>  arch/arm/mach-omap2/mmu.h                 |    4 ++--
>  arch/arm/mach-omap2/mux.c                 |    2 +-
>  arch/arm/mach-omap2/pm.c                  |    3 ++-
>  arch/arm/mach-omap2/pm.h                  |   16 ++++++++++------
>  arch/arm/mach-omap2/pm34xx.c              |    2 +-
>  arch/arm/mach-omap2/smartreflex.c         |   10 ++++++----
>  arch/arm/mach-omap2/smartreflex.h         |    3 +++
>  include/asm-arm/arch-omap/mailbox.h       |    2 ++
>  include/asm-arm/arch-omap/prcm.h          |    4 ++++
>  20 files changed, 80 insertions(+), 50 deletions(-)
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

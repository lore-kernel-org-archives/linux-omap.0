From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/5] Updates on mcbsp driver (take #4)
Date: Fri, 30 May 2008 15:21:29 -0700
Message-ID: <20080530222129.GD30901@atomide.com>
References: <1212079850-28202-1-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:52521 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548AbYE3WVb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 May 2008 18:21:31 -0400
Content-Disposition: inline
In-Reply-To: <1212079850-28202-1-git-send-email-edubezval@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-omap@vger.kernel.org, Eduardo Valentin <eduardo.valentin@indt.org.br>

* Eduardo Valentin <edubezval@gmail.com> [080529 09:50]:
> From: Eduardo Valentin <eduardo.valentin@indt.org.br>
> 
> Hi Tony,
> 
> Here is the updated version of my previous patches.
> Now with modifications recommended by Anand and Andrew.
> 
> As on take #2, DMA and IRQ definitions were left as they are.
> Chandra is going to send his work on top of this series.
> 
> This series adds Tony's comments about clock usage on plat-omap/mcbsp.c.
> Now it is done only with usual clk_* functions calls. But a
> fake clock is created under mach-omap[1,2] to enable / disable
> correct clocks when necessary. I also included Tony's patch to fix
> clock definitions for 24xx.
> 
> This patch series updates mcbsp driver by transforming it into
> a platform driver. This is a very initial implementation.
> Basically it moves machine specific code to their correct place
> and creates the platform driver necessary structures.
> 
> It must be working for previous boards. For omap34xx it should
> work for mcbsp 1 and 2.
> 
> In order to do not break other places, I tryied to do not change
> previous API. But future improvements are needed.
> 
> Clock definitions for  mcbsp 1 and 2 were also modified to add
> correct support for omap34xx.
> 
> Thanks for last comments. More comments are wellcome. :)

Pushing this series today.

Tony


> 
> Cheers,
> 
> Eduardo Valentin (4):
>   PLAT-OMAP: MCBSP: Tranform into platform driver
>   MACH-OMAP1: MCBSP: Add support for mcbsp on mach-omap1
>   Fix mcbsp clock definition on clock34xx.h
>   MACH-OMAP2: MCBSP: Add support for mcbsp on mach-omap2
> 
> Tony Lindgren (1):
>   ARM: OMAP: Fix 24xx mcbsp clocks
> 
>  arch/arm/mach-omap1/Makefile      |    2 +
>  arch/arm/mach-omap1/mcbsp.c       |  280 ++++++++++++++++
>  arch/arm/mach-omap2/Makefile      |    2 +
>  arch/arm/mach-omap2/clock24xx.h   |   30 ++-
>  arch/arm/mach-omap2/clock34xx.h   |   30 ++-
>  arch/arm/mach-omap2/mcbsp.c       |  208 ++++++++++++
>  arch/arm/plat-omap/devices.c      |   45 +++
>  arch/arm/plat-omap/mcbsp.c        |  662 ++++++++++++++-----------------------
>  include/asm-arm/arch-omap/mcbsp.h |   62 ++++-
>  9 files changed, 890 insertions(+), 431 deletions(-)
>  create mode 100644 arch/arm/mach-omap1/mcbsp.c
>  create mode 100644 arch/arm/mach-omap2/mcbsp.c
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

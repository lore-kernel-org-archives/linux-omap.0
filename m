From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] OMAP3 clock: add DPLL enable, disable, autoidle
	control
Date: Fri, 4 Apr 2008 12:47:22 +0300
Message-ID: <20080404094722.GJ3505@atomide.com>
References: <20080404010941.510844152@pwsan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:65004 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752376AbYDDJrY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Apr 2008 05:47:24 -0400
Content-Disposition: inline
In-Reply-To: <20080404010941.510844152@pwsan.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [080404 04:29]:
> Hello,
> 
> this patch series adds DPLL autoidle control for OMAP3.  It then adds
> OMAP3 DPLL enable and disable support via clock framework clk_enable()
> and clk_disable().  It also updates the clock34xx.h comments to credit
> frequent contributors.
> 
> I personally have verified that DPLL disable has been verified to
> work on this code on OMAP3430ES2 SDP; and I believe that Jouni has 
> verified that DPLL enable works correctly.

Pushing these today.

Tony



> - Paul
> 
> 
> size:
>    text    data     bss     dec     hex filename
> 3262069  149384  100464 3511917  35966d vmlinux.orig
> 3263177  149384  100464 3513025  359ac1 vmlinux
> 
> diffstat:
>  arch/arm/mach-omap2/clock34xx.c       |  301 +++++++++++++++++++++++++++++++++-
>  arch/arm/mach-omap2/clock34xx.h       |   72 ++++++--
>  arch/arm/mach-omap2/cm-regbits-34xx.h |   18 +-
>  arch/arm/mach-omap2/cm.h              |    1
>  include/asm-arm/arch-omap/clock.h     |    5
>  5 files changed, 369 insertions(+), 28 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] OMAP2/3 clock: add DPLL rate rounding; OMAP3 DPLL
	rate programming
Date: Fri, 11 Apr 2008 12:31:50 -0700
Message-ID: <20080411193150.GJ7717@atomide.com>
References: <20080408062725.660256735@pwsan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56083 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758617AbYDKTbw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Apr 2008 15:31:52 -0400
Content-Disposition: inline
In-Reply-To: <20080408062725.660256735@pwsan.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [080407 23:48]:
> Hello,
> 
> the following two patches add:
> 
> - a new DPLL rate rounding algorithm for OMAP2/3, and
> 
> - non-CORE DPLL rate programming for OMAP3 (e.g., DPLLs 1, 2, 4, 5)
> 
> The rate rounding code is not yet integrated into the OMAP2 DPLL - this 
> will come in future patches - but it is integrated on OMAP3.  

Pushing today.

Tony


> Tested on OMAP3430ES2 SDP.  Applies against 722c80b...
> 
> 
> - Paul
> 
> 
> size:
>    text    data     bss     dec     hex filename
> 3264796  150696  100736 3516228  35a744 vmlinux.orig
> 3266060  151032  100736 3517828  35ad84 vmlinux
> 
> 
> diffstat:
>  arch/arm/mach-omap2/clock.c       |  198 +++++++++++++++++++++++++++++++++++++-
>  arch/arm/mach-omap2/clock.h       |    5
>  arch/arm/mach-omap2/clock24xx.c   |   12 +-
>  arch/arm/mach-omap2/clock24xx.h   |   17 ++-
>  arch/arm/mach-omap2/clock34xx.c   |  139 ++++++++++++++++++++++++++
>  arch/arm/mach-omap2/clock34xx.h   |   47 +++++++--
>  include/asm-arm/arch-omap/clock.h |   10 +
>  7 files changed, 409 insertions(+), 19 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

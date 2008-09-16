From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] OMAP2/3 clock: encode prcm_mod for each struct clk
Date: Tue, 16 Sep 2008 16:25:56 -0700
Message-ID: <20080916232555.GD25885@atomide.com>
References: <20080916141809.13182.31144.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62857 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752403AbYIPXZz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Sep 2008 19:25:55 -0400
Content-Disposition: inline
In-Reply-To: <20080916141809.13182.31144.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [080916 07:23]:
> Add a new field, prcm_mod, to the OMAP2/3 struct clk.  Major effects
> of this change include:
> 
> - the removal of the register rewriting code for OMAP2xxx clock framework,
> 
> - the resolution of gcc and sparse warnings for the clock code,
> 
> - the removal of many __force void __iomem * casts in the clock tree,
> 
> - and the reduction of the register address field size in struct clk by two
>   bytes per clk.
> 
> 
> This series applies on top of the "OMAP2/3 clock: revise DPLL bypass
> handling in clock tree" series.  This series is a prerequisite for the
> IDLEST handling revision patches, following shortly.
> 
> Boot-tested on 3430SDP and 2430SDP.
> 
> ---
> 
>    text    data     bss     dec     hex filename
> 3457748  160200  106600 3724548  38d504 vmlinux.3430sdp.orig
> 3457832  159768  106600 3724200  38d3a8 vmlinux.3430sdp
> 
>  arch/arm/mach-omap2/clock.c             |  223 +++++-----
>  arch/arm/mach-omap2/clock.h             |    3 
>  arch/arm/mach-omap2/clock24xx.c         |   58 ---
>  arch/arm/mach-omap2/clock24xx.h         |  458 +++++++++++++--------
>  arch/arm/mach-omap2/clock34xx.c         |   27 +
>  arch/arm/mach-omap2/clock34xx.h         |  672 ++++++++++++++++++++-----------
>  arch/arm/mach-omap2/cm.h                |    3 
>  arch/arm/plat-omap/common.c             |    1 
>  arch/arm/plat-omap/include/mach/clock.h |   26 +
>  9 files changed, 874 insertions(+), 597 deletions(-)

Looks like patch 3/3 is missing?

Tony

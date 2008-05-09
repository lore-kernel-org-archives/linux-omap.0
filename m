From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] OMAP3 clock: two small fixes
Date: Fri, 9 May 2008 14:46:14 -0700
Message-ID: <20080509214614.GE5976@atomide.com>
References: <20080508011650.15057.8127.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56840 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753594AbYEIVqQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 May 2008 17:46:16 -0400
Content-Disposition: inline
In-Reply-To: <20080508011650.15057.8127.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [080507 18:29]:
> Two minor OMAP3 clock framework fixes.  This series:
> 
> - puts the sys_clkout2 struct clk into the core_clkdm where it belongs
> 
> - removes the omap2_noncore_dpll_set_rate() function pointer from the 
>   DPLL3 struct clk (since DPLL3 is the CORE DPLL)

Pushing.

Tony

> 
> 
> - Paul
> 
> ---
> 
>  arch/arm/mach-omap2/clock34xx.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

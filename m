From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 6/9] omap: dpll: Add allow_idle/deny_idle support for
 all DPLL's
Date: Mon, 7 Feb 2011 19:57:10 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102071952300.21991@utopia.booyaka.com>
References: <1296813544-25170-1-git-send-email-santosh.shilimkar@ti.com> <1296813544-25170-7-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49797 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755179Ab1BHC5M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Feb 2011 21:57:12 -0500
In-Reply-To: <1296813544-25170-7-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rnayak@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org

Hi

On Fri, 4 Feb 2011, Santosh Shilimkar wrote:

> From: Rajendra Nayak <rnayak@ti.com>
> 
> All OMAP3/4 dpll's support hardware level autogating.
> Populate allow_idle/deny_idle function pointers for all
> DPLL's in clkops.
> 
> Also for OMAP4, call omap_clk_enable_autoidle() from PM
> core (only with CONFIG_PM) to enable hardware level
> autogating on all clock nodes which support it (For now
> only DPLL nodes)
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/clock.c          |    8 +++++++-
>  arch/arm/mach-omap2/clock.h          |    1 +
>  arch/arm/mach-omap2/clock3xxx_data.c |    2 +-
>  arch/arm/mach-omap2/clock44xx_data.c |    2 +-
>  arch/arm/mach-omap2/pm44xx.c         |    4 ++++

Looks like you add the allow_idle/deny_idle functions for the OMAP3 CORE 
DPLL, but you don't change mach-omap2/pm34xx.c.  Any reason for this?  It 
seems that the current OMAP3 PM code doesn't enable CORE DPLL autoidle.  
Do you recall why?  Perhaps it is due to some of the autoidle bugs, where 
DPLL3 would enter auto-idle while some OMAP3 IP blocks that used CORE 
clocks were not idle...


- Paul

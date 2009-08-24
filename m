From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/7] OMAP3: PM debug infrastructure
Date: Mon, 24 Aug 2009 18:20:57 +0300
Message-ID: <20090824152056.GL5165@atomide.com>
References: <1251063146-9255-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:55276 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463AbZHXPU7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Aug 2009 11:20:59 -0400
Content-Disposition: inline
In-Reply-To: <1251063146-9255-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

* Kevin Hilman <khilman@deeprootsystems.com> [090824 00:32]:
> updates from v1
> - update 'Add PRCM register dump support' to use SoC specific
>   registers.  Currenly only OMAP3 supported.
> - drop debug observability support for now, needs some updates as pointed
>   out by Tony
> 
> Peter 'p2' De Schrijver (5):
>   OMAP: PM counter infrastructure.
>   OMAP: PM: Hook into PM counters
>   OMAP: PM: Add closures to clkdm_for_each and pwrdm_for_each.
>   OMAP: PM: Add pm-debug counters
>   OMAP: PM debug: make powerdomains use PM-debug counters
> 
> Tero Kristo (2):
>   OMAP: PM debug: Add PRCM register dump support
>   OMAP: PM: Added suspend target state control to debugfs for OMAP3

I've pulled this into omap for-next in addition to your pm-upstream/fixes-32
branch.

Tony

> 
>  arch/arm/mach-omap2/clock.c                   |    2 +
>  arch/arm/mach-omap2/clockdomain.c             |   10 +-
>  arch/arm/mach-omap2/pm-debug.c                |  429 ++++++++++++++++++++++++-
>  arch/arm/mach-omap2/pm.h                      |   11 +
>  arch/arm/mach-omap2/pm24xx.c                  |    4 +-
>  arch/arm/mach-omap2/pm34xx.c                  |   38 ++-
>  arch/arm/mach-omap2/powerdomain.c             |  110 ++++++-
>  arch/arm/plat-omap/include/mach/clockdomain.h |    3 +-
>  arch/arm/plat-omap/include/mach/powerdomain.h |   15 +-
>  9 files changed, 607 insertions(+), 15 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 03/04] PM counters: fix initialization race condition
Date: Wed, 29 Oct 2008 11:16:40 -0700
Message-ID: <87mygn8dx3.fsf@deeprootsystems.com>
References: <1225279884-30668-1-git-send-email-tero.kristo@nokia.com>
	<1225279884-30668-2-git-send-email-tero.kristo@nokia.com>
	<1225279884-30668-3-git-send-email-tero.kristo@nokia.com>
	<1225279884-30668-4-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from po-out-1718.google.com ([72.14.252.159]:34624 "EHLO
	po-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753584AbYJ2SQo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Oct 2008 14:16:44 -0400
Received: by po-out-1718.google.com with SMTP id y22so5384149pof.1
        for <linux-omap@vger.kernel.org>; Wed, 29 Oct 2008 11:16:43 -0700 (PDT)
In-Reply-To: <1225279884-30668-4-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Wed\, 29 Oct 2008 13\:31\:23 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <tero.kristo@nokia.com> writes:

> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
> ---
>  arch/arm/mach-omap2/clockdomain.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
> index b0b5885..b27afc0 100644
> --- a/arch/arm/mach-omap2/clockdomain.c
> +++ b/arch/arm/mach-omap2/clockdomain.c
> @@ -481,6 +481,8 @@ void omap2_clkdm_allow_idle(struct clockdomain *clkdm)
>  			    v << __ffs(clkdm->clktrctrl_mask),
>  			    clkdm->pwrdm.ptr->prcm_offs,
>  			    CM_CLKSTCTRL);
> +
> +	pwrdm_clkdm_state_switch(clkdm);
>  }
>  
>  /**

Thanks, pulling into next PM branch.

Kevin

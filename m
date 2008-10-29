From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 02/04] PM debug: do not print out status for meta powerdomains (dpll*)
Date: Wed, 29 Oct 2008 11:15:29 -0700
Message-ID: <87vdvb8dz2.fsf@deeprootsystems.com>
References: <1225279884-30668-1-git-send-email-tero.kristo@nokia.com>
	<1225279884-30668-2-git-send-email-tero.kristo@nokia.com>
	<1225279884-30668-3-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from po-out-1718.google.com ([72.14.252.153]:33838 "EHLO
	po-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752431AbYJ2SPd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Oct 2008 14:15:33 -0400
Received: by po-out-1718.google.com with SMTP id y22so5383411pof.1
        for <linux-omap@vger.kernel.org>; Wed, 29 Oct 2008 11:15:32 -0700 (PDT)
In-Reply-To: <1225279884-30668-3-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Wed\, 29 Oct 2008 13\:31\:22 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <tero.kristo@nokia.com> writes:

> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
> ---
>  arch/arm/mach-omap2/pm-debug.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
> index c903c55..d21af83 100644
> --- a/arch/arm/mach-omap2/pm-debug.c
> +++ b/arch/arm/mach-omap2/pm-debug.c
> @@ -197,7 +197,8 @@ static int clkdm_dbg_show_counter(struct clockdomain *clkdm, void *user)
>  	struct seq_file *s = (struct seq_file *)user;
>  
>  	if (strcmp(clkdm->name, "emu_clkdm") == 0 ||
> -		strcmp(clkdm->name, "wkup_clkdm") == 0)
> +		strcmp(clkdm->name, "wkup_clkdm") == 0 ||
> +		strncmp(clkdm->name, "dpll", 4) == 0)
>  		return 0;
>  
>  	seq_printf(s, "%s->%s (%d)", clkdm->name,
> @@ -214,7 +215,8 @@ static int pwrdm_dbg_show_counter(struct powerdomain *pwrdm, void *user)
>  	int i;
>  
>  	if (strcmp(pwrdm->name, "emu_pwrdm") == 0 ||
> -		strcmp(pwrdm->name, "wkup_pwrdm") == 0)
> +		strcmp(pwrdm->name, "wkup_pwrdm") == 0 ||
> +		strncmp(pwrdm->name, "dpll", 4) == 0)
>  		return 0;
>  
>  	if (pwrdm->state != pwrdm_read_pwrst(pwrdm))
> -- 
> 1.5.4.3
>

Thanks, pulling into next PM branch.

Kevin

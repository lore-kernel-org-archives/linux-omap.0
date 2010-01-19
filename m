From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: [PATCH 1/1] OMAP3: PM: Fix compilation issue of omap3_pm_init_opp_table
Date: Tue, 19 Jan 2010 06:01:32 -0600
Message-ID: <4B559F1C.6070802@gmail.com>
References: <1263902254-3015-1-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:51893 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752578Ab0ASMBf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jan 2010 07:01:35 -0500
Received: by yxe17 with SMTP id 17so4815689yxe.33
        for <linux-omap@vger.kernel.org>; Tue, 19 Jan 2010 04:01:34 -0800 (PST)
In-Reply-To: <1263902254-3015-1-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@nokia.com>
Cc: ext Kevin Hilman <khilman@deeprootsystems.com>, Linux-OMAP <linux-omap@vger.kernel.org>

Eduardo Valentin said the following on 01/19/2010 05:57 AM:
> From: Eduardo Valentin <eduardo.valentin@nokia.com>
>
> This patch removes the compilation error when compiling
> kernel with CONFIG_PM=N. The problem was that omap3_pm_init_opp_table
> was not defined if CONFIG_PM=N.
>
> Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
> ---
>  arch/arm/mach-omap2/pm.h |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index d257225..5fc056f 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -69,7 +69,13 @@ static inline void omap3_pm_init_vc(struct prm_setup_vc *setup_vc)
>   * Initialize the basic opp table here, board files could choose to modify opp
>   * table after the basic initialization
>   */
> +#ifdef CONFIG_PM
>  extern void omap3_pm_init_opp_table(void);
> +#else
> +static inline void omap3_pm_init_opp_table(void)
> +{
> +}
> +#endif
>  
>  extern int omap3_pm_get_suspend_state(struct powerdomain *pwrdm);
>  extern int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state);
>   
Err... NAK.. I think you missed 
http://marc.info/?t=126356119700001&r=1&w=2 ?
there seems to be an issue else where, I have not dug at it yet..
Regards,
Nishanth Menon

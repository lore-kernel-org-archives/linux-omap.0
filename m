From: Kevin Hilman <khilman@ti.com>
Subject: Re: [pm-wip/voltdm_nm][PATCH 03/10] OMAP4: PM: VC: allow channels to use cmdra reg
Date: Thu, 09 Jun 2011 10:48:07 -0700
Message-ID: <8762oe28x4.fsf@ti.com>
References: <1307412972-25854-1-git-send-email-nm@ti.com>
	<1307412972-25854-4-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:32917 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753038Ab1FIRsM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jun 2011 13:48:12 -0400
Received: by pwj4 with SMTP id 4so1025942pwj.2
        for <linux-omap@vger.kernel.org>; Thu, 09 Jun 2011 10:48:10 -0700 (PDT)
In-Reply-To: <1307412972-25854-4-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Mon, 6 Jun 2011 21:16:06 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Nishanth Menon <nm@ti.com> writes:

> if volt_reg and cmd_reg are the same from PMIC configuration,
> we can use the cmd reg by using racen - 

-ECONFUSED

If volt_reg and cmd_reg are the same then I understood RACEN to be a
don't care.  Zero means use volt_reg, 1 means use cmd_reg, but if
volt_reg == cmd_reg, then either way is the same result.

The way I understood (and coded) this is that the only time you need
RACEN set is precicesly the case when a cmd_reg is provided (and thus is
different from volt_reg.

What am I missing?

Or, stated differently, I guess I don't understand the use case for 
RAC != RACEN

Kevin

> this is valid for
> voltage commands, however, in most cases, we'd like to retain
> voltage reg configuration as well for vfsm commands going thru
> from h/w.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/mach-omap2/vc.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
> index 0c0e416..6017c70 100644
> --- a/arch/arm/mach-omap2/vc.c
> +++ b/arch/arm/mach-omap2/vc.c
> @@ -337,9 +337,13 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
>  		voltdm->rmw(vc->smps_cmdra_mask,
>  			    vc->cmd_reg_addr << __ffs(vc->smps_cmdra_mask),
>  			    vc->common->smps_cmdra_reg);
> -		vc->cfg_channel |= vc_cfg_bits->rac | vc_cfg_bits->racen;
> +		vc->cfg_channel |= vc_cfg_bits->rac;
>  	}
>  
> +	/* If voltage and cmd regs are same, we can use cmdra register */
> +	if (vc->volt_reg_addr == vc->cmd_reg_addr)
> +		vc->cfg_channel |= vc_cfg_bits->racen;
> +
>  	/* Set up the on, inactive, retention and off voltage */
>  	on_vsel = voltdm->pmic->uv_to_vsel(voltdm->pmic->on_volt);
>  	onlp_vsel = voltdm->pmic->uv_to_vsel(voltdm->pmic->onlp_volt);

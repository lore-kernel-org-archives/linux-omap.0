From: Kevin Hilman <khilman@ti.com>
Subject: Re: [pm-wip/voltdm_nm][PATCH 01/10] OMAP3+: VC: fix mutant channel handling
Date: Thu, 09 Jun 2011 10:21:19 -0700
Message-ID: <8739ji3oq8.fsf@ti.com>
References: <1307412972-25854-1-git-send-email-nm@ti.com>
	<1307412972-25854-2-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:35433 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752987Ab1FIRVX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jun 2011 13:21:23 -0400
Received: by mail-pw0-f51.google.com with SMTP id 9so854358pwi.10
        for <linux-omap@vger.kernel.org>; Thu, 09 Jun 2011 10:21:22 -0700 (PDT)
In-Reply-To: <1307412972-25854-2-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Mon, 6 Jun 2011 21:16:04 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Nishanth Menon <nm@ti.com> writes:

> "OMAP3+: PM: VC: handle mutant channel config for OMAP4 MPU channel"
> handles the mutant channel flags, however since vc_cfg_bits is static
> file wide variable, it makes better sense to update this based on
> the specific channel using mutant or not. else if we have a initial
> registration of mutant channel definition, all other channels will
> end up using the mutant definition.

Indeed.

> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> we should probably squash this in to the original commit

Thanks, squashed.

Kevin

>  arch/arm/mach-omap2/vc.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
> index c8deac9..aa9f0bc 100644
> --- a/arch/arm/mach-omap2/vc.c
> +++ b/arch/arm/mach-omap2/vc.c
> @@ -53,7 +53,7 @@ static struct omap_vc_channel_cfg vc_mutant_channel_cfg = {
>  	.cmd   = BIT(1),
>  };
>  
> -static struct omap_vc_channel_cfg *vc_cfg_bits = &vc_default_channel_cfg;
> +static struct omap_vc_channel_cfg *vc_cfg_bits;
>  #define CFG_CHANNEL_MASK 0x1f
>  
>  /**
> @@ -300,6 +300,8 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
>  	vc->cfg_channel = 0;
>  	if (vc->flags & OMAP_VC_CHANNEL_CFG_MUTANT)
>  		vc_cfg_bits = &vc_mutant_channel_cfg;
> +	else
> +		vc_cfg_bits = &vc_default_channel_cfg;
>  
>  	/* get PMIC/board specific settings */
>  	vc->i2c_slave_addr = voltdm->pmic->i2c_slave_addr;

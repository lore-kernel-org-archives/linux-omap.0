From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/1] OMAP3:Re-introduce omap_type()
Date: Fri, 12 Jun 2009 15:12:49 -0700
Message-ID: <874oulayou.fsf@deeprootsystems.com>
References: <1244840311-11809-1-git-send-email-ubh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f187.google.com ([209.85.222.187]:49497 "EHLO
	mail-pz0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269AbZFLWMt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Jun 2009 18:12:49 -0400
Received: by pzk17 with SMTP id 17so811459pzk.33
        for <linux-omap@vger.kernel.org>; Fri, 12 Jun 2009 15:12:51 -0700 (PDT)
In-Reply-To: <1244840311-11809-1-git-send-email-ubh@ti.com> (Ulrik Bech Hald's message of "Fri\, 12 Jun 2009 15\:58\:31 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ulrik Bech Hald <ubh@ti.com>
Cc: linux-omap@vger.kernel.org

Ulrik Bech Hald <ubh@ti.com> writes:

> The functionality of omap_type() is needed for eg. watchdog
> device registration to distinguish different device types.
>
> Signed-off-by: Ulrik Bech Hald <ubh@ti.com>

Collision. :) I have an add-back of this in my fixes queue which I
just posted as well.

Kevin

> ---
>  arch/arm/mach-omap2/id.c |   21 +++++++++++++++++++++
>  1 files changed, 21 insertions(+), 0 deletions(-)
>  mode change 100644 => 100755 arch/arm/mach-omap2/id.c
>
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> old mode 100644
> new mode 100755
> index 458990e..9fa61b4
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -48,6 +48,27 @@ int omap_chip_is(struct omap_chip_id oci)
>  }
>  EXPORT_SYMBOL(omap_chip_is);
>  
> +int omap_type(void)
> +{
> +	u32 val = 0;
> +
> +	if (cpu_is_omap24xx()) {
> +		val = omap_ctrl_readl(OMAP24XX_CONTROL_STATUS);
> +	} else if (cpu_is_omap34xx()) {
> +		val = omap_ctrl_readl(OMAP343X_CONTROL_STATUS);
> +	} else {
> +		pr_err("Cannot detect omap type!\n");
> +		goto out;
> +	}
> +
> +	val &= OMAP2_DEVICETYPE_MASK;
> +	val >>= 8;
> +
> +out:
> +	return val;
> +}
> +EXPORT_SYMBOL(omap_type);
> +
>  /*----------------------------------------------------------------------------*/
>  
>  #define OMAP_TAP_IDCODE		0x0204
> -- 
> 1.5.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: enable EHCI by default
Date: Thu, 5 Dec 2013 09:11:04 -0800
Message-ID: <20131205171104.GZ26766@atomide.com>
References: <1386205695-26191-1-git-send-email-thomas@cozybit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:35223 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752131Ab3LERLH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Dec 2013 12:11:07 -0500
Content-Disposition: inline
In-Reply-To: <1386205695-26191-1-git-send-email-thomas@cozybit.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Pedersen <thomas@cozybit.com>
Cc: linux-omap@vger.kernel.org, linux@arm.linux.org.uk, Roger Quadros <rogerq@ti.com>

* Thomas Pedersen <thomas@cozybit.com> [131204 17:09]:
> This is needed for the pandaboard (ES) kernel to detect
> the ethernet device during boot. Useful for NFS root etc.

Thanks for the patch, just to clarify why we have not been able
to apply this is EHCI blocks deeper PM states for at least omap3
currently. And this means the PM related tests won't run properly
out of the box..

Roger has been working to get EHCI working properly with PM,
and the recent interrupts-extended binding and the addition of
wake-up interrupts to pinctrl-single.c should allow us to do that
soon. Maybe Roger can summarize what else might still be missing?

Regards,

Tony
 
> Signed-off-by: Thomas Pedersen <thomas@cozybit.com>
> ---
>  arch/arm/configs/omap2plus_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> index bfa80a1..a236a2b 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -212,6 +212,7 @@ CONFIG_SND_OMAP_SOC_OMAP_TWL4030=m
>  CONFIG_SND_OMAP_SOC_OMAP_ABE_TWL6040=m
>  CONFIG_SND_OMAP_SOC_OMAP3_PANDORA=m
>  CONFIG_USB=y
> +CONFIG_USB_EHCI_HCD=y
>  CONFIG_USB_DEBUG=y
>  CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
>  CONFIG_USB_MON=y
> -- 
> 1.8.4.3
> 

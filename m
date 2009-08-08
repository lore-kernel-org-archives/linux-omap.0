From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH][pm-2.6.29] OMAP: PM: Fix MUSB power domain association
Date: Fri, 07 Aug 2009 17:02:32 -0700
Message-ID: <87iqgzkw9z.fsf@deeprootsystems.com>
References: <1249688520-22946-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:29011 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756660AbZHHACd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Aug 2009 20:02:33 -0400
Received: by wf-out-1314.google.com with SMTP id 26so734949wfd.4
        for <linux-omap@vger.kernel.org>; Fri, 07 Aug 2009 17:02:34 -0700 (PDT)
In-Reply-To: <1249688520-22946-1-git-send-email-vikram.pandita@ti.com> (Vikram Pandita's message of "Fri\,  7 Aug 2009 18\:42\:00 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vikram Pandita <vikram.pandita@ti.com>
Cc: linux-omap@vger.kernel.org

Vikram Pandita <vikram.pandita@ti.com> writes:

> MUSB lies in CORE power domain.
> Current code wrongly associates MUSB with USBHOST domain.
> USBHOST domain is for EHCI/OHCI controller.
>
> Correct the association of MUSB to CORE power domain.
>
> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>

Thanks, pushed to pm-2.6.29 branch.
(Not relevant to current PM branch due to new omap_hwmod/omap_device 
infrastructure.)

Kevin

> ---
>  arch/arm/mach-omap2/omapdev3xxx.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omapdev3xxx.h b/arch/arm/mach-omap2/omapdev3xxx.h
> index d2772c4..fd29129 100644
> --- a/arch/arm/mach-omap2/omapdev3xxx.h
> +++ b/arch/arm/mach-omap2/omapdev3xxx.h
> @@ -663,7 +663,7 @@ static struct omapdev usbhost_3xxx_omapdev = {
>  
>  static struct omapdev usbotg_3xxx_omapdev = {
>  	.name		= "usbotg_omapdev",
> -	.pwrdm		= { .name = "usbhost_pwrdm" },
> +	.pwrdm		= { .name = "core_pwrdm" },
>  	.pdev_name	= "musb_hdrc",
>  	.pdev_id	= -1,
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
> -- 
> 1.6.3.3.334.g916e1

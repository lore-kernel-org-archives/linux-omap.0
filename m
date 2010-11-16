From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap3: feature: fix OMAP3_IVA_MASK
Date: Tue, 16 Nov 2010 13:27:15 -0800
Message-ID: <20101116212715.GK9264@atomide.com>
References: <1288973121-14073-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:38273 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932087Ab0KPV1Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Nov 2010 16:27:25 -0500
Content-Disposition: inline
In-Reply-To: <1288973121-14073-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Arno Steffen <arno.steffen@googlemail.com>

* Nishanth Menon <nm@ti.com> [101105 17:29]:
> From: Arno Steffen <arno.steffen@googlemail.com>
> 
> OMAP3_IVA_MASK should use OMAP3_IVA_SHIFT instead of OMAP3_SGX_SHIFT
> 
> Signed-off-by: Arno Steffen <arno.steffen@googlemail.com>
> ---
> Sending on behalf of Arno - he pointed at the change and everything
> except for the patch ;)
> Reported here:
> http://marc.info/?l=linux-omap&m=128896969832702&w=2

Hmm, until we have an official verbal-patch-to-unified-diff translator,
I guess the right thing to do here is to make it be:

From: Nishanth Menon <nm@ti.com>

OMAP3_IVA_MASK should use OMAP3_IVA_SHIFT instead of OMAP3_SGX_SHIFT

Reported-by: Arno Steffen <arno.steffen@googlemail.com>
Signed-off-by: Nishanth Menon <nm@ti.com>

Can you please repost or confirm that's OK for you?

Tony
 
>  arch/arm/mach-omap2/control.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
> index b6c6b7c..5325297 100644
> --- a/arch/arm/mach-omap2/control.h
> +++ b/arch/arm/mach-omap2/control.h
> @@ -309,7 +309,7 @@
>  #define		FEAT_SGX_NONE		2
>  
>  #define OMAP3_IVA_SHIFT			12
> -#define OMAP3_IVA_MASK			(1 << OMAP3_SGX_SHIFT)
> +#define OMAP3_IVA_MASK			(1 << OMAP3_IVA_SHIFT)
>  #define		FEAT_IVA		0
>  #define		FEAT_IVA_NONE		1
>  
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

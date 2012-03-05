From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/3] ARM: OMAP2/3: Add idle_st bits for ST_32KSYNC
 timer to prcm-common header
Date: Mon, 5 Mar 2012 14:56:40 -0800
Message-ID: <20120305225640.GK12083@atomide.com>
References: <1326983304-14619-1-git-send-email-hvaibhav@ti.com>
 <1326983304-14619-3-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:14019 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756666Ab2CEW4p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Mar 2012 17:56:45 -0500
Content-Disposition: inline
In-Reply-To: <1326983304-14619-3-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com, johnstul@us.ibm.com, Felipe Balbi <balbi@ti.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

* Vaibhav Hiremath <hvaibhav@ti.com> [120119 06:01]:
> Add missing idle_st bit for 32k-sync timer into the prcm-common
> header file, required for hwmod data.

These should be queued by Paul when the related hwmod changes
are done.

Regards,

Tony
 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/mach-omap2/prcm-common.h |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
> index 5aa5435..29955d5 100644
> --- a/arch/arm/mach-omap2/prcm-common.h
> +++ b/arch/arm/mach-omap2/prcm-common.h
> @@ -177,6 +177,8 @@
>  /* PM_WKST_WKUP, CM_IDLEST_WKUP shared bits */
>  #define OMAP24XX_ST_GPIOS_SHIFT				2
>  #define OMAP24XX_ST_GPIOS_MASK				(1 << 2)
> +#define OMAP24XX_ST_32KSYNC_SHIFT			1
> +#define OMAP24XX_ST_32KSYNC_MASK			(1 << 1)
>  #define OMAP24XX_ST_GPT1_SHIFT				0
>  #define OMAP24XX_ST_GPT1_MASK				(1 << 0)
>  
> @@ -307,6 +309,8 @@
>  #define OMAP3430_ST_SR1_MASK				(1 << 6)
>  #define OMAP3430_ST_GPIO1_SHIFT				3
>  #define OMAP3430_ST_GPIO1_MASK				(1 << 3)
> +#define OMAP3430_ST_32KSYNC_SHIFT			2
> +#define OMAP3430_ST_32KSYNC_MASK			(1 << 2)
>  #define OMAP3430_ST_GPT12_SHIFT				1
>  #define OMAP3430_ST_GPT12_MASK				(1 << 1)
>  #define OMAP3430_ST_GPT1_SHIFT				0
> -- 
> 1.7.0.4
> 

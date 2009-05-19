From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: PM: Do not Enable SmartReflex if OPP tables not defined
Date: Tue, 19 May 2009 09:54:16 -0700
Message-ID: <87d4a56nk7.fsf@deeprootsystems.com>
References: <1242736671-27268-1-git-send-email-ext-roger.quadros@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f134.google.com ([209.85.222.134]:52217 "EHLO
	mail-pz0-f134.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462AbZESQyQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2009 12:54:16 -0400
Received: by mail-pz0-f134.google.com with SMTP id 40so309251pzk.33
        for <linux-omap@vger.kernel.org>; Tue, 19 May 2009 09:54:18 -0700 (PDT)
In-Reply-To: <1242736671-27268-1-git-send-email-ext-roger.quadros@nokia.com> (Roger Quadros's message of "Tue\, 19 May 2009 15\:37\:51 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <ext-roger.quadros@nokia.com>
Cc: linux-omap@vger.kernel.org

Roger Quadros <ext-roger.quadros@nokia.com> writes:

> Prevent SmartReflex driver driver from loading if OPP tables are
> not defined by platform. This removes possibility of NULL pointer
> reference in SmartReflex driver code.
>
> Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>

Thanks, pushing to PM branch.

Kevin

> ---
>  arch/arm/mach-omap2/smartreflex.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index b032366..4823ce8 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -852,6 +852,12 @@ static int __init omap3_sr_init(void)
>  	int ret = 0;
>  	u8 RdReg;
>  
> +	/* Exit if OPP tables are not defined */
> +        if (!(mpu_opps && l3_opps)) {
> +                pr_err("SR: OPP rate tables not defined for platform, not enabling SmartReflex\n");
> +		return -ENODEV;
> +        }
> +
>  	/* Enable SR on T2 */
>  	ret = twl4030_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &RdReg,
>  					R_DCDC_GLOBAL_CFG);
> -- 
> 1.6.0.4

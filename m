From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 01/10] ARM: OMAP2+: pm: Do not init statically the SR
 and voltage layer with DT
Date: Wed, 4 Jan 2012 11:04:32 -0700
Message-ID: <20120104180432.GH15503@ponder.secretlab.ca>
References: <1323439361-1647-1-git-send-email-b-cousson@ti.com>
 <1323439361-1647-2-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:51347 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932105Ab2ADTGW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jan 2012 14:06:22 -0500
Received: by mail-vx0-f174.google.com with SMTP id fk14so13444702vcb.19
        for <linux-omap@vger.kernel.org>; Wed, 04 Jan 2012 11:06:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1323439361-1647-2-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: tony@atomide.com, rob.herring@calxeda.com, Kevin Hilman <khilman@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Dec 09, 2011 at 03:02:32PM +0100, Benoit Cousson wrote:
> In the case of DT, the PMIC and SR initialization will be done using
> a completely different mechanism.
> 
> Disable this part if a DT blob is available.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> Cc: Kevin Hilman <khilman@ti.com>
> ---
>  arch/arm/mach-omap2/pm.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index 1881fe9..ad4f693 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -227,6 +227,14 @@ postcore_initcall(omap2_common_pm_init);
>  
>  static int __init omap2_common_pm_late_init(void)
>  {
> +	/*
> +	 * In the case of DT, the PMIC and SR initialization will be done using
> +	 * a completely different mechanism.
> +	 * Disable this part if a DT blob is available.
> +	 */
> +	if (of_have_populated_dt())
> +		return 0;
> +
>  	/* Init the voltage layer */
>  	omap_pmic_late_init();
>  	omap_voltage_late_init();
> -- 
> 1.7.0.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

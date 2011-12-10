From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 01/10] ARM: OMAP2+: pm: Do not init statically the SR and voltage layer with DT
Date: Fri, 09 Dec 2011 17:32:26 -0800
Message-ID: <87obvhgqj9.fsf@ti.com>
References: <1323438631-28124-1-git-send-email-b-cousson@ti.com>
	<1323438631-28124-2-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:32934 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751105Ab1LJBca (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Dec 2011 20:32:30 -0500
Received: by mail-iy0-f176.google.com with SMTP id k12so5445455iak.7
        for <linux-omap@vger.kernel.org>; Fri, 09 Dec 2011 17:32:29 -0800 (PST)
In-Reply-To: <1323438631-28124-2-git-send-email-b-cousson@ti.com> (Benoit
	Cousson's message of "Fri, 9 Dec 2011 14:50:22 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: tony@atomide.com, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Benoit Cousson <b-cousson@ti.com> writes:

> In the case of DT, the PMIC and SR initialization will be done using
> a completely different mechanism.
>
> Disable this part if a DT blob is available.
>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>

Acked-by: Kevin Hilman <khilman@ti.com>

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

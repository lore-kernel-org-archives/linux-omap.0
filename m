From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 03/05] OMAP3: SR: Use sysclk for SR CLKLENGTH calc
Date: Wed, 18 Mar 2009 08:57:53 -0700
Message-ID: <87hc1qq0vy.fsf@deeprootsystems.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02FAEDE84A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:32662 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752692AbZCRP57 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Mar 2009 11:57:59 -0400
Received: by qw-out-2122.google.com with SMTP id 8so102426qwh.37
        for <linux-omap@vger.kernel.org>; Wed, 18 Mar 2009 08:57:56 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02FAEDE84A@dbde02.ent.ti.com> (Rajendra Nayak's message of "Wed\, 18 Mar 2009 15\:25\:30 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Nayak, Rajendra" <rnayak@ti.com> writes:

> From: Rajendra Nayak <rnayak@ti.com>
>
> This patch uses the sysclk to set the SR CLKLENGTH instead
> of the OSC clock speed used earlier.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
> ---
>  arch/arm/mach-omap2/smartreflex.c |   14 +++++++-------
>  1 files changed, 7 insertions(+), 7 deletions(-)
>
> Index: linux-omap-2.6/arch/arm/mach-omap2/smartreflex.c
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/smartreflex.c	2009-03-18 13:56:25.610250244 +0530
> +++ linux-omap-2.6/arch/arm/mach-omap2/smartreflex.c	2009-03-18 13:56:26.106235150 +0530
> @@ -146,14 +146,14 @@ static u32 cal_test_nvalue(u32 sennval, 
>  
>  static void sr_set_clk_length(struct omap_sr *sr)
>  {
> -	struct clk *osc_sys_ck;
> -	u32 sys_clk = 0;
> +	struct clk *sys_ck;
> +	u32 sys_clk_speed = 0;

Don't need to init this to zero as it is always assigned below.

> -	osc_sys_ck = clk_get(NULL, "osc_sys_ck");
> -	sys_clk = clk_get_rate(osc_sys_ck);
> -	clk_put(osc_sys_ck);
> +	sys_ck = clk_get(NULL, "sys_ck");
> +	sys_clk_speed = clk_get_rate(sys_ck);
> +	clk_put(sys_ck);
>  
> -	switch (sys_clk) {
> +	switch (sys_clk_speed) {
>  	case 12000000:
>  		sr->clk_length = SRCLKLENGTH_12MHZ_SYSCLK;
>  		break;
> @@ -170,7 +170,7 @@ static void sr_set_clk_length(struct oma
>  		sr->clk_length = SRCLKLENGTH_38MHZ_SYSCLK;
>  		break;
>  	default :
> -		printk(KERN_ERR "Invalid sysclk value: %d\n", sys_clk);
> +		printk(KERN_ERR "Invalid sysclk value: %d\n", sys_clk_speed);
>  		break;
>  	}
>  }--
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

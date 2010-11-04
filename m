From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/3 v2] omap4: opp: add OPP table data
Date: Thu, 4 Nov 2010 16:13:09 -0700
Message-ID: <20101104231309.GE9264@atomide.com>
References: <1287536543-9729-1-git-send-email-nm@ti.com>
 <1287536543-9729-2-git-send-email-nm@ti.com>
 <1287536543-9729-3-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:54498 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752927Ab0KDXNR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Nov 2010 19:13:17 -0400
Content-Disposition: inline
In-Reply-To: <1287536543-9729-3-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: l-o <linux-omap@vger.kernel.org>, Kevin H <khilman@deeprootsystems.com>

* Nishanth Menon <nm@ti.com> [101019 17:53]:
> @@ -86,7 +87,10 @@ int __init omap_init_opp_table(void)
>  	omap_table_init = 1;
>  
>  	/* Select the OPP table we'd like to enable based on cpu we are on */
> -	if (cpu_is_omap34xx()) {
> +	if (cpu_is_omap44xx()) {
> +		opp_def = omap44xx_opp_def_list;
> +		opp_def_size = ARRAY_SIZE(omap44xx_opp_def_list);
> +	} else if (cpu_is_omap34xx()) {
>  		opp_def = cpu_is_omap3630() ? omap36xx_opp_def_list :
>  			omap34xx_opp_def_list;
>  		opp_def_size = cpu_is_omap3630() ?

And based on the comments in patch 1/3, when you add support for
new processor, you just add a new init function instead of adding
"if cpu_is_omapxxxx else if" chunks.

Regards,

Tony

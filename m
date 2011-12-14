From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 4/4] ARM: omap: pass minimal SoC/board data for UART
 from dt
Date: Wed, 14 Dec 2011 11:25:10 -0800
Message-ID: <20111214192509.GH32251@atomide.com>
References: <1323863746-18145-1-git-send-email-rnayak@ti.com>
 <1323863746-18145-5-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:22910 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757135Ab1LNTZO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Dec 2011 14:25:14 -0500
Content-Disposition: inline
In-Reply-To: <1323863746-18145-5-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, khilman@ti.com, govindraj.raja@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org, robherring2@gmail.com

* Rajendra Nayak <rnayak@ti.com> [111214 03:24]:
> Pass minimal data needed for console boot, from dt, for
> OMAP4 panda/sdp and OMAP3 beagle boards, and get rid of the
> static initialization from generic board file.
> 
> Acked-by: Rob Herring <rob.herring@calxeda.com>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

This we can't merge because this breaks serial console for
omap2 because you're not adding the omap2 specific dtsi
entries for omap2..

> --- a/arch/arm/mach-omap2/board-generic.c
> +++ b/arch/arm/mach-omap2/board-generic.c
> @@ -69,7 +69,6 @@ static void __init omap_generic_init(void)
>  	if (node)
>  		irq_domain_add_simple(node, 0);
>  
> -	omap_serial_init();
>  	omap_sdrc_init(NULL, NULL);
>  
>  	of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);

..and you're removing the call for omap_serial_init.

Please just update this patch with the omap2 entries
as well. Other than that looks good to me.

Tony

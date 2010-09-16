From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 3/6] TI816X: Update common OMAP machine specific
 sources
Date: Thu, 16 Sep 2010 15:25:00 -0700
Message-ID: <20100916222459.GQ29610@atomide.com>
References: <1281546664-11477-1-git-send-email-hemantp@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50630 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753877Ab0IPWZE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Sep 2010 18:25:04 -0400
Content-Disposition: inline
In-Reply-To: <1281546664-11477-1-git-send-email-hemantp@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemant Pedanekar <hemantp@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com

* Hemant Pedanekar <hemantp@ti.com> [100811 10:03]:
> This patch updates the common machine spcific source files with support for
> TI816X.
> 
> Note that the nr_irqs is overridden in INTC driver since the number of IRQs on
> TI816X are different (128) comapared to other OMAPs (96).

<snip>

> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -419,6 +441,9 @@ void __init omap2_check_revision(void)
>  	} else if (cpu_is_omap44xx()) {
>  		omap4_check_revision();
>  		return;
> +	} else if (cpu_is_ti816x()) {
> +		ti816x_check_revision();
> +		return;
>  	} else {
>  		pr_err("OMAP revision unknown, please fix!\n");
>  	}

This does not look right, at this point you should just know
the processor class set by the set_globals call.

Please take a look at plat-omap/common.c and add an entry for
omap2_set_globals_ti816x. This gets called very early from the board-*.c
file, so you can initialize things.

Note that by default we are building in support for omap2, 3 and 4
and support for all the boards too. This allows booting them
with the same kernel binary for developers and distros.

In general, you might want to see how we added support for omap36xx.
TI816X seems to be very close to omap3 with some extra registers, and
I'm not at all convinced that we even need to set it up as a separate
processor. Basically adding the set_globals + doing the more
accurate detection in id.c should do the trick.

Regards,

Tony

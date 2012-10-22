From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP3: Beagle: fix OPP customization and initcall
 ordering
Date: Mon, 22 Oct 2012 14:26:56 -0700
Message-ID: <20121022212656.GK4730@atomide.com>
References: <1350938009-22716-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:36033 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754355Ab2JVV1B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Oct 2012 17:27:01 -0400
Content-Disposition: inline
In-Reply-To: <1350938009-22716-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org

* Kevin Hilman <khilman@deeprootsystems.com> [121022 13:35]:
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -24,6 +24,7 @@
>  #include <linux/input.h>
>  #include <linux/gpio_keys.h>
>  #include <linux/opp.h>
> +#include <linux/cpu.h>
>  
>  #include <linux/mtd/mtd.h>
>  #include <linux/mtd/partitions.h>
> @@ -444,12 +445,13 @@ static struct omap_board_mux board_mux[] __initdata = {
>  };
>  #endif
>  
> -static void __init beagle_opp_init(void)
> +static int __init beagle_opp_init(void)
>  {
>  	int r = 0;

Don't you need to add some check here for machine_is
to prevent this from running on other boards if you now
make this into an initcall?

Regards,

Tony

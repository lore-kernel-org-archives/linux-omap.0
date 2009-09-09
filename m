From: Jean Pihet <jpihet@mvista.com>
Subject: Re: [PATCH]PM: Initialization of SDRC params for DVFS on Zoom2
Date: Wed, 9 Sep 2009 14:12:07 +0200
Message-ID: <200909091412.07748.jpihet@mvista.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030A007938@dbde02.ent.ti.com> <87ljkpm67t.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:13760 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751242AbZIIMNB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Sep 2009 08:13:01 -0400
In-Reply-To: <87ljkpm67t.fsf@deeprootsystems.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Reddy, Teerth" <teerth@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wednesday 09 September 2009 00:17:42 Kevin Hilman wrote:
> "Reddy, Teerth" <teerth@ti.com> writes:
> > This patch initializes the SDRC params for DVFS on Zoom2.
> >
> > Signed-off-by: Teerth Reddy <teerth@ti.com>
> > ---
> >  arch/arm/mach-omap2/board-zoom2.c |    6 ++++--
> >  1 files changed, 4 insertions(+), 2 deletions(-)
> >
> > Index: linux-omap-pm/arch/arm/mach-omap2/board-zoom2.c
> > ===================================================================
> > --- linux-omap-pm.orig/arch/arm/mach-omap2/board-zoom2.c
> > +++ linux-omap-pm/arch/arm/mach-omap2/board-zoom2.c
> > @@ -23,6 +23,7 @@
> >
> >  #include "mmc-twl4030.h"
> >  #include "omap3-opp.h"
> > +#include "sdram-micron-mt46h32m32lf-6.h"
> >
> >  static struct omap_uart_config zoom2_uart_config __initdata = {
> >  	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
> > @@ -36,8 +37,9 @@ static void __init omap_zoom2_init_irq(v
> >  {
> >  	omap_board_config = zoom2_config;
> >  	omap_board_config_size = ARRAY_SIZE(zoom2_config);
> > -	omap2_init_common_hw(NULL, NULL, omap3_mpu_rate_table,
> > -	                     omap3_dsp_rate_table, omap3_l3_rate_table);
> > +	omap2_init_common_hw(mt46h32m32lf6_sdrc_params, NULL,
> > +		omap3_mpu_rate_table, omap3_dsp_rate_table,
> > +					omap3_l3_rate_table);
>
> Not having looked at the Zoom2 schematics, are you sure this is only
> using a single chip select?  The other boards using the same part
> (beagle, overo) are interfacing to this part using both CSes.
>
> Have you tested DVFS on Zoom2 using the full 256Mb?
Good point!

DVFS works fine using the two chip selects:
        omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
                             mt46h32m32lf6_sdrc_params,
                             omap3_mpu_rate_table,
                             omap3_dsp_rate_table,
                             omap3_l3_rate_table);

One remark though: since the memory chips are popped on top of the OMAP chip 
the schematics are not showing the chip selects connections. In any case 
U-Boot is configuring the SDRC module to use the 2 chip selects, so I think 
this change is needed.

We need confirmation. Anyone from TI knows?

Regards,
Jean

>
> Kevin
>
> >  	omap_init_irq();
> >  	omap_gpio_init();
> >  }
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



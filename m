From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3 : PM : Functions to get freq from opp and vice-versa
Date: Wed, 30 Sep 2009 11:17:38 -0700
Message-ID: <87fxa4mh4t.fsf@deeprootsystems.com>
References: <1252495499-8455-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f194.google.com ([209.85.216.194]:59118 "EHLO
	mail-px0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755029AbZI3SRg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Sep 2009 14:17:36 -0400
Received: by pxi32 with SMTP id 32so5690076pxi.4
        for <linux-omap@vger.kernel.org>; Wed, 30 Sep 2009 11:17:40 -0700 (PDT)
In-Reply-To: <1252495499-8455-1-git-send-email-premi@ti.com> (Sanjeev Premi's message of "Wed\,  9 Sep 2009 16\:54\:59 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

Sanjeev Premi <premi@ti.com> writes:

> There is no generic function to get OPP corresponding to frequency
> and vice versa.
>
> Function get_opp() - in resource34xx.c - is included only when
> CONFIG_OMAP_PM_SRF is enabled. Moreover, it is always called with
> an explicit addition of MAX_VDDn_OPP e.g.
>   opp = get_opp(mpu_opps + MAX_VDD1_OPP, clk->rate);
>   opp = get_opp(l3_opps + MAX_VDD2_OPP, clk->rate);
>
> This is 'addition' is required as there is no encapsulation of
> MIN and MAX VDDs associated to the table.
>
> This patch fixes the issue by creating a 'table' object that
> encapsulates the MIN and MAX values and the existing rate table.
>
> Signed-off-by: Sanjeev Premi <premi@ti.com>

Looks ok, minor comment below...

[...]

> diff --git a/arch/arm/plat-omap/include/mach/omap-pm.h b/arch/arm/plat-omap/include/mach/omap-pm.h
> index 583e540..cf910ef 100644
> --- a/arch/arm/plat-omap/include/mach/omap-pm.h
> +++ b/arch/arm/plat-omap/include/mach/omap-pm.h
> @@ -33,6 +33,20 @@ struct omap_opp {
>  	u16 vsel;
>  };
>  
> +/* struct omap_opp_table - View OPP table as an object
> + * @min: Minimum OPP id
> + * @max: Maximim OPP id
> + * @opps: Pointer to array defining the OPPs.
> + *
> + * An OPP table has varied length. Knowing minimum and maximum
> + * OPP ids allow easy traversal.
> + */
> +struct omap_opp_table {
> +	u8	min;
> +	u8	max;
> +	struct omap_opp* opps;
> +};
> +
>  extern struct omap_opp *mpu_opps;
>  extern struct omap_opp *dsp_opps;
>  extern struct omap_opp *l3_opps;
> @@ -49,6 +63,17 @@ extern struct omap_opp *l3_opps;
>  #define OCP_INITIATOR_AGENT		2
>  
>  /**
> + *
> + */

Either add a useful comment or remove the comment block (preferably the latter)

> +int opp_to_freq(unsigned long* freq, const struct omap_opp_table* table, u8 opp);
> +
> +/**
> + *
> + */

ditto

Kevin

From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3 v2] omap: opp: add OMAP3 OPP table data and common
 init
Date: Thu, 4 Nov 2010 16:10:15 -0700
Message-ID: <20101104231014.GD9264@atomide.com>
References: <1287536543-9729-1-git-send-email-nm@ti.com>
 <1287536543-9729-2-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52176 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740Ab0KDXKX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Nov 2010 19:10:23 -0400
Content-Disposition: inline
In-Reply-To: <1287536543-9729-2-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: l-o <linux-omap@vger.kernel.org>, Kevin H <khilman@deeprootsystems.com>

Hi Nishant,

You can make the opp init more generic by changing omap_init_opp_table to be:

int __init omap_init_opp_table(struct omap_opp_def *opp_list)

instead of below. And then..

> +int __init omap_init_opp_table(void)
> +{
> +	struct omap_opp_def *opp_def;
> +	u32 opp_def_size;
> +	int i, r;
> +
> +	/*
> +	 * Allow multiple calls, but initialize only if not already initalized
> +	 * even if the previous call failed, coz, no reason we'd succeed again
> +	 */
> +	if (omap_table_init)
> +		return 0;
> +	omap_table_init = 1;
> +
> +	/* Select the OPP table we'd like to enable based on cpu we are on */
> +	if (cpu_is_omap34xx()) {
> +		opp_def = cpu_is_omap3630() ? omap36xx_opp_def_list :
> +			omap34xx_opp_def_list;
> +		opp_def_size = cpu_is_omap3630() ?
> +			ARRAY_SIZE(omap36xx_opp_def_list) :
> +			ARRAY_SIZE(omap34xx_opp_def_list);
> +	} else {
> +		pr_err("%s: called for an unsupported cpu type\n", __func__);
> +		return -EINVAL;
> +	}

..the above can go into omap3 and omap4 specific init functions so this
function stays generic.

Regards,

Tony

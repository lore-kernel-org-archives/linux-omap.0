From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/3 v2] OMAP3: remove OPP interfaces from OMAP PM layer
Date: Thu, 4 Nov 2010 16:20:06 -0700
Message-ID: <20101104232005.GF9264@atomide.com>
References: <1287536543-9729-1-git-send-email-nm@ti.com>
 <1287536543-9729-2-git-send-email-nm@ti.com>
 <1287536543-9729-3-git-send-email-nm@ti.com>
 <1287536543-9729-4-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61062 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752515Ab0KDXUL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Nov 2010 19:20:11 -0400
Content-Disposition: inline
In-Reply-To: <1287536543-9729-4-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: l-o <linux-omap@vger.kernel.org>, Kevin H <khilman@deeprootsystems.com>

* Nishanth Menon <nm@ti.com> [101019 17:53]:
>  static int __init omap2_common_pm_init(void)
>  {
>  	omap2_init_processor_devices();
> +
> +	if (cpu_is_omap34xx() || cpu_is_omap44xx())
> +		omap_init_opp_table();
> +
>  	omap_pm_if_init();

It's best to have separate init for each supported processor instead:

static init __init omap3_opp_init(void)
{
	if (cpu_is_not_omap34xx())
		return -ENODEV;

	/* Do omap3 specific init */
	...

	return omap_opp_init(omap3_opp_def_list);
}
device_initcall(omap3_opp_init);

static init __init omap4_opp_init(void)
{
	if (cpu_is_not_omap44xx())
		return -ENODEV;

	/* Do omap3 specific init */
	...

	return omap_opp_init(omap4_opp_def_list);
}
device_initcall(omap4_opp_init);
...

This way it's easier to add support for new processors by
implementing the necessary initcalls, common code stays
generic, one level of code indentation is avoided, and
the code still gets optimized out for unselected processors.

Regards,

Tony


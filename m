From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] MFD: TWL4030: changes for TRITON glitch fix
Date: Wed, 21 Apr 2010 14:20:49 -0700
Message-ID: <20100421212049.GK18272@atomide.com>
References: <1270809191-17007-1-git-send-email-leslyam@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55189 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755516Ab0DUVUw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Apr 2010 17:20:52 -0400
Content-Disposition: inline
In-Reply-To: <1270809191-17007-1-git-send-email-leslyam@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lesly A M <leslyam@ti.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

* Lesly A M <leslyam@ti.com> [100409 03:05]:
> @@ -465,6 +465,41 @@ static struct twl4030_resconfig twl4030_rconfig[] = {
>  	{ 0, 0},
>  };
>  
> +#ifdef CONFIG_TWL5030_GLITCH_FIX
> +/* VDD1/VDD2/VPLL are assigned to P1 and P3, to have better control
> + * during OFFMODE. HFCLKOUT is assigned to P1 and P3 (*p2) to trun off
> + * only during OFFMODE.
> + * (*P2 is included if the platform uses it for modem/some other processor)
> + */
> +static struct twl4030_resconfig twl4030_rconfig_glitchfix[] = {
> +	{ .resource = RES_VPLL1, .devgroup = DEV_GRP_P1 | DEV_GRP_P3,
> +		.type = 3, .type2 = 1, .remap_sleep = RES_STATE_OFF },
> +	{ .resource = RES_VINTANA1, .devgroup = DEV_GRP_ALL, .type = 1,
> +		.type2 = 2, .remap_sleep = RES_STATE_SLEEP },
> +	{ .resource = RES_VINTANA2, .devgroup = DEV_GRP_ALL, .type = 0,
> +		.type2 = 2, .remap_sleep = RES_STATE_SLEEP },
> +	{ .resource = RES_VINTDIG, .devgroup = DEV_GRP_ALL, .type = 1,
> +		.type2 = 2, .remap_sleep = RES_STATE_SLEEP },
> +	{ .resource = RES_VIO, .devgroup = DEV_GRP_ALL, .type = 2,
> +		.type2 = 2, .remap_sleep = RES_STATE_SLEEP },
> +	{ .resource = RES_VDD1, .devgroup = DEV_GRP_P1 | DEV_GRP_P3,
> +		.type = 4, .type2 = 1, .remap_sleep = RES_STATE_OFF },
> +	{ .resource = RES_VDD2, .devgroup = DEV_GRP_P1 | DEV_GRP_P3,
> +		.type = 3, .type2 = 1, .remap_sleep = RES_STATE_OFF },
> +	{ .resource = RES_REGEN, .devgroup = DEV_GRP_ALL, .type = 2,
> +		.type2 = 1, .remap_sleep = RES_STATE_SLEEP },
> +	{ .resource = RES_NRES_PWRON, .devgroup = DEV_GRP_ALL, .type = 0,
> +		.type2 = 1, .remap_sleep = RES_STATE_SLEEP },
> +	{ .resource = RES_CLKEN, .devgroup = DEV_GRP_ALL, .type = 3,
> +		.type2 = 2, .remap_sleep = RES_STATE_SLEEP },
> +	{ .resource = RES_SYSEN, .devgroup = DEV_GRP_ALL, .type = 6,
> +		.type2 = 1, .remap_sleep = RES_STATE_SLEEP },
> +	{ .resource = RES_HFCLKOUT, .devgroup = DEV_GRP_P1 | DEV_GRP_P3,
> +		.type = 0, .type2 = 1, .remap_sleep = RES_STATE_SLEEP },
> +	{ 0, 0},
> +};
> +#endif

No thanks for CONFIG_TWL5030_GLITCH_FIX. Please check the version
dynamically during init instead.

Regards,

Tony

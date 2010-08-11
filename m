From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/4] initial support for LogicPD's OMAP3 SOM and TORPEDO development kits
Date: Wed, 11 Aug 2010 11:04:52 -0700
Message-ID: <87r5i52fgb.fsf@deeprootsystems.com>
References: <1281544297-18015-1-git-send-email-Jacob.Tanenbaum@logicpd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1281544297-18015-1-git-send-email-Jacob.Tanenbaum@logicpd.com>
	(Jacob Tanenbaum's message of "Wed, 11 Aug 2010 12:31:34 -0400")
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Tanenbaum <Jacob.Tanenbaum@logicpd.com>
Cc: linux@arm.linux.org.uk, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

Jacob Tanenbaum <Jacob.Tanenbaum@logicpd.com> writes:

> 	Adding LogicPD OMAP3 board support
>
>          Adding support for LogicPD's OMAP 3530 LV SOM and
>          OMAP 35x Torpedo board.
> 	 
> 	 Tested against: linux-next 81e09f50c93edff607259cbe374a3006c9c5fa74
>          Signed-off-by: Jacob Tanenbaum <Jacob.Tanenbaum@logicpd.com>

[...]

> +/* Micron MT46H32M32LF-6 */
> +/* FIXME: borrowed from sdram-micron-mt46h32m32lf-6.h because on LogicPD
> + * boards we can't use the default values -- why? I suspect the reason
> + * lies in the boot strap code. We correct this part if we have ported
> + * U-Boot and X-Load. */

Another option here instead of re-defining the struct is to includ the
original header and just change the values you need to.  That way
you can describe the reasons behind the values that are changing.

[...]

> +static struct omap_board_config_kernel omap3logic_config[] __initdata = {
> +};
> +
> +static void __init omap3logic_init_irq(void)
> +{
> +	omap_board_config = omap3logic_config;
> +	omap_board_config_size = ARRAY_SIZE(omap3logic_config);
> +	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
> +				mt46h32m32lf6_sdrc_params);
> +	omap_init_irq();
> +#ifdef CONFIG_OMAP_32K_TIMER
> +	omap2_gp_clockevent_set_gptimer(12);
> +#endif

Why do you need GPT12?

Was this a copy-paste from Beagle?  Certain revs of beagle had this
limitation due to a board design problem, so unless you've inherited the
same board-design problem, you should be find with the default.


Kevin

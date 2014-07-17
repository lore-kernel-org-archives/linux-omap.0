From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [Re-send PATCH 1/1] arm: dra7xx: Add hwmod data for MDIO and CPSW
Date: Thu, 17 Jul 2014 00:49:48 -0700
Message-ID: <20140717074948.GF18374@atomide.com>
References: <1404825399-10330-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1404825399-10330-1-git-send-email-mugunthanvnm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org> [140708 06:18]:
> Adding hwmod data for CPSW and MDIO which is present in DRA7xx SoC
> 
> Cc: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
> Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
> Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
> ---
> 
> This patch was already send twice on 2013-10-18 and 2014-05-13. Adding
> more people in Cc to review the patch.
> 
> ---
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 65 +++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> index 20b4398..45b5113 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> @@ -273,6 +273,56 @@ static struct omap_hwmod dra7xx_ctrl_module_wkup_hwmod = {
>  };
>  
>  /*
> + * 'gmac' class
> + * cpsw/gmac sub system
> + */
> +static struct omap_hwmod_class_sysconfig dra7xx_gmac_sysc = {
> +	.rev_offs	= 0x0,
> +	.sysc_offs	= 0x8,
> +	.syss_offs	= 0x4,
> +	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_MIDLEMODE |
> +			   SYSS_HAS_RESET_STATUS),
> +	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | MSTANDBY_FORCE |
> +			   MSTANDBY_NO),
> +	.sysc_fields	= &omap_hwmod_sysc_type3,
> +};

We seem to have this layout WR_SOFT_RESET and WR_CONTROL in the TRM:

WR_SOFT_RESET
[0]     SOFT_RESET

WR_CONTROL
[3:2]   MMR_STDBYMODE   0 = force-idle, 1 = no-standby
[1:0]   MMR_IDLEMODE    0 = force-idle, 1 = no-idle

And so it seems to match what am33xx also has for am33xx_cpgmac_sysc
and am33xx TRM for 14.5.9 CONTROL register. So as far as I'm concerned:

Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

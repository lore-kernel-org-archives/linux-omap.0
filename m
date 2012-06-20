From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH RESEND] usb: otg: OMAP4: Fix the omap4430_phy_set_clk
 function
Date: Wed, 20 Jun 2012 06:31:16 -0700
Message-ID: <20120620133115.GL12766@atomide.com>
References: <1339522581-8124-1-git-send-email-ruslan.bilovol@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1339522581-8124-1-git-send-email-ruslan.bilovol-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ruslan Bilovol <ruslan.bilovol-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Ruslan Bilovol <ruslan.bilovol-l0cyMroinI0@public.gmane.org> [120612 10:42]:
> If the clocks are enabled and we want to enable them again
> omap4430_phy_set_clk disables them.
> 
> Fix this - so now if we try to enable already enabled clocks
> it works correctly.

Sounds like Felipe is on vacation. Trying to figure out if this
is something for the fixes branch:

What happens if this not fixed, do you get some error?

Was this caused by some recent commit?

Regards,

Tony


 
> Signed-off-by: Ruslan Bilovol <ruslan.bilovol-l0cyMroinI0@public.gmane.org>
> ---
>  arch/arm/mach-omap2/omap_phy_internal.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_phy_internal.c b/arch/arm/mach-omap2/omap_phy_internal.c
> index 4c90477..0196683 100644
> --- a/arch/arm/mach-omap2/omap_phy_internal.c
> +++ b/arch/arm/mach-omap2/omap_phy_internal.c
> @@ -97,7 +97,7 @@ int omap4430_phy_set_clk(struct device *dev, int on)
>  		clk_enable(clk48m);
>  		clk_enable(clk32k);
>  		state = 1;
> -	} else if (state) {
> +	} else if (!on && state) {
>  		/* Disable the phy clocks */
>  		clk_disable(phyclk);
>  		clk_disable(clk48m);
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

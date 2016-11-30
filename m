From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH 1/1] mach-omap2: fixing wrong strcat for Non-NULL
 terminated string
Date: Wed, 30 Nov 2016 13:27:35 +0000
Message-ID: <20161130132735.GH23750@n2100.armlinux.org.uk>
References: <1480502428-19509-1-git-send-email-maninder1.s@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1480502428-19509-1-git-send-email-maninder1.s@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Maninder Singh <maninder1.s@samsung.com>
Cc: bcousson@baylibre.com, paul@pwsan.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, ajeet.y@samsung.com, pankaj.m@samsung.com, Vaneet Narang <v.narang@samsung.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 30, 2016 at 04:10:28PM +0530, Maninder Singh wrote:
> variable name can have Non NULL terminated string after cropping
> which may result strcat to fail, and cropping is not
> required if (strlen(oh->name) + 8 < MOD_CLK_MAX_NAME_LEN).
> 
> Issue caught with static analysis tool:
> "Dangerous usage of 'name' (strncpy doesn't always 0-terminate it)"

Maybe switch to strlcpy() ?

> 
> Signed-off-by: Vaneet Narang <v.narang@samsung.com>
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 759e1d4..8adf272 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -742,12 +742,15 @@ static int _init_main_clk(struct omap_hwmod *oh)
>  	char name[MOD_CLK_MAX_NAME_LEN];
>  	struct clk *clk;
>  
> -	/* +7 magic comes from '_mod_ck' suffix */
> -	if (strlen(oh->name) + 7 > MOD_CLK_MAX_NAME_LEN)
> +	/* +8 magic comes from strlen("_mod_ck") added as suffix */
> +	if (strlen(oh->name) + 8 > MOD_CLK_MAX_NAME_LEN) {
>  		pr_warn("%s: warning: cropping name for %s\n", __func__,
>  			oh->name);
> +		strncpy(name, oh->name, MOD_CLK_MAX_NAME_LEN - 8);
> +		name[MOD_CLK_MAX_NAME_LEN - 8] = '\0';
> +	} else
> +		strcpy(name, oh->name);
>  
> -	strncpy(name, oh->name, MOD_CLK_MAX_NAME_LEN - 7);
>  	strcat(name, "_mod_ck");
>  
>  	clk = clk_get(NULL, name);
> -- 
> 1.9.1
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v2] mach-omap2: fixing wrong strcat for Non-NULL
 terminated string
Date: Thu, 1 Dec 2016 12:40:15 +0000
Message-ID: <20161201124015.GI23750@n2100.armlinux.org.uk>
References: <1480589913-8839-1-git-send-email-maninder1.s@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1480589913-8839-1-git-send-email-maninder1.s@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Maninder Singh <maninder1.s@samsung.com>
Cc: bcousson@baylibre.com, paul@pwsan.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, ajeet.y@samsung.com, pankaj.m@samsung.com, Vaneet Narang <v.narang@samsung.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 01, 2016 at 04:28:33PM +0530, Maninder Singh wrote:
> variable name can have Non NULL terminated string after cropping
> which may result strcat to fail, and cropping is not
> required if (strlen(oh->name) + 8 < MOD_CLK_MAX_NAME_LEN).
> 
> Issue caught with static analysis tool:
> "Dangerous usage of 'name' (strncpy doesn't always 0-terminate it)"
> 
> Signed-off-by: Vaneet Narang <v.narang@samsung.com>
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> ---
> v1 -> v2: changed strncpy to strlcpy
>  arch/arm/mach-omap2/omap_hwmod.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 759e1d4..582b95a 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -742,12 +742,14 @@ static int _init_main_clk(struct omap_hwmod *oh)
>  	char name[MOD_CLK_MAX_NAME_LEN];
>  	struct clk *clk;
>  
> -	/* +7 magic comes from '_mod_ck' suffix */
> -	if (strlen(oh->name) + 7 > MOD_CLK_MAX_NAME_LEN)
> +	/* +8 magic comes from strlen("_mod_ck") added as suffix */
> +	if (strlen(oh->name) + 8 > MOD_CLK_MAX_NAME_LEN) {
>  		pr_warn("%s: warning: cropping name for %s\n", __func__,
>  			oh->name);
> +		strlcpy(name, oh->name, MOD_CLK_MAX_NAME_LEN - 7);
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

Simpler, clearer, and less error-prone:

	static const char modck[] = "_mod_ck";

	if (strlen(oh->name) >= MOD_CLK_MAX_NAME_LEN - strlen(modck))
		pr_warn("%s: warning: cropping name for %s\n", __func__,
			oh->name);

	strlcpy(name, oh->name, MOD_CLK_MAX_NAME_LEN - strlen(modck));
	strlcat(name, modck, MOD_CLK_MAX_NAME_LEN);

Note that the length argument to strlcpy _includes_ the NUL terminator.
Also note the use of strlcat() which ensures that it won't overflow the
buffer.


-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

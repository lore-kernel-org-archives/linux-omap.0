From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH] ARM: OMAP: DRA7: hwmod: Make gpmc software supervised
 as the smart idle is broken
Date: Tue, 20 Jan 2015 11:53:37 +0530
Message-ID: <54BDF469.3030907@ti.com>
References: <1421139085-27183-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1421139085-27183-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: t-kristo@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux@arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On Tuesday 13 January 2015 02:21 PM, Keerthy wrote:
> This patch fixes: 'omap_hwmod: gpmc: _wait_target_disable failed'
> error during suspend.
>
> This is because smart idle is broken.
> Tested in dra7-evm D1 board.

Ping on this.

> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod_7xx_data.c |    3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> index 9cdd8b8..29e55fe 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> @@ -826,7 +826,8 @@ static struct omap_hwmod dra7xx_gpmc_hwmod = {
>   	.name		= "gpmc",
>   	.class		= &dra7xx_gpmc_hwmod_class,
>   	.clkdm_name	= "l3main1_clkdm",
> -	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
> +	.flags		= (HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET |
> +			   HWMOD_SWSUP_SIDLE),
>   	.main_clk	= "l3_iclk_div",
>   	.prcm = {
>   		.omap4 = {

Regards,
Keerthy

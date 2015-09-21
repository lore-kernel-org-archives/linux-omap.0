From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] ARM: OMAP: Remove duplicated operand in OR operation
Date: Mon, 21 Sep 2015 10:28:36 +0300
Message-ID: <55FFB1A4.4090107@ti.com>
References: <1442496171-28741-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442496171-28741-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>, linux-kernel@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On 17/09/15 16:22, Javier Martinez Canillas wrote:
> Commit b483a4a5a711 ("ARM: OMAP4+: hwmod data: Don't prevent RESET of
> USB Host module") added the SYSC_HAS_RESET_STATUS flag to both OMAP4
> and OMAP5 USB host module hwmon sysconfig but that flag was already
> set for OMAP5. So now the flag appears twice in the expression.
> 
> make coccicheck complains with the following message:
> 
> omap_hwmod_54xx_data.c:1846:37-58: duplicated argument to & or |
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Acked-by: Roger Quadros <rogerq@ti.com>

> 
> ---
> 
>  arch/arm/mach-omap2/omap_hwmod_54xx_data.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
> index 7c3fac035e93..8cdfd9b7ab4f 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
> @@ -1844,8 +1844,7 @@ static struct omap_hwmod_class_sysconfig omap54xx_usb_host_hs_sysc = {
>  	.rev_offs	= 0x0000,
>  	.sysc_offs	= 0x0010,
>  	.sysc_flags	= (SYSC_HAS_MIDLEMODE | SYSC_HAS_RESET_STATUS |
> -			   SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
> -			   SYSC_HAS_RESET_STATUS),
> +			   SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET),
>  	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
>  			   SIDLE_SMART_WKUP | MSTANDBY_FORCE | MSTANDBY_NO |
>  			   MSTANDBY_SMART | MSTANDBY_SMART_WKUP),
> 

--
cheers,
-roger

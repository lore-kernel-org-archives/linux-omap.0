From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH 1/8] ARM: OMAP2+: Fix missing SYSC_HAS_RESET_STATUS for
 dra7 epwmss
Date: Tue, 23 Jul 2019 13:16:15 -0500
Message-ID: <212f2172-8612-86b6-83d7-0c70baaaf046@ti.com>
References: <20190723112811.44381-1-tony@atomide.com>
 <20190723112811.44381-2-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190723112811.44381-2-tony@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Roger Quadros <rogerq@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 7/23/19 6:28 AM, Tony Lindgren wrote:
> TRM says PWMSS_SYSCONFIG bit for SOFTRESET changes to zero when
> reset is completed. Let's configure it as otherwise we get warnings
> on boot when we check the data against dts provided data. Eventually
> the legacy platform data will be just dropped, but let's fix the
> warning first.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Reviewed-by: Suman Anna <s-anna@ti.com>

regards
Suman

> ---
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> --- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> @@ -379,7 +379,8 @@ static struct omap_hwmod dra7xx_dcan2_hwmod = {
>  static struct omap_hwmod_class_sysconfig dra7xx_epwmss_sysc = {
>  	.rev_offs	= 0x0,
>  	.sysc_offs	= 0x4,
> -	.sysc_flags	= SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET,
> +	.sysc_flags	= SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
> +			  SYSC_HAS_RESET_STATUS,
>  	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
>  	.sysc_fields	= &omap_hwmod_sysc_type2,
>  };
> 

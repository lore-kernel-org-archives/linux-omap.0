From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH] ARM: DRA7: hwmod: Fix OCP2SCP sysconfig
Date: Thu, 4 Feb 2016 12:15:00 +0530
Message-ID: <56B2F36C.1070406@ti.com>
References: <1454567491-30499-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454567491-30499-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

Hi,

On Thursday 04 February 2016 12:01 PM, Kishon Vijay Abraham I wrote:
> OCP2SCP doesn't support smart idle wakeup according to
> DRA72x_SR1.0_NDA_TRM_vL and DRA75x_DRA74x_SR1.1_NDA_TRM_vW.

Ignore this patch. I'll re-send the patch with a public TRM link.

Thanks
Kishon

> Remove SIDLE_SMART_WKUP from the list of supported SIDLE modes
> in hwmod data.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> index 848356e..84c2699 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> @@ -1482,8 +1482,7 @@ static struct omap_hwmod_class_sysconfig dra7xx_ocp2scp_sysc = {
>  	.syss_offs	= 0x0014,
>  	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_SIDLEMODE |
>  			   SYSC_HAS_SOFTRESET | SYSS_HAS_RESET_STATUS),
> -	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
> -			   SIDLE_SMART_WKUP),
> +	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
>  	.sysc_fields	= &omap_hwmod_sysc_type1,
>  };
>  
> 

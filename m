From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH] ARM: AM33xx: PRM: Remove wrongly defined RSTST offset for
 PER Domain
Date: Tue, 21 Jun 2016 17:25:52 -0500
Message-ID: <5769BEF0.4040902@ti.com>
References: <1466503706-5292-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466503706-5292-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>, rnayak@codeaurora.org, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, t-kristo@ti.com, afzal@ti.com, d-gerlach@ti.com, paul@pwsan.com, linux@armlinux.org.uk
List-Id: linux-omap@vger.kernel.org

Hi Keerthy,

On 06/21/2016 05:08 AM, Keerthy wrote:
> As per the TRM: http://www.ti.com/lit/ug/spruh73m/spruh73m.pdf
> offset 0x4 is reserved for PRM_PER. Hence removing the wrongly
> defined address offset.

Thanks for the patch.  These macros are not used anywhere, so it should
be safe to remove these. I have tested this patch with an off-tree PRUSS
driver releasing the reset, it works as expected without throwing any
issues.

That said, the current omap_hwmod code assumes default rstst_offs and
st_shift and tries to still write some value into the RSTCTRL register
in am33xx_prm_deassert_hardreset(), but it didn't have any side-affects
though on AM33xx. This is what affected the AM437x due to incorrect
RSTST offset value. That behavior is independent of this patch though.

Tested-by: Suman Anna <s-anna@ti.com>

regards
Suman

> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  arch/arm/mach-omap2/prm33xx.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/prm33xx.h b/arch/arm/mach-omap2/prm33xx.h
> index 2bc4ec5..66302c6 100644
> --- a/arch/arm/mach-omap2/prm33xx.h
> +++ b/arch/arm/mach-omap2/prm33xx.h
> @@ -52,8 +52,6 @@
>  /* PRM.PER_PRM register offsets */
>  #define AM33XX_RM_PER_RSTCTRL_OFFSET		0x0000
>  #define AM33XX_RM_PER_RSTCTRL			AM33XX_PRM_REGADDR(AM33XX_PRM_PER_MOD, 0x0000)
> -#define AM33XX_RM_PER_RSTST_OFFSET		0x0004
> -#define AM33XX_RM_PER_RSTST			AM33XX_PRM_REGADDR(AM33XX_PRM_PER_MOD, 0x0004)
>  #define AM33XX_PM_PER_PWRSTST_OFFSET		0x0008
>  #define AM33XX_PM_PER_PWRSTST			AM33XX_PRM_REGADDR(AM33XX_PRM_PER_MOD, 0x0008)
>  #define AM33XX_PM_PER_PWRSTCTRL_OFFSET		0x000c
> 

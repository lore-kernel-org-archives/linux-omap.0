From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 07/13] OMAP4: prm: Replace warm reset API with the
 offset based version
Date: Fri, 1 Jul 2011 06:39:03 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107010638110.27025@utopia.booyaka.com>
References: <1309189641-25010-1-git-send-email-b-cousson@ti.com> <1309189641-25010-8-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39913 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756290Ab1GAMjD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 08:39:03 -0400
In-Reply-To: <1309189641-25010-8-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: rnayak@ti.com, santosh.shilimkar@ti.com, linux-omap@vger.kernel.org

Hi

minor issue...

On Mon, 27 Jun 2011, Benoit Cousson wrote:

> The warm reset function was still using the obsolete API.
> Replace it by the new one and move the file to the proper c file.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/prm44xx.c     |   15 ---------------
>  arch/arm/mach-omap2/prm44xx.h     |    2 --
>  arch/arm/mach-omap2/prminst44xx.c |   19 +++++++++++++++++++
>  3 files changed, 19 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
> index faec860..f815329 100644
> --- a/arch/arm/mach-omap2/prm44xx.c
> +++ b/arch/arm/mach-omap2/prm44xx.c
> @@ -87,18 +87,3 @@ u32 omap4_prm_clear_inst_reg_bits(u32 bits, s16 inst, s16 reg)
>  {
>  	return omap4_prm_rmw_inst_reg_bits(bits, 0x0, inst, reg);
>  }
> -
> -void omap4_prm_global_warm_sw_reset(void)
> -{
> -	u32 v;
> -
> -	v = omap4_prm_read_inst_reg(OMAP4430_PRM_DEVICE_INST,
> -				    OMAP4_RM_RSTCTRL);
> -	v |= OMAP4430_RST_GLOBAL_WARM_SW_MASK;
> -	omap4_prm_write_inst_reg(v, OMAP4430_PRM_DEVICE_INST,
> -				 OMAP4_RM_RSTCTRL);
> -
> -	/* OCP barrier */
> -	v = omap4_prm_read_inst_reg(OMAP4430_PRM_DEVICE_INST,
> -				    OMAP4_RM_RSTCTRL);
> -}
> diff --git a/arch/arm/mach-omap2/prm44xx.h b/arch/arm/mach-omap2/prm44xx.h
> index 21b0240..a3887b8 100644
> --- a/arch/arm/mach-omap2/prm44xx.h
> +++ b/arch/arm/mach-omap2/prm44xx.h
> @@ -691,8 +691,6 @@ extern u32 omap4_prm_set_inst_reg_bits(u32 bits, s16 inst, s16 idx);
>  extern u32 omap4_prm_clear_inst_reg_bits(u32 bits, s16 inst, s16 idx);
>  extern u32 omap4_prm_read_bits_shift(void __iomem *reg, u32 mask);
>  
> -extern void omap4_prm_global_warm_sw_reset(void);
> -
>  # endif
>  
>  #endif
> diff --git a/arch/arm/mach-omap2/prminst44xx.c b/arch/arm/mach-omap2/prminst44xx.c
> index 95fbbcf..f5a9cf5 100644
> --- a/arch/arm/mach-omap2/prminst44xx.c
> +++ b/arch/arm/mach-omap2/prminst44xx.c
> @@ -151,3 +151,22 @@ int omap4_prm_deassert_hardreset(u8 shift, u8 part, s16 inst,
>  
>  	return (c == MAX_MODULE_HARDRESET_WAIT) ? -EBUSY : 0;
>  }
> +
> +
> +void omap4_prm_global_warm_sw_reset(void)

This function should be named 'omap4_prminst_global_warm_sw_reset' if it's 
in the prminst44xx.c file.

> +{
> +	u32 v;
> +
> +	v = omap4_prminst_read_inst_reg(OMAP4430_PRM_PARTITION,
> +				    OMAP4430_PRM_DEVICE_INST,
> +				    OMAP4_PRM_RSTCTRL_OFFSET);
> +	v |= OMAP4430_RST_GLOBAL_WARM_SW_MASK;
> +	omap4_prminst_write_inst_reg(v, OMAP4430_PRM_PARTITION,
> +				 OMAP4430_PRM_DEVICE_INST,
> +				 OMAP4_PRM_RSTCTRL_OFFSET);
> +
> +	/* OCP barrier */
> +	v = omap4_prminst_read_inst_reg(OMAP4430_PRM_PARTITION,
> +				    OMAP4430_PRM_DEVICE_INST,
> +				    OMAP4_PRM_RSTCTRL_OFFSET);
> +}
> -- 
> 1.7.0.4
> 


- Paul

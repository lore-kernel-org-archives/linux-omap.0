From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC][PATCH 2/2] OMAP4: PRCM: Fix usage of prm/cm accessor api's
 for OMAP4
Date: Thu, 14 Oct 2010 12:44:52 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1010141239170.21196@utopia.booyaka.com>
References: <1281452576-5705-1-git-send-email-rnayak@ti.com> <1281452576-5705-2-git-send-email-rnayak@ti.com> <1281452576-5705-3-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54757 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752717Ab0JNSox (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Oct 2010 14:44:53 -0400
In-Reply-To: <1281452576-5705-3-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, b-cousson@ti.com

Hello Rajendra,

On Tue, 10 Aug 2010, Rajendra Nayak wrote:

> OMAP's have always had PRCM split into PRM for power and reset
> management and CM for clock management.
> In OMAP4 the split (physically) is not very straight forward and
> there are instances of clock management control registers in PRM
> and vice versa.
> However it still makes sense, even on OMAP4 to logically split
> PRCM into PRM and CM for better understanding and to avoid adding
> additonal complexity in higher level frameworks which rely on the
> accessor api;s to do the low level register accesses.
> 
> Hence this patch makes sure that any clock management code can
> use the cm_read/write* accessor apis (without knowing the physical split)
> and power and reset management code can use prm_read/write*
> accessor api;s.
> 
> To do this the submodule offsets within PRM/CM1 and CM2 have additonal
> info embedded in them specifying what base address to use while
> trying to access registers in the given submodule.
> 
> The 16 bit signed submodule offset is defined for OMAP4 as
> <Bit 15>	| <Bit 14:13> 		| <Bit 12:0>
> <Sign bit>	| <base identifier>	| <submodule offset from base>

The concern that I have with embedding multiple parameters into a single 
parameter is that it seems like a hack.  Why not add an extra parameter 
for the base identifier, rather than packing it into an existing 
parameter?

I am not necessarily opposed to your patch as it exists.  But I would like 
to hear your opinions first on separating out the base identifier 
parameter as a separate function parameter, and then adding an extra field 
for it into any data structure that would need it.  Could you write 
briefly if you see any significant advantages/disadvantages to that 
approach?

> For older OMAP's the base identifier is always set to 0.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> ---
>  arch/arm/mach-omap2/cm.h          |    4 +-
>  arch/arm/mach-omap2/prcm-common.h |   58 ++++++++++++++++++++-----------
>  arch/arm/mach-omap2/prcm.c        |   68 ++++++++++++++++++++++++++++++++++--
>  arch/arm/mach-omap2/prm.h         |    4 +-
>  4 files changed, 105 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/cm.h b/arch/arm/mach-omap2/cm.h
> index a02ca30..7b7ef09 100644
> --- a/arch/arm/mach-omap2/cm.h
> +++ b/arch/arm/mach-omap2/cm.h
> @@ -23,9 +23,9 @@
>  #define OMAP34XX_CM_REGADDR(module, reg)				\
>  			OMAP2_L4_IO_ADDRESS(OMAP3430_CM_BASE + (module) + (reg))
>  #define OMAP44XX_CM1_REGADDR(module, reg)				\
> -			OMAP2_L4_IO_ADDRESS(OMAP4430_CM1_BASE + (module) + (reg))
> +			OMAP2_L4_IO_ADDRESS(OMAP4430_CM1_BASE + ((module) & (MOD_MASK)) + (reg))
>  #define OMAP44XX_CM2_REGADDR(module, reg)				\
> -			OMAP2_L4_IO_ADDRESS(OMAP4430_CM2_BASE + (module) + (reg))
> +			OMAP2_L4_IO_ADDRESS(OMAP4430_CM2_BASE + ((module) & (MOD_MASK)) + (reg))
>  
>  #include "cm44xx.h"
>  
> diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
> index 995b7ed..b93d33e 100644
> --- a/arch/arm/mach-omap2/prcm-common.h
> +++ b/arch/arm/mach-omap2/prcm-common.h
> @@ -57,10 +57,26 @@
>  #define BITFIELD(l_bit, u_bit)	\
>  	(BITS(u_bit) & ~((BITS(l_bit)) >> 1))
>  
> -/* OMAP44XX specific module offsets */
> +/*
> + * OMAP44XX specific module offsets
> + * The 16 bit submodule offset is defined for OMAP4 as
> + * <Bit 15>	| <Bit 14:13> 		| <Bit 12:0>
> + * <Sign bit>	| <base identifier>	| <submodule offset from base>
> + */
>  
> -/* CM1 instances */
> +#define DEFAULT_BASE	0x0
> +#define PRM_BASE	0x1
> +#define PRCM_MPU_BASE	0x2
> +#define CM2_BASE	0x3
>  
> +#define BASE_ID_SHIFT	13
> +#define MOD_MASK	((1 << BASE_ID_SHIFT)-1)
> +
> +#define PRM_BASE_ID		(PRM_BASE << BASE_ID_SHIFT)
> +#define PRCM_MPU_BASE_ID	(PRCM_MPU_BASE << BASE_ID_SHIFT)
> +#define CM2_BASE_ID		(CM2_BASE << BASE_ID_SHIFT)
> +
> +/* CM1 instances */
>  #define OMAP4430_CM1_OCP_SOCKET_MOD	0x0000
>  #define OMAP4430_CM1_CKGEN_MOD		0x0100
>  #define OMAP4430_CM1_MPU_MOD		0x0300
> @@ -71,19 +87,19 @@
>  
>  /* CM2 instances */
>  
> -#define OMAP4430_CM2_OCP_SOCKET_MOD	0x0000
> -#define OMAP4430_CM2_CKGEN_MOD		0x0100
> -#define OMAP4430_CM2_ALWAYS_ON_MOD	0x0600
> -#define OMAP4430_CM2_CORE_MOD		0x0700
> -#define OMAP4430_CM2_IVAHD_MOD		0x0f00
> -#define OMAP4430_CM2_CAM_MOD		0x1000
> -#define OMAP4430_CM2_DSS_MOD		0x1100
> -#define OMAP4430_CM2_GFX_MOD		0x1200
> -#define OMAP4430_CM2_L3INIT_MOD		0x1300
> -#define OMAP4430_CM2_L4PER_MOD		0x1400
> -#define OMAP4430_CM2_CEFUSE_MOD		0x1600
> -#define OMAP4430_CM2_RESTORE_MOD	0x1e00
> -#define OMAP4430_CM2_INSTR_MOD		0x1f00
> +#define OMAP4430_CM2_OCP_SOCKET_MOD	0x0000 | CM2_BASE_ID
> +#define OMAP4430_CM2_CKGEN_MOD		0x0100 | CM2_BASE_ID
> +#define OMAP4430_CM2_ALWAYS_ON_MOD	0x0600 | CM2_BASE_ID
> +#define OMAP4430_CM2_CORE_MOD		0x0700 | CM2_BASE_ID
> +#define OMAP4430_CM2_IVAHD_MOD		0x0f00 | CM2_BASE_ID
> +#define OMAP4430_CM2_CAM_MOD		0x1000 | CM2_BASE_ID
> +#define OMAP4430_CM2_DSS_MOD		0x1100 | CM2_BASE_ID
> +#define OMAP4430_CM2_GFX_MOD		0x1200 | CM2_BASE_ID
> +#define OMAP4430_CM2_L3INIT_MOD		0x1300 | CM2_BASE_ID
> +#define OMAP4430_CM2_L4PER_MOD		0x1400 | CM2_BASE_ID
> +#define OMAP4430_CM2_CEFUSE_MOD		0x1600 | CM2_BASE_ID
> +#define OMAP4430_CM2_RESTORE_MOD	0x1e00 | CM2_BASE_ID
> +#define OMAP4430_CM2_INSTR_MOD		0x1f00 | CM2_BASE_ID
>  
>  /* PRM instances */
>  
> @@ -102,9 +118,9 @@
>  #define OMAP4430_PRM_L4PER_MOD		0x1400
>  #define OMAP4430_PRM_CEFUSE_MOD		0x1600
>  #define OMAP4430_PRM_WKUP_MOD		0x1700
> -#define OMAP4430_PRM_WKUP_CM_MOD	0x1800
> +#define OMAP4430_PRM_WKUP_CM_MOD	0x1800 | PRM_BASE_ID
>  #define OMAP4430_PRM_EMU_MOD		0x1900
> -#define OMAP4430_PRM_EMU_CM_MOD		0x1a00
> +#define OMAP4430_PRM_EMU_CM_MOD		0x1a00 | PRM_BASE_ID
>  #define OMAP4430_PRM_DEVICE_MOD		0x1b00
>  #define OMAP4430_PRM_INSTR_MOD		0x1f00
>  
> @@ -114,10 +130,10 @@
>  
>  /* PRCM_MPU instances */
>  
> -#define OMAP4430_PRCM_MPU_OCP_SOCKET_PRCM_MOD	0x0000
> -#define OMAP4430_PRCM_MPU_DEVICE_PRM_MOD	0x0200
> -#define OMAP4430_PRCM_MPU_CPU0_MOD		0x0400
> -#define OMAP4430_PRCM_MPU_CPU1_MOD		0x0800
> +#define OMAP4430_PRCM_MPU_OCP_SOCKET_PRCM_MOD	0x0000 | PRCM_MPU_BASE_ID
> +#define OMAP4430_PRCM_MPU_DEVICE_PRM_MOD	0x0200 | PRCM_MPU_BASE_ID
> +#define OMAP4430_PRCM_MPU_CPU0_MOD		0x0400 | PRCM_MPU_BASE_ID
> +#define OMAP4430_PRCM_MPU_CPU1_MOD		0x0800 | PRCM_MPU_BASE_ID
>  
>  
>  /* 24XX register bits shared between CM & PRM registers */
> diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
> index 4df30d0..124e866 100644
> --- a/arch/arm/mach-omap2/prcm.c
> +++ b/arch/arm/mach-omap2/prcm.c
> @@ -182,13 +182,40 @@ static inline void __omap_prcm_write(u32 value, void __iomem *base,
>  /* Read a register in a PRM module */
>  u32 prm_read_mod_reg(s16 module, u16 idx)
>  {
> -	return __omap_prcm_read(prm_base, module, idx);
> +	u32 base = 0;
> +
> +	base = abs(module) >> BASE_ID_SHIFT;
> +	module &= MOD_MASK;
> +
> +	switch (base) {
> +	case PRCM_MPU_BASE:
> +		return __omap_prcm_read(prcm_mpu_base, module, idx);
> +	case DEFAULT_BASE:
> +		return __omap_prcm_read(prm_base, module, idx);
> +	default:
> +		pr_err("Unknown PRM submodule base\n");
> +	}
> +	return 0;
>  }
>  
>  /* Write into a register in a PRM module */
>  void prm_write_mod_reg(u32 val, s16 module, u16 idx)
>  {
> -	__omap_prcm_write(val, prm_base, module, idx);
> +	u32 base = 0;
> +
> +	base = abs(module) >> BASE_ID_SHIFT;
> +
> +	switch (base) {
> +	case PRCM_MPU_BASE:
> +		__omap_prcm_write(val, prcm_mpu_base, module, idx);
> +		break;
> +	case DEFAULT_BASE:
> +		__omap_prcm_write(val, prm_base, module, idx);
> +		break;
> +	default:
> +		pr_err("Unknown PRM submodule base\n");
> +		break;
> +	}
>  }
>  
>  /* Read-modify-write a register in a PRM module. Caller must lock */
> @@ -219,13 +246,46 @@ u32 prm_read_mod_bits_shift(s16 domain, s16 idx, u32 mask)
>  /* Read a register in a CM module */
>  u32 cm_read_mod_reg(s16 module, u16 idx)
>  {
> -	return __omap_prcm_read(cm_base, module, idx);
> +	u32 base = 0;
> +
> +	base = abs(module) >> BASE_ID_SHIFT;
> +	module &= MOD_MASK;
> +
> +	switch (base) {
> +	case PRM_BASE:
> +		return __omap_prcm_read(prm_base, module, idx);
> +	case CM2_BASE:
> +		return __omap_prcm_read(cm2_base, module, idx);
> +	case DEFAULT_BASE:
> +		return __omap_prcm_read(cm_base, module, idx);
> +	default:
> +		pr_err("Unknown CM submodule base\n");
> +	}
> +	return 0;
>  }
>  
>  /* Write into a register in a CM module */
>  void cm_write_mod_reg(u32 val, s16 module, u16 idx)
>  {
> -	__omap_prcm_write(val, cm_base, module, idx);
> +	u32 base = 0;
> +
> +	base = abs(module) >> BASE_ID_SHIFT;
> +	module &= MOD_MASK;
> +
> +	switch (base) {
> +	case PRM_BASE:
> +		__omap_prcm_write(val, prm_base, module, idx);
> +		break;
> +	case CM2_BASE:
> +		__omap_prcm_write(val, cm2_base, module, idx);
> +		break;
> +	case DEFAULT_BASE:
> +		__omap_prcm_write(val, cm_base, module, idx);
> +		break;
> +	default:
> +		pr_err("Unknown CM submodule base\n");
> +		break;
> +	}
>  }
>  
>  /* Read-modify-write a register in a CM module. Caller must lock */
> diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
> index 588873b..72456cc 100644
> --- a/arch/arm/mach-omap2/prm.h
> +++ b/arch/arm/mach-omap2/prm.h
> @@ -23,9 +23,9 @@
>  #define OMAP34XX_PRM_REGADDR(module, reg)				\
>  		OMAP2_L4_IO_ADDRESS(OMAP3430_PRM_BASE + (module) + (reg))
>  #define OMAP44XX_PRM_REGADDR(module, reg)				\
> -		OMAP2_L4_IO_ADDRESS(OMAP4430_PRM_BASE + (module) + (reg))
> +		OMAP2_L4_IO_ADDRESS(OMAP4430_PRM_BASE +	((module) & (MOD_MASK)) + (reg))
>  #define OMAP44XX_PRCM_MPU_REGADDR(module, reg)				\
> -		OMAP2_L4_IO_ADDRESS(OMAP4430_PRCM_MPU_BASE + (module) + (reg))
> +		OMAP2_L4_IO_ADDRESS(OMAP4430_PRCM_MPU_BASE + ((module) & (MOD_MASK)) + (reg))
>  
>  #include "prm44xx.h"
>  
> -- 
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul

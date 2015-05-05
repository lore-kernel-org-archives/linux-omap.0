From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH 1/2] ARM: OMAP4+: PRM: add support for passing status
 register/bit info to reset
Date: Tue, 5 May 2015 11:47:54 -0500
Message-ID: <5548F43A.4020409@ti.com>
References: <1430832785-1976-1-git-send-email-t-kristo@ti.com> <1430832785-1976-2-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58326 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933198AbbEEQsV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 May 2015 12:48:21 -0400
In-Reply-To: <1430832785-1976-2-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, d-gerlach@ti.com
Cc: linux-arm-kernel@lists.infradead.org

On 05/05/2015 08:33 AM, Tero Kristo wrote:
> AM43xx has slightly different reset register layout compared to OMAP4+,
> with varying status bit shifts and status register offsets. Current
> code assumes static offsets and identical status / reset control bit
> shifts, which is wrong. This patch adds PRM core support for passing
> the actual implementations from hwmod code. AM43xx mappings will be fixed
> in subsequent patch.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Reported-by: Dave Gerlach <d-gerlach@ti.com>
> Reported-by: Anna Suman <s-anna@ti.com>

Looks good to me, please correct the signature to
Suman Anna <s-anna@ti.com> on this patch and next patch as well.

regards
Suman

> ---
>  arch/arm/mach-omap2/omap_hwmod.c  |   12 ++++++++++--
>  arch/arm/mach-omap2/prminst44xx.c |   20 +++++++-------------
>  2 files changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 355b089..e482562 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -171,6 +171,12 @@
>   */
>  #define LINKS_PER_OCP_IF		2
>  
> +/*
> + * Address offset (in bytes) between the reset control and the reset
> + * status registers: 4 bytes on OMAP4
> + */
> +#define OMAP4_RST_CTRL_ST_OFFSET	4
> +
>  /**
>   * struct omap_hwmod_soc_ops - fn ptrs for some SoC-specific operations
>   * @enable_module: function to enable a module (via MODULEMODE)
> @@ -3016,10 +3022,12 @@ static int _omap4_deassert_hardreset(struct omap_hwmod *oh,
>  	if (ohri->st_shift)
>  		pr_err("omap_hwmod: %s: %s: hwmod data error: OMAP4 does not support st_shift\n",
>  		       oh->name, ohri->name);
> -	return omap_prm_deassert_hardreset(ohri->rst_shift, 0,
> +	return omap_prm_deassert_hardreset(ohri->rst_shift, ohri->rst_shift,
>  					   oh->clkdm->pwrdm.ptr->prcm_partition,
>  					   oh->clkdm->pwrdm.ptr->prcm_offs,
> -					   oh->prcm.omap4.rstctrl_offs, 0);
> +					   oh->prcm.omap4.rstctrl_offs,
> +					   oh->prcm.omap4.rstctrl_offs +
> +					   OMAP4_RST_CTRL_ST_OFFSET);
>  }
>  
>  /**
> diff --git a/arch/arm/mach-omap2/prminst44xx.c b/arch/arm/mach-omap2/prminst44xx.c
> index c4859c4..d0b15db 100644
> --- a/arch/arm/mach-omap2/prminst44xx.c
> +++ b/arch/arm/mach-omap2/prminst44xx.c
> @@ -87,12 +87,6 @@ u32 omap4_prminst_rmw_inst_reg_bits(u32 mask, u32 bits, u8 part, s16 inst,
>  	return v;
>  }
>  
> -/*
> - * Address offset (in bytes) between the reset control and the reset
> - * status registers: 4 bytes on OMAP4
> - */
> -#define OMAP4_RST_CTRL_ST_OFFSET		4
> -
>  /**
>   * omap4_prminst_is_hardreset_asserted - read the HW reset line state of
>   * submodules contained in the hwmod module
> @@ -141,11 +135,11 @@ int omap4_prminst_assert_hardreset(u8 shift, u8 part, s16 inst,
>   * omap4_prminst_deassert_hardreset - deassert a submodule hardreset line and
>   * wait
>   * @shift: register bit shift corresponding to the reset line to deassert
> - * @st_shift: status bit offset, not used for OMAP4+
> + * @st_shift: status bit offset corresponding to the reset line
>   * @part: PRM partition
>   * @inst: PRM instance offset
>   * @rstctrl_offs: reset register offset
> - * @st_offs: reset status register offset, not used for OMAP4+
> + * @rstst_offs: reset status register offset
>   *
>   * Some IPs like dsp, ipu or iva contain processors that require an HW
>   * reset line to be asserted / deasserted in order to fully enable the
> @@ -157,11 +151,11 @@ int omap4_prminst_assert_hardreset(u8 shift, u8 part, s16 inst,
>   * of reset, or -EBUSY if the submodule did not exit reset promptly.
>   */
>  int omap4_prminst_deassert_hardreset(u8 shift, u8 st_shift, u8 part, s16 inst,
> -				     u16 rstctrl_offs, u16 st_offs)
> +				     u16 rstctrl_offs, u16 rstst_offs)
>  {
>  	int c;
>  	u32 mask = 1 << shift;
> -	u16 rstst_offs = rstctrl_offs + OMAP4_RST_CTRL_ST_OFFSET;
> +	u32 st_mask = 1 << st_shift;
>  
>  	/* Check the current status to avoid de-asserting the line twice */
>  	if (omap4_prminst_is_hardreset_asserted(shift, part, inst,
> @@ -169,13 +163,13 @@ int omap4_prminst_deassert_hardreset(u8 shift, u8 st_shift, u8 part, s16 inst,
>  		return -EEXIST;
>  
>  	/* Clear the reset status by writing 1 to the status bit */
> -	omap4_prminst_rmw_inst_reg_bits(0xffffffff, mask, part, inst,
> +	omap4_prminst_rmw_inst_reg_bits(0xffffffff, st_mask, part, inst,
>  					rstst_offs);
>  	/* de-assert the reset control line */
>  	omap4_prminst_rmw_inst_reg_bits(mask, 0, part, inst, rstctrl_offs);
>  	/* wait the status to be set */
> -	omap_test_timeout(omap4_prminst_is_hardreset_asserted(shift, part, inst,
> -							      rstst_offs),
> +	omap_test_timeout(omap4_prminst_is_hardreset_asserted(st_shift, part,
> +							      inst, rstst_offs),
>  			  MAX_MODULE_HARDRESET_WAIT, c);
>  
>  	return (c == MAX_MODULE_HARDRESET_WAIT) ? -EBUSY : 0;
> 


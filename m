From: Paul Walmsley <paul@booyaka.com>
Subject: Re: [PATCH 1/5] mach:omap: some correction in Clock 34XX
Date: Mon, 5 Nov 2007 00:31:09 -0700 (MST)
Message-ID: <Pine.LNX.4.64.0711050021380.32372@utopia.booyaka.com>
References: <00f501c81d64$7d547040$6a8918ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <00f501c81d64$7d547040$6a8918ac@ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Girish <girishsg@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Girish,

Your changes to clock34xx.h look good.  But the change to clock34xx.c 
isn't quite right.  The dpll_params.enable_mask field is intended to be a 
mask for the register's enable bits - i.e., something one would 
logical-AND with the shifted contents of CM_CLKEN_PLL* - rather than the 
value to logical-OR into those bits to indicate a locked DPLL.  The two 
values happen to coincide, so the change is functionally harmless; but 
semantically, not what was intended for the enable_mask field.  Would you 
care to resubmit the patch with the clock34xx.c change dropped?

Regards,

- Paul

On Fri, 2 Nov 2007, Girish wrote:

> This patch modifies the I2C clock nodes as per LDM, corrects usage of DPLL mask
> and updates the flags of 96M clock nodes
> Signed-off-by: Chandra Shekhar <x0044955@ti.com>
>
> ---
> arch/arm/mach-omap2/clock34xx.c |    4 +---
> arch/arm/mach-omap2/clock34xx.h |   27 ++++++++++++++++++---------
> 2 files changed, 19 insertions(+), 12 deletions(-)
>
> Index: linux-omap-git/arch/arm/mach-omap2/clock34xx.c
> ===================================================================
> --- linux-omap-git.orig/arch/arm/mach-omap2/clock34xx.c	2007-10-25 18:59:42.000000000 +0530
> +++ linux-omap-git/arch/arm/mach-omap2/clock34xx.c	2007-10-25 19:03:03.000000000 +0530
> @@ -37,8 +37,6 @@
> #include "cm.h"
> #include "cm_regbits_34xx.h"
>
> -/* CM_CLKEN_PLL*.EN* bit values */
> -#define DPLL_LOCKED		0x7
>
> /**
>  * omap3_dpll_recalc - recalculate DPLL rate
> @@ -79,7 +77,7 @@
> 	WARN_ON(!dd->control_reg || !dd->enable_mask);
>
> 	v = cm_read_reg(dd->control_reg) & dd->enable_mask;
> -	if (v != DPLL_LOCKED)
> +	if (v != dd->enable_mask)
> 		clk->rate = clk->parent->rate;
> 	else
> 		clk->rate = clk->parent->rate * 2;
> Index: linux-omap-git/arch/arm/mach-omap2/clock34xx.h
> ===================================================================
> --- linux-omap-git.orig/arch/arm/mach-omap2/clock34xx.h	2007-10-25 18:59:49.000000000 +0530
> +++ linux-omap-git/arch/arm/mach-omap2/clock34xx.h	2007-10-25 19:03:03.000000000 +0530
> @@ -437,14 +437,16 @@
> static struct clk omap_96m_alwon_fck = {
> 	.name		= "omap_96m_alwon_fck",
> 	.parent		= &dpll4_m2x2_ck,
> -	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
> +	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
> +				 PARENT_CONTROLS_CLOCK,
> 	.recalc		= &followparent_recalc,
> };
>
> static struct clk omap_96m_fck = {
> 	.name		= "omap_96m_fck",
> 	.parent		= &omap_96m_alwon_fck,
> -	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
> +	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
> +				PARENT_CONTROLS_CLOCK,
> 	.recalc		= &followparent_recalc,
> };
>
> @@ -830,7 +832,8 @@
> static struct clk core_96m_fck = {
> 	.name		= "core_96m_fck",
> 	.parent		= &omap_96m_fck,
> -	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
> +	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
> +				PARENT_CONTROLS_CLOCK,
> 	.recalc		= &followparent_recalc,
> };
>
> @@ -862,7 +865,8 @@
> };
>
> static struct clk i2c3_fck = {
> -	.name		= "i2c3_fck",
> +	.name		= "i2c_fck",
> +	.id		= 3,
> 	.parent		= &core_96m_fck,
> 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
> 	.enable_bit	= OMAP3430_EN_I2C3_SHIFT,
> @@ -871,7 +875,8 @@
> };
>
> static struct clk i2c2_fck = {
> -	.name		= "i2c2_fck",
> +	.name		= "i2c_fck",
> +	.id 		= 2,
> 	.parent		= &core_96m_fck,
> 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
> 	.enable_bit	= OMAP3430_EN_I2C2_SHIFT,
> @@ -880,7 +885,8 @@
> };
>
> static struct clk i2c1_fck = {
> -	.name		= "i2c1_fck",
> +	.name		= "i2c_fck",
> +	.id		= 1,
> 	.parent		= &core_96m_fck,
> 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
> 	.enable_bit	= OMAP3430_EN_I2C1_SHIFT,
> @@ -1222,7 +1228,8 @@
> };
>
> static struct clk i2c3_ick = {
> -	.name		= "i2c3_ick",
> +	.name		= "i2c_ick",
> +	.id		= 3,
> 	.parent		= &core_l4_ick,
> 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
> 	.enable_bit	= OMAP3430_EN_I2C3_SHIFT,
> @@ -1231,7 +1238,8 @@
> };
>
> static struct clk i2c2_ick = {
> -	.name		= "i2c2_ick",
> +	.name		= "i2c_ick",
> +	.id		= 2,
> 	.parent		= &core_l4_ick,
> 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
> 	.enable_bit	= OMAP3430_EN_I2C2_SHIFT,
> @@ -1240,7 +1248,8 @@
> };
>
> static struct clk i2c1_ick = {
> -	.name		= "i2c1_ick",
> +	.name		= "i2c_ick",
> +	.id		= 1,
> 	.parent		= &core_l4_ick,
> 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
> 	.enable_bit	= OMAP3430_EN_I2C1_SHIFT,
>
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>


- Paul
